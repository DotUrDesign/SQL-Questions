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

with player_scores as (
select first_player as player_id, first_score as score
from sys.matches1
union all 
select second_player as player_id, second_score as score
from sys.matches1
),
player_wise_scores as ( 
select player_id, sum(score) as player_score
from player_scores
group by player_id
),
group_wise_score as (
select p.group_id, p.player_id, coalesce(pws.player_score, 0) as player_score
from sys.players1 p
left join player_wise_scores pws
on p.player_id = pws.player_id
), 
players_rnk_tbl as (
select group_id, player_id, player_score, rank() over (partition by group_id order by player_score desc, player_id asc) as rnk
from group_wise_score
)

select group_id, player_id, player_score
from players_rnk_tbl
where rnk = 1










/*
with cte1 as (
select first_player as player_id, first_score as score 
from sys.matches1
union all 
select second_player as player_id, second_score as score
from sys.matches1),
cte2 as (
select player_id, sum(score) as score
from cte1
group by player_id),
cte3 as (
select p.group_id, p.player_id, coalesce(cte2.score, 0) as score
from sys.players1 p
left join cte2
on p.player_id = cte2.player_id),
cte4 as (
select group_id, player_id, score,
rank() over (partition by group_id order by score desc, player_id asc) as rnk
from cte3)

select group_id, player_id, score
from cte4
where rnk = 1
order by group_id
*/

