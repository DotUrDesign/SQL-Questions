-- customer churn analysis

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
with cte as (
	select cust_id, month(order_date) as monthh,
	lead(month(order_date), 1) over(partition by cust_id order by month(order_date)) as lead_month
	from sys.transactions
),
all_users as (
	select monthh as month_date from cte where lead_month is null
	union all 
	select monthh as month_date from cte where lead_month is not null and (lead_month - monthh) <> 1
)
select month_date, count(*) as no_of_users
from all_users group by month_date 
order by month_date













