# Find all the subordinates of the manager 
# Given a manager_id = 101, find all employees under them (direct + indirect).


with recursive subordinates as (
	select 
    emp_id, name, manager_id
    from sys.employees 
    where manager_id = 101
    
    union all 
    
    select 
    e.emp_id, e.name, e.manager_id
    from sys.employees e
    join subordinates s
    on s.emp_id = e.manager_id
)

select * from subordinates 