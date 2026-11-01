use sys
create table candidates (
emp_id int,
experience varchar(20),
salary int
);
delete from candidates;
insert into candidates values
(1,'Junior',10000),(2,'Junior',15000),(3,'Junior',40000),(4,'Senior',16000),(5,'Senior',20000),(6,'Senior',50000);


select * from candidates


--------------------------------------------------------------------------


with total_sal as (
	select 
	emp_id, salary, experience, sum(salary) over(partition by experience order by salary rows between unbounded preceding and current row) as cumm_salary
	from candidates 
),
seniors as (
	select emp_id, experience, salary
	from total_sal
	where experience = 'Senior' and cumm_salary <= 70000
),
juniors as (
	select emp_id, experience, salary
	from total_sal
	where experience = 'Junior' and cumm_salary <= 70000 - (select sum(salary) from seniors)
)


select * from juniors 
union all 
select * from seniors 
