
CREATE OR REPLACE EXTERNAL TABLE `utility-cathode-448702-g7.448702_dezoomcamp_hw3.yellow_tripdata_2024_external`
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://448702-dezoomcamp_hw3_2025/yellow_tripdata_2024-*.parquet']
);

-- Create a non partitioned table from external table
CREATE OR REPLACE TABLE `utility-cathode-448702-g7.448702_dezoomcamp_hw3.yellow_tripdata_2024` AS
SELECT * FROM `utility-cathode-448702-g7.448702_dezoomcamp_hw3.yellow_tripdata_2024_external`;

SELECT *
FROM `utility-cathode-448702-g7.448702_dezoomcamp_hw3.yellow_tripdata_2024`
limit 1000
;


-- QUESTION 1 
SELECT COUNT(*) FROM `utility-cathode-448702-g7.448702_dezoomcamp_hw3.yellow_tripdata_2024_external`;
-- 20,332,093
SELECT COUNT(*) FROM `utility-cathode-448702-g7.448702_dezoomcamp_hw3.yellow_tripdata_2024`;
-- 20,332,093

-- QUESTION 2
SELECT count(distinct PULocationID)
FROM `utility-cathode-448702-g7.448702_dezoomcamp_hw3.yellow_tripdata_2024_external`;
-- EXTERNAL TABLE 155.12 MB processed.  156 MB billed
-- But in fact when is external, BigQuery can't determine how much because is not in 
-- internal storage for bigquery so it's 0

SELECT count(distinct PULocationID)
FROM `utility-cathode-448702-g7.448702_dezoomcamp_hw3.yellow_tripdata_2024`;
-- TABLE 155.12 MB processed. 


-- QUESTION 3
SELECT PULocationID --155.12MB, 156MB
FROM `utility-cathode-448702-g7.448702_dezoomcamp_hw3.yellow_tripdata_2024`;

SELECT DOLocationID --155.12MB, 156MB
FROM `utility-cathode-448702-g7.448702_dezoomcamp_hw3.yellow_tripdata_2024`;

SELECT PULocationID, DOLocationID -- 310.24MB, 311MB
FROM `utility-cathode-448702-g7.448702_dezoomcamp_hw3.yellow_tripdata_2024`;


-- QUESTION 4
SELECT 
fare_amount, 
--SAFE_CAST(fare_amount AS INT64) as fare_amount_safe_cast,
--CAST(fare_amount AS INT64) as fare_amount_cast,
--CAST(ROUND(fare_amount) AS INT64) as fare_amount_round_cast,
CEIL(fare_amount) as fare_amount_ceil,
SAFE_CAST(CEIL(fare_amount) AS INT64) as fare_amount_ceil_and_int
FROM `utility-cathode-448702-g7.448702_dezoomcamp_hw3.yellow_tripdata_2024`
WHERE 1=1
AND fare_amount >= 0 and fare_amount < 0.1
AND SAFE_CAST(CEIL(fare_amount) AS INT64) = 0
order by fare_amount asc
;


-- Question 5:
-- What is the best strategy to make an optimized table in Big Query if your query will always filter -- based on tpep_dropoff_datetime and order the results by VendorID (Create a new table with this 
-- strategy)
-- In my opiont should be partition tpep_dropoff_datetime and cluster VendorID.
-- Big query only allows to use one partition. 
-- In Big query is only possible to generate first a partition then a clustering, but is not possible 
-- to do it first clustering then partition.

CREATE OR REPLACE TABLE utility-cathode-448702-g7.448702_dezoomcamp_hw3.yellow_tripdata_2024_partitoned_clustered
PARTITION BY DATE(tpep_dropoff_datetime)
CLUSTER BY VendorID AS
SELECT * FROM utility-cathode-448702-g7.448702_dezoomcamp_hw3.yellow_tripdata_2024_external;

SELECT count(*) as trips
FROM utility-cathode-448702-g7.448702_dezoomcamp_hw3.yellow_tripdata_2024_partitoned_clustered
WHERE DATE(tpep_dropoff_datetime) BETWEEN '2024-03-01' AND '2024-05-01'
  AND VendorID=1;
-- 90.09 MB

SELECT count(*) as trips
FROM utility-cathode-448702-g7.448702_dezoomcamp_hw3.yellow_tripdata_2024
WHERE DATE(tpep_dropoff_datetime) BETWEEN '2024-03-01' AND '2024-05-01'
  AND VendorID=1;
-- 310.24 MB

CREATE OR REPLACE TABLE utility-cathode-448702-g7.448702_dezoomcamp_hw3.yellow_tripdata_2024_clustered_clustered
CLUSTER BY tpep_dropoff_datetime, VendorID  AS
SELECT * FROM utility-cathode-448702-g7.448702_dezoomcamp_hw3.yellow_tripdata_2024_external;

SELECT count(*) as trips
FROM utility-cathode-448702-g7.448702_dezoomcamp_hw3.yellow_tripdata_2024_clustered_clustered
WHERE DATE(tpep_dropoff_datetime) BETWEEN '2024-03-01' AND '2024-05-01'
  AND VendorID=1;
  -- 115.98 MB



-- Question 6:
SELECT distinct VendorID
FROM `utility-cathode-448702-g7.448702_dezoomcamp_hw3.yellow_tripdata_2024`
WHERE  1=1
AND tpep_dropoff_datetime >= '2024-03-01' 
AND tpep_dropoff_datetime <= '2024-03-15'
-- 310.24MB

SELECT distinct VendorID
FROM utility-cathode-448702-g7.448702_dezoomcamp_hw3.yellow_tripdata_2024_partitoned_clustered
WHERE  1=1
AND tpep_dropoff_datetime >= '2024-03-01' 
AND tpep_dropoff_datetime <= '2024-03-15'
-- 26.84MB