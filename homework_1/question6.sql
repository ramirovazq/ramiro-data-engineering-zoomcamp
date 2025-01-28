SELECT
DATE_TRUNC('month', lpep_pickup_datetime) AS month_picked_up,
zpu."Zone" as "zone_pick_up_loc",
zdo."Zone" as "zone_do_loc",
tip_amount
FROM green_taxi_trips t 
LEFT JOIN zones_homework zpu
	ON t."PULocationID" = zpu."LocationID"
LEFT JOIN zones_homework zdo 
	ON t."DOLocationID" = zdo."LocationID"
WHERE DATE_TRUNC('month', lpep_pickup_datetime) = '2019-10-01'
AND zpu."Zone" = 'East Harlem North'
GROUP BY 1,2,3,4
ORDER BY tip_amount desc
