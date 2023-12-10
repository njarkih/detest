

WITH rank_data AS (
	SELECT
	  id
	, value
	, client_id
	, client_name
	, payment_date
	, manager_name
	, manager_email
	, RANK() OVER (PARTITION BY client_id ORDER BY payment_date, id) rnk
	FROM payments
)
SELECT
  id
, value
, client_id
, client_name
, payment_date
, manager_name
, manager_email
, if(rnk = 1, 'Новый', 'Действующий') client_state
FROM rank_data