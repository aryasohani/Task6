# Task 6: Sales Trend Analysis Using Aggregations

Sales Trend Analysis Using MySQL
 Objective
Analyze monthly revenue and order volume from an online sales dataset using SQL aggregation functions.

Dataset
Columns:
Transaction ID → Unique order identifier (similar to order_id)
Date → Order date (order_date)
Product Category
Product Name
Units Sold
Unit Price
Total Revenue → Order amount
Region
Payment Method

🛠 Steps Performed
Created database & table in MySQL (salesdb and online_sales).

Imported CSV into MySQL using:

sql
Copy
Edit
LOAD DATA LOCAL INFILE 'path/to/orders.csv'
INTO TABLE online_sales
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;
Verified data (row count, date range, revenue sum).

Ran analysis queries:
Monthly revenue & order volume
Top 3 months by revenue
Revenue by product & region
