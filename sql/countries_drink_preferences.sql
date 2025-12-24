-- Create a SQL query to find all countries and their preference for beer, spirit, and wine, based on the highest serving type as their preference. The output should show only the countries whose preferences are wine and spirits, ordered in ascending order of the country name.
-- These are the tables to query for this question:
-- playground.drinks

--     country string
--     beer_servings int
--     spirit_servings int
--     wine_servings int
--     total_litres_of_pure_alcohol double

-- Your answer should include these columns:

--     country varchar
--     preferred_drink varchar

COUNTRY, BEER, SPIRIT, WINE, TOTAL_LITRES_OF_PURE_ALCOHOL
Albania, 89, 132, 54, 4.9

COUNTRY, BEER, SPIRIT, WINE, FIRST_SERVING, SECOND_SERVING, THIRD_SERVING
Albania, 89, 132, 54, 4.9, Spirit, Beer, Wine

-- Select all rows from 'TableName'
WITH preferred_drinks AS (
    SELECT 
    country, 
    spirit_servings, 
    wine_servings,
    beer_servings, 
    CASE 
        WHEN beer_servings >= spirit_servings AND beer_servings >= wine_servings THEN 'Beer'
        WHEN spirit_servings >= beer_servings AND spirit_servings >= wine_servings THEN 'Spirit'
        ELSE 'Wine' END 
        AS first_serving,
    CASE 
        WHEN beer_servings <= spirit_servings AND beer_servings <= wine_servings THEN 'Beer'
        WHEN spirit_servings <= beer_servings AND spirit_servings <= wine_servings  THEN 'Spirit'
        WHEN wine_servings <= beer_servings AND wine_servings <= spirit_servings  THEN 'Wine'
        ELSE 'Other' END
        AS third_serving,
    CASE 
        WHEN first_serving = 'Wine' and third_serving = 'Spirit' THEN 'Beer'
        WHEN first_serving = 'Spirit' and third_serving = 'Wine' THEN 'Beer'
        WHEN first_serving = 'Beer' and third_serving = 'Wine' THEN 'Spirit'
        WHEN first_serving = 'Wine' and third_serving = 'Beer' THEN 'Spirit'
        ELSE 'Wine' END
        AS second_serving,
    total_litres_of_pure_alcohol
    FROM playground.drinks
    WHERE total_litres_of_pure_alcohol > 0
  --AND country in ('Austria', 'Azerbaijan', 'Bolivia', 'Cameroon','Ecuador','Guinea','Latvia','Mali', 'Albania', 'Argentina', 'Belize', 'Costa Rica')
)
SELECT 
  country,
--   spirit_servings, 
--   wine_servings,
--   beer_servings, 
  first_serving as preferred_drink
FROM preferred_drinks
WHERE first_serving IN ('Wine', 'Spirit')
ORDER BY country
