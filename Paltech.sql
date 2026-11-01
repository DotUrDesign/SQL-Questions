
1 c
1 S
2 c
3 s

1 c 2
1 s 2
2 c 1
3 s 1


with cte as (
    select
    customer_id, account_type,
    count(1) over(partition by customer_id) as cnt
    from customer
)

select distinct customer_id
from cte 
where account_type = 'SAVINGS' and cnt = 1



-----------------------------------------------

Write pyspark code to implement SCD1 and SCD2 logics 


target / source 
id, name, salary

scd-1

df1 = target_df.alias("t")
df2 = source_df.alias("s")

output = target_df.alias("t").merge(source_df.alias("s"), "t.id = s.id")\
                            .whenMatched(set = {
                                "id" = "s.id",
                                "name" = "s.name",
                                "salary" = "s.salary"
                            })\
                            .whenNotMatched(insert = {
                                "id" = "s.id",
                                "name" = "s.name",
                                "salary" = "s.salary"
                            })\
                            .execute()




scd type -2 

