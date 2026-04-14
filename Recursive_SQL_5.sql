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

# solution
with recursive dates_expansion as (
	-- base case 
    select 
    user_id,
    start_date as dt,
    end_date
    from sys.subscriptions
    
    union all
    
    -- recursive case
    select 
    user_id,
    dt + interval 1 day,
    end_date
    from dates_expansion
    where dt < end_date
)

select 
user_id, dt
from dates_expansion
order by user_id;

-- --------------------------------------------------------------


with recursive date_expansion as (
	-- starting point 
    select user_id, start_date as dt, end_date
    from sys.subscriptions 
    
    union all 
    
    -- recursive case 
    select 
    user_id, 
    dt + interval 1 day,
    end_date
    from date_expansion
	where dt < end_date
)

select * from date_expansion order by user_id
































