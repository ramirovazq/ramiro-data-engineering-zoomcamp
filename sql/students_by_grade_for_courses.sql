-- Finding Highest Grade and Corresponding Course per Student
 

-- Using the table playground.student_grades, write a SQL query to find the highest grade and its corresponding course for each student. In cases where there is a tie for the highest grade, select the course with the smallest course_id. The output should include student_id, course_id, and the grade, with the results sorted by increasing student_id.
-- These are the tables to query for this question:
-- playground.student_grades

--     student_id int
--     course_id int
--     grade int

-- Your answer should include these columns:

--     student_id integer
--     course_id integer
--     grade integer

WITH students_rank_grades AS (
SELECT
  DENSE_RANK() OVER(
    PARTITION BY student_id 
    ORDER BY grade DESC, course_id ASC
  ) AS rank_grades,
  student_id,
  grade,
  course_id
FROM playground.student_grades 
) 

SELECT 
  student_id,
  grade,
  course_id
FROM
students_rank_grades
WHERE rank_grades=1