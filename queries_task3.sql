/*
============================================================
DATA ANALYST INTERNSHIP – Task 3
SQL Basics – Filtering + Sorting + Aggregations

Deliverables required (as per task PDF):
  1) queries_task3.sql
  2) sales_summary.csv (export of a summary query)
  3) README.md

This SQL file contains:
- Basic SELECT queries
- Filtering using WHERE
- Sorting using ORDER BY
- Aggregations using SUM/AVG/COUNT with GROUP BY
- HAVING clause to filter grouped results
- BETWEEN for date ranges (monthly report)
- LIKE for pattern search (customer names)

Dataset assumption: "Superstore" style CSV imported into a table named `superstore`.
If your table name differs, replace `superstore` accordingly.
============================================================
*/

/* ---------------------------------------------------------
SECTION 0: Quick sanity checks (understand columns & rows)
--------------------------------------------------------- */

-- 0.1 View first 10 rows
SELECT *
FROM superstore
LIMIT 10;

-- 0.2 Count total records (to verify matches CSV row count)
SELECT COUNT(*) AS total_rows
FROM superstore;

-- 0.3 List distinct categories (helps validate values)
SELECT DISTINCT category
FROM superstore
ORDER BY category;

-- 0.4 List distinct regions (helps validate values)
SELECT DISTINCT region
FROM superstore
ORDER BY region;


/* ---------------------------------------------------------
SECTION 1: Filtering using WHERE
--------------------------------------------------------- */

-- 1.1 Filter only Technology category orders
SELECT order_id, order_date, customer_name, category, sub_category, sales, profit
FROM superstore
WHERE category = 'Technology'
ORDER BY sales DESC;

-- 1.2 Filter only orders with negative profit (loss-making orders)
SELECT order_id, order_date, customer_name, category, sub_category, sales, profit
FROM superstore
WHERE profit < 0
ORDER BY profit ASC;

-- 1.3 Filter only Corporate segment orders
SELECT order_id, order_date, customer_name, segment, sales, profit
FROM superstore
WHERE segment = 'Corporate'
ORDER BY order_date DESC;

-- 1.4 Filter orders for a specific state (example: California)
SELECT order_id, order_date, customer_name, state, city, sales, profit
FROM superstore
WHERE state = 'California'
ORDER BY sales DESC;


/* ---------------------------------------------------------
SECTION 2: Sorting using ORDER BY (Top items, highest sales)
--------------------------------------------------------- */

-- 2.1 Top 10 highest single-order sales rows
SELECT order_id, order_date, product_name, category, sub_category, sales, profit
FROM superstore
ORDER BY sales DESC
LIMIT 10;

-- 2.2 Top 10 most profitable rows
SELECT order_id, order_date, product_name, category, sub_category, sales, profit
FROM superstore
ORDER BY profit DESC
LIMIT 10;


/* ---------------------------------------------------------
SECTION 3: Aggregations + GROUP BY (summary reports)
--------------------------------------------------------- */

-- 3.1 Category level summary
SELECT
  category,
  COUNT(*) AS total_orders,
  ROUND(SUM(sales), 2) AS total_sales,
  ROUND(AVG(sales), 2) AS avg_sales,
  ROUND(SUM(profit), 2) AS total_profit,
  ROUND(AVG(profit), 2) AS avg_profit
FROM superstore
GROUP BY category
ORDER BY total_sales DESC;

-- 3.2 Region level summary
SELECT
  region,
  COUNT(*) AS total_orders,
  ROUND(SUM(sales), 2) AS total_sales,
  ROUND(SUM(profit), 2) AS total_profit
FROM superstore
GROUP BY region
ORDER BY total_sales DESC;

-- 3.3 Category + Region matrix summary
SELECT
  category,
  region,
  COUNT(*) AS total_orders,
  ROUND(SUM(sales), 2) AS total_sales,
  ROUND(SUM(profit), 2) AS total_profit
