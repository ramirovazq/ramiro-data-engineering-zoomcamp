SELECT 
COUNT(*)
FROM green_taxi_trips
WHERE lpep_pickup_datetime >= '2019-10-01'
AND lpep_dropoff_datetime < '2019-11-01'
--AND trip_distance <= 1 -- 104,802
--AND trip_distance > 1
--AND trip_distance <= 3
--AND trip_distance > 3 
--AND trip_distance <= 7 
--AND trip_distance > 7 
--AND trip_distance <= 10 
--AND trip_distance > 10
