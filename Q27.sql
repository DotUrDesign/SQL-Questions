CREATE TABLE sys.int_orders(
 order_number int NOT NULL,
 order_date date NOT NULL,
 cust_id int NOT NULL,
 salesperson_id int NOT NULL,
 amount float NOT NULL
);
INSERT INTO sys.int_orders (order_number, order_date, cust_id, salesperson_id, amount)
VALUES (30, CAST('1995-07-14' AS Date), 9, 1, 460);

INSERT INTO sys.int_orders (order_number, order_date, cust_id, salesperson_id, amount)
VALUES (10, CAST('1996-08-02' AS Date), 4, 2, 540);

INSERT INTO sys.int_orders (order_number, order_date, cust_id, salesperson_id, amount)
VALUES (40, CAST('1998-01-29' AS Date), 7, 2, 2400);

INSERT INTO sys.int_orders (order_number, order_date, cust_id, salesperson_id, amount)
VALUES (50, CAST('1998-02-03' AS Date), 6, 7, 600);

INSERT INTO sys.int_orders (order_number, order_date, cust_id, salesperson_id, amount)
VALUES (60, CAST('1998-03-02' AS Date), 6, 7, 720);

INSERT INTO sys.int_orders (order_number, order_date, cust_id, salesperson_id, amount)
VALUES (70, CAST('1998-05-06' AS Date), 9, 7, 150);

INSERT INTO sys.int_orders (order_number, order_date, cust_id, salesperson_id, amount)
VALUES (20, CAST('1999-01-30' AS Date), 4, 8, 1800);


select * from sys.int_orders

-- using subquery 

with max_amt_cte as (
select salesperson_id, max(amount) as max_amt from sys.int_orders group by salesperson_id
)

select o.order_number, o.order_date, o.cust_id, o.salesperson_id, o.amount
from sys.int_orders o
join max_amt_cte m
on o.salesperson_id = m.salesperson_id 
and o.amount = m.max_amt
order by o.salesperson_id 

----------------------------------------------

-- window function 

with cte as (
select *,
rank() over (partition by salesperson_id order by amount desc) as rnk
from sys.int_orders 
order by salesperson_id
)

select *
from cte 
where rnk = 1


------------------------------------------------------

-- using self join only 

select * from sys.int_orders

select o1.*
from sys.int_orders o1
left join sys.int_orders o2
on o1.salesperson_id = o2.salesperson_id
and o1.order_number != o2.order_number
and o1.amount < o2.amount
where o2.amount is null

600	
720
150











