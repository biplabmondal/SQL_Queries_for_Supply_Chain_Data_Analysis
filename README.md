# SQL Queries for Supply Chain Data Analysis

Welcome to this repository featuring SQL queries designed for analyzing various aspects of **supply chain data**, particularly focusing on product sales, customer segments, and order details. The provided SQL queries are tailored for extracting meaningful insights from the supply_db dataset, which contains comprehensive data on products, orders, customers, and more. This collection of queries aims to assist in decision-making by providing detailed reports and analytics related to sales trends, customer behavior, and product performance.

**Included Files**

1. Supply Chain Data: An attached XLSX file containing raw data for analysis.
2. supply_db Schema: The database schema to replicate the SQL environment.
3. Supply Chain Entity Relationship Diagram.
4. Two SQL files contains query to retrieve data. 

**Key Features**

1. Golf-related Products: Queries to list products related to golf, identify the most sold golf items, and segment orders based on sales and customer behavior.
2. Customer Segments: Analysis on orders segmented by customer types and segments (e.g., "Home Office", "Consumer"). This includes order counts, percentage splits, and detailed order behavior.
3. Nike Sales Analysis: A query that tracks month-wise sales and quantities for Nike products, providing insights into how these products are performing over time.
4. Costliest Products: Identifies the top 5 most expensive products in the database, displaying their details along with the product price.
5. Cash Customer Orders: A query that isolates orders placed through 'CASH' type transactions and ranks the top items by sales and order count.
6. Customer Orders in Texas: Identifies orders from Texas state with specific address criteria, helping to filter and analyze location-based orders.
7. Department and Order Segmentation: For customers from specific segments (e.g., "Home Office") and certain product departments ("Apparel" or "Outdoors"), these queries provide insights into order patterns and customer preferences.
8. Shipping Mode Analysis: A detailed ranking of shipping modes where shipping days were underestimated, helping to optimize delivery processes.

**Dataset**

The queries utilize data from the supply_db, which includes several tables:
* product_info: Product details such as names, prices, and categories.
* category: Product category details.
* department: Department details associated with each product.
* orders: Order information including status, shipping days, and customer data.
* ordered_items: Items within each order, including quantity and sales figures.
* customer_info: Customer details including segment and address information.

**Queries Overview**

The SQL queries range from simple selects to more advanced aggregation techniques, including:
* Joins: Combining information across multiple tables.
* Grouping and Aggregation: Summing sales, counting orders, etc.
* Subqueries: Using subqueries to calculate percentages and rankings.
* Window Functions: Employing functions like ROW_NUMBER(), DENSE_RANK(), and COUNT() for ranking and partitioning data.
* Date Formatting: Grouping and analyzing sales data based on date ranges, such as monthly analysis.

**Setup**

1. Download the SQL files from this repository.
2. Access the supply_db database.
3. Execute the queries from the provided SQL files in SQL environment.
