lead
lag
rank()
dense_rank
row_number


-----------------------------------

{# Assume you have a table named sales with the following columns:
* transaction_date
* revenue
Write a SQL query to calculate the total revenue for each day and the 7-day rolling average of daily revenue.
The rolling average should include the current day and the previous six days #}


1 90
1 100
2 80
2 30

1 190
2 110



with cte as (
    select
    transaction_date, sum(revenue) as total_revenue
    from sales 
    group by transaction_date
    order by transaction_date
)

select 
transaction_date, total_revenue,
avg(total_revenue) over(order by transaction_date asc rows between 6 preceding and current row) as window_avg
from cte 
order by transaction_date


--------------------------------------------

Table revenue
year, revenue
2000, 100M
2001,150M
2002, 200M
2003, 150M  200M    2002
2004, 120M
2006, 350M


output - 
2003
2004


with cte as (
    select 
    year, revenue, 
    lag(year, 1) over(order by year asc) as prev_yr,
    lag(revenue, 1) over(order by year asc) as prev_yr_revenue,
    from revenue
)

select distinct year
from cte 
where year - prev_yr = 1 and revenue < prev_yr_revenue






