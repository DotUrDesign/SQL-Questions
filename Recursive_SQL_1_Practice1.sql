CREATE TABLE sys.employees (
    emp_id INT,
    name VARCHAR(50),
    manager_id INT
);

INSERT INTO sys.employees (emp_id, name, manager_id) VALUES
(1, 'A', NULL),   -- top manager
(2, 'B', 1),
(3, 'C', 2),
(4, 'D', 2),
(5, 'E', 1),
(6, 'F', 3);


# Recursion SQL
/*
	with recursion <table_name> as (
		-- base case 
        
        union all 
        
        -- recursive case 
        
    )
    select * from <table_name> 
    
    inside the base case, we get the initial value - meaning from which the recursion will be starting.
    And to stop the recursion, we will placing a condition inside the recursive case.
*/

# Get the Employee Hierarchy
# employee -> manager -> top manager

select * from sys.employees 

with recursive emp_hierarchy as (
	select 
	emp_id, name, 1 as level
    from sys.employees 
    where manager_id is null
    
    union all 
    
    select
    e.emp_id, e.name, eh.level+1
    from sys.employees e
    join emp_hierarchy eh
    on eh.emp_id = e.manager_id
)

select distinct * from emp_hierarchy



















