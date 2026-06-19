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

with cte as (
	select 
	username, activity, startDate, endDate, row_number() over (partition by username order by startDate desc) as rn
	from sys.UserActivity 
)
select * from sys.UserActivity 
where username in (select username from sys.UserActivity group by username having count(*) = 1)
union all 
select username, activity, startDate, endDate from cte where rn = 2
order by username







