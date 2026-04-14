create table sys.customer_orders2 (
order_id integer,
customer_id integer,
order_date date,
order_amount integer
);
select * from sys.customer_orders2
insert into sys.customer_orders2 values(1,100,cast('2022-01-01' as date),2000),(2,200,cast('2022-01-01' as date),2500),(3,300,cast('2022-01-01' as date),2100)
,(4,100,cast('2022-01-02' as date),2000),(5,400,cast('2022-01-02' as date),2200),(6,500,cast('2022-01-02' as date),2700)
,(7,100,cast('2022-01-03' as date),3000),(8,400,cast('2022-01-03' as date),1000),(9,600,cast('2022-01-03' as date),3000)
;

with cust_first_visit as 
(select customer_id, min(order_date) as min_order_date
from sys.customer_orders2
group by customer_id),
new_old_cust_cnt as (
select c.customer_id, 
c.order_date, 
cte.min_order_date,
(case when c.order_date = cte.min_order_date then 1 else 0 end) as new_customers,
(case when c.order_date <> cte.min_order_date then 1 else 0 end) as old_customers
from sys.customer_orders2 c
left join cust_first_visit cte
on c.customer_id = cte.customer_id
)

select order_date, sum(new_customers) as new_customer_count, sum(old_customers) as old_customer_count
from new_old_cust_cnt
group by order_date
order by order_date


















/*

with cte as (
select customer_id, min(order_date) as min_order_date from sys.customer_orders2 group by customer_id),
cte2 as (
select c.customer_id, c.order_date, cte.min_order_date,
(case when order_date = min_order_date then 1 else 0 end) as new_customer_flag,
(case when order_date != min_order_date then 1 else 0 end) as repeat_customer_flag
from sys.customer_orders2 c
left join cte
on c.customer_id = cte.customer_id)

select order_date, sum(new_customer_flag) as new_customers, sum(repeat_customer_flag) as repeat_customers
from cte2
group by order_date

*/







