Consider a customer care centre which receives calls from customers. 
Starttime and endtime denotes the conversation start time and end time. 
Missed calls are the calls where no conversation happened. For any missed call, 
the customer care returns the call.
Find the number of return calls that were done by cust care (1800) within 
30 minutes of the missed call. 2nd and 6th rows indicate such return calls.
 	 	 	 
From_number	To_number	starttime	endtime
100	1800	2019-08-11 18:40:56	2019-08-11 18:40:56
1800	100	2019-08-11 18:55:56	2019-08-11 18:57:56
200	1800	2019-08-11 19:30:56	2019-08-11 19:30:56
1800	200	2019-08-11 20:05:56	2019-08-11 20:10:56
300	1800	2019-08-11 21:00:56	2019-08-11 21:00:56
1800	300	2019-08-11 21:20:56	2019-08-11 21:25:56
400	1800	2019-08-12 7:00:56	2019-08-12 7:00:56
500	1800	2019-08-12 8:00:56	2019-08-12 8:05:56



with cte as (
    select
    c2.from_number, c2.to_number
    from customer_care c1 
    join customer_care c2
    on c1.starttime = c1.endtime
    and c1.from_number = c2.to_number 
    and c1.to_number = c2.from_number 
    and c1.to_number = 1800
    and c2.starttime-c1.starttime <= 30 minutes
    and c2.starttime > c1.starttime
)

select count(*) as cnt
from cte 


-------------------------------------------------------------


Giving a data table with monthly sales of each store 
(Cols: Store id, month, sales) : 
get list of the stores with increasing sales each month ?

1   jan 100K    200K
1   feb 200K    150K
1   apr 150K    NULL
2   feb 
3
4


with cte as (
    select 
    store_id, month, sales, 
    lead(sales, 1) over(partition by store_id order by month asc) as next_month_sales
    from data_tbl 
),
cte2 as (
    select distinct store_id
    from cte 
    where sales > next_month_sales
)

select distinct store_id
from data_tbl 
where store_id not in (select distinct store_id from cte2)



------------------------------------------------------------







 