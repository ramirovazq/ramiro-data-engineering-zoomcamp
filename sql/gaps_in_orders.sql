-- Detecting Gaps in a Sequence
-- Given a table quiz_orders(order_id, customer_id, order_date) 
-- where order_id should be consecutive daily numbers, 
-- list any missing order_ids
-- These are the tables to query for this question:
-- bootcamp.quiz_orders

-- Your answer should include these columns:
--     missing_id integer

select 
order_id + 1 as missing_id
from (
	SELECT 
	order_id,
	lead(order_id) over (order by order_id) as next_id
	FROM bootcamp.quiz_orders
) t
where next_id - order_id > 1