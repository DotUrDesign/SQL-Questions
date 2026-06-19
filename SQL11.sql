create table sys.spending 
(
user_id int,
spend_date date,
platform varchar(10),
amount int
);

insert into sys.spending values(1,'2019-07-01','mobile',100),(1,'2019-07-01','desktop',100),(2,'2019-07-01','mobile',100)
,(2,'2019-07-02','mobile',100),(3,'2019-07-01','desktop',100),(3,'2019-07-02','desktop',100);

select * from sys.spending order by spend_date, user_id, platform desc

with user_spendings as (
	select spend_date, max(platform) as platform, sum(amount) as total_amount, count(distinct user_id) as total_users
	from sys.spending 
	group by user_id, spend_date
	having count(*) = 1

	union all

	select spend_date, 'both' as platform, sum(amount) as total_amount, count(distinct user_id) as total_users
	from sys.spending 
	group by user_id, spend_date
	having count(*) = 2
),
possible_outcomes as (
	select  T.spend_date, T1.platform
	from (select distinct spend_date from sys.spending) T
	cross join 
	(
		select 'mobile' as platform
		union all 
		select 'desktop' as platform
		union all
		select 'both' as platform
	) T1
)

select p.spend_date, p.platform, coalesce(u.total_amount, 0) as total_amount, coalesce(u.total_users, 0) as total_users
from possible_outcomes p 
left join user_spendings u
on p.spend_date = u.spend_date and p.platform = u.platform
order by p.spend_date, p.platform desc









