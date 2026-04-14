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

with cummulative_sum_cte as (
select product_id, cost, sum(cost) over (order by cost) as running_sales
from sys.products
), 
compare_cte as (
select cb.*, csc.*
from sys.customer_budget cb
cross join cummulative_sum_cte csc
order by cb.customer_id
)

select customer_id, max(budget) as budget,
count(*) as no_of_products, group_concat(product_id order by product_id separator ',') as list_of_products
from compare_cte
where budget > running_sales
group by customer_id
order by customer_id













