-- Calculate the number of seats not yet purchased for each flight. 
-- Use three tables: 
--     playground.flights (with columns: flight_id, plane_id)
--     playground.planes (with columns: plane_id, number_of_seats)
--     playground.purchases (with columns: flight_id, seat_no)
-- Each row in purchases is unique for (flight_id, seat_no) pairs. 
-- For each flight_id, compute the free_seats as the number of seats not purchased. 
-- Order the results by flight_id in ascending order. 
-- Ensure consistency in purchases, with no records for non-existing flight_ids or seat_nos.

WITH purchased_seats_per_flight AS (
    SELECT
        flight_id,
        COUNT(seat_no) AS purchased_seats
    FROM playground.purchases
    GROUP BY flight_id
)
SELECT 
    f.flight_id,
    pl.plane_id,    
    pl.number_of_seats - COALESCE(ps.purchased_seats,0) AS free_seats
FROM playground.flights f
INNER JOIN playground.planes pl
ON f.plane_id = pl.plane_id
LEFT JOIN purchased_seats_per_flight ps
ON f.flight_id = ps.flight_id
ORDER BY f.flight_id ASC;