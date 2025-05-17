# 🛍️ Retail Sales Analysis

## 📌 Project Overview

**Project Title:** Retail Sales Analysis  
**Objective:** Analyze retail transaction data to generate insights and answer key business questions.

---

## 🎯 Objectives

1. Setup the data
2. Clean the data
3. Perform Exploratory Data Analysis (EDA)
4. Answer key business questions

---

## 🗄️ 1. Database Setup

### Create the Table

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

