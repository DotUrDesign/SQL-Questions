create table sys.covid(city varchar(50),days date,cases int);
delete from sys.covid;
insert into sys.covid values('DELHI','2022-01-01',100);
insert into sys.covid values('DELHI','2022-01-02',200);
insert into sys.covid values('DELHI','2022-01-03',300);

insert into sys.covid values('MUMBAI','2022-01-01',100);
insert into sys.covid values('MUMBAI','2022-01-02',100);
insert into sys.covid values('MUMBAI','2022-01-03',300);

insert into sys.covid values('CHENNAI','2022-01-01',100);
insert into sys.covid values('CHENNAI','2022-01-02',200);
insert into sys.covid values('CHENNAI','2022-01-03',150);

insert into sys.covid values('BANGALORE','2022-01-01',100);
insert into sys.covid values('BANGALORE','2022-01-02',300);
insert into sys.covid values('BANGALORE','2022-01-03',200);
insert into sys.covid values('BANGALORE','2022-01-04',400);

select * from sys.covid

with cte as (
select 
city, days, cases, 
rank() over (partition by city order by days) as rnk_days,
rank() over (partition by city order by cases) as rnk_cases,
abs(cast(rank() over (partition by city order by days) as signed) - cast(rank() over (partition by city order by cases) as signed)) as diff
from sys.covid
order by city, days
)

select 
city
from cte
group by city
having count(distinct diff) = 1









