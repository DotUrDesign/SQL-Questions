# Write your MySQL query statement below

with trips_cte as (
    select * from trips where request_at >= '2013-10-01' and request_at <= '2013-10-03'
), 
unbanned_clients as (
    select t.client_id, t.driver_id, t.status, t.request_at
    from trips_cte t
    left join users u
    on t.client_id = u.users_id and u.role = 'client'
    where u.users_id is not null and u.banned = 'No'
), 
unbanned_drivers as (
    select uc.client_id, uc.driver_id, uc.status, uc.request_at
    from unbanned_clients uc
    left join users u
    on uc.driver_id = u.users_id and u.role = 'driver'
    where u.users_id is not null and u.banned = 'No'
)

select request_at as Day,
round(sum(case when status like 'cancelled%' then 1 else 0 end)/count(*) , 2) "Cancellation Rate"
from unbanned_drivers
group by request_at 

