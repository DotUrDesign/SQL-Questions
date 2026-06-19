-- write a sql query to generate all the unique match combinations between the teams in the format: team1 vs team2
-- each pair should appear only once => CSK VS KKR appeared, but KKR VS CSK should not appear again 
-- a team should not be matched with itself. 


-- Create table
CREATE TABLE sys.teams (
    team_name VARCHAR(10) PRIMARY KEY
);

-- Insert data
INSERT INTO sys.teams (team_name) VALUES
('CSK'),
('DC'),
('GT'),
('KKR'),
('LSG');


select 
concat(c1.team_name, " VS ", c2.team_name) as Matches
from sys.teams c1 
join sys.teams c2 
on c1.team_name < c2.team_name



