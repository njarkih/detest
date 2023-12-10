

  create view `dedb`.`task4__dbt_tmp` 
  
    
    
  as (
    

WITH group_data AS(
	SELECT
	  toMonth(payment_date) tmonth
	, toYear(payment_date) tyear
	, SUM(value) revenue_by_month
	FROM payments
	GROUP BY tmonth, tyear
)
, months_name AS(
	SELECT 1 tmonth, 'Январь' name UNION ALL
	SELECT 2, 'Февраль'		UNION ALL
	SELECT 3, 'Март'		UNION ALL
	SELECT 4, 'Апрель' 		UNION ALL
	SELECT 5, 'Май' 		UNION ALL
	SELECT 6, 'Июнь' 		UNION ALL
	SELECT 7, 'Июль' 		UNION ALL
	SELECT 8, 'Август' 		UNION ALL
	SELECT 9, 'Сентябрь' 	UNION ALL
	SELECT 10, 'Октябрь' 	UNION ALL
	SELECT 11, 'Ноябрь'		UNION ALL
	SELECT 12, 'Декабрь'
)
SELECT mn.name || ' ' || toString(gd.tyear) "period"
, revenue_by_month
, SUM(revenue_by_month) OVER w revenue_cumulative
FROM group_data gd
INNER JOIN months_name mn ON gd.tmonth = mn.tmonth
WINDOW w AS (
  PARTITION BY gd.tyear
  ORDER BY gd.tmonth
  ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
)
  )