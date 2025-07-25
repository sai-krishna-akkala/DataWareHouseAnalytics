/*=========================================================================================================
 Section: Time-Series Sales Trend Analysis
 Purpose:
     1. Track daily total sales over time.
     2. Summarize sales by year (revenue trends year-over-year).
     3. Provide month-level detail: year, month, sales volume, customer count, quantity sold.
Why it matters:
     Time series analysis enables business users to spot trends, seasonality,
     and anomalies—critical for forecasting, planning, and reporting.
Warning / Caveats:
       • Ensure 'order_date' data is complete and consistently formatted.
       • Watch out for missing or duplicate dates which can skew trends.
       • Aggregate calculations assume no suppressed or back-dated entries.
       • Date boundaries (fiscal vs. calendar) should be clearly defined if needed.
=======================================================================================================*/

--1.change of sales over time by order date
 select
  order_date,
  sum(sales_amount) as total_amount
from gold.fact_sales
where order_date is not null
group by order_date
order by order_date;
--2.chnage of sales by year
 select
  datepart(year,order_date) as year_1,
  sum(sales_amount) as total_amount
from gold.fact_sales
where order_date is not null
group by datepart(year,order_date)
order by datepart(year,order_date) desc;
--3. sales summary by month wise 
select
  datepart(year,order_date) as year_1,
  datepart(month,order_date) month_1,
  sum(sales_amount) as total_amount,
  count(customer_key) total_cust,
  sum(quantity) as total_qunatity
from gold.fact_sales
where order_date is not null
group by datepart(year,order_date),datepart(month,order_date)
order by datepart(year,order_date), datepart(month,order_date) desc;
