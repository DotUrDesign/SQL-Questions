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


select o1.*
from sys.int_order o1
left join sys.int_order o2
on o1.order_number != o2.order_number 
and o1.salesperson_id = o2.salesperson_id
and o1.amount < o2.amount
where o2.amount is null 


{# 7   600
7   720
7   150


7 600 150
7 720 600
7 720 150
2 2400 540

7 600 720
7 150 720
7 720  #}



















