-- Scenario based Interviews Question for Product companies

select * from sys.entries;

with visits_cte as (
select name, floor, count(*) as visits from sys.entries group by name, floor
),
ranking_cte as (
select name, floor, rank() over(partition by name order by visits desc) as rnk from visits_cte 
),
most_vis_cte as (
select name, floor as most_visited_floor from ranking_cte where rnk = 1
), 
resources as (
select distinct name, resources from sys.entries 
),
total_res as (
select name, group_concat(resources separator ',') as resources from resources group by name
),
total_vis as (
select name, count(*) as total_visits from sys.entries group by name
)

select tv.name, tv.total_visits, mv.most_visited_floor, tr.resources
from total_vis tv
join total_res tr 
on tv.name = tr.name
join most_vis_cte mv
on mv.name = tv.name

