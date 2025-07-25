/*
===============================================================
Customer Report
===============================================================
Purpose:
  - This report consolidates key customer metrics and behaviors

Highlights:
1. Gathers essential fields such as names, ages, and transaction details.
2. Segments customers into categories (VIP, Regular, New) and age groups.
3. Aggregates customer-level metrics:
   - total orders
   - total sales
   - total quantity purchased
   - total products
   - lifespan (in months)
4. Calculates valuable KPIs:
   - recency (months since last order)
   - average order value
   - average monthly spend
===============================================================
*/
--1) base query : to get the columns needed
create view gold.customer_report as
	with CTE_base as
	--base query needed columns
	(
		select
		  f.order_number,
		  f.sales_amount,
		  f.order_date,
		  f.product_key,
		  f.quantity,
		  c.customer_key,
		  c.customer_number,
		  datediff(year,c.birthdate,getdate()) age,
		  concat(c.first_name,' ',c.last_name) customer_name
		from gold.fact_sales f
		left join gold.dim_customers c
		on f.customer_key=c.customer_key
		where f.order_date is not null
		)
	,CTE_Agg as
	--calcuate aggregation
	 (
	 select
		customer_key,
		customer_number,
		age,
		customer_name,
		count(distinct order_number) as total_orders,
		sum(sales_amount) as total_sales,
		sum(quantity) as total_quantity,
		count(distinct product_key) total_products,
		max(order_date) as last_order,
		datediff(month,min(order_date),max(order_date)) as life_span
	from CTE_base
	group by
		customer_key,
		customer_number,
		age,
		customer_name
	)
	select
	   customer_key,
	   customer_name
	   customer_number,
		age,
		case when age<20 then 'young'
			 when age between 20 and 45 then 'middle aged'
			 when age between 45 and 60 then 'older middle aged'
			 else 'old aged'
			 end age_segmentation,
		case when life_span>=12 and total_sales>5000 then 'VIP'
				when life_span>=12 and total_sales<=5000 then 'REGULAR'
				else 'NEW'
				end spending_segmentation,
		datediff(month,last_order,getdate()) as recency,
		total_sales
		total_orders,
		total_products,
		total_quantity,
		life_span,
		--KPI average order value(AOV)
		case when total_orders=0 then 0 
			 else total_sales/total_orders
		end avg_order_value,
	   --KPI average monthly spending
	   case when life_span=0 then total_sales
			 else total_sales/life_span 
		end avg_monthly_spend  
	from CTE_Agg 

-- to test the create report view
select * from gold.customer_report
