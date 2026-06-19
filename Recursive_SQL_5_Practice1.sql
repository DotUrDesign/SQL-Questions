# Date Expansion Problem
/*
	Table:
subscriptions(
  user_id INT,
  start_date DATE,
  end_date DATE
)

Expand each row into daily records
*/


CREATE TABLE sys.subscriptions (
    user_id INT,
    start_date DATE,
    end_date DATE
);

INSERT INTO sys.subscriptions (user_id, start_date, end_date) VALUES
(1, '2024-01-01', '2024-01-03'),
(2, '2024-02-10', '2024-02-12');


select * from sys.subscriptions 

with recursive dates as (
	select user_id, start_date as dt, end_date
    from sys.subscriptions 
    
    union all 
    
    select user_id, date_add(dt, interval 1 day) as dt, end_date
    from dates 
    where dt < end_date
)

select user_id, dt from dates
order by user_id, dt






