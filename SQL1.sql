-- ICC World Cup Matches 

select * from sys.icc_world_cup

with team1_winner as (
	select 
	team_1 as team_name,
	case 
		when team_1 = winner then 1 
		else 0 
	end as winner
	from sys.icc_world_cup
),
team2_winner as (
	select 
	team_2 as team_name,
	case 
		when team_2 = winner then 1
		else 0
	end as winner
	from sys.icc_world_cup
),
team_matches as (
	select * from team1_winner
	union all 
	select * from team2_winner
)

select 
team_name, 
count(*) as matches_played, 
sum(winner) as no_of_wins, 
count(*) - sum(winner) as no_of_losses
from team_matches
group by team_name








