# SQL Sales  Analytics Project
Welcome to the documentation for the **SQL Retail Analytics Project**. This project explores a retail dataset using SQL to extract key business insights, build reusable reports, and showcase advanced analytics techniques.
## 📌 Project Objective
To analyze sales, customers, and products using SQL and generate comprehensive metrics, trends, and reports that support business decisions.
## Data Sets Used
### 📄 Table: `gold.dim_customers`

| Attribute         | Data Type | Example Value  | Description                                                                 |
|------------------|-----------|----------------|-----------------------------------------------------------------------------|
| `customer_key`    | `int64`   | `1`            | Surrogate key used for internal joins (primary key in the dimension table).|
| `customer_id`     | `int64`   | `11000`        | Business/customer ID (natural key from the source system).                 |
| `customer_number` | `object`  | `AW00011000`   | Alphanumeric identifier assigned to the customer (e.g., account number).   |
| `first_name`      | `object`  | `Jon`          | Customer’s first name.                                                     |
| `last_name`       | `object`  | `Yang`         | Customer’s last name.                                                      |
| `country`         | `object`  | `Australia`    | Country of residence.                                                      |
| `marital_status`  | `object`  | `Married`      | Customer's marital status (e.g., Married, Single).                         |
| `gender`          | `object`  | `Male`         | Gender of the customer.                                                    |
| `birthdate`       | `object`  | `10/6/1971`    | Date of birth (string format, should be parsed to `datetime`).            |
| `create_date`     | `object`  | `10/6/2025`    | Date when the customer was registered or created in the system.            |
### 📄 Table: `gold.dim_products`

| Attribute         | Data Type | Example Value             | Description                                                                  |
|------------------|-----------|---------------------------|------------------------------------------------------------------------------|
| `product_key`     | `int64`   | `1`                       | Surrogate key used for internal joins (primary key in the dimension table). |
| `product_id`      | `int64`   | `210`                     | Business-level product identifier from the source system.                    |
| `product_number`  | `object`  | `FR-R92B-58`              | Unique product code or SKU.                                                  |
| `product_name`    | `object`  | `HL Road Frame - Black-58`| Human-readable name of the product.                                          |
| `category_id`     | `object`  | `CO_RF`                   | Encoded ID used to represent the product category.                           |
| `category`        | `object`  | `Components`              | High-level product grouping/category.                                        |
| `subcategory`     | `object`  | `Road Frames`             | More specific classification within the main category.                       |
| `maintenance`     | `object`  | `Yes`                     | Indicates if the product requires regular maintenance.                       |
| `cost`            | `int64`   | `0`                       | Cost to the business (can be 0 or missing if not captured).                  |
| `product_line`    | `object`  | `Road`                    | Product line or branding under which it's sold.                              |
| `start_date`      | `object`  | `2003-07-01`              | Launch date or date the product was added to the system.                     |
### 📄 Table: `gold.fact_sales`

| Attribute         | Data Type | Example Value | Description                                                               |
|------------------|-----------|----------------|---------------------------------------------------------------------------|
| `order_number`    | `object`  | `SO54496`      | Unique identifier for the sales order.                                   |
| `product_key`     | `int64`   | `282`          | Foreign key referencing the product sold (`dim_products.product_key`).   |
| `customer_key`    | `int64`   | `5400`         | Foreign key referencing the customer who placed the order.               |
| `order_date`      | `object`  | `2013-03-16`   | Date when the order was placed.                                          |
| `shipping_date`   | `object`  | `2013-03-23`   | Date when the product was shipped.                                       |
| `due_date`        | `object`  | `2013-03-28`   | Promised delivery date to the customer.                                  |
| `sales_amount`    | `int64`   | `25`           | Total revenue from the sale (i.e., price × quantity).                    |
| `quantity`        | `int64`   | `1`            | Number of items sold in the order.                                       |
| `price`           | `int64`   | `25`           | Price per unit of the product sold.                                      |
## 🧰 Tools & Technologies
- SQL Server / Synapse Analytics
- SQL Window Functions, CTEs, Views
- GitHub for version control
## 📈 Key Capabilities Demonstrated
- Data Profiling & Exploration  
- Metric Aggregation & Ranking  
- Customer & Product Segmentation  
- Time Series & Trend Analysis  
- Cumulative and Comparative (YOY) KPIs  
- Report Creation using Views
## 🚀 Getting Started
1. Clone the repo.
2. Navigate to the `Scripts/` directory.
3. Run scripts in sequence: `00_Db_exploration.sql` → `11_products_report.sql`.
4. Explore the views `gold.customers_report` and `gold.products_report`.
## 🤝 Contributions
Contributions or suggestions to improve this analysis are welcome. Feel free to raise issues or submit pull requests

## 📬 Contact
For any queries or collaboration ideas, reach out via 📧 [saikrishnaakkala9@gmail.com](mailto:saikrishnaakkala9@gmail.com)


