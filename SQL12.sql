create table sys.sales (
product_id int,
period_start date,
period_end date,
average_daily_sales int
);

insert into sys.sales values(1,'2019-01-25','2019-02-28',100),(2,'2018-12-01','2020-01-01',10),(3,'2019-12-01','2020-01-31',1);

select * from sys.sales


with recursive daily_sales as (
	-- base case 
    select product_id, period_start, period_start as dt, period_end, average_daily_sales 
    from sys.sales
    
    union all
    
    -- recursive case
    select product_id, period_start, date_add(dt, interval 1 day) as dt, period_end, average_daily_sales
    from daily_sales
    where dt < period_end
)

select product_id, year(dt) as report_year, sum(average_daily_sales) as total_amount
from daily_sales 
group by product_id, year(dt)
order by product_id, report_year








