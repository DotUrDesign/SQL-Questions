use sys
create table phonelog(
    Callerid int, 
    Recipientid int,
    Datecalled datetime
);

insert into phonelog(Callerid, Recipientid, Datecalled)
values(1, 2, '2019-01-01 09:00:00.000'),
       (1, 3, '2019-01-01 17:00:00.000'),
       (1, 4, '2019-01-01 23:00:00.000'),
       (2, 5, '2019-07-05 09:00:00.000'),
       (2, 3, '2019-07-05 17:00:00.000'),
       (2, 3, '2019-07-05 17:20:00.000'),
       (2, 5, '2019-07-05 23:00:00.000'),
       (2, 3, '2019-08-01 09:00:00.000'),
       (2, 3, '2019-08-01 17:00:00.000'),
       (2, 5, '2019-08-01 19:30:00.000'),
       (2, 4, '2019-08-02 09:00:00.000'),
       (2, 5, '2019-08-02 10:00:00.000'),
       (2, 5, '2019-08-02 10:45:00.000'),
       (2, 4, '2019-08-02 11:00:00.000');
       
       
select * from phonelog


------------------------------------------------------------------


with cte as (
	select 
	callerid, recipientid, datecalled, 
	row_number() over(partition by date_format(datecalled, "%Y-%m-%d"), callerid order by datecalled asc) as calls1,
	row_number() over(partition by date_format(datecalled, "%Y-%m-%d"), callerid order by datecalled desc) as calls2
	from phonelog
)

select 
callerid, recipientid, date_format(datecalled, "%Y-%m-%d") as caller_date
from cte 
where calls1 = 1 or calls2 = 1
group by date_format(datecalled, "%Y-%m-%d"), callerid, recipientid
having count(*) = 2