-- IMPORTANT

create table sys.players_location
(
name varchar(20),
city varchar(20)
);
insert into sys.players_location
values ('Sachin','Mumbai'),('Virat','Delhi') , ('Rahul','Bangalore'),('Rohit','Mumbai'),('Mayank','Bangalore');


select * from sys.players_location

with rn_cte as (
select 
name, city,
row_number() over (partition by city order by name) as rn
from sys.players_location
order by city
)

select 
min(case when city = 'Mumbai' then name end) as 'Mumbai',
min(case when city = 'Bangalore' then name end) as 'Bangalore',
min(case when city = 'Delhi' then name end) as 'Delhi'
from rn_cte
group by rn
order by rn










