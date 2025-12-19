WITH rolling_avg AS (
    SELECT 
    user_id,
    post_date,
    AVG(post_count) OVER ( 
        PARTITION BY user_id
        ORDER BY post_date 
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS rolling_3_day_avg
    FROM playground.posts 
) 
SELECT 
  user_id,
  post_date,
  ROUND(rolling_3_day_avg, 2) AS third_rolling_avg
FROM rolling_avg
ORDER BY user_id, post_date asc;

-- One single query
SELECT 
    user_id,
    post_date,
    ROUND(
        AVG(post_count) OVER ( 
            PARTITION BY user_id
            ORDER BY post_date 
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ), 2) AS third_rolling_avg
FROM playground.posts 
ORDER BY user_id, post_date;