/*=================================================================================================
  SECTION: Cumulative & Trend Analysis

  PURPOSE:
    • Produce monthly total sales (via DATETRUNC)
    • Compute running total and moving average over annual sales
    • Conduct Year‑over‑Year product-level analysis using window functions

  BUSINESS VALUE:
    Enables stakeholders to identify upward/downward trends, seasonal effects,
    and per-product performance changes—critical for strategic forecasting.

  DATA QUALITY WARNINGS:
    • Confirm that order_date values are complete and uniformly formatted
    • Be cautious of missing or duplicate dates which may mislead trend analysis
    • Check if historical updates or back‑dated entries influence past data
==================================================================================================*/

--1. caluculating the sales for each month
select
  datetrunc(month,order_date) as months,
  sum(sales_amount) as total_sales
from gold.fact_sales
where order_date is not null
group by datetrunc(month,order_date)
order by datetrunc(month,order_date);
--2.running total and moving average
select
years,
total_sales,
sum(total_sales) over(order by years) as running_total,
avg(avg_price) over(order by years) as moving_avg
from
	(select
	  datetrunc(year,order_date) as years,
	  sum(sales_amount) as total_sales,
	  avg(price) avg_price
	from gold.fact_sales
	where order_date is not null
	group by datetrunc(year,order_date)
	)temp

	--3. analysing the change in average sales  product wise and comapring the previous year sales i.e YOY analysis
with CTE_change_analysis as
	 (select
		  year(f.order_date) order_year,
		  p.product_name,
		  sum(f.sales_amount) as current_sales
	  from gold.fact_sales f
	  left join gold.dim_products p
	  on  f.product_key=p.product_key
	  where f.order_date is not null
	  group by year(f.order_date),p.product_name
	  )
select  
	order_year,
	product_name,current_sales,
	avg(current_sales) over(partition by product_name) avg_sales,
	current_sales-avg(current_sales) over(partition by product_name) differenceOfsales,
	case when current_sales-avg(current_sales) over(partition by product_name)>0 then 'Above Avg'
	     when current_sales-avg(current_sales) over(partition by product_name)<0 then 'Below Avg'
		 else 'Avg'
	end performance,
	--year-over-year analysis
	lag(current_sales) over(partition by product_name order by order_year) as Pre_year_sales,
	current_sales-lag(current_sales) over(partition by product_name order by order_year) as diff_pre,
	case when current_sales-lag(current_sales) over(partition by product_name order by order_year) >0 then 'Increase'
	     when current_sales-lag(current_sales) over(partition by product_name order by order_year)<0 then 'Decrease'
		 else 'No Change' 
		 end Pre_year_sales_comp
from CTE_change_analysis
order by product_name,order_year
