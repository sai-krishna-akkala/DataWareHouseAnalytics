# DataWareHouse Analytics Project
## 📊 Sales Data Analytics SQL Project
### 🔍 Project Purpose
Transform raw sales and dimension data into two strategic analytics views—Customer Report and Product Report—within the gold schema. These views turn transactional data into actionable business intelligence, ideal for dashboards and strategic decision-making.

### 🧪 Business Impact
Customer Report enables targeted marketing and retention by segmenting customers into VIP/Regular/New, tracking customer lifecycles, and calculating Lifetime Value metrics like AOV and monthly spend.

Product Report identifies top- and low-performing SKUs, supports pricing strategy, and highlights sales trends by product.

Building these insights via SQL demonstrates the ability to contribute to data-driven company goals, dashboards, and reporting workflows.

### 🗺️ Project Scope & Workflow
#### Exploration & EDA
Use INFORMATION_SCHEMA.TABLES and COLUMNS to inspect schema.

Explore dimension attributes: country (customers), category/subcategory (products).

Get temporal range via MIN(order_date) and MAX(order_date); compute data span.

#### Metric Aggregation
Compute core measures: total sales (SUM), quantity sold, average price, distinct orders/customers/products.

Summarize key metrics via combined UNION query.

#### Dimensional Analysis
Analyze customers by country/gender.

Analyze products by category: count, avg cost, revenue per category.

Rank products by top and bottom performers using both TOP N + ORDER BY and window functions (RANK()).

#### Temporal & Trend Analysis
Track sales over time by day, year, and month.

Compute running totals and moving averages with window functions.

Perform YoY sales change analysis, product-wise, using LAG().

#### Proportional & Segmented Analytics
Compute part-to-whole revenue share by product category.

Segment products by cost bands and count in each category.

Segment customers as VIP/Regular/New based on life span and spend thresholds.

#### Report View Creation
Customer Report View: merges aggregates and KPIs per customer (orders, spend, age, segmentation).

Product Report View: aggregates product performance including sales count, segmentation tiers, average revenue metrics.


