-- Find new and repeated customers 

select * from sys.customer_orders

with cte as (
	select 
	customer_id, order_date,
	row_number() over (partition by customer_id order by order_date asc) as rn
	from sys.customer_orders
)

select 
order_date,
sum(
	case 
		when rn = 1 then 1
        else 0 end
) as new_customer_count,
sum(
	case 
		when rn <> 1 then 1 
        else 0 end
) as repeat_customer_count
from cte 
group by order_date 
