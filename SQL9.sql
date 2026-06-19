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

with numbering_cte as (
	select item_id, seller_id,
	row_number() over(partition by seller_id order by order_date) as rn
	from sys.orders2
),
filtered_sellers as (
	select item_id, seller_id from numbering_cte where rn = 2
),
required_sellers as (
	select fs.seller_id
	from filtered_sellers fs 
	left join sys.items2 i
	on fs.item_id = i.item_id
	left join sys.users2 u
	on fs.seller_id = u.user_id
	where i.item_brand = u.favorite_brand
)

select u.user_id as seller_id, 
case when rs.seller_id is not null then "yes" else "no" end as "2nd_item_fav_brand"
from sys.users2 u
left join required_sellers rs
on u.user_id = rs.seller_id













