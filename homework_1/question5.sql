SELECT 
	DATE_TRUNC('day', lpep_pickup_datetime),
	CONCAT(zpu."Borough",' / ', zpu."Zone") as "pick_up_loc",
	SUM(total_amount)
FROM green_taxi_trips t 
LEFT JOIN zones_homework zpu 
	ON t."PULocationID" = zpu."LocationID"
WHERE DATE_TRUNC('day', lpep_pickup_datetime) = '2019-10-18'
GROUP BY 1,2
HAVING SUM(total_amount) > 13000
ORDER BY 3 DESC;