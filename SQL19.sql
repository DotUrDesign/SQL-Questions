CREATE TABLE sys.activity666 (
    user_id INT,
    event_name VARCHAR(50),
    event_date DATE,
    country VARCHAR(50)
);

INSERT INTO sys.activity666 (user_id, event_name, event_date, country)
VALUES
(1, 'app-installed', '2022-01-01', 'India'),
(1, 'app-purchase', '2022-01-02', 'India'),
(2, 'app-installed', '2022-01-01', 'USA'),
(3, 'app-installed', '2022-01-01', 'USA'),
(3, 'app-purchase', '2022-01-03', 'USA'),
(4, 'app-installed', '2022-01-03', 'India'),
(4, 'app-purchase', '2022-01-03', 'India'),
(5, 'app-installed', '2022-01-03', 'SL'),
(5, 'app-purchase', '2022-01-03', 'SL'),
(6, 'app-installed', '2022-01-04', 'Pakistan'),
(6, 'app-purchase', '2022-01-04', 'Pakistan');


select * from sys.activity666


-- find the total no of active users  for each date
select event_date, count(distinct user_id) as no_of_active_users from sys.activity666 group by event_date


-- find the total no of active users  for each week
select year(event_date) as year_no, week(event_date) as week_no, count(distinct user_id) as no_of_active_users from sys.activity666 group by year_no,week_no


-- date wise total number of users who made the purchase same day they installed the app
with next_events as (
	select user_id, event_date, 
	coalesce(lead(event_date, 1) over(partition by user_id order by event_date), '3999-12-12') as next_event_date
	from sys.activity666
)

select event_date, count(distinct user_id) as no_of_users
from next_events
where next_event_date = event_date
group by event_date


-- percentage of paid users in India, and any other country shoud be tagged as others 
with premium_cust as (
	select user_id, country from sys.activity666 where event_name = 'app-purchase' and (country = 'India' or country = 'USA')
    union all 
    select user_id, 'others' as country from sys.activity666 where event_name = 'app-purchase' and country <> 'India' and country <> 'USA'
)

select 
country,
round(100.0 * count(1)/(select count(1) from premium_cust), 2) as perc_users
from premium_cust
group by country


-- among all the users who installed the app on a given day, how many did in app purchased on the very next day -- day wise results.
with cte as (
	select user_id, event_date, 
	lead(event_date, 1) over(partition by user_id order by event_date) as next_event_date
	from sys.activity666
),
distinct_dates as (
	select distinct event_date from sys.activity666
),
grouped_data as (
	select next_event_date as evnt_date, count(1) as cnt_users
	from cte 
	where next_event_date is not null and datediff(next_event_date, event_date) = 1
	group by evnt_date
)

select dd.event_date, coalesce(gd.cnt_users, 0) as cnt_users
from distinct_dates dd
left join grouped_data gd 
on dd.event_date = gd.evnt_date















