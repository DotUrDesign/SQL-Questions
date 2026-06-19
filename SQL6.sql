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

with person_friends_cte as (
	select f.pid, f.fid, p.name, p.score
	from sys.friend1 f
	left join sys.person1 p
	on f.fid = p.pid
),
filtered_cte as (
	select pid, count(*) as no_of_friends, sum(score) as total_friendscore
	from person_friends_cte
	group by pid
	having total_friendscore > 100
	order by pid
)
select fc.pid, p.name, fc.no_of_friends, fc.total_friendscore
from filtered_cte fc
left join sys.person1 p
on fc.pid = p.pid