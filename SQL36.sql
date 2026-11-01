use sys

create table call_details  (
call_type varchar(10),
call_number varchar(12),
call_duration int
);

insert into call_details
values ('OUT','181868',13),('OUT','2159010',8)
,('OUT','2159010',178),('SMS','4153810',1),('OUT','2159010',152),('OUT','9140152',18),('SMS','4162672',1)
,('SMS','9168204',1),('OUT','9168204',576),('INC','2159010',5),('INC','2159010',4),('SMS','2159010',1)
,('SMS','4535614',1),('OUT','181868',20),('INC','181868',54),('INC','218748',20),('INC','2159010',9)
,('INC','197432',66),('SMS','2159010',1),('SMS','4535614',1);


select * from call_details


---------------------------- SOLUTION ------------------------------------------

with cte as (
	select 
	call_type, call_number, sum(call_duration) as total_dur
	from call_details 
	where call_type = 'OUT' or call_type = 'INC'
	group by call_type, call_number
),
cte2 as (
	select 
	call_type, call_number, total_dur,
	rank() over(partition by call_number order by total_dur desc) as rnk,
	count(*) over(partition by call_number) as cnt
	from cte 
)

select distinct call_number
from cte2 
where cnt = 2 and rnk = 1 and call_type = 'OUT'
and total_dur > (select total_dur from cte where cte.call_number = cte2.call_number and cte.call_type = 'INC')



---------------------------------------------------------


-- Using pivot

select * from call_details

select distinct t.call_number 
from (
	select
	call_number, 
	sum(case when call_type = 'OUT' then call_duration else 0 end) as 'outgoing',
	sum(case when call_type = 'INC' then call_duration else 0 end) as 'incoming'
	from call_details 
	where call_type = 'OUT' or call_type = 'INC'
	group by call_number
	having outgoing != 0 and incoming != 0 and outgoing > incoming
) t

