create table sys.company_users 
(
company_id int,
user_id int,
language varchar(20)
);

insert into sys.company_users values (1,1,'English')
,(1,1,'German')
,(1,2,'English')
,(1,3,'German')
,(1,3,'English')
,(1,4,'English')
,(2,5,'English')
,(2,5,'German')
,(2,5,'Spanish')
,(2,6,'German')
,(2,6,'Spanish')
,(2,7,'English');

select * from sys.company_users


-- find the companies who have at-least 2 users who speaks English and German both the languages. 

with eng_ger_users_cte as (
select * 
from sys.company_users 
where language in ("English", "German")
),
final_cte as (
select max(company_id) as company_id, user_id, count(*) as no_of_lang
from eng_ger_users_cte
group by user_id
)
select company_id
from final_cte 
where no_of_lang = 2
group by company_id
having count(*) >= 2











