Sure! Below is the clean and properly formatted **Markdown** version of your `README.md` file. You can directly copy and paste this into your GitHub README.

---

````markdown
# 🛍️ Retail Sales Analysis

## 📌 Project Overview

**Project Title:** Retail Sale Analysis  
**Objective:** Analyze retail sales data to extract insights and answer business-related questions.

---

## 🎯 Objectives

1. Setup the data  
2. Clean the data  
3. Perform Exploratory Data Analysis  
4. Answer Business Questions  

---

## 🗄️ 1. Database Setup

### Create Table

```sql
CREATE TABLE retail_sales (
  transactions_id INT PRIMARY KEY,
  sale_time TIME,
  customer_id INT,
  gender VARCHAR(10),
  age INT,
  category VARCHAR(15),
  quantiy INT,
  price_per_unit FLOAT,
  cogs FLOAT,
  total_sale FLOAT
);
````

---

## 🔍 2. Check the Data

```sql
SELECT * FROM retail_sales LIMIT 10;
```

---

## 🧹 3. Data Exploration and Cleaning

### A. Data Cleaning

* **Check Unique Customers**

```sql
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
```

* **Check Null Values**

```sql
SELECT * FROM retail_sales
WHERE customer_id IS NULL OR gender IS NULL OR age IS NULL OR
      category IS NULL OR quantiy IS NULL OR price_per_unit IS NULL OR
      cogs IS NULL OR total_sale IS NULL;
```

* **Determine Average Age**

```sql
SELECT AVG(age) FROM retail_sales;
```

* **Update Missing Age Values**

```sql
UPDATE retail_sales SET age = 41 WHERE age IS NULL;
```

* **Delete Remaining Nulls**

```sql
DELETE FROM retail_sales
WHERE customer_id IS NULL OR gender IS NULL OR category IS NULL OR
      quantiy IS NULL OR price_per_unit IS NULL OR cogs IS NULL OR
      total_sale IS NULL;
```

---

### B. Data Exploration

* **Total Transactions**

```sql
SELECT COUNT(*) FROM retail_sales;
```

* **Total Unique Customers**

```sql
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
```

* **Number of Categories**

```sql
SELECT COUNT(DISTINCT category) FROM retail_sales;
```

---

## 📊 4. Data Analysis and Business Questions

### Q1. Sales on '2022-11-05'

```sql
SELECT * FROM retail_sales WHERE sale_date = '2022-11-05';
```

---

### Q2. Clothing Sales (Quantity > 3) in Nov 2022

```sql
SELECT * FROM retail_sales
WHERE category = 'Clothing'
  AND quantiy > 3
  AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11';
```

---

### Q3. Total Sales Per Category

```sql
SELECT category, SUM(total_sale) AS Net_Sales, COUNT(*) AS total_orders
FROM retail_sales
GROUP BY category;
```

---

### Q4. Average Age of 'Beauty' Customers

```sql
SELECT ROUND(AVG(age), 2)
FROM retail_sales
WHERE category = 'Beauty';
```

---

### Q5. Transactions with Total Sale > 1000

```sql
SELECT * FROM retail_sales WHERE total_sale > 1000;
```

---

### Q6. Transactions by Gender and Category

```sql
SELECT gender, category, COUNT(*)
FROM retail_sales
GROUP BY gender, category;
```

---

### Q7. Average Sale Per Month & Best-Selling Month in Each Year

```sql
WITH temp1 AS (
  SELECT EXTRACT(YEAR FROM sale_date) AS year,
         TO_CHAR(sale_date, 'YYYY-MM') AS sale_month,
         ROUND(AVG(total_sale)::NUMERIC, 2) AS avg_sale
  FROM retail_sales
  GROUP BY 1, 2
)
SELECT sale_month, avg_sale
FROM temp1
WHERE (year, avg_sale) IN (
  SELECT year, MAX(avg_sale)
  FROM temp1
  GROUP BY year
)
ORDER BY sale_month;
```

---

### Q8. Top 5 Customers by Total Sales

```sql
SELECT customer_id, SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;
```

---

### Q9. Unique Customers by Category

```sql
SELECT COUNT(DISTINCT customer_id), category
FROM retail_sales
GROUP BY category;
```

---

### Q10. Orders by Time of Day (Shift)

```sql
SELECT
  CASE
    WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
    WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening'
  END AS time_period,
  SUM(quantiy) AS total_order
FROM retail_sales
GROUP BY time_period;
```

---

### Q11. Customers Who Purchased from All Categories

**Method 1: Using INTERSECT**

```sql
SELECT DISTINCT customer_id FROM retail_sales WHERE category = 'Electronics'
INTERSECT
SELECT DISTINCT customer_id FROM retail_sales WHERE category = 'Clothing'
INTERSECT
SELECT DISTINCT customer_id FROM retail_sales WHERE category = 'Beauty';
```

**Method 2: Using Subquery**

```sql
SELECT COUNT(DISTINCT customer_id) AS no_of_customer
FROM (
  SELECT customer_id
  FROM retail_sales
  GROUP BY customer_id
  HAVING COUNT(DISTINCT category) = (
    SELECT COUNT(DISTINCT category) FROM retail_sales
  )
) AS customers_who_bought_all;
```

---

## 📁 Files

* `SQL-Retail Sales Analysis_utf.csv` - Source dataset
* `README.md` - Project documentation
* SQL scripts (if separated)

---

## ✅ Conclusion

This project showcases how to explore and clean data, perform SQL-based analysis, and extract meaningful insights to support retail business decision-making.

---

```


