create table sys.players1
(player_id int,
group_id int)

insert into sys.players1 values (15,1);
insert into sys.players1 values (25,1);
insert into sys.players1 values (30,1);
insert into sys.players1 values (45,1);
insert into sys.players1 values (10,2);
insert into sys.players1 values (35,2);
insert into sys.players1 values (50,2);
insert into sys.players1 values (20,3);
insert into sys.players1 values (40,3);

create table sys.matches1
(
match_id int,
first_player int,
second_player int,
first_score int,
second_score int)

insert into sys.matches1 values (1,15,45,3,0);
insert into sys.matches1 values (2,30,25,1,2);
insert into sys.matches1 values (3,30,15,2,0);
insert into sys.matches1 values (4,40,20,5,2);
insert into sys.matches1 values (5,35,50,1,1);

select * from sys.players1
select * from sys.matches1

with all_matches as (
	select first_player as player, first_score as score from sys.matches
	union all 
	select second_player as player, second_score as score from sys.matches 
),
total_score as (
	select player, sum(score) as score from all_matches group by player 
),
score_per_group as (
	select p.group_id, p.player_id, coalesce(ts.score, 0) as score
	from sys.players p
	left join total_score ts
	on p.player_id = ts.player
), 
ranking_cte as (
	select 
	group_id, player_id, score, 
	rank() over(partition by group_id order by score desc, player_id asc) as rnk
	from score_per_group 
)
select group_id, player_id, score
from ranking_cte 
where rnk = 1






