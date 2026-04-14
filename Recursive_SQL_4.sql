# Find Path Between Nodes (Graph Problem)
/*
Table: 
routes( 
	source STRING, 
    destination STRING 
)

Find all paths starting from 'A'
*/

CREATE TABLE sys.routes (
    source VARCHAR(10),
    destination VARCHAR(10)
);

INSERT INTO sys.routes (source, destination) VALUES
('A', 'B'),
('A', 'C'),
('B', 'D'),
('C', 'D'),
('D', 'E'),
('C', 'F'),
('F', 'G');


with recursive paths as (
	-- base case
    select 
    source,
    destination, 
    concat(source, '->', destination) as path
    from sys.routes 
    where source = 'A'
    
    union all 
    
    -- recursive case 
    select 
    r.source,
    r.destination,
    concat(p.path, '->', r.destination)
    from paths p
    join sys.routes r
    on r.source = p.destination
)

select * from paths;


-- -----------------------------------------------------




with recursive paths as (
	-- starting point 
    select source, destination, concat(source, "->", destination) as path
    from sys.routes 
    where source = 'A'
    
    union all 
    
    -- recursive case 
    select 
    r.source,
    r.destination, 
    concat(p.path, "->", r.destination)
    from sys.routes r
    join paths p
    on r.source = p.destination
)

select * from paths



















