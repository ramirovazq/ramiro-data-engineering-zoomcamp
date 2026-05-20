-- Identifying students with the best grade
 

-- Using the playground.marks table, write a SQL query to determine the students who achieved the highest marks when graded according to Option 3, where the final exam accounts for 100% of the grade. The other grading options are provided for context: Option 1: Midterm 1 contributes 25%, Midterm 2 contributes 25%, and the Final exam contributes 50% of the grade. Option 2: Midterm 1 contributes 50% and Midterm 2 contributes 50% of the grade. Option 3: The Final exam contributes 100% of the grade. The output should be sorted by the students' names in ascending order. Ensure the column names in the result are displayed in lowercase. The resultant table should have two columns, name and their id.
-- These are the tables to query for this question:
-- playground.marks

--     Name string
--     ID int
--     Midterm1 int
--     Midterm2 int
--     Final int

-- Your answer should include these columns:

--     name varchar
--     id integer

WITH ranked_students AS (
    SELECT
        name,
        id,
        final,
        ROW_NUMBER() OVER (
            ORDER BY final DESC
        ) AS rnk
    FROM playground.marks
)

SELECT
    name,
    id
FROM ranked_students
WHERE rnk IN (1,2,3)
ORDER BY name ASC;
