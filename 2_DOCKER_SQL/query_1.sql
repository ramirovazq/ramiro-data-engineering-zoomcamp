SELECT * FROM yellow_taxi_trips limit 100;

SELECT * FROM zones
WHERE zones."LocationID" = 264;

-- one way to join between all combinations
SELECT 
	tpep_pickup_datetime,
	tpep_dropoff_datetime,
	total_amount,
	CONCAT(zpu."Borough",' / ', zpu."Zone") as "pick_up_loc",
	CONCAT(zdo."Borough", ' / ', zdo."Zone") as "drop_off_loc"
FROM yellow_taxi_trips t,
	zones zpu,
	zones zdo
WHERE t."PULocationID" = zpu."LocationID" 
AND t."DOLocationID" = zdo."LocationID" 
LIMIT 100;



-- checking if empty PU or DO locationId
SELECT 
	tpep_pickup_datetime,
	tpep_dropoff_datetime,
	total_amount,
	"PULocationID",
	"DOLocationID"
	--*
FROM yellow_taxi_trips t 
WHERE "PULocationID" is null OR "DOLocationID" is null;

-- checking if are locations in trips that doesn't exist in zones
SELECT 
	tpep_pickup_datetime,
	tpep_dropoff_datetime,
	total_amount,
	"PULocationID",
	"DOLocationID"
	--*
FROM yellow_taxi_trips t 
WHERE "PULocationID" NOT IN (SELECT "LocationID" FROM zones)
OR "DOLocationID" NOT IN (SELECT "LocationID" FROM zones)

-- to show LEFT JOIN we need to DELETE ONE RECORD FROM zones
DELETE FROM zones WHERE "LocationID" = '142';

-- WITH INNER IS NOT POSSIBLE TO SEE EMPTY INNER
SELECT 
	tpep_pickup_datetime,
	tpep_dropoff_datetime,
	total_amount,
	"PULocationID",
	"DOLocationID",
	CONCAT(zpu."Borough",' ** ', zpu."Zone") as "pick_up_loc",
	CONCAT(zdo."Borough", ' / ', zdo."Zone") as "drop_off_loc"
FROM yellow_taxi_trips t 
INNER JOIN zones zpu 
	ON t."PULocationID" = zpu."LocationID"
INNER JOIN zones zdo 
	ON t."DOLocationID" = zdo."LocationID"
WHERE total_amount = 40.3;


-- WE USE LEFT JOIN AND CAN SEE EMPTY VALUES
SELECT 
	tpep_pickup_datetime,
	tpep_dropoff_datetime,
	total_amount,
	"PULocationID",
	"DOLocationID",
	CONCAT(zpu."Borough",' / ', zpu."Zone") as "pick_up_loc",
	CONCAT(zdo."Borough", ' / ', zdo."Zone") as "drop_off_loc"
FROM yellow_taxi_trips t 
LEFT JOIN zones zpu 
	ON t."PULocationID" = zpu."LocationID"
LEFT JOIN zones zdo 
	ON t."DOLocationID" = zdo."LocationID";


SELECT 
	tpep_pickup_datetime,
	tpep_dropoff_datetime,
	total_amount,
	"PULocationID",
	"DOLocationID",
	CONCAT(zpu."Borough",' / ', zpu."Zone") as "pick_up_loc",
	CONCAT(zdo."Borough", ' / ', zdo."Zone") as "drop_off_loc"
FROM yellow_taxi_trips t 
RIGHT JOIN zones zpu 
	ON t."PULocationID" = zpu."LocationID"
RIGHT JOIN zones zdo 
	ON t."DOLocationID" = zdo."LocationID"
ORDER BY "PULocationID", "DOLocationID";


SELECT 
	tpep_pickup_datetime,
	tpep_dropoff_datetime,
	total_amount,
	"PULocationID",
	"DOLocationID",
	CONCAT(zpu."Borough",' / ', zpu."Zone") as "pick_up_loc",
	CONCAT(zdo."Borough", ' / ', zdo."Zone") as "drop_off_loc"
FROM yellow_taxi_trips t 
FULL OUTER JOIN zones zpu 
	ON t."PULocationID" = zpu."LocationID"
FULL OUTER JOIN zones zdo 
	ON t."DOLocationID" = zdo."LocationID";


-- GROUP BY
SELECT 
	tpep_pickup_datetime,
	tpep_dropoff_datetime,
	DATE_TRUNC('day', tpep_dropoff_datetime),
	total_amount
FROM yellow_taxi_trips t ;

SELECT 
	CAST(tpep_dropoff_datetime AS DATE) AS "day",
	"DOLocationID",
	count(1) as "count",
	SUM(total_amount) as "sum_amount",
	MAX(total_amount) as "total_amount",
	MAX(passenger_count) as "passanger_count"
FROM yellow_taxi_trips t 
--GROUP BY CAST(tpep_dropoff_datetime AS DATE)
GROUP BY 1,2
--ORDER BY "count" DESC;
ORDER BY "day" ASC, 
"DOLocationID" ASC;
