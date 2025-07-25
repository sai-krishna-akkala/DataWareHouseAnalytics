/*===============================================================
now lets explore the measures to understand the big numbers 
=================================================================*/
--1.find the toatal sales
select
  sum(sales_amount) total_sales
from gold.fact_sales;
--2.finding how many items are sold
select
  sum(quantity) total_quantity
from gold.fact_sales;
--3.finding the average selling price
select
   avg(price) avg_sp
from gold.fact_sales;
--4.finding the total number of orders
select
  count( distinct order_number) as total_orders
from gold.fact_sales;
select
  count( distinct order_number) as total_orders
from gold.fact_sales;
--5.finding the total no.of products
select
  count(product_key) total_products
from gold.dim_products;
--6.finding the total no.of customers
select
  count(customer_id) as total_customers
from gold.dim_customers;
--7.total no.of customers placed orders
select
  count( distinct customer_key) as total_customers
from gold.fact_sales;

--generate a report of key Metrics 
select 'Total Sales' as measure_name, sum(sales_amount) measure_value from gold.fact_sales
union all
select 'Total_Quantity' ,sum(quantity) from gold.fact_sales
union all
select 'Avg_salesprice' , avg(price) from gold.fact_sales
union all
select 'Total_orders',count( distinct order_number) from gold.fact_sales
union all
select 'Total_Products',count(product_key) from gold.dim_products
union all
select 'Total_Customers',count(customer_id) from gold.dim_customers
union all
select'Toatl_cust_orders',count( distinct customer_key) from gold.fact_sales;
