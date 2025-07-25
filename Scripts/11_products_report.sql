/*
===============================================================
Product Report
===============================================================
Purpose:
  - This report consolidates key product metrics and behaviors.

Highlights:
1. Gathers essential fields such as product name, category, subcategory, and cost.
2. Segments products by revenue to identify High‑Performers, Mid‑Range, or Low‑Performers.
3. Aggregates product‑level metrics:
   - total orders
   - total sales
   - total quantity sold
   - total customers (unique)
   - lifespan (in months)
4. Calculates valuable KPIs:
   - recency (months since last sale)
   - average Product revenue (APR)
   - average monthly revenue
*/
create view gold.product_report as
	WITH CTE_product AS (
	  SELECT
		p.product_key,
		p.category,
		p.subcategory,
		p.product_name,
		p.product_number,
		p.cost,
		f.customer_key,
		f.order_number,
		f.order_date,
		f.price,
		f.sales_amount,
		f.quantity
	  FROM gold.fact_sales f
	  LEFT JOIN gold.dim_products p
	  ON f.product_key = p.product_key
	  where order_date is  not null
	), CTE_pro_agg as
		(SELECT
		  product_key,
		  category,
		  subcategory,
		  product_name,
		  COUNT(DISTINCT order_number) AS total_orders,
		  SUM(sales_amount) AS total_sales,
		  SUM(quantity) AS total_quantity,
		  COUNT(DISTINCT customer_key) AS total_customers,
		  DATEDIFF(month, MIN(order_date), MAX(order_date)) AS life_span,
		  count(distinct product_key) as total_Products
		FROM CTE_product
		GROUP BY
		  product_key,
		  category,
		  subcategory,
		  product_name
		)
	  
	 select
	 --calculating the KPI's
		 product_key,
		 category,
		 subcategory,
		 product_name,
		--product segmentation based on sales
		case when total_sales<100000 then 'Low_Performers'
			  when total_sales between 100000 and 700000 then 'Mid_Range'
			  else 'High_Performers'
			  end Product_performance_saleswise,
		--calculate average revenue 
		case when total_products=0 then 0
			 else total_sales/total_products
		end avg_product_revenue,
		--calculating the monthly wise revenue 
		case when life_span=0 then total_sales
			 else total_sales/life_span
		end avg_monthly_revenue
	from  CTE_pro_agg;
--testing the created product view 
select * from gold.product_report
