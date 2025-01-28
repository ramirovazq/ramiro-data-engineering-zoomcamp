SELECT 
lpep_pickup_datetime,
trip_distance
FROM green_taxi_trips
order by trip_distance desc
limit 1;
