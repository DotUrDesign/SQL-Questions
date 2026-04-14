CREATE TABLE sys.STORES (
Store varchar(10),
Quarter varchar(10),
Amount int);

INSERT INTO sys.STORES (Store, Quarter, Amount)
VALUES ('S1', 'Q1', 200),
('S1', 'Q2', 300),
('S1', 'Q4', 400),
('S2', 'Q1', 500),
('S2', 'Q3', 600),
('S2', 'Q4', 700),
('S3', 'Q1', 800),
('S3', 'Q2', 750),
('S3', 'Q3', 900);

select * from sys.stores

/*
	for sure, 4 quarters will be present in total.
	1 + 2 + 3 + 4 = 10
	Q + (10 - (values))
*/

select store, 
concat(
	'Q', 
	10 - sum(substring(quarter, 2))
) as missing_quarter
from sys.stores
group by store





