CREATE OR REPLACE EXTERNAL TABLE `utility-cathode-448702-g7.dbt_hw3_2025.external_yellow_tripdata`
OPTIONS(
  format = 'CSV',
  uris = ['gs://448702-dezoomcamp_hw3_2025/yellow_tripdata/yellow_tripdata_2019-*.csv', 
          'gs://448702-dezoomcamp_hw3_2025/yellow_tripdata/yellow_tripdata_2020-*.csv']
);

CREATE OR REPLACE TABLE `utility-cathode-448702-g7.dbt_hw3_2025.yellow_tripdata` AS
SELECT * FROM `utility-cathode-448702-g7.dbt_hw3_2025.external_yellow_tripdata`;

SELECT count(*)
FROM `utility-cathode-448702-g7.dbt_hw3_2025.yellow_tripdata`;





CREATE OR REPLACE EXTERNAL TABLE `utility-cathode-448702-g7.dbt_hw3_2025.external_green_tripdata`
OPTIONS(
  format = 'CSV',
  uris = ['gs://448702-dezoomcamp_hw3_2025/green_tripdata/green_tripdata_2019-*.csv', 
          'gs://448702-dezoomcamp_hw3_2025/green_tripdata/green_tripdata_2020-*.csv']
);

CREATE OR REPLACE TABLE `utility-cathode-448702-g7.dbt_hw3_2025.green_tripdata` AS
SELECT * FROM `utility-cathode-448702-g7.dbt_hw3_2025.external_green_tripdata`;

SELECT count(*)
FROM `utility-cathode-448702-g7.dbt_hw3_2025.green_tripdata`;




CREATE OR REPLACE EXTERNAL TABLE `utility-cathode-448702-g7.dbt_hw3_2025.external_fhv`
OPTIONS(
  format = 'CSV',
  uris = ['gs://448702-dezoomcamp_hw3_2025/fhv_2019/fhv*.csv']
);


CREATE OR REPLACE TABLE `utility-cathode-448702-g7.dbt_hw3_2025.fhv_tripdata` AS
SELECT * FROM `utility-cathode-448702-g7.dbt_hw3_2025.external_fhv`;

SELECT count(*)
FROM `utility-cathode-448702-g7.dbt_hw3_2025.external_fhv`;

