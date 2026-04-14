-- recursive cte
with recursive cte_numbers as 
(
	select 1 as num		-- anchor query

	union all

	select num+1		-- recursive query 
	from cte_numbers
	where num < 6		-- filter to stop the recursion
)

select num
from cte_numbers;

----------------------------------------------------------------------

create table sys.sales (
product_id int,
period_start date,
period_end date,
average_daily_sales int
);

insert into sys.sales values(1,'2019-01-25','2019-02-28',100),(2,'2018-12-01','2020-01-01',10),(3,'2019-12-01','2020-01-31',1);

select * from sys.sales

with recursive dates_cte as (
select min(period_start) as dates, max(period_end) as max_date from sys.sales	-- anchor query
union all
-- here actual recursion(looping) starts
select date_add(dates, interval 1 day) as dates, max_date
from dates_cte
where dates < max_date		-- condition to stop the recursion
), joined_cte as (
select year(d.dates) as year, s.product_id, s.average_daily_sales
from dates_cte d
join sys.sales s
on d.dates between s.period_start and s.period_end
)

select product_id, year, sum(average_daily_sales) as total_amount
from joined_cte 
group by product_id, year
order by product_id, year






