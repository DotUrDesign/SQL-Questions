# Write your MySQL query statement below

with clients_unbanned_cte as (
select t.status, t.request_at
from trips t left join users u on t.client_id = u.users_id and t.request_at >= "2013-10-01" and t.request_at <= "2013-10-03"
left join users u2 on t.driver_id = u2.users_id
where u.banned <> "Yes" and u2.banned <> "Yes"
)

select 
request_at as Day,
round(sum(case when status like "cancelled%" then 1 else 0 end)/count(*), 2) "Cancellation Rate"
from clients_unbanned_cte
group by request_at
order by request_at




/*
with cte1 as (
select * from trips where request_at between "2013-10-01" and "2013-10-03"
),
cte2 as(
select 
t.client_id, t.driver_id, t.status, t.request_at, u.banned as clients_banned, u2.banned as driver_banned
from cte1 t
left join users u
on t.client_id = u.users_id
left join users u2
on t.driver_id = u2.users_id
order by request_at)

select request_at as Day,
round(sum(case when status like 'cancelled%' then 1 else 0 end)/count(*) , 2) 'Cancellation Rate'
from cte2
where clients_banned = 'No' and driver_banned = 'No'
group by request_at
*/