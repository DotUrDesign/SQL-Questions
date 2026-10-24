CREATE TABLE sys.subscriber (
 sms_date date ,
 sender varchar(20) ,
 receiver varchar(20) ,
 sms_no int
);
-- insert some values
INSERT INTO sys.subscriber VALUES ('2020-4-1', 'Avinash', 'Vibhor',10);
INSERT INTO sys.subscriber VALUES ('2020-4-1', 'Vibhor', 'Avinash',20);
INSERT INTO sys.subscriber VALUES ('2020-4-1', 'Avinash', 'Pawan',30);
INSERT INTO sys.subscriber VALUES ('2020-4-1', 'Pawan', 'Avinash',20);
INSERT INTO sys.subscriber VALUES ('2020-4-1', 'Vibhor', 'Pawan',5);
INSERT INTO sys.subscriber VALUES ('2020-4-1', 'Pawan', 'Vibhor',8);
INSERT INTO sys.subscriber VALUES ('2020-4-1', 'Vibhor', 'Deepak',50);

-- find total no of messages exchanged between each person per day

select * from sys.subscriber


with person_cte as (
    select sms_date,
    case 
        when sender < receiver then sender 
        else receiver 
    end as person1,
    case 
        when sender > receiver then sender
        else receiver 
    end as person2,
    sms_no
    from sys.subscriber
)

select sms_date, person1, person2, sum(sms_no) as total_sms
from person_cte 
group by sms_date, person1, person2
order by sms_date, person1, person2