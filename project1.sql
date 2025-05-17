-- SQL retail sales analysis
create table sales

-- create table
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
SELECT * FROM retail_sales
LIMIT 10;
SELECT count(DISTINCT customer_id) FROM retail_sales
--Data cleaning--
--checking null values
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
--Determining avg age to fill
select avg(age) from retail_sales
--updating age
update retail_sales
set age = 41
where age is null;
--deleteing other null value containg rows
delete from retail_sales
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
	
--Data Exploration
--1.How many total transactions do we have? 
SELECT COUNT(*) FROM retail_sales; --1997
--2.How many total customers did we have?
SELECT COUNT(DISTINCT customer_id) FROM retail_sales; --155
--How many category do we have?
SELECT COUNT(DISTINCT category) FROM retail_sales; --3

--Data analysis and question answers

--Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05';

--Q.2 Write a SQL query to retrieve all transactions where the category is
--'Clothing'and the quantity sold is more than 4 in the month of Nov-2022:
SELECT * FROM retail_sales
WHERE
	category = 'Clothing'
	AND 
	quantiy >=4
	AND
	TO_CHAR(sale_date,'YYYY-MM')='2022-11';
	
--Q.3 Write a SQL query to calculate
--the total sales (total_sale) for each category.:
SELECT category , SUM(total_sale) as Net_Sales, COUNT(*) as total_orders FROM retail_sales
GROUP BY category

--Q.4 Write a SQL query to find the average age of customers who 
--purchased items from the 'Beauty' category.:
SELECT ROUND(AVG(age),2) FROM retail_sales
WHERE category = 'Beauty';

--Q.5 Write a SQL query to find all transactions wherethe total_sale is greater than 1000.:
SELECT * FROM retail_sales
WHERE total_sale > 1000;

--Q.6 Write a SQL query to find the total number of transactions (transaction_id)
--made by each gender in each category.:
SELECT gender , category , COUNT(*) FROM retail_sales
GROUP BY gender, category;

--Q.7 Write a SQL query to calculate the average sale for each month. 
--Find out best selling month in each year
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

--Q.8 Write a SQL query to find the top 5 customers based on the highest total sales
SELECT customer_id, SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

--Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.:
SELECT 
	COUNT(DISTINCT(customer_id)),
	category
FROM retail_sales
GROUP BY 2
--Q.10 Write a SQL query to create each shift and number of orders 
--(Example Morning <12, Afternoon Between 12 & 17, Evening >17):
SELECT 
  CASE 
    WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
    WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening'
  END AS time_period,
  SUM(quantity) AS total_order
FROM retail_sales
GROUP BY time_period;



--Q.11 Find customers who bought from each category

SELECT DISTINCT(customer_id) FROM retail_sales WHERE category='Electronics'
INTERSECT
SELECT DISTINCT(customer_id) FROM retail_sales WHERE category='Clothing'
INTERSECT
SELECT DISTINCT(customer_id) FROM retail_sales WHERE category='Beauty'
--2nd method
SELECT
	COUNT(DISTINCT customer_id) AS no_of_customer
FROM (SELECT customer_id
		FROM retail_sales
		GROUP BY customer_id
		HAVING COUNT(DISTINCT category)=(SELECT COUNT(DISTINCT category) FROM retail_sales)
		)AS customers_who_bought_all 


