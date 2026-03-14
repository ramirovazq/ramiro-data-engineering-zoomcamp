-- Identifying Active Businesses Based on Event Occurrences
-- Using the playground.business_events table, 
-- identify all active businesses. 
-- An active business is defined as one that has more than one event type with 
-- occurrences greater than the average occurrences 
-- of that event type among all businesses. 
-- The goal is to filter businesses based on their activity level, 
-- comparing individual event occurrences to the overall average 
-- for those event types. The result should be a table with one column called 
-- business_id with all the business ids that are active.

WITH average_event_type AS (
    SELECT 
    event_type, 
    AVG(occurences) as avg_occurences
    FROM playground.business_events be
    GROUP BY be.event_type ),
business_events_with_avg AS (
    SELECT 
    be.business_id,
    be.event_type,
    be.occurences,
    a.avg_occurences
    FROM playground.business_events be
    LEFT JOIN average_event_type a  
    ON be.event_type = a.event_type ),
businesses_with_greater_than_avg AS (
    SELECT 
    bea.business_id,
    -- bea.event_type,
    -- bea.occurences,
    -- bea.avg_occurences,
    SUM(CASE WHEN bea.occurences > bea.avg_occurences THEN 1 ELSE 0 END) as greather_than_avg
    FROM business_events_with_avg bea
    GROUP BY bea.business_id)
SELECT business_id
FROM businesses_with_greater_than_avg
WHERE greather_than_avg >= 1;