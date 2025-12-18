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

-- AS CTE
WITH monthly_sales AS (
  SELECT 
    id as id,
    month as month,
    SUM(sales) as total_sales
  FROM playground.sales 
GROUP BY id, month
),
ranked_sales AS (
  SELECT 
    id,
    month,
    total_sales,
    RANK() OVER (PARTITION BY month ORDER BY total_sales desc) as rank  
    FROM monthly_sales
)
SELECT 
  id,
  month,
  total_sales,
  rank
FROM ranked_sales
WHERE RANK IN (1,2)
ORDER BY month desc
