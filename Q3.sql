create table sys.entries1 ( 
name varchar(20),
address varchar(20),
email varchar(20),
floor int,
resources varchar(10));

insert into sys.entries1
values ('A','Bangalore','A@gmail.com',1,'CPU'),('A','Bangalore','A1@gmail.com',1,'CPU'),('A','Bangalore','A2@gmail.com',2,'DESKTOP')
,('B','Bangalore','B@gmail.com',2,'DESKTOP'),('B','Bangalore','B1@gmail.com',2,'DESKTOP'),('B','Bangalore','B2@gmail.com',1,'MONITOR');


select * from sys.entries1;

with res_assign as (
	select distinct name, resources
	from sys.entries1 
),
res_assign1 as ( 
	select name, group_concat(resources separator ",") as resources
	from res_assign
	group by name
),
visits_per_floor_ranking as (
	select name, floor, 
	count(*) as visits_per_floor,
	rank() over (partition by name order by count(*) desc) as rnk
	from sys.entries1
	group by name, floor
),
rnk_1_cte as (
	select name, floor as most_visited_floor
	from visits_per_floor_ranking
	where rnk = 1
),
total_visits_cte as ( 
	select name, count(*) as total_visits
	from sys.entries1
	group by name
)

select t.name, tv.total_visits, rc.most_visited_floor, r.resources
from total_visits_cte t join res_assign1 r on t.name = r.name
join rnk_1_cte rc on t.name = rc.name
join total_visits_cte tv on t.name = tv.name






















/*
with cte1 as (
select name, count(*) as total_visits from sys.entries1 group by name
), cte2 as (
select name, 
floor,
rank() over (partition by name order by count(1) desc) as rnk
from sys.entries1 
group by name, floor
), cte3 as (
select name, floor as most_visited_floor
from cte2 where rnk = 1
), cte4 as (
select distinct name, resources from sys.entries1
), cte5 as (
select name, group_concat(resources separator ',') as resources
from cte4 group by name)

select cte3.name,  cte1.total_visits, cte3.most_visited_floor, cte5.resources
from cte1 join cte3 
on cte1.name = cte3.name
join cte5 
on cte5.name = cte1.name
*/







