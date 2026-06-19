create table sys.users555
(
user_id integer,
name varchar(20),
join_date date
);
INSERT INTO sys.users555
VALUES 
(1, 'Jon',  '2020-02-14'),
(2, 'Jane', '2020-02-14'),
(3, 'Jill', '2020-02-15'),
(4, 'Josh', '2020-02-15'),
(5, 'Jean', '2020-02-16'),
(6, 'Justin','2020-02-17'),
(7, 'Jeremy','2020-02-18');

create table sys.events555
(
user_id integer,
type varchar(10),
access_date date
);

INSERT INTO sys.events555 VALUES
(1, 'Pay',   '2020-03-01'), 
(2, 'Music', '2020-03-02'), 
(2, 'P',     '2020-03-12'),
(3, 'Music', '2020-03-15'), 
(4, 'Music', '2020-03-15'), 
(1, 'P',     '2020-03-16'), 
(3, 'P',     '2020-03-22');

select * from sys.users555
select * from sys.events555

with music_users as (
	select *
	from sys.events555 
	where user_id in (select distinct user_id from sys.events555 where type = 'Music')
), 
required_users as (
	select u.user_id, u.join_date, mu.type, mu.access_date, coalesce(datediff(access_date, u.join_date), 99) as diff 
	from music_users mu 
	left join sys.users555 u
	on u.user_id = mu.user_id
)

-- select * from required_users

select count(distinct user_id) as total_users, 
count(distinct case when type = 'P' and diff <= 30 then user_id end) as prime_users, 
round(1.0*count(distinct case when type = 'P' and diff <= 30 then user_id end)/count(distinct user_id), 2) as ratio  
from required_users 


















