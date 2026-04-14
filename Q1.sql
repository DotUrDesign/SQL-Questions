create table sys.icc_world_cup1
(
Team_1 Varchar(20),
Team_2 Varchar(20),
Winner Varchar(20)
);
INSERT INTO sys.icc_world_cup1 values('India','SL','India');
INSERT INTO sys.icc_world_cup1 values('SL','Aus','Aus');
INSERT INTO sys.icc_world_cup1 values('SA','Eng','Eng');
INSERT INTO sys.icc_world_cup1 values('Eng','NZ','NZ');
INSERT INTO sys.icc_world_cup1 values('Aus','India','India');

select * from sys.icc_world_cup1;

-- Get the difference clear between union and union all

with cte as (
select team_1 as team_name, (case when team_1 = winner then 1 else 0 end) as winner_team
from sys.icc_world_cup1
union all
select team_2 as team_name, (case when team_2 = winner then 1 else 0 end) as winner_team
from sys.icc_world_cup1
)

select team_name, 
count(*) as matches_played,
sum(winner_team) as no_of_wins,
(count(*) - sum(winner_team)) as no_of_losses
from cte
group by team_name






















/*
with cte as (
select team_1 as team, 
(case when team_1 = winner then 1 else 0 end) as winner
from sys.icc_world_cup1
union all
select team_2 as team,
(case when team_2 = winner then 1 else 0 end) as winner
from sys.icc_world_cup1)

select team, count(*) as matches_played,
sum(winner) as no_of_wins,
count(*) - sum(winner) as no_of_losses
from cte
group by team
*/