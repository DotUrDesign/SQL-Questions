Your task is to write a SQL query to identify customers who made purchases 
on at least 3 consecutive calendar days, 
and determine their longest consecutive purchase streak.



TransactionID, CustomerID , TransactionDate


1
2
3
5
6
7
8


with cte as (
    select
    transactionid, customerid, transactionDate,
    lead(transactionDate, 1) over (partition by customerId order by transactionDate asc) as nextdt,
    lead(transactionDate, 2) over (partition by customerId order by transactionDate asc) as nextdt1,
    from transactions 
),
customers_list (
    select customerId
    from cte 
    where date_diff(nextdt, transactionDate) = 1 
    and date_diff(nextdt1, nextdt) = 1 
)


select customerId, count(*) as total_trxns
from transactions 
where customerId in (select distinct customerId from customer_list) 
group by customerId




