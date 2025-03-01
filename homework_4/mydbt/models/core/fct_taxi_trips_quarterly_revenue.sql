{{ config(materialized='table') }}

with trips_data as (
    select * from {{ ref('fact_trips') }}
),
monthly_tripdata as (
    select 
    -- Revenue grouping 
    service_type,
    TIMESTAMP_TRUNC(CAST(pickup_datetime AS TIMESTAMP), YEAR) AS revenue_year, 
    TIMESTAMP_TRUNC(CAST(pickup_datetime AS TIMESTAMP), MONTH) AS revenue_month,
    
    sum(total_amount) as revenue_monthly,

    from trips_data
    group by 1,2,3
),
quarterly_tripdata as (
select
    service_type,
    revenue_year as year,
    case
        WHEN EXTRACT(MONTH FROM revenue_month) IN (1,2,3) then 'Q1'
        WHEN EXTRACT(MONTH FROM revenue_month) IN (4,5,6) then 'Q2'
        WHEN EXTRACT(MONTH FROM revenue_month) IN (7,8,9) then 'Q3'
        WHEN EXTRACT(MONTH FROM revenue_month) IN (10,11,12) then 'Q4'
        END AS quarter,
    sum(revenue_monthly) as revenue_quarterly,

from monthly_tripdata
group by 1,2,3
order by 1,2,3
)
SELECT 
    t1.service_type,
    t1.quarter,
    t1.revenue_quarterly AS revenue_2019,
    t2.revenue_quarterly AS revenue_2020,
    ROUND(
        ((t2.revenue_quarterly - t1.revenue_quarterly) / t1.revenue_quarterly) * 100, 2
    ) AS revenue_growth_percentage
FROM quarterly_tripdata t1
JOIN quarterly_tripdata t2 
ON  t1.service_type = t2.service_type AND t1.quarter = t2.quarter 
WHERE 1=1 and
t1.year = '2019-01-01' AND t2.year = '2020-01-01'
