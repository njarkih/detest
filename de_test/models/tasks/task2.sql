{{ config(materialized='view') }}

WITH mds AS (
	SELECT LEFT(email, 1) || SUBSTRING(email, 3, LENGTH(email)-1) email, department
	FROM manager_departments
)
SELECT COALESCE(mds.department, 'Отдел не определен') department, SUM(p.value) "sum"
FROM payments p
LEFT JOIN mds ON p.manager_email = mds.email
GROUP BY mds.department