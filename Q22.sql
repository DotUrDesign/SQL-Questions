create table sys.exams (student_id int, subject varchar(20), marks int);

delete from sys.exams;

insert into sys.exams values (1,'Chemistry',91),(1,'Physics',91)
,(2,'Chemistry',80),(2,'Physics',90)
,(3,'Chemistry',80)
,(4,'Chemistry',71),(4,'Physics',54);

select * from sys.exams

select cte.student_id 
from (
	select 
	e1.student_id
	from sys.exams e1
	join sys.exams e2
	on e1.subject != e2.subject
	and e1.marks = e2.marks
) cte
group by cte.student_id

--------------------------------------------

select student_id
from sys.exams
where subject in ('Chemistry','Physics')
group by student_id
having count(distinct subject) = 2 and count(distinct marks) = 1









