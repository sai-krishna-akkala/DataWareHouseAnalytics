/***********************************************************************
 Purpose: Identify Top‑n and Bottom‑n performers in sales data
 Section: Ranking Analysis (Top 5 and Bottom 5 products by revenue,
          and lowest‑activity customers)
 Why it matters: Enables business leaders to quickly pinpoint
                 high-revenue SKUs for prioritization and underperformers
                  for investigation or strategic action.
-Key Techniques:
    • Native SQL: Uses TOP N + ORDER BY for fast filtering.
    • Window Functions: Uses RANK() OVER(...) to support ties
      and scalability via partitioned ranking.
    • Clean separation of logic: inner subquery builds ranks,
      outer filter applies the Top/Bottom threshold.
***************************************************************************/
 --1.which 5 products generate the highest revenue
 select
	 top 5
	 p.product_name,
	 sum(f.sales_amount) total_revenue
 from gold.fact_sales f
 left join gold.dim_products p
 on f.product_key=p.product_key
 group by p.product_name
 order by total_revenue desc;
 -- the above can be solved using window function also
 select
 product_name,
 amount
 from
	 (select
		 p.product_name,
		 sum(f.sales_amount)  amount,
		 RANK() over(order by sum(f.sales_amount) desc) as rn
	 from gold.fact_sales f
	 left join gold.dim_products p
	 on f.product_key=p.product_key
	 group by p.product_name
	 )temp
 where rn < = 5

 --2.worst 5 performing products in terms of sales 
 select
	 top 5
	 p.product_name,
	 sum(f.sales_amount) total_revenue
 from gold.fact_sales f
 left join gold.dim_products p
 on f.product_key=p.product_key
 group by p.product_name
 order by total_revenue;
   -- we can solve above using window function
 select
 product_name,
 amount
 from
	(select
		 p.product_name,
		 sum(f.sales_amount)  amount,
		 RANK() over(order by sum(f.sales_amount)) as rn
	 from gold.fact_sales f
	 left join gold.dim_products p
	 on f.product_key=p.product_key
	 group by p.product_name
	 )temp
 where rn < = 5
 --3. top 3 customers with fewest orders
 select
	 top 3
	 c.customer_key,
	 c.first_name,
	 c.last_name,
	 count(distinct f.order_number) total_orders
 from gold.dim_customers c
 left join gold.fact_sales f
 on f.customer_key=c.customer_key
 group by c.customer_key,c.first_name,c.last_name
 order by total_orders;
