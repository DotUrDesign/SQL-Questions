use sys

create table students
(
student_id int,
student_name varchar(20)
);
insert into students values
(1,'Daniel'),(2,'Jade'),(3,'Stella'),(4,'Jonathan'),(5,'Will');

create table exams
(
exam_id int,
student_id int,
score int);

insert into exams values
(10,1,70),(10,2,80),(10,3,90),(20,1,80),(30,1,70),(30,3,80),(30,4,90),(40,1,60)
,(40,2,70),(40,4,80);


select * from exams


------------------------------- SOLUTION -------------------------------------


with cte as (
	select
	exam_id, student_id, score, 
	dense_rank() over(partition by exam_id order by score asc) as low2high,
	dense_rank() over(partition by exam_id order by score desc) as high2low
	from exams
),
cte2 as (
	select distinct student_id
	from exams
	where student_id not in (
		select distinct student_id
		from cte 
		where low2high = 1 or high2low = 1
	)
)

select s.student_id, s.student_name
from cte2 c
join students s
on c.student_id = s.student_id