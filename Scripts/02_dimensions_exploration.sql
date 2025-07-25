--Lets explore the dimensions in tables
--1. explore the customers from which country they are coming from
select distinct country from gold.dim_customers;

--2.explore the Product categories 'The Major Categories'
select distinct category, subcategory, product_name from gold.dim_products
order by 1,2,3;

-- exporation of dates
--1. finding the first and last order date
select 
min(order_date) as first_order , 
max(order_date) as last_order 
from gold.fact_sales;
--2. how many years sales date is available?
select
 datediff(year,min(order_date),max(order_date)) sales_date_range
from gold.fact_sales;
--3.finding youngest and oldest customer
select
  min(birthdate) oldest_birthdate,
  datediff(year,min(birthdate),getdate()) as oldest_age,
  max(birthdate) youngest_birthdate,
  datediff(year,max(birthdate),getdate()) as youngest_age
from gold.dim_customers;
