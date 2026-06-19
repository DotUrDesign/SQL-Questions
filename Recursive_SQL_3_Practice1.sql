# Generate Numbers (Classic Warmup)
# Generate numbers from 1 to 10 using SQL

with recursive numbers as (
	select 1 as num 
    
    union all 
    
    select num+1
    from numbers 
    where num < 10
)

select * from numbers 