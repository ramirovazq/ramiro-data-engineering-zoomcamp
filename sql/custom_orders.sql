-- List all customers who have not placed any orders.

-- These are the tables to query for this question:
-- bootcamp.quiz_customers
-- bootcamp.quiz_orders

-- Your answer should include these columns:
-- customer_id integer
-- customer_name varchar

SELECT 
    customer_id,
    customer_name
FROM bootcamp.quiz_customers
WHERE CUSTOMER_ID NOT IN (
    SELECT CUSTOMER_ID 
    FROM bootcamp.quiz_orders
);
-- opcion 2
SELECT
c.customer_id,
c.customer_name
FROM bootcamp.quiz_customers c
LEFT JOIN bootcamp.quiz_orders o
ON c.customer_id = o.customer_id
WHERE o.customer_id IS NULL;

--
SELECT
c.customer_id,
c.customer_name
FROM bootcamp.quiz_customers c
WHERE NOT EXISTS (
  SELECT 1 FROM bootcamp.quiz_orders o
  WHERE c.customer_id = o.customer_id
);