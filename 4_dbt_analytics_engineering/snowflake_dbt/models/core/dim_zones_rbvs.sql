{{ config(materialized='table') }}

select 
    locationid, 
    borough, 
    zone, 
    service_zone as service_zone_old,
    replace(service_zone,'Boro','Green') as service_zone 
from {{ ref('taxi_zones_lookup_rbvs') }}