-- Analyze Engine Efficiency by Fuel Type
-- Using the table playground.automobile, 
-- write a SQL query to analyze engine efficiency 
-- by comparing the average city mileage 
-- to highway mileage for each fuel type. 
-- The efficiency ratio is defined as the average highway mileage divided 
-- by the average city mileage. 
-- Include fuel type, average city mileage, average highway mileage, 
-- and efficiency ratio in the results, rounded up to 2 decimal places, 
-- ordered by the highest efficiency ratio.

WITH aggregatgions_by_fuel_type AS (
    SELECT 
        fuel_type, 
        AVG(city_mileage) as avg_city_mileage,
        AVG(highway_mileage) as avg_highway_mileage
    FROM playground.automobile
    GROUP BY fuel_type
) 
SELECT 
  fuel_type,
  ROUND(avg_city_mileage,2) AS avg_city_mileage,
  ROUND(avg_highway_mileage,2) AS avg_highway_mileage,
  ROUND(
        avg_highway_mileage / NULLIF(avg_city_mileage, 0),
        2
    ) AS efficiency_ratio
FROM aggregatgions_by_fuel_type
ORDER BY efficiency_ratio DESC