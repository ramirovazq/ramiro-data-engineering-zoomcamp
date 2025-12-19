WITH avg_3_day AS (
SELECT 
  user_id,
  post_date,
  AVG(post_count) OVER ( 
    PARTITION BY user_id
    ORDER BY post_date 
    ROWS BETWEEN 2 PRECEDING 
    AND CURRENT ROW
  ) AS third_rolling_avg
FROM playground.posts 
ORDER BY POST_DATE asc
) 
SELECT 
  user_id,
  post_date,
  ROUND(third_rolling_avg, 2) AS third_rolling_avg
FROM avg_3_day