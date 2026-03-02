# Retail Sales Analysis (SQL)

This is a SQL project where I analyzed a retail sales dataset to understand sales and profit performance across regions, states, categories, customer segments, discounts, and shipping modes.

Dataset - superstore.csv 
Source - https://www.kaggle.com/datasets/ibrahimelsayed182/superstore
Queries - analysis.sql 

## Project Description
I used PostgreSQL (pgAdmin) to explore the Superstore dataset and answer practical business questions like: which regions/states are performing best, which categories are most profitable, and how discounts impact profit.

## Tasks Performed
- performed basic data validation  
  - counted total rows to confirm successful data load  
  - checked nulls in key fields (sales, profit, quantity)

- analyzed overall performance  
  - total sales, total profit, total quantity  
  - dataset coverage (unique cities and states)

- analyzed business performance by key dimensions  
  - sales and profit by region  
  - top states by total profit  
  - category performance + profit margin (%)  
  - sub-category performance + loss-making sub-categories  
  - segment performance + profit margin (%)  
  - ship mode performance + average discount

- analyzed discount impact  
  - created discount buckets (no/low/medium/high) and compared sales/profit

- performed comparison analysis (subquery + join)  
  - found orders with sales higher than the region average

- applied a window function  
  - ranked states by total sales using rank()

## SQL Concepts Used
- select, where, order by, limit
- sum(), avg(), count()
- group by, having
- case when
- subquery + join
- nullif() for safe division
- window function: rank() over()
