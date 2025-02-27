{{ config(materialized='table') }}

with trips_data_filtere_invalid_entries as (
    select 
    TIMESTAMP_DIFF(dropoff_datetime, pickup_datetime, SECOND) as trip_duration,
    *
    from {{ ref('dim_fhv_trips') }}
),
trips_data_percentile as (
Select
    pickup_year, 
    pickup_month, 
    trip_duration,
    --pickup_locationid, 
    --dropoff_locationid,
    pickup_borough,
    pickup_zone,
    dropoff_borough,
    dropoff_zone,

    PERCENTILE_CONT(trip_duration, 0.90) 
        OVER (PARTITION BY pickup_year, pickup_month, pickup_locationid, dropoff_locationid) AS trip_duration_p90
from trips_data_filtere_invalid_entries 
)
Select * from trips_data_percentile


