create table sys.orders111
(
order_id int,
customer_id int,
product_id int
);

insert into sys.orders111 VALUES 
(1, 1, 1),
(1, 1, 2),
(1, 1, 3),
(2, 2, 1),
(2, 2, 2),
(2, 2, 4),
(3, 1, 5);

create table sys.products111 (
id int,
name varchar(10)
);
insert into sys.products111 VALUES 
(1, 'A'),
(2, 'B'),
(3, 'C'),
(4, 'D'),
(5, 'E');

select * from sys.orders111
select * from sys.products111

with orders as (
	select o.order_id, o.product_id, p.name
	from sys.orders111 o
	left join sys.products111 p
	on o.product_id = p.id
)

select concat(o1.name, " ", o2.name) as pair, count(*) as purchase_freq
from orders o1
join orders o2
on o1.order_id = o2.order_id
and o1.name < o2.name
group by pair
order by pair









