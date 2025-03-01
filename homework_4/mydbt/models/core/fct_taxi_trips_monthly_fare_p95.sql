{{ config(materialized='table') }}

with trips_data_filtere_invalid_entries as (
    select 
    service_type,
    fare_amount, 
    trip_distance, 
    payment_type_description,
    TIMESTAMP_TRUNC(CAST(pickup_datetime AS TIMESTAMP), YEAR) AS pickup_year, 
    TIMESTAMP_TRUNC(CAST(pickup_datetime AS TIMESTAMP), MONTH) AS pickup_month

    from {{ ref('fact_trips') }}
    where payment_type_description in ('Credit card', 'Cash')
    and trip_distance > 0
    and fare_amount > 0 
),
trips_data_percentile as (
Select
    service_type,
    pickup_year,
    pickup_month,
    PERCENTILE_CONT(fare_amount, 0.97) OVER(PARTITION BY service_type, pickup_year, pickup_month) AS percentile_97,
    PERCENTILE_CONT(fare_amount, 0.95) OVER(PARTITION BY service_type, pickup_year, pickup_month) AS percentile_95,
    PERCENTILE_CONT(fare_amount, 0.90) OVER(PARTITION BY service_type, pickup_year, pickup_month) AS percentile_90,
from trips_data_filtere_invalid_entries 
)
Select * from trips_data_percentile
order by service_type, pickup_year, pickup_month
