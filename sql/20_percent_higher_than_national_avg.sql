-- Which states have high risk of fatal collisions involving Alcohol
 

-- Using playground.bad_drivers, determine the states and their percentage of alcohol impaired collisions where the risk of fatal collisions involving alcohol is significantly higher than the national average. Consider a state as high-risk if its percent_alcohol_impaired is at least 20% higher than the national average. Show the output in descending order of the percent_alcohol_impaired.
-- These are the tables to query for this question:
-- playground.bad_drivers

--     state string
--     fatal_collisions_per_billion_miles double
--     percent_speeding int
--     percent_alcohol_impaired int
--     percent_not_distracted int
--     percent_no_previous_accidents int
--     insurance_premiums double
--     losses_per_insured_driver double

-- Your answer should include these columns:

--     state varchar
--     percent_alcohol_impaired integer

WITH national_avg AS (
  SELECT 
    AVG(percent_alcohol_impaired) 
    AS national_avg
  FROM playground.bad_drivers
)
  
SELECT 
  bd.state,
  bd.percent_alcohol_impaired,
  na.national_avg
FROM playground.bad_drivers bd
JOIN national_avg na
WHERE bd.percent_alcohol_impaired >= (na.national_avg * 1.2)
ORDER BY bd.percent_alcohol_impaired DESC
