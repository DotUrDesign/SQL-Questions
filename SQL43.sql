use sys

create table transaction44(
transaction_id int ,
type varchar(255),
amount float,
transaction_date datetime
);
insert into transaction44 values (19153, 'deposit', 65.90, '2022-07-10 10:00:00'),
(53151, 'deposit', 178.55, '2022-07-08 10:00:00'),
(29776, 'withdrawal', 25.90, '2022-07-08 10:00:00'),
(16461, 'withdrawal', 45.99, '2022-07-08 13:00:00'),
(77134, 'deposit',32.60, '2022-07-10 10:00:00');

select * from transaction44


--------------------------------------------------------------------------


with cte as (
	select 
	transaction_id, type, amount, transaction_date,
	sum(case when type = 'deposit' then amount else (-1*amount) end) 
                over(partition by date_format(transaction_date, "%Y-%m") 
				order by transaction_date,transaction_id rows between unbounded preceding and current row) as running_sum,
	row_number() over(partition by date_format(transaction_date, "%Y-%m-%d")
				order by transaction_date, transaction_id desc) as rn
	from transaction44
)

select 
transaction_date, round(running_sum, 2) as balance
from cte 
where rn = 1
