
-- Return the orders with missing customers
-- Tables
-- bootcamp.orders
-- bootcamp.customers

-- Answer should include the following columns:
-- order_id bigint
-- customer_id bigint
-- order_date date

-- first approach
SELECT 
  o.order_id,
  o.customer_id,
  o.order_date
FROM bootcamp.orders o 
WHERE customer_id IS NULL;

-- second approach
SELECT 
  order_id,
  customer_id,
  order_date
FROM(
SELECT 
  o.order_id,
  o.customer_id as cust_id,
  o.order_date,
  c.customer_id as customer_id,
  c.name
FROM bootcamp.orders o 
LEFT JOIN bootcamp.customers c
  ON o.customer_id = c.customer_id
) WHERE customer_id IS NULL;

-- third approach
SELECT 
  o.order_id,
  o.customer_id,
  o.order_date
FROM bootcamp.orders as o 
LEFT JOIN bootcamp.customers as c
  ON o.customer_id = c.customer_id
 WHERE c.customer_id IS NULL

 -- last approach and best practice
 SELECT
    o.order_id,
    o.customer_id,
    o.order_dateo
FROM bootcamp.orders o
WHERE NOT EXISTS (
    SELECT 1
    FROM bootcamp.customers as c
    WHERE o.customer_id = c.customer_id
);