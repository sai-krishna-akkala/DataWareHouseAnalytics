/*=============================================================================================
  SECTION: Part‑to‑Whole (Proportional) Sales Analysis

  PURPOSE:
    • Calculate total sales per category.
    • Determine each category’s contribution to overall sales.

  BUSINESS VALUE:
    Supports stakeholders in identifying top-performing categories,
    optimizing inventory, and aligning marketing efforts.

  DATA QUALITY CONSIDERATIONS:
    • Verify that sales_amount values are accurate and complete.
    • Ensure categories are consistently defined and populated.
    • Avoid divide-by-zero errors: if overall sales = 0 or null, percentage may be invalid

===================================================================================================*/

with CTE_ptw as(
    select
	   p.category,
	   sum(f.sales_amount) as total_sales
	from gold.fact_sales f
	left join  gold.dim_products p
	on f.product_key=p.product_key
	group by  p.category
	)
select 
   category,
   total_sales,
   sum(total_sales) over()  as overallsales,
   concat(round(cast(total_sales as float)/(sum(total_sales) over())*100,2),'%') as percentage_of_total
from CTE_ptw
order by total_sales desc;
