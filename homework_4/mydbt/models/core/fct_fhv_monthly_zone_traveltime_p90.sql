{{ config(materialized='table') }}

with dim_fhv_trips_with_trip_duratio as (
    select 
    TIMESTAMP_DIFF(dropoff_datetime, pickup_datetime, SECOND) as trip_duration,
    *
    from {{ ref('dim_fhv_trips') }}
)
SELECT *,
PERCENTILE_CONT(trip_duration, 0.90) 
        OVER (PARTITION BY pickup_year, pickup_month, pickup_locationid, dropoff_locationid) AS trip_duration_p90
FROM dim_fhv_trips_with_trip_duratio