SELECT 
    user_id,
    post_date,
    AVG(post_count) OVER ( PARTITION BY user_id ORDER BY post_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS third_rolling_avg,
FROM playground.posts