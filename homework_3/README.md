# Module Homework 3 - Cohort 2025


## Quiz Questions

### 1. Question 1: What is count of records for the 2024 Yellow Taxi Data?

```
-- QUESTION 1 
SELECT COUNT(*) FROM `utility-cathode-448702-g7.448702_dezoomcamp_hw3.yellow_tripdata_2024_external`;
-- 20,332,093
SELECT COUNT(*) FROM `utility-cathode-448702-g7.448702_dezoomcamp_hw3.yellow_tripdata_2024`;
-- 20,332,093
```

##### Answer
Then answer 20,332,093


### 2. Write a query to count the distinct number of PULocationIDs for the entire dataset on both the tables. What is the estimated amount of data that will be read when this query is executed on the External Table and the Table?

```
SELECT count(distinct PULocationID)
FROM `utility-cathode-448702-g7.448702_dezoomcamp_hw3.yellow_tripdata_2024_external`;
-- EXTERNAL TABLE 155.12 MB processed.  156 MB billed
-- But in fact when is external, BigQuery can't determine how much because is not in 
-- internal storage for bigquery so it's 0

SELECT count(distinct PULocationID)
FROM `utility-cathode-448702-g7.448702_dezoomcamp_hw3.yellow_tripdata_2024`;
-- TABLE 155.12 MB processed. 

```

#### Answer
0 and TABLE 155.12 MB processed. 

### 3. Write a query to retrieve the PULocationID from the table (not the external table) in BigQuery. Now write a query to retrieve the PULocationID and DOLocationID on the same table. Why are the estimated number of Bytes different?
```
-- QUESTION 3
SELECT PULocationID --155.12MB, 156MB
FROM `utility-cathode-448702-g7.448702_dezoomcamp_hw3.yellow_tripdata_2024`;

SELECT DOLocationID --155.12MB, 156MB
FROM `utility-cathode-448702-g7.448702_dezoomcamp_hw3.yellow_tripdata_2024`;

SELECT PULocationID, DOLocationID -- 310.24MB, 311MB
FROM `utility-cathode-448702-g7.448702_dezoomcamp_hw3.yellow_tripdata_2024`;

```

#### Answer
BigQuery is a columnar database, and it only scans the specific columns requested in the query. Querying two columns (PULocationID, DOLocationID) requires reading more data than querying one column (PULocationID), leading to a higher estimated number of bytes processed.


### 4. How many records have a fare_amount of 0?

```
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

```

#### Answer
8,333


### 5. What is the best strategy to make an optimized table in Big Query if your query will always filter based on tpep_dropoff_datetime and order the results by VendorID (Create a new table with this strategy)
 
```
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

```

#### Answer
Partition by tpep_dropoff_datetime and Cluster on VendorID


### 6. Write a query to retrieve the distinct VendorIDs between tpep_dropoff_datetime 2024-03-01 and 2024-03-15 (inclusive). Use the materialized table you created earlier in your from clause and note the estimated bytes. Now change the table in the from clause to the partitioned table you created for question 5 and note the estimated bytes processed. What are these values? Choose the answer which most closely matches.

```
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

```

#### Answer
310.24 MB for non-partitioned table and 26.84 MB for the partitioned table


### 7. Where is the data stored in the External Table you created?
```
-- In our case we are using GCP Bucket
```

#### Answer
GCP Bucket


### 8. It is best practice in Big Query to always cluster your data:
```
-- False it depends on datset. For example for smaller dataset < 1GB it's not a good idea 
-- even could increase costs
```

#### Answer
Not always


### 9. No Points: Write a SELECT count(*) query FROM the materialized table you created. How many bytes does it estimate will be read? Why?

```
```
#### Answer
