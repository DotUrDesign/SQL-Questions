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

with music_cte as (
	select user_id, type, access_date as music_access_date from sys.events555 where type = 'Music'
), all_dates_cte as (
	select e.user_id, e.type, e.access_date, m.music_access_date, u.join_date
	from sys.events555 e 
	left join music_cte m on e.user_id = m.user_id
	left join sys.users555 u on e.user_id = u.user_id 
	where m.user_id is not null
), music_prime_cnt_cte as (
	select count(*) as music_prime_users
	from all_dates_cte
	where type = "P" and
	datediff(access_date, join_date) <= 30
), music_cnt_cte as (
	select count(*) as total_users from all_dates_cte where type = "Music"
)

select m.total_users, mp.music_prime_users, round((mp.music_prime_users/m.total_users)*100, 2) as percentage
from music_prime_cnt_cte mp join music_cnt_cte m



-- RETRY THIS QUESTION - The approach I made is pretty big, it can be done in a much simpler way.






