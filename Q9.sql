create table sys.users2 (
user_id         int     ,
 join_date       date    ,
 favorite_brand  varchar(50));

 create table sys.orders2 (
 order_id       int     ,
 order_date     date    ,
 item_id        int     ,
 buyer_id       int     ,
 seller_id      int 
 );

 create table sys.items2
 (
 item_id        int     ,
 item_brand     varchar(50)
 );


 insert into sys.users2 values (1,'2019-01-01','Lenovo'),(2,'2019-02-09','Samsung'),(3,'2019-01-19','LG'),(4,'2019-05-21','HP');

 insert into sys.items2 values (1,'Samsung'),(2,'Lenovo'),(3,'LG'),(4,'HP');

 insert into sys.orders2 values (1,'2019-08-01',4,1,2),(2,'2019-08-02',2,1,3),(3,'2019-08-03',3,2,3),(4,'2019-08-04',1,4,2)
 ,(5,'2019-08-04',1,3,4),(6,'2019-08-05',2,2,4);
 
 
 
select * from sys.users2
select * from sys.items2
select * from sys.orders2

with cte1 as (
select 
seller_id, order_date, buyer_id, item_id,
rank() over (partition by seller_id order by order_date asc) as rnk
from sys.orders2),
cte2 as (
select * from cte1 where rnk = 2
)
select u.user_id,
-- cte2.order_date, cte2.item_id, u.favorite_brand, i.item_brand,
(case when favorite_brand = item_brand then 'Yes' else 'No' end) as item_fav_brand
from sys.users2 u left join cte2
on u.user_id = cte2.seller_id
left join sys.items2 i
on cte2.item_id = i.item_id

 
 
 
 
 
 
 
 
 
 
 
 
 
 
 