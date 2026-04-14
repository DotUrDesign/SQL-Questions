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

with lg_sts_cte as (
select *,
lag(status) over (order by event_time) as lag_sts
from sys.event_status
),
evnt_timings_cte as (
select *,
lead(event_time) over (order by event_time) as lag_evnt_time
from lg_sts_cte
where (status = 'off' and lag_sts = 'on')
or (status = 'on' and lag_sts is null)
or (status = 'on' and lag_sts = 'off')
)

select event_time as login, lag_evnt_time as logout,
timestampdiff(
	minute,
    str_to_date(event_time, '%H:%i'),
    str_to_date(lag_evnt_time, '%H:%i')
) as cnt
from evnt_timings_cte
where (status = 'on' and lag_sts is null)
or (status = 'on' and lag_sts = 'off')
order by str_to_date(event_time, '%H:%i')


------------------------------------------------------------------------

select * from sys.event_status

with grouping_cte as (
	select *,
	sum(case when a.status = 'on' and a.next_sts = 'off' then 1 else 0 end) over (order by a.event_time) as group_key
	from (
		select *,
		lag(status,1,status) over (order by event_time) as next_sts
		from sys.event_status
	) a
)

select 
min(event_time) as login, max(event_time) as logout, count(1)-1 as cnt
from grouping_cte
group by group_key









