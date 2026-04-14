Create table sys.friend1 (pid int, fid int);
insert into sys.friend1 (pid , fid ) values ('1','2');
insert into sys.friend1 (pid , fid ) values ('1','3');
insert into sys.friend1 (pid , fid ) values ('2','1');
insert into sys.friend1 (pid , fid ) values ('2','3');
insert into sys.friend1 (pid , fid ) values ('3','5');
insert into sys.friend1 (pid , fid ) values ('4','2');
insert into sys.friend1 (pid , fid ) values ('4','3');
insert into sys.friend1 (pid , fid ) values ('4','5');
create table sys.person1 (pid int,	Name varchar(50),	Score int);
insert into sys.person1(pid,Name ,Score) values('1','Alice','88');
insert into sys.person1(pid,Name ,Score) values('2','Bob','11');
insert into sys.person1(pid,Name ,Score) values('3','Devis','27');
insert into sys.person1(pid,Name ,Score) values('4','Tara','45');
insert into sys.person1(pid,Name ,Score) values('5','John','63');
select * from sys.person1
select * from sys.friend1

with friends_scores as (
select f.pid, f.fid, p.score
from sys.friend1 f
left join sys.person1 p
on p.pid = f.fid
),
friends_total_score as (
select pid, count(*) as no_of_friends, sum(score) as total_friendscore
from friends_scores
group by pid
)

select p.pid, p.name, ftc.no_of_friends, ftc.total_friendscore
from sys.person1 p
join friends_total_score ftc
on p.pid = ftc.pid
and ftc.total_friendscore >= 100
























/*
with cte1 as (
select 
f.pid, f.fid, p.score
from sys.friend1 f
left join sys.person1 p
on f.fid = p.personid), 
cte2 as (
select pid, count(1) as no_of_friends, sum(score) as total_friendscore
from cte1
group by pid 
having total_friendscore > 100)

select cte2.pid, p.name, cte2.no_of_friends, cte2.total_friendscore
from cte2
join sys.person1 p
on cte2.pid = p.personid
*/




