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

- 122
- 142
- 162
- 182


## Question 5: User Interface

Spark’s User Interface which shows the application's dashboard runs on which local port?

- 80
- 443
- 4040
- 8080



## Question 6: Least frequent pickup location zone

Load the zone lookup data into a temp view in Spark:

```bash
wget https://d37ci6vzurychx.cloudfront.net/misc/taxi_zone_lookup.csv
```

Using the zone lookup data and the Yellow October 2024 data, what is the name of the LEAST frequent pickup location Zone?

- Governor's Island/Ellis Island/Liberty Island
- Arden Heights
- Rikers Island
- Jamaica Bay


## Submitting the solutions

- Form for submitting: https://courses.datatalks.club/de-zoomcamp-2025/homework/hw5
- Deadline: See the website
