# No extra creation of tables needed - The previous query tab(Q15) already contains the necessary tables.

select * from sys.transactions 

with cust_month_cte as (
	select cust_id, month(order_date) as month_num, monthname(order_date) as month
	from sys.transactions 
	order by cust_id, month_num
),
joined_cte as (
	select c1.cust_id, c1.month
	from cust_month_cte c1 
	left join cust_month_cte c2
	on c1.cust_id = c2.cust_id
	and c1.month_num = c2.month_num-1
	where c2.month is null
),
cust_churn_cnt_cte as (
	select month, count(*) as cust_churn 
	from joined_cte 
	group by month
),
dis_month_cte as (
	select distinct monthname(order_date) as month from sys.transactions 
)

select t1.month, coalesce(t2.cust_churn, 0) as cust_churn_cnt
from dis_month_cte t1
left join cust_churn_cnt_cte t2
on t1.month = t2.month




