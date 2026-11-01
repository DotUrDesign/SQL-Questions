use sys

create table brands 
(
category varchar(20),
brand_name varchar(20)
);
insert into brands values
('chocolates','5-star')
,(null,'dairy milk')
,(null,'perk')
,(null,'eclair')
,('Biscuits','britannia')
,(null,'good day')
,(null,'boost');

select * from brands


------------------------------- SOLUTION -------------------------------


with cte as (
	select 
	category, brand_name, 
	row_number() over(order by (select null) asc) as rn
	from brands 
),
cte2 as (
	select 
	category, brand_name, rn,
	lead(rn, 1) over (order by rn asc) as next_rn
	from cte
	where category is not null
)

select 
cte2.category, cte.brand_name
from cte
join cte2
on cte.rn >= cte2.rn and (cte2.next_rn is null or cte.rn <= cte2.next_rn-1)