FROM superstore
GROUP BY category, region
ORDER BY category, total_sales DESC;


/* ---------------------------------------------------------
SECTION 4: HAVING clause (filter grouped results)
--------------------------------------------------------- */

-- 4.1 Show only categories having total sales > 100000
SELECT
  category,
  ROUND(SUM(sales), 2) AS total_sales,
  ROUND(SUM(profit), 2) AS total_profit
FROM superstore
GROUP BY category
HAVING SUM(sales) > 100000
ORDER BY total_sales DESC;

-- 4.2 Show only regions having positive profit overall
SELECT
  region,
  ROUND(SUM(sales), 2) AS total_sales,
  ROUND(SUM(profit), 2) AS total_profit
FROM superstore
GROUP BY region
HAVING SUM(profit) > 0
ORDER BY total_profit DESC;


/* ---------------------------------------------------------
SECTION 5: BETWEEN (date range) + monthly sales report
--------------------------------------------------------- */

-- 5.1 Orders in a specific date range
-- NOTE: ensure order_date is of DATE type or compatible
SELECT order_id, order_date, customer_name, sales, profit
FROM superstore
WHERE order_date BETWEEN '2017-01-01' AND '2017-12-31'
ORDER BY order_date;

-- 5.2 Monthly sales summary (PostgreSQL version)
-- If using MySQL, use DATE_FORMAT(order_date, '%Y-%m') instead.
-- PostgreSQL:
SELECT
  TO_CHAR(order_date, 'YYYY-MM') AS month,
  ROUND(SUM(sales), 2) AS total_sales,
  ROUND(SUM(profit), 2) AS total_profit,
  COUNT(*) AS total_orders
FROM superstore
GROUP BY TO_CHAR(order_date, 'YYYY-MM')
ORDER BY month;

-- 5.3 Monthly sales summary (MySQL version)
-- MySQL:
-- SELECT
--   DATE_FORMAT(order_date, '%Y-%m') AS month,
--   ROUND(SUM(sales), 2) AS total_sales,
--   ROUND(SUM(profit), 2) AS total_profit,
--   COUNT(*) AS total_orders
-- FROM superstore
-- GROUP BY DATE_FORMAT(order_date, '%Y-%m')
-- ORDER BY month;


/* ---------------------------------------------------------
SECTION 6: LIKE (pattern search)
--------------------------------------------------------- */

-- 6.1 Customers whose name starts with 'A'
SELECT DISTINCT customer_name
FROM superstore
WHERE customer_name LIKE 'A%'
ORDER BY customer_name;

-- 6.2 Customers whose name contains 'Singh'
SELECT DISTINCT customer_name
FROM superstore
WHERE customer_name LIKE '%Singh%'
ORDER BY customer_name;

-- 6.3 Products containing 'Chair'
SELECT DISTINCT product_name
FROM superstore
WHERE product_name LIKE '%Chair%'
ORDER BY product_name;


/* ---------------------------------------------------------
SECTION 7: Interview question query – Top 5 customers by spend
--------------------------------------------------------- */

-- Top 5 customers by total spend (Sales)
SELECT
  customer_name,
  ROUND(SUM(sales), 2) AS total_spend,
  COUNT(*) AS total_orders,
  ROUND(AVG(sales), 2) AS avg_order_value
FROM superstore
GROUP BY customer_name
ORDER BY total_spend DESC
LIMIT 5;


/* ---------------------------------------------------------
SECTION 8: Export-ready summary query (sales_summary.csv)
--------------------------------------------------------- */

-- This is the exact query you can export to CSV as: sales_summary.csv
SELECT
  category,
  region,
  ROUND(SUM(sales), 2) AS total_sales,
  ROUND(SUM(profit), 2) AS total_profit,
  COUNT(*) AS total_orders
FROM superstore
GROUP BY category, region
ORDER BY category, region;
