customers
orders

cust_id, cust_name, order_id

order_id, amount


top 10 customers who order value is more than 10K(cummulative) and customers whose order count > 10

select 
c.cust_id as id, c.cust_name as name, sum(o.amount) as total_amt
from customers c
join orders o
on c.order_id = o.order_id 
group by c.cust_id, c.cust_name
having count(*) > 10 and sum(o.amount) > 10000
order by sum(o.amount) desc
limit 10


-----------------------------------------------------------

cust_df 
order_df 

df_joined = cust_df.alias("c").join(order_df.alias("o"), "order_id", "inner")\
                    .groupBy("c.cust_id", "c.cust_name")\
                    .agg(
                        count("*").alias("cnt"),
                        sum("o.amount").alias("total")
                    )\
                    .filter(
                        (col("cnt") > 10) & (col("total") > 10000)
                    )\
                    .orderBy(col("total").desc())\
                    .limit(10)\
                    .select(
                        col("c.cust_id"),
                        col("c.cust_name"),
                        col("total")
                    )

display(df_joined)



--------------------------------------------------


events with their event_dates 

event_date
2024-01-01
2024-01-06
2024-01-14
2024-01-21

get all the missing dates 

output -
missing_dates
2024-01-02
2024-01-03
.
.
.

HINT
=> recursive query 


