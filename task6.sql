-- Task 6: Sales Trend Analysis (MySQL)
-- Created for uploaded dataset with columns:
-- Transaction ID, Date, Product Category, Product Name, Units Sold, Unit Price, Total Revenue, Region, Payment Method
-- NOTE: Adjust the LOAD DATA LOCAL INFILE path below to the CSV file location on your machine when running in MySQL client or Workbench.

-- 1) Create database and table
CREATE DATABASE IF NOT EXISTS salesdb;
USE salesdb;

DROP TABLE IF EXISTS online_sales;
CREATE TABLE `online_sales` (
  `transaction_id` INT,
  `order_date` DATE,
  `product_category` VARCHAR(255),
  `product_name` VARCHAR(255),
  `units_sold` INT,
  `unit_price` DECIMAL(10,2),
  `total_revenue` DECIMAL(12,2),
  `region` VARCHAR(100),
  `payment_method` VARCHAR(100)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 2) Load CSV into table
-- Replace the path below with the full path to the CSV on the machine where your MySQL client runs.
-- Example (on this environment): '/mnt/data/187da438-6690-4bb2-a334-23d7b0030a16.csv'
-- If you get a 'The used command is not allowed with this MySQL version' error, enable local_infile or use Workbench import.
-- To enable (may require admin): SET GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE 'C:\Users\User\Downloads\archive (2)'
INTO TABLE online_sales
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(`transaction_id`,`order_date`,`product_category`,`product_name`,`units_sold`,`unit_price`,`total_revenue`,`region`,`payment_method`);

-- 3) Quick checks
SELECT COUNT(*) AS total_rows, COUNT(DISTINCT transaction_id) AS distinct_transactions FROM online_sales;
SELECT MIN(order_date) AS first_date, MAX(order_date) AS last_date FROM online_sales;
SELECT SUM(total_revenue) AS total_revenue FROM online_sales;

-- 4) Monthly revenue and order volume (year + month)
SELECT
  YEAR(order_date) AS year,
  MONTH(order_date) AS month,
  SUM(IFNULL(total_revenue,0)) AS monthly_revenue,
  COUNT(DISTINCT transaction_id) AS order_volume,
  ROUND(SUM(IFNULL(total_revenue,0)) / NULLIF(COUNT(DISTINCT transaction_id),0),2) AS avg_order_value
FROM online_sales
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY year, month;

-- 5) Top 3 months by sales (overall)
SELECT
  YEAR(order_date) AS year,
  MONTH(order_date) AS month,
  SUM(IFNULL(total_revenue,0)) AS monthly_revenue
FROM online_sales
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY monthly_revenue DESC
LIMIT 3;

-- 6) Monthly revenue for a specific year (example 2024)
SELECT
  MONTH(order_date) AS month,
  SUM(IFNULL(total_revenue,0)) AS monthly_revenue
FROM online_sales
WHERE YEAR(order_date) = 2024
GROUP BY MONTH(order_date)
ORDER BY monthly_revenue DESC;

-- 7) Additional helpful queries
-- Top 5 products by revenue
SELECT product_name, SUM(IFNULL(total_revenue,0)) AS product_revenue
FROM online_sales
GROUP BY product_name
ORDER BY product_revenue DESC
LIMIT 5;

-- Revenue by region and month
SELECT region, YEAR(order_date) AS year, MONTH(order_date) AS month, SUM(IFNULL(total_revenue,0)) AS revenue
FROM online_sales
GROUP BY region, YEAR(order_date), MONTH(order_date)
ORDER BY region, year, month;
