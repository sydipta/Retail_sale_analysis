# Retail_sale_analysis
## Project Overview


**Project Title**: Retail Sale Analysys

## Objectives:

1. **Setup the data**
2. **Clean the data**
3. **Exploratory Data Analysis**
4. **Answer Business Questions**

### 1. Database setup
1. **Create Database**
2. **Create Table with the column names present in the file SQL-Reatail Sales Analysis_utf.csv**
3. **Insert the csv file**
'''sql
CREATE TABLE retail_sales
	(
		transactions_id INT PRIMARY KEY,
		sale_time TIME,	
		customer_id INT,
		gender VARCHAR(10),
		age INT,
		category VARCHAR(15),	
		quantiy	INT,
		price_per_unit FLOAT,
		cogs FLOAT,
		total_sale FLOAT
	);
'''
### 2. Check the data
'''sql
SELECT * FROM retail_sales
LIMIT 10;
'''
### 3. Data Exploration and Cleaning
## A. Data Cleaning
1. **Checking unique Customers**
'''sql
SELECT count(DISTINCT customer_id) FROM retail_sales;
'''
2. **Checking Null Vallues**
'''sql
select * from retail_sales
where
	customer_id is null
	or
	gender is null
	or
	age is null
	or 
	category is null
	or
	quantiy is null
	or
	price_per_unit is null
	or
	cogs is null
	or total_sale is null;
'''
3. **Determining Avg age to fill the age column**
'''sql
select avg(age) from retail_sales;
'''
4. **Updating age**
'''sql
update retail_sales
set age = 41
where age is null;
'''
5. **Deleteing other rows containing Null values**
'''sql
delete from retail_sales
where
	customer_id is null
	or
	gender is null
	or
	category is null
	or
	quantiy is null
	or
	price_per_unit is null
	or
	cogs is null
	or
  total_sale is null;
'''
## B. Data Exploration
1. **How many total transactions do we have?**
'''sql
SELECT COUNT(*) FROM retail_sales;
'''
2. **How many total customers did we have?**
'''sql
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
'''
3. **How many category do we have?**
'''sql
SELECT COUNT(DISTINCT category) FROM retail_sales;
'''

### Data analysis and question answers:
**Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05?**
'''sql
SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05';
'''
**Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing'and the quantity sold is more than 3 in the month of Nov-2022:**
'''sql
SELECT * FROM retail_sales
WHERE
	category = 'Clothing'
	AND 
	quantiy >3
	AND
	TO_CHAR(sale_date,'YYYY-MM')='2022-11';
'''	
**Q.3 Write a SQL query to calculate the total sales (total_sale) for each category:**
'''sql
SELECT category , SUM(total_sale) as Net_Sales, COUNT(*) as total_orders FROM retail_sales
GROUP BY category;
'''
**Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category:**
'''sql
SELECT ROUND(AVG(age),2) FROM retail_sales
WHERE category = 'Beauty';
'''
**Q.5 Write a SQL query to find all transactions wherethe total_sale is greater than 1000:**
'''sql
SELECT * FROM retail_sales
WHERE total_sale > 1000;
'''
**Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category:**
'''sql
SELECT gender , category , COUNT(*) FROM retail_sales
GROUP BY gender, category;
'''
**Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:**
'''sql
WITH temp1 AS
(
SELECT 
	EXTRACT (YEAR FROM sale_date) AS year,
	TO_CHAR(sale_date, 'YYYY-MM') as sale_month,
	ROUND(AVG(total_sale)::NUMERIC,2) AS avg_sale
FROM retail_sales
GROUP BY 1,2
ORDER BY 1
)
SELECT 
	 sale_month, avg_sale
FROM temp1
WHERE 
	(year, avg_sale) IN (SELECT 
	year,MAX(avg_sale) AS max_avg_sale
FROM temp1
GROUP BY 1)
ORDER BY 1;
'''
**Q.8 Write a SQL query to find the top 5 customers based on the highest total sales:**
'''sql
SELECT customer_id, SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;
'''
**Q.9 Write a SQL query to find the number of unique customers who purchased items from each category:**
'''sql
SELECT 
	COUNT(DISTINCT(customer_id)),
	category
FROM retail_sales
GROUP BY 2;
'''
**Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):**
'''sql
SELECT 
  CASE 
    WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
    WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening'
  END AS time_period,
  SUM(quantity) AS total_order
FROM retail_sales
GROUP BY time_period;
'''
**Q.11 Find customers who bought from each category:**

'''sql
SELECT DISTINCT(customer_id) FROM retail_sales WHERE category='Electronics'
INTERSECT
SELECT DISTINCT(customer_id) FROM retail_sales WHERE category='Clothing'
INTERSECT
SELECT DISTINCT(customer_id) FROM retail_sales WHERE category='Beauty';
'''
**2nd method**
'''sql
SELECT
	COUNT(DISTINCT customer_id) AS no_of_customer
FROM (SELECT customer_id
		FROM retail_sales
		GROUP BY customer_id
		HAVING COUNT(DISTINCT category)=(SELECT COUNT(DISTINCT category) FROM retail_sales)
		)AS customers_who_bought_all;
'''
