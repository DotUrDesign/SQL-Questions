sales table 

Order id , order date, sales_amount
1               12-10-2025     50000
2                23-09-2025     10000


oct-25  10  nov-25  20  10
nov-25  20


with cte as (
    select 
    date_format(order_date, '%Y-%m') as month, sum(sales_amount)
    from sales 
    group by date_format(order_date, '%Y-%m') 
    order by date_format(order_date, '%Y-%m')
),
dummy as (
    select
    month, lag(month, 1) over(order by month) as prev_month, 
    sales_amount as curr_amt, lag(sales_amount, 1) over(order by month) as prev_am
    from cte 
)

select 
month, prev_month, abs(next_amt-curr_amt) as growth
from dummy
