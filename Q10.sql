create table sys.tasks2 (
date_value date,
state varchar(10)
);

insert into sys.tasks2  values ('2019-01-01','success'),('2019-01-02','success'),('2019-01-03','success'),('2019-01-04','fail')
,('2019-01-05','fail'),('2019-01-06','success')

select * from sys.tasks2

with cte as(
select state, date_value,
row_number() over (partition by state order by date_value) as rn,
date_sub(date_value, interval row_number() over (partition by state order by date_value) day) as date_boundary
from sys.tasks2
order by date_value)

select max(state), min(date_value) as min_date, max(date_value) as max_date
from cte
group by date_boundary























