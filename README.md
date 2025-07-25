# 📊 Sales Data Analytics SQL Project

### 🔍 Project Purpose
Transform raw sales and dimension data into two strategic analytics views—Customer Report and Product Report—within the gold schema. These views enable actionable BI insights for dashboards and strategic decision-making.

### ✅ At-a-Glance Highlights
- Built **customer_report** and **product_report** T-SQL views
- Segmented ~100K customers into VIP / Regular / New
- Identified top and bottom 5 products using rankings
- Computed sales trends, YOY change, and proportional revenue analytics

### 🌍 Business Impact
- Customer segmentation supports targeted marketing and retention
- SKU analytics drive pricing and inventory decisions

### 🧪 Project Scope & Workflow
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

### 🛠️ How to Run
1. Run the schema exploration script.
2. Build the reporting views via provided SQL files.
3. Execute queries to preview results.
4. Integrate views with BI tools for dashboards.

### 🧰 Skills & Tools Used
- SQL (CTEs, window functions: RANK(), LAG(),SUM(),AVG(),SUB-QUERIES,VIEWs)
- KPI design: recency, AOV, customer segmentation,YOY
- BI-ready SQL views for dashboard integration

### 🧾 Sample Output
| customer_key | segment | total_sales | avg_order_value | lifespan_months |
|--------------|---------|-------------|------------------|-----------------|
| 12345        | VIP     | $12,345     | $450             | 18              |



