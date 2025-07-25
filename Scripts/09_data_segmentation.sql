/*====================================================================================================================
  SECTION: Data Segmentation – Product & Customer Analysis
  PURPOSE:
    • Categorize products into cost bands for product-level segmentation
    • Segment customers into VIP/Regular/New based on lifetime spend & lifespan
  BUSINESS VALUE:
    • Enables strategies around pricing tiers, inventory optimization
    • Helps identify high-value customers and retention targets
  DATA QUALITY CONSIDERATIONS:
    • Ensure that cost values are accurate and non-null in product dimension
    • Confirm order_date dates are valid and complete to calculate lifespan
    • Set thresholds (cost/sales/spend) based on business context and data distributio
  SEGMENTATION CONTEXT:
    • Product Segmentation: cost-based tiers such as Below 100, 100–500, 500–1000, Above 1000
    • Customer Segmentation: VIP (long lifespan, high spend), Regular (moderate spend), New (minimal longevity/spend)
==========================================================================================================================*/

with CTE_segment as(
	select
	   product_key,
	   product_name,
	   cost,
	   case when cost<100 then 'Below 100'
	        when cost between 100 and 500 then '100-500'
			when cost between 500 and 1000 then '500-1000'
			else 'Above 1000'
		end cost_range
	from gold.dim_products
	)
select 
 cost_range,
 count(product_key) as countofseg
from CTE_segment
group by cost_range
order by countofseg desc;
/* groupng the customers into three segments based on the lifespan on orders
   VIP: lifespan atleast 12 months and spending more than $5000
   REGULAR: lifespan atleast 12 months and spending less than $5000
   NEW: with life span less than 12 months
   and total no.of customer by each group*/
with CTE_spending as (
	select
	   c.customer_key,
	   sum(f.sales_amount) total_spending,
	   min(f.order_date) as first_order,
	   max(f.order_date) as last_order,
	   datediff(month,min(f.order_date),max(f.order_date))  as life_span
	from gold.fact_sales f
	left join gold.dim_customers c
	on f.customer_key=c.customer_key
	group by c.customer_key
	)
select 
segmentation,
count(customer_key) as customer_count
from
   (
	select
	   customer_key,
	   case when life_span>=12 and total_spending>5000 then 'VIP'
			when life_span>=12 and total_spending<=5000 then 'REGULAR'
			else 'NEW'
			end segmentation
	from CTE_spending
	) tmp
group by segmentation
order by customer_count desc;
