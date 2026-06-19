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

with leading_month as (
	select cust_id, month(order_date) as monthh,
	lead(month(order_date), 1) over(partition by cust_id order by month(order_date)) as next_month
	from sys.transactions
)
select 1 as month_date, 0 as no_of_loyal_users
union all
select next_month as month_date, count(*) as no_of_loyal_users
from leading_month 
where next_month is not null and (next_month - monthh) = 1
group by month_date

1 2 = 1
2 4 = 2  -- filtered out
4 5 = 1

1 2 = 1
2 3 = 1
3 4 = 1
4 5 = 1












