# Find all the subordinates of the manager 
# Given a manager_id = 101, find all employees under them (direct + indirect).

with recursive subordinates as (
	-- base case 
    select emp_id, name, manager_id
    from sys.employees
    where manager_id = 101
    
    union all
    
    -- recursive case
    select 
    e.emp_id,
    e.name,
    e.manager_id
    from sys.employees e
    join subordinates s
    on e.manager_id = s.emp_id
)

select * from subordinates;

-- ---------------------------------------------------------------


with recursive subordinates as (
	-- starting point 
    select emp_id, name, manager_id
    from sys.employees 
    where manager_id = 101
    
    union all 
    
    -- recursive case 
    select 
    e.emp_id,
    e.name,
    e.manager_id
    from sys.employees e
    join subordinates s 
    on e.manager_id = s.emp_id
)

select * from subordinates
























