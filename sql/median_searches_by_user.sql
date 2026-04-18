-- Calculating Median Searches per User
--  Using the table playground.search_freq with each row representing the number of searches (searches column) 
--  made by a certain number of users (users column), write a SQL query to calculate the median number of 
--  searches per user up to one decimal place and be sure to cast it as a double.

WITH rank_searches_by_users AS (
    SELECT 
        searches,
        num_users,
        ROW_NUMBER() OVER (ORDER BY searches) AS num_rank,
        COUNT(*) OVER () AS total_rows,
        FLOOR((total_rows + 1) / 2) AS floor_row,
        CEIL((total_rows + 1) / 2) as ceil_row
    FROM playground.search_freq 
    ORDER BY searches, num_users
)
SELECT 
  AVG(searches) AS median
FROM rank_searches_by_users
WHERE num_rank IN (floor_row, ceil_row)