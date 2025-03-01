CREATE TABLE utility-cathode-448702-g7.trips_data_all.yellow_trip_data AS
SELECT * FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2019`;

INSERT INTO utility-cathode-448702-g7.trips_data_all.yellow_trip_data 
SELECT * FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2020`;

-- FOR GREEN TRIP DATA

CREATE TABLE utility-cathode-448702-g7.trips_data_all.green_trip_data AS
SELECT * FROM `bigquery-public-data.new_york_taxi_trips.tlc_green_trips_2019`;

INSERT INTO utility-cathode-448702-g7.trips_data_all.green_trip_data 
SELECT * FROM `bigquery-public-data.new_york_taxi_trips.tlc_green_trips_2020`;


CREATE TABLE utility-cathode-448702-g7.trips_data_all.fhv_trip_data AS

--
-- Fixes yellow table schema
ALTER TABLE `utility-cathode-448702-g7.trips_data_all.yellow_trip_data`
  RENAME COLUMN vendor_id TO VendorID;
ALTER TABLE `utility-cathode-448702-g7.trips_data_all.yellow_trip_data`
  RENAME COLUMN pickup_datetime TO tpep_pickup_datetime;
ALTER TABLE `utility-cathode-448702-g7.trips_data_all.yellow_trip_data`
  RENAME COLUMN dropoff_datetime TO tpep_dropoff_datetime;
ALTER TABLE `utility-cathode-448702-g7.trips_data_all.yellow_trip_data`
  RENAME COLUMN rate_code TO RatecodeID;
ALTER TABLE `utility-cathode-448702-g7.trips_data_all.yellow_trip_data`
  RENAME COLUMN imp_surcharge TO improvement_surcharge;
ALTER TABLE `utility-cathode-448702-g7.trips_data_all.yellow_trip_data`
  RENAME COLUMN pickup_location_id TO PULocationID;
ALTER TABLE `utility-cathode-448702-g7.trips_data_all.yellow_trip_data`
  RENAME COLUMN dropoff_location_id TO DOLocationID;



 -- Fixes green table schema
ALTER TABLE `utility-cathode-448702-g7.trips_data_all.green_trip_data`
  RENAME COLUMN vendor_id TO VendorID;
ALTER TABLE `utility-cathode-448702-g7.trips_data_all.green_trip_data`
  RENAME COLUMN pickup_datetime TO lpep_pickup_datetime;
ALTER TABLE `utility-cathode-448702-g7.trips_data_all.green_trip_data`
  RENAME COLUMN dropoff_datetime TO lpep_dropoff_datetime;
ALTER TABLE `utility-cathode-448702-g7.trips_data_all.green_trip_data`
  RENAME COLUMN rate_code TO RatecodeID;
ALTER TABLE `utility-cathode-448702-g7.trips_data_all.green_trip_data`
  RENAME COLUMN imp_surcharge TO improvement_surcharge;
ALTER TABLE `utility-cathode-448702-g7.trips_data_all.green_trip_data`
  RENAME COLUMN pickup_location_id TO PULocationID;
ALTER TABLE `utility-cathode-448702-g7.trips_data_all.green_trip_data`
  RENAME COLUMN dropoff_location_id TO DOLocationID;