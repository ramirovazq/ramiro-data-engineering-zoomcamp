-- Comparing State Fatal Collisions to the National Average
 

-- Using playground.bad_drivers, write a SQL query to compare each state’s fatal collisions per billion miles to the national average. Include a column that indicates whether the state is "Above Average" or "Below Average". The resultant table should have three columns, "state", "fatal_collisions_per_billion_miles" and "comparison_to_national_avg". Show the result ordered by state name asc.
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
--     fatal_collisions_per_billion_miles double
--     comparison_to_national_avg varchar

SELECT
  state,
  fatal_collisions_per_billion_miles,
  CASE 
    WHEN fatal_collisions_per_billion_miles > (
      SELECT 
        AVG(fatal_collisions_per_billion_miles) AS national_avg
      FROM playground.bad_drivers
    ) THEN 'Above Average'
    WHEN fatal_collisions_per_billion_miles < (
      SELECT 
        AVG(fatal_collisions_per_billion_miles) AS national_avg
      FROM playground.bad_drivers
    ) THEN 'Below Average'
    ELSE 'Other average' END AS comparison_to_national_avg
FROM playground.bad_drivers

