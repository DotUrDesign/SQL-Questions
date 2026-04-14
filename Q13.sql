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

with item_pairing_cte as (
	select o1.order_id, o1.product_id as item1, o2.product_id as item2
	from sys.orders111 o1
	join sys.orders111 o2
	on o1.order_id = o2.order_id
	and o1.product_id < o2.product_id
), pair_cte as (
	select p1.name as item1_name, p2.name as item2_name,
	concat_ws(" ", p1.name, p2.name) as pair
	from item_pairing_cte i left join sys.products111 p1 on i.item1 = p1.id
	left join sys.products111 p2 on i.item2 = p2.id
)

select pair, count(*) as purchase_freq
from pair_cte
group by pair














