# Module 5 Homework

## Question 1: Install Spark and PySpark

- Install Spark
- Run PySpark
- Create a local spark session
- Execute spark.version.

What's the output?

https://github.com/ramirovazq/ramiro-data-engineering-zoomcamp/blob/main/homework_5/question_1.png


## Question 2: Yellow October 2024

Read the October 2024 Yellow into a Spark Dataframe.

Repartition the Dataframe to 4 partitions and save it to parquet.

What is the average size of the Parquet (ending with .parquet extension) Files that were created (in MB)? Select the answer which most closely matches.


- 25MB

```
df_repartitioned = df.repartition(4) ## this is a lazy command
df_repartitioned.write.parquet('code/data/homework/partitioned')
```

https://github.com/ramirovazq/ramiro-data-engineering-zoomcamp/blob/main/homework_5/question_2_code.png

https://github.com/ramirovazq/ramiro-data-engineering-zoomcamp/blob/main/homework_5/question_2_list.png


## Question 3: Count records 

How many taxi trips were there on the 15th of October?

Consider only trips that started on the 15th of October.

- 125,567

```
df_repartitioned.createOrReplaceTempView('trips_repartitioned')
query_repartitioned = """
SELECT * FROM trips_repartitioned 
WHERE TO_DATE(FROM_UTC_TIMESTAMP(tpep_pickup_datetime, 'Europe/Berlin')) = '2024-10-15'
"""
df_filtered_repartitioned = spark.sql(query_repartitioned)
df_filtered_repartitioned.count()
```



## Question 4: Longest trip

What is the length of the longest trip in the dataset in hours?

- 162

```
query_longest_trip = """
SELECT 
    tpep_pickup_datetime as start,
    tpep_dropoff_datetime as end,
    UNIX_TIMESTAMP(tpep_dropoff_datetime) - UNIX_TIMESTAMP(tpep_pickup_datetime) AS difference,
    (UNIX_TIMESTAMP(tpep_dropoff_datetime) - UNIX_TIMESTAMP(tpep_pickup_datetime)) / 3600 AS difference_hrs,
    (UNIX_TIMESTAMP(tpep_dropoff_datetime) - UNIX_TIMESTAMP(tpep_pickup_datetime)) / (3600*12) AS difference_days
FROM trips 
ORDER BY 3 desc
LIMIT 100
"""
df_longest = spark.sql(query_longest_trip)
df_longest.show()
```


## Question 5: User Interface

Spark’s User Interface which shows the application's dashboard runs on which local port?

- 4040

https://github.com/ramirovazq/ramiro-data-engineering-zoomcamp/blob/main/homework_5/question_5.png


## Question 6: Least frequent pickup location zone

Load the zone lookup data into a temp view in Spark:

```bash
wget https://d37ci6vzurychx.cloudfront.net/misc/taxi_zone_lookup.csv
```

Using the zone lookup data and the Yellow October 2024 data, what is the name of the LEAST frequent pickup location Zone?

- Governor's Island/Ellis Island/Liberty Island
```
df_lookup = spark.read \
    .option("header","true")\
    .csv('code/data/homework/raw/taxi_zone_lookup.csv')

df_lookup.createOrReplaceTempView('lookup_table')

query_least_frequent = """
SELECT 
    p.pickup_location_id,
    l.Borough,
    l.Zone,
    l.service_zone
FROM(
SELECT 
    PULocationID as pickup_location_id,
    COUNT(PULocationID) AS count_pu_location
FROM trips 
WHERE YEAR(tpep_pickup_datetime) = 2024
AND MONTH(tpep_pickup_datetime) = 10
GROUP BY PULocationID
ORDER BY 2 asc
limit 1
)  p
LEFT JOIN lookup_table l ON l.LocationID = p.pickup_location_id
"""
df_least = spark.sql(query_least_frequent)
df_least.show()


+------------------+---------+--------------------+------------+
|pickup_location_id|  Borough|                Zone|service_zone|
+------------------+---------+--------------------+------------+
|               105|Manhattan|Governor's Island...| Yellow Zone|
+------------------+---------+--------------------+------------+
```



## Submitting the solutions

- Form for submitting: https://courses.datatalks.club/de-zoomcamp-2025/homework/hw5
- Deadline: See the website
