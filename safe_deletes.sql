-- =========================================
-- SAFE DELETE 1 : REMOVE DUPLICATE ENROLLMENTS
-- =========================================

-- Before Delete
SELECT student_id, course_id, COUNT(*)
FROM enrollments_staging
GROUP BY student_id, course_id
HAVING COUNT(*) > 1;

-- Delete
DELETE FROM enrollments_staging
WHERE enrollment_id NOT IN
(
    SELECT MIN(enrollment_id)
    FROM enrollments_staging
    GROUP BY student_id, course_id
);

-- After Delete
SELECT student_id, course_id, COUNT(*)
FROM enrollments_staging
GROUP BY student_id, course_id
HAVING COUNT(*) > 1;

-- Safe because one valid enrollment record is preserved.

-- =========================================
-- SAFE DELETE 2 : REMOVE ORPHAN TEST RESULTS
-- =========================================

-- Before Delete
SELECT tr.result_id
FROM test_results_staging tr
LEFT JOIN submissions s
ON tr.submission_id = s.submission_id
WHERE s.submission_id IS NULL;

-- Delete
DELETE FROM test_results_staging
WHERE submission_id NOT IN
(
    SELECT submission_id
    FROM submissions
);

-- After Delete
SELECT tr.result_id
FROM test_results_staging tr
LEFT JOIN submissions s
ON tr.submission_id = s.submission_id
WHERE s.submission_id IS NULL;

-- Safe because only orphan records without valid submissions are deleted.
