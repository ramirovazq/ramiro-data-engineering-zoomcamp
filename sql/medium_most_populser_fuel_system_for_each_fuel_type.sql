-- Most Popular Fuel System for Each Fuel Type
 

-- Using the table playground.automobile, create a SQL query to find the most popular fuel system for each fuel type based on the number of cars. Include columns for fuel type, fuel system, and the count of cars, showing only the top fuel system for each fuel type. Order the result on the basis of fuel type in ascending order.
-- These are the tables to query for this question:
-- playground.automobile

--     brand_name string
--     fuel_type string
--     aspiration string
--     door_panel string
--     design string
--     wheel_drive string
--     engine_location string
--     engine_type string
--     cylinder_count string
--     engine_size int
--     fuel_system string
--     bore double
--     stroke double
--     compression_ratio double
--     horse_power int
--     top_RPM int
--     city_mileage int
--     highway_mileage int
--     price_in_dollars int

-- Your answer should include these columns:

--     fuel_type varchar
--     fuel_system varchar
--     total_cars integer


WITH grouped_by_type_and_system AS (
    SELECT 
        fuel_type,
        fuel_system,
        count(*) as total_cars
    FROM playground.automobile 
    GROUP BY 
        fuel_type,
        fuel_system
    ORDER BY fuel_system, fuel_type
),
ranked_by_fuel_type AS (
    SELECT
        fuel_type,
        fuel_system,
        total_cars,
        ROW_NUMBER() OVER(
            PARTITION BY fuel_type 
            ORDER BY total_cars desc
        ) AS fuel_type_total_cars
    FROM grouped_by_type_and_system
)
SELECT 
    fuel_type,
    fuel_system,
    total_cars
FROM ranked_by_fuel_type
WHERE fuel_type_total_cars = 1