create table sys.products
(
product_id varchar(20) ,
cost int
);
insert into sys.products values ('P1',200),('P2',300),('P3',500),('P4',800);

create table sys.customer_budget
(
customer_id int,
budget int
);

insert into sys.customer_budget values (100,400),(200,800),(300,1500);

-- find how many products falls into customer budget along with list of products 
-- In case of clash, choose the less costly product

select * from sys.products
select * from sys.customer_budget

with cte_products as (
    select product_id, cost, 
    sum(cost) over(order by cost, product_id rows between unbounded preceding and current row) as running_cost
    from sys.products 
)

select 
cb.customer_id, max(cb.budget), 
count(*) as no_of_products,
group_concat(cp.product_id order by cp.product_id separator ",") as list_of_products
from cte_products cp
join sys.customer_budget cb
on cp.running_cost <= cb.budget
group by cb.customer_id




{# p1 200  200
p2 300  500
p3 500  1000
p4 800  1800



p1 200  200     400
p1 200  200     800
p2 300  500     800
p1 200  200     1500
p2 300  500     1500
p3 500  1000    1500
p4 800  1800 #}















