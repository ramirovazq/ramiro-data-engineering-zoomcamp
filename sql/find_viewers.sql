-- Find Viewers with Multiple Article Views in a Day
-- Using the table playground.views, write a SQL query to identify all viewers who viewed more than one article on the same day. The table includes columns viewer_id (the ID of the viewer), article_id (the ID of the article viewed), and view_date (the date of the view). The result should contain a single column named viewer_id, listing each viewer who meets the criteria without duplicates, and should be sorted in ascending order of viewer_id.
-- These are the tables to query for this question:
-- playground.views
--     article_id int
--     author_id int
--     viewer_id int
--     view_date date
-- Your answer should include these columns:
--     viewer_id integer

-- view_date, viewer_id, article_id
-- 23/01/2026, 10, x
-- 23/01/2026, 10, y
-- 23/01/2026, 10, z
-- 23/01/2026, 9, x
-- 23/01/2026, 8, y
-- 23/01/2026, 8, y


-- view_date, viewer_id, count_different_articles
-- 23/01/2026, 10, 3
-- 23/01/2026, 9, 1
-- 23/01/2026, 8, 2
WITH group_by_same_article as (
  SELECT 
    view_date, 
    viewer_id, 
    article_id
  FROM playground.views 
  GROUP BY view_date, viewer_id, article_id
)

SELECT 
  viewer_id
FROM group_by_same_article
GROUP BY view_date, viewer_id
HAVING count(*) > 1
ORDER BY viewer_id asc

-- same query without CTE
SELECT 
  viewer_id
FROM (
    SELECT 
    view_date, 
    viewer_id, 
    article_id
  FROM playground.views 
  GROUP BY view_date, viewer_id, article_id
) 
GROUP BY view_date, viewer_id
HAVING count(*) > 1
ORDER BY viewer_id asc

