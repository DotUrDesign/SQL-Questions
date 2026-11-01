use sys
create table hotel(
rental_id int ,
amenities nvarchar(20)
);
---------
insert into hotel values (123, 'Pool'),
(123, 'Kitchen'),
(234, 'Hot Tub'),
(234, 'Fireplace'),
(345, 'Kitchen'),
(345, 'Pool'),
(456, 'Pool');


select * from hotel

with cte as (
	select
	rental_id, group_concat(amenities order by amenities separator ",") as all_amenities
	from hotel 
	group by rental_id
)
select round(count(*)/2, 0) as matching_airbnb
from cte c1 
join cte c2
on c1.all_amenities = c2.all_amenities
and c1.rental_id != c2.rental_id


