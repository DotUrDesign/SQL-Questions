-- IMPORTANT

create table sys.players_location
(
name varchar(20),
city varchar(20)
);
insert into sys.players_location
values ('Sachin','Mumbai'),('Virat','Delhi') , ('Rahul','Bangalore'),('Rohit','Mumbai'),('Mayank','Bangalore');


select * from sys.players_location


with cte as (
	select 
	name, city, 
	row_number() over(partition by city order by name asc) as rn,
	(case when city = 'Bangalore' then name else NULL end) as 'Bangalore',
    (case when city = 'Mumbai' then name else NULL end) as 'Mumbai',
	(case when city = 'Delhi' then name else NULL end) as 'Delhi'
	from sys.players_location
)

select rn, max(Bangalore) as Bangalore, 
max(Mumbai) as Mumbai,
max(Delhi) as Delhi
from cte 
group by rn 
order by rn  


