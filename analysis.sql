-- retail sales analysis using sql
-- database: postgresql 
-- table: superstore_sales


-- data validation checks
-- total rows in dataset
select count(*) as total_rows
from superstore_sales;

-- check for null values in key numeric columns
select *
from superstore_sales
where sales is null
   or profit is null
   or quantity is null;


-- analysis queries
-- q1) total sales, total profit, and total quantity sold
select
  sum(sales) as total_sales,
  sum(profit) as total_profit,
  sum(quantity) as total_quantity
from superstore_sales;


-- q2) total rows, unique cities, and unique states
select
  count(*) as total_rows,
  count(distinct city) as unique_cities,
  count(distinct state) as unique_states
from superstore_sales;


-- q3) top 10 transactions by sales
select
  ship_mode,
  segment,
  city,
  state,
  region,
  category,
  sub_category,
  sales,
  quantity,
  discount,
  profit
from superstore_sales
order by sales desc
limit 10;


-- q4) sales and profit by region
select
  region,
  sum(sales) as total_sales,
  sum(profit) as total_profit
from superstore_sales
group by region
order by total_sales desc;


-- q5) top 10 states by total profit
select
  state,
  sum(profit) as total_profit
from superstore_sales
group by state
order by total_profit desc
limit 10;


-- q6) category performance: sales, profit, and profit margin (%)
select
  category,
  sum(sales) as total_sales,
  sum(profit) as total_profit,
  (sum(profit) / nullif(sum(sales), 0)) * 100.0 as profit_margin_pct
from superstore_sales
group by category
order by total_sales desc;


-- q7) sub-category performance: sales and profit
select
  sub_category,
  sum(sales) as total_sales,
  sum(profit) as total_profit
from superstore_sales
group by sub_category
order by total_profit desc;


-- q8) loss-making sub-categories (negative total profit)
select
  sub_category,
  sum(profit) as total_profit
from superstore_sales
group by sub_category
having sum(profit) < 0
order by total_profit asc;


-- q9) segment performance: sales, profit, and profit margin (%)
select
  segment,
  sum(sales) as total_sales,
  sum(profit) as total_profit,
  (sum(profit) / nullif(sum(sales), 0)) * 100.0 as profit_margin_pct
from superstore_sales
group by segment
order by total_sales desc;


-- q10) ship mode performance: sales, profit, and average discount
select
  ship_mode,
  sum(sales) as total_sales,
  sum(profit) as total_profit,
  avg(discount) as avg_discount
from superstore_sales
group by ship_mode
order by total_sales desc;


-- q11) discount impact using discount buckets
select
  case
    when discount = 0 then 'no discount'
    when discount > 0 and discount <= 0.2 then 'low (0-0.2)'
    when discount > 0.2 and discount <= 0.4 then 'medium (0.2-0.4)'
    else 'high (>0.4)'
  end as discount_bucket,
  count(*) as rows_count,
  sum(sales) as total_sales,
  sum(profit) as total_profit,
  avg(profit) as avg_profit
from superstore_sales
group by discount_bucket
order by rows_count desc;


-- q12) orders where sales are higher than region average
select
  s.region,
  s.state,
  s.city,
  s.category,
  s.sub_category,
  s.sales,
  r.avg_sales_in_region
from superstore_sales s
join (
  select
    region,
    avg(sales) as avg_sales_in_region
  from superstore_sales
  group by region
) r
on s.region = r.region
where s.sales > r.avg_sales_in_region
order by s.region, s.sales desc
limit 50;


-- q13) rank states by total sales (window function)
select
  state,
  sum(sales) as total_sales,
  rank() over (order by sum(sales) desc) as sales_rank
from superstore_sales
group by state
order by sales_rank;
