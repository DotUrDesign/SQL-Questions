create table sys.billings 
(
emp_name varchar(10),
bill_date date,
bill_rate int
);
delete from sys.billings;
INSERT INTO sys.billings VALUES
('Sachin','1990-01-01',25),
('Sehwag','1989-01-01',15),
('Dhoni','1989-01-01',20),
('Sachin','1991-02-05',30);


create table sys.HoursWorked 
(
emp_name varchar(20),
work_date date,
bill_hrs int
);
INSERT INTO sys.HoursWorked VALUES
('Sachin', '1990-07-01', 3),
('Sachin', '1990-08-01', 5),
('Sehwag', '1990-07-01', 2),
('Sachin', '1991-07-01', 4);


select * from sys.billings
select * from sys.HoursWorked

with bill_rates as (
select 
hw.emp_name, hw.work_date, b.bill_date, hw.bill_hrs, b.bill_rate,
row_number() over(partition by emp_name, work_date order by bill_date desc) as rn
from sys.HoursWorked hw
left join sys.billings b
on hw.emp_name = b.emp_name and hw.work_date >= b.bill_date
)

select 
emp_name, sum(bill_hrs*bill_rate) as totalcharges
from bill_rates 
where rn = 1
group by emp_name


---------------------------------------------

-- Another approach 

with date_range as (
	select emp_name, bill_date, 
	coalesce(lead(bill_date, 1) over(partition by emp_name order by bill_date), '3999-12-12') as next_bill_date,
	bill_rate 
	from sys.billings
)

select hw.emp_name, coalesce(sum(bill_hrs * bill_rate), 0) as totalcharges
from sys.HoursWorked hw
left join date_range dr
on hw.emp_name = dr.emp_name and hw.work_date >= dr.bill_date and hw.work_date < dr.next_bill_date
group by emp_name






