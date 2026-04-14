
with product_wise_sales as 
(
	select 
	product_id, sum(sales) as product_sales
	from orders 
	group by product_id
),
cumm_sales_calc as (
select 
product_id, 
product_sales,
sum(product_sales) over(order by product_sales desc rows between unbounded preceding and current row) as cummulative_sales_sum,	# it's a moving window, so no mentioning of "partition by" inside the over()
0.8 * sum(product_sales) over() as total_sales
from product_wise_sales
)

select * from cumm_sales_calc where cummulative_sales_sum <= total_sales


















/*

with product_wise_sales as 
(
	select product_id, sum(sales) as product_sales
	from orders
	group by product_id
), calc_sales as (
	select product_id, product_sales,
	sum(product_sales) over (order by product_sales desc rows between unbounded preceding and current row) as running_sales,
	0.8 * sum(product_sales) over () as total_sales
	from product_wise_sales
) 

select * from calc_sales where running_sales <= total_sales

*/