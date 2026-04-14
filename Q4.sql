set @given_date = '2025-11-17';
set @n = 3;

select date_add(
@given_date,
interval(
	(7 - dayofweek(@given_date) - 1)
    + (7 * (@n-1))
) day)





/*
select date_add(
@given_date,
interval(
(7-dayofweek(@given_date)+1)
+
(7*(@n-1))
)day)
*/