-- IMPORTANT

create table sys.event_status
(
event_time varchar(10),
status varchar(10)
);
insert into sys.event_status 
values
('10:01','on'),('10:02','on'),('10:03','on'),('10:04','off'),('10:07','on'),('10:08','on'),('10:09','off')
,('10:11','on'),('10:12','off');


select * from sys.event_status

with cte as (
	select
	event_time, status, 
	lag(status, 1) over (order by event_time) as prev_status
	from sys.event_status
),
marked_cte as (
	select
	event_time, status, prev_status,
	sum(
		case when status = 'on' and prev_status = 'off' then 1
		else 0 end
	) over (
		order by event_time 
		rows between unbounded preceding and current row 
	)
	as flag
	from cte
)

select min(event_time) as login, max(event_time) as logout, 
sum(case when status = 'on' then 1 else 0 end) as cnt
from marked_cte 
group by flag


---------------------------------------------------------------------






