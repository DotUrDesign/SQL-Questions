drop table sys.players_location
create table sys.players_location
(
name varchar(20),
city varchar(20)
);
SET SQL_SAFE_UPDATES = 0;
delete from sys.players_location;
insert into sys.players_location
values ('Sachin','Mumbai'),('Virat','Delhi') , ('Rahul','Bangalore'),('Rohit','Mumbai'),('Mayank','Bangalore');


select * from sys.players_location

with city_numbering as (
	select name, city,
	row_number() over (partition by city order by city) as rn
	from sys.players_location
	order by city
)

select 
max(case when city = "Bangalore" then name end) as "Bangalore",
max(case when city = "Delhi" then name end) as "Delhi",
max(case when city = "Mumbai" then name end) as "Mumbai"
from city_numbering
group by rn








