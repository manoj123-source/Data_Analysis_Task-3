# Task 3 – SQL Basics (Filtering + Sorting + Aggregations)

This repository contains the **final deliverables** for **Data Analyst Internship – Task 3**.

## ✅ Files in this submission

- `queries_task3.sql` – All SQL queries written for the task
- `sales_summary.csv` – Exported output of a summary report query
- `README.md` – Documentation of what I did and what each query means

---

## Dataset used
The task suggests any one of the following:
- Superstore CSV dataset (import into SQL)
- Retail Sales dataset
- Chinook database

In my script, I used the common **Superstore** table structure:

**Table name:** `superstore`

Common columns referenced:
- `order_id`, `order_date`, `ship_date`
- `customer_name`, `segment`
- `region`, `state`, `city`
- `category`, `sub_category`
- `sales`, `profit`, `discount`, `quantity`

> If your dataset column names differ, just rename the fields in the queries.

---

## What I did (Step-by-step)

### 1) Basic exploration queries
- Checked total row count
- Previewed sample rows
- Listed distinct values like category/region

### 2) Filtering using `WHERE`
Examples included:
- Filter by `category = 'Technology'`
- Filter by `region = 'West'`
- Filter by `profit < 0` to find loss-making orders

### 3) Sorting using `ORDER BY`
Examples included:
- Top sales orders
- Top profit orders
- Lowest profit / worst orders

### 4) Aggregations using `GROUP BY`
Examples included:
- Total sales and profit by category
- Total sales by region
- Total sales by category & region

### 5) `HAVING` clause usage
Used `HAVING` to filter **aggregated results**, for example:
- Show only categories with `SUM(sales) > 100000`

### 6) `BETWEEN` and `LIKE`
Examples included:
- Monthly sales report by filtering `order_date` between a date range
- Search customers using pattern matching (`LIKE '%Singh%'`)

### 7) Export output as CSV
The file `sales_summary.csv` is an exported summary report format:
- category
- region
- order_count
- total_sales
- total_profit
- avg_sales_per_order
- avg_discount

---

## Interview Q&A (from task sheet)

### ✅ 1) Difference between `WHERE` and `HAVING`
- `WHERE` filters **rows before grouping**
- `HAVING` filters **groups after GROUP BY**

### ✅ 2) How does `GROUP BY` work?
It groups rows by one or more columns and allows aggregate functions like:
- `SUM()`
- `AVG()`
- `COUNT()`

### ✅ 3) When do you use `ORDER BY`?
To sort the final output:
- ascending (`ASC`)
- descending (`DESC`)

### ✅ 4) What happens if a column has NULL values in SUM/AVG?
- `SUM()` and `AVG()` ignore `NULL` values

### ✅ 5) Query to find top 5 customers by total spend
Included in `queries_task3.sql`:
```sql
SELECT customer_name, SUM(sales) AS total_spend
FROM superstore
GROUP BY customer_name
ORDER BY total_spend DESC
LIMIT 5;
```

---

## How to run
1. Import your CSV dataset into SQL as table `superstore`
2. Run queries from `queries_task3.sql`
3. Export a query output as `sales_summary.csv`

✅ Done.
