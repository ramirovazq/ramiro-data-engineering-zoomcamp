-- Find all players with age 23 and weight 181
 

-- Get all the players with the age = 23 weight = 181 and order by player_name descending
-- These are the tables to query for this question:
-- bootcamp.nba_player_seasons

-- Your answer should include these columns:

--     player_name varchar
--     age integer
--     height varchar
--     weight integer
--     college varchar
--     country varchar
--     draft_year varchar
--     draft_round varchar
--     draft_number varchar
--     gp double
--     pts double
--     reb double
--     ast double
--     netrtg double
--     oreb_pct double
--     dreb_pct double
--     usg_pct double
--     ts_pct double
--     ast_pct double
--     season integer
SELECT 
    player_name,
    age,
    height,
    weight,
    college,
    country,
    draft_year,
    draft_round,
    draft_number,
    gp,
    pts,
    reb::float as reb,
    ast,
    netrtg,
    oreb_pct,
    dreb_pct,
    usg_pct,
    ts_pct,
    ast_pct,
    season
FROM bootcamp.nba_player_seasons 
WHERE 1=1
  AND weight = 181
  AND age = 23
ORDER BY player_name DESC