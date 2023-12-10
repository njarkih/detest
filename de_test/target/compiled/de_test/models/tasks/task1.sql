

WITH rank_payments AS (
  SELECT
    client_name
  , payment_date
  , value
  , RANK() OVER (PARTITION BY client_id ORDER BY value DESC) rnk
  FROM payments
  WHERE payment_date BETWEEN '2023-01-01' AND '2023-01-31'
)
SELECT
  client_name
, payment_date
, value
FROM rank_payments
WHERE rnk = 1
ORDER BY client_name