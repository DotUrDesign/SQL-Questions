create table sys.UserActivity
(
username      varchar(20) ,
activity      varchar(20),
startDate     Date   ,
endDate      Date
);

insert into sys.UserActivity values 
('Alice','Travel','2020-02-12','2020-02-20')
,('Alice','Dancing','2020-02-21','2020-02-23')
,('Alice','Travel','2020-02-24','2020-02-28')
,('Bob','Travel','2020-02-11','2020-02-18');

select * from sys.UserActivity;

with section1_cte as (
select username, max(activity) as activity, max(startDate) as startDate, max(endDate) as endDate
from sys.UserActivity 
group by username
having count(*) = 1
),
ranking_cte as (
select username, activity, startDate, endDate,
row_number() over (partition by username order by startDate desc) as row_n 
from sys.UserActivity 
),
section2_cte as (
select username, activity, startDate, endDate
from ranking_cte 
where row_n = 2
)

select * from section1_cte
union all 
select * from section2_cte
order by username


-----------------------------------------------------

-- Another approach 

with cte as (
	select username, activity, startDate, endDate,
	count(username) over (partition by username) as streak,
	rank() over (partition by username order by startDate desc) as rnk
	from sys.UserActivity
)

select username, activity, startDate, endDate from cte where streak = 1 or rnk = 2 order by username









