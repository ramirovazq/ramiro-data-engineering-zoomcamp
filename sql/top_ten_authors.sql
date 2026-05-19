-- Who are the top 10 authors by number of reviews?
 

-- Using bootcamp.books, find the top 10 authors by reviews, 
-- no_of_reviews is a string column with bad data,
-- try your best to get the values to parse correctly
-- These are the tables to query for this question:
-- bootcamp.books

--     s_no int
--     price double
--     ranks int
--     title string
--     no_of_reviews string
--     ratings string
--     author string
--     cover_type string
--     year string
--     genre string

-- Your answer should include these columns:

--     author varchar
--     number_of_reviews bigint

SELECT 
  author,
  SUM(
  COALESCE(
    NULLIF(
      REGEXP_REPLACE(
        no_of_reviews,
        '[0-9.,]',
        ''),
     ''), 
    0))
FROM bootcamp.books 
WHERE 
  AUTHOR = '22,268' 
  OR AUTHOR = '4.4'
--GROUP BY AUTHOR
ORDER BY 2 asc
limit 10