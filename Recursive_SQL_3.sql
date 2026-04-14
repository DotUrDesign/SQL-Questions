# Generate Numbers (Classic Warmup)
# Generate numbers from 1 to 10 using SQL

with recursive numbers as (
	-- base case 
    select 1 as num
    
    union all 
    
    -- recursive case 
    select num+1
    from numbers
    where num <= 9
)

select * from numbers 