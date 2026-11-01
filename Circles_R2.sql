dataset
student table 
student_id, student_name, marks, subject, year


to pull out top 2 students in each year who scored maximum marks 

raj 90  biology
ramesh 90   chem
tarun 80    chem
.
.
.

raj 
ramesh 


with cte as (
    select 
    student_id, year, max(student_name) as student_name, sum(marks) as total_marks 
    from student 
    group by student_id, year
),
cte2 as (
    select 
    student_id, year, student_name, total_marks,
    row_number() over (partition by year order by total_marks desc) as rn 
    from cte 
)

select 
student_id, student_name, total_marks, year 
from cte2
where rn = 1 or rn = 2






---------------------------------------------------


with cte as (
    select 
    student_id, year, max(student_name) as student_name, sum(marks) as total_marks,
    row_number() over (partition by year order by sum(marks) desc) as rn 
    from student 
    group by student_id, year
)

select 
student_id, student_name, total_marks, year 
from cte2
where rn = 1 or rn = 2


