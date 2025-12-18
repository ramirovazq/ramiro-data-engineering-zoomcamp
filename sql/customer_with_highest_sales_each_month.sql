-- AS SUBQUERY
SELECT 
  * 
FROM (
SELECT 
  *,
  RANK() OVER (PARTITION BY month ORDER BY total_sales desc) as rank
FROM (
SELECT 
  id as id,
  month as month,
  SUM(sales) as total_sales
FROM playground.sales 
GROUP BY id, month
)
  ) WHERE RANK IN (1,2)

