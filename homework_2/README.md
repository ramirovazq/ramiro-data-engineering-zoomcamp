# Module Homework 2 - Cohort 2025

## Assignment

So far in the course, we processed data for the year 2019 and 2020. Your task is to extend the existing flows to include data for the year 2021.

## Assignment answer

In this case I used Kestra running in local with docker:

```
 docker run --pull=always --rm -it -p 8080:8080 --user=root -v /var/run/docker.sock:/var/run/docker.sock -v /tmp:/tmp kestra/kestra:latest server local
```

I used Kestra in backfill since January to July 2021 and using GCP with GCS and Bigquery. Code for this: https://github.com/ramirovazq/ramiro-data-engineering-zoomcamp/tree/main/KESTRA_orchestration/kestra_using_gcp 
Backfill was done for yellow ant green taxi data

https://github.com/ramirovazq/ramiro-data-engineering-zoomcamp/blob/main/homework_2/jan_july_2021.png

## Quiz Questions

1. Within the execution for Yellow Taxi data for the year 2020 and month 12: what is the uncompressed file size (i.e. the output file yellow_tripdata_2020-12.csv of the extract task)?

https://github.com/ramirovazq/ramiro-data-engineering-zoomcamp/blob/main/homework_2/yellow_tripdata_2020_12.png
#### 128.3MB

2. What is the rendered value of the variable file when the inputs taxi is set to green, year is set to 2020, and month is set to 04 during execution?


{{inputs.taxi}}_tripdata_{{inputs.year}}-{{inputs.month}}.csv
* inputs.taxi = 'green'
* inputs.year = '2020'
* inputs.month = '04'
* {{green}}_tripdata_{{2020}}-{{04}}.csv

#### Answer
green_tripdata_2020-04.csv

3. How many rows are there for the Yellow Taxi data for all CSV files in the year 2020?
```
SELECT count(*) as count, '2020_01_yellow_csv' as year_month FROM `utility-cathode-448702-g7.de_zoomcamp.yellow_tripdata_2020_01_ext`  UNION ALL
SELECT count(*) as count, '2020_02_yellow_csv' as year_month FROM `utility-cathode-448702-g7.de_zoomcamp.yellow_tripdata_2020_02_ext`  UNION ALL
SELECT count(*) as count, '2020_03_yellow_csv' as year_month FROM `utility-cathode-448702-g7.de_zoomcamp.yellow_tripdata_2020_03_ext`  UNION ALL
SELECT count(*) as count, '2020_04_yellow_csv' as year_month FROM `utility-cathode-448702-g7.de_zoomcamp.yellow_tripdata_2020_04_ext`  UNION ALL
SELECT count(*) as count, '2020_05_yellow_csv' as year_month FROM `utility-cathode-448702-g7.de_zoomcamp.yellow_tripdata_2020_05_ext`  UNION ALL
SELECT count(*) as count, '2020_06_yellow_csv' as year_month FROM `utility-cathode-448702-g7.de_zoomcamp.yellow_tripdata_2020_06_ext`  UNION ALL
SELECT count(*) as count, '2020_07_yellow_csv' as year_month FROM `utility-cathode-448702-g7.de_zoomcamp.yellow_tripdata_2020_07_ext`  UNION ALL
SELECT count(*) as count, '2020_08_yellow_csv' as year_month FROM `utility-cathode-448702-g7.de_zoomcamp.yellow_tripdata_2020_08_ext`  UNION ALL
SELECT count(*) as count, '2020_09_yellow_csv' as year_month FROM `utility-cathode-448702-g7.de_zoomcamp.yellow_tripdata_2020_09_ext`  UNION ALL
SELECT count(*) as count, '2020_10_yellow_csv' as year_month FROM `utility-cathode-448702-g7.de_zoomcamp.yellow_tripdata_2020_10_ext`  UNION ALL
SELECT count(*) as count, '2020_11_yellow_csv' as year_month FROM `utility-cathode-448702-g7.de_zoomcamp.yellow_tripdata_2020_11_ext`  UNION ALL
SELECT count(*) as count, '2020_12_yellow_csv' as year_month FROM `utility-cathode-448702-g7.de_zoomcamp.yellow_tripdata_2020_12_ext`
```

