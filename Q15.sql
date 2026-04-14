-- customer retention analysis

create table sys.transactions(
order_id int,
cust_id int,
order_date date,
amount int
);
-- delete from transactions;
insert into sys.transactions values 
(1,1,'2020-01-15',150)
,(2,1,'2020-02-10',150)
,(3,2,'2020-01-16',150)
,(4,2,'2020-02-25',150)
,(5,3,'2020-01-10',150)
,(6,3,'2020-02-20',150)
,(7,4,'2020-01-20',150)
,(8,5,'2020-02-20',150)
;

select * from sys.transactions

with cust_month_cte as (
	select cust_id, month(order_date) as month_num, monthname(order_date) as month
	from sys.transactions 
	order by cust_id, month_num
), 
joined_cte as (
	select c1.cust_id, c2.month
	from cust_month_cte c1 
	left join cust_month_cte c2
	on c1.cust_id = c2.cust_id
	and c1.month_num = c2.month_num-1
	where c2.month is not null
),
distinct_month_cte as (
select distinct monthname(order_date) as month from sys.transactions
),
month_cnt_cte as (
	select month, count(*) as cust_retained from joined_cte group by month
)

select m1.month, coalesce(m2.cust_retained, 0) as cust_retained
from distinct_month_cte m1
left join month_cnt_cte m2
on m1.month = m2.month








