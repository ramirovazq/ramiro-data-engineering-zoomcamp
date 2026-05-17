-- Find Product Prices
-- Using the table playground.product_prices, create a SQL query to find all products 
-- and their prices on 2023-08-17, assuming the initial price of all products was 10 before any price changes. 
-- Order the results in ascending order of product_id.
-- These are the tables to query for this question:
-- playground.product_prices

--     product_id int
--     new_price int
--     change_date date

-- Your answer should include these columns:

--     product_id integer
--     price integer

with all_products as (
	select 
		distinct product_id
	from product_prices 
	order by 1
), all_products_in_order as (
	select
		product_id,
		new_price,
		change_date,
		ROW_NUMBER() OVER(partition by product_id order by change_date desc) as rn
	from product_prices
	where change_date <= '2023-08-17'
	order by product_id, change_date desc
)

select 
	ap.product_id,
	apo.product_id,
	coalesce(apo.new_price, 10) as price,
	apo.change_date,
	apo.rn
from all_products ap
left join all_products_in_order apo
on ap.product_id = apo.product_id
and apo.rn = 1