```
SELECT SUM(count) FROM(
SELECT count(*) as count, '2020_01_yellow_csv' as year_month FROM `utility-cathode-448702-g7.de_zoomcamp.yellow_tripdata_2020_01_ext`  UNION ALL
SELECT count(*) as count, '2020_02_yellow_csv' as year_month FROM `utility-cathode-448702-g7.de_zoomcamp.yellow_tripdata_2020_02_ext`  UNION ALL
SELECT count(*) as count, '2020_03_yellow_csv' as year_month FROM `utility-cathode-448702-g7.de_zoomcamp.yellow_tripdata_2020_03_ext`  UNION ALL
SELECT count(*) as count, '2020_04_yellow_csv' as year_month FROM `utility-cathode-448702-g7.de_zoomcamp.yellow_tripdata_2020_04_ext`  UNION ALL
SELECT count(*) as count, '2020_05_yellow_csv' as year_month FROM `utility-cathode-448702-g7.de_zoomcamp.yellow_tripdata_2020_05_ext`  UNION ALL
SELECT count(*) as count, '2020_06_yellow_csv' as year_month FROM `utility-cathode-448702-g7.de_zoomcamp.yellow_tripdata_2020_06_ext`  UNION ALL
SELECT count(*) as count, '2020_07_yellow_csv' as year_month FROM `utility-cathode-448702-g7.de_zoomcamp.yellow_tripdata_2020_07_ext`  UNION ALL
SELECT count(*) as count, '2020_08_yellow_csv' as year_month FROM `utility-cathode-448702-g7.de_zoomcamp.yellow_tripdata_2020_08_ext`  UNION ALL
SELECT count(*) as count, '2020_09_yellow_csv' as year_month FROM `utility-cathode-448702-g7.de_zoomcamp.yellow_tripdata_2020_09_ext`  UNION ALL
SELECT count(*) as count, '2020_10_yellow_csv' as year_month FROM `utility-cathode-448702-g7.de_zoomcamp.yellow_tripdata_2020_10_ext`  UNION ALL
SELECT count(*) as count, '2020_11_yellow_csv' as year_month FROM `utility-cathode-448702-g7.de_zoomcamp.yellow_tripdata_2020_11_ext`  UNION ALL
SELECT count(*) as count, '2020_12_yellow_csv' as year_month FROM `utility-cathode-448702-g7.de_zoomcamp.yellow_tripdata_2020_12_ext` )
```

4. How many rows are there for the Green Taxi data for all CSV files in the year 2020?

```
SELECT sum(count) FROM (
SELECT count(*) as count, '2020_01_green_csv' as year_month_green FROM `utility-cathode-448702-g7.de_zoomcamp.green_tripdata_2020_01_ext`  UNION ALL
SELECT count(*) as count, '2020_02_green_csv' as year_month_green FROM `utility-cathode-448702-g7.de_zoomcamp.green_tripdata_2020_02_ext`  UNION ALL
SELECT count(*) as count, '2020_03_green_csv' as year_month_green FROM `utility-cathode-448702-g7.de_zoomcamp.green_tripdata_2020_03_ext`  UNION ALL
SELECT count(*) as count, '2020_04_green_csv' as year_month_green FROM `utility-cathode-448702-g7.de_zoomcamp.green_tripdata_2020_04_ext`  UNION ALL
SELECT count(*) as count, '2020_05_green_csv' as year_month_green FROM `utility-cathode-448702-g7.de_zoomcamp.green_tripdata_2020_05_ext`  UNION ALL
SELECT count(*) as count, '2020_06_green_csv' as year_month_green FROM `utility-cathode-448702-g7.de_zoomcamp.green_tripdata_2020_06_ext`  UNION ALL
SELECT count(*) as count, '2020_07_green_csv' as year_month_green FROM `utility-cathode-448702-g7.de_zoomcamp.green_tripdata_2020_07_ext`  UNION ALL
SELECT count(*) as count, '2020_08_green_csv' as year_month_green FROM `utility-cathode-448702-g7.de_zoomcamp.green_tripdata_2020_08_ext`  UNION ALL
SELECT count(*) as count, '2020_09_green_csv' as year_month_green FROM `utility-cathode-448702-g7.de_zoomcamp.green_tripdata_2020_09_ext`  UNION ALL
SELECT count(*) as count, '2020_10_green_csv' as year_month_green FROM `utility-cathode-448702-g7.de_zoomcamp.green_tripdata_2020_10_ext`  UNION ALL
SELECT count(*) as count, '2020_11_green_csv' as year_month_green FROM `utility-cathode-448702-g7.de_zoomcamp.green_tripdata_2020_11_ext`  UNION ALL
SELECT count(*) as count, '2020_12_green_csv' as year_month_green FROM `utility-cathode-448702-g7.de_zoomcamp.green_tripdata_2020_12_ext`
);
```


5. How many rows are there for the Yellow Taxi data for the March 2021 CSV file?
```
SELECT count(*) as count, '2021_03_yellow_csv' as year_month_yellow FROM utility-cathode-448702-g7.de_zoomcamp.yellow_tripdata_2021_03_ext
```

6.How would you configure the timezone to New York in a Schedule trigger?
 Would be something similiar to
```
triggers:
  - id: green_schedule
    type: io.kestra.plugin.core.trigger.Schedule
    cron: "0 9 1 * *"
    timezone: America/New_York
    inputs:
      taxi: green
```