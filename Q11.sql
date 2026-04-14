create table sys.spending 
(
user_id int,
spend_date date,
platform varchar(10),
amount int
);

insert into sys.spending values(1,'2019-07-01','mobile',100),(1,'2019-07-01','desktop',100),(2,'2019-07-01','mobile',100)
,(2,'2019-07-02','mobile',100),(3,'2019-07-01','desktop',100),(3,'2019-07-02','desktop',100);

select * from sys.spending order by spend_date

with cte as (
select spend_date, user_id, max(platform) as platform, sum(amount) as amount
from sys.spending
group by spend_date, user_id
having count(distinct platform) = 1
union all
select spend_date, user_id, 'both' as platform, sum(amount) as amount
from sys.spending
group by spend_date, user_id
having count(distinct platform) = 2
union all 
select distinct spend_date, null as user_id, 'both' as platform, 0 as amount
from sys.spending
)

select spend_date, platform, sum(amount) as total_amount, count(distinct user_id) as total_users
from cte 
group by spend_date, platform
order by spend_date asc, platform desc









