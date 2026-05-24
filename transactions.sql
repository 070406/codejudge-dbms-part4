-- =========================================
-- TRANSACTION 1 : INSERT SUBMISSION
-- =========================================

START TRANSACTION;

INSERT INTO submissions_staging
(submission_id, student_id, problem_id, language, score, status)
VALUES
(9001, 101, 501, 'Python', 85, 'Successful');

INSERT INTO test_results_staging
(result_id, submission_id, passed)
VALUES
(3001, 9001, TRUE);

COMMIT;

-- Final State:
-- Both submission and test result are permanently saved.

-- =========================================
-- TRANSACTION 2 : ROLLBACK EXAMPLE
-- =========================================

START TRANSACTION;

INSERT INTO enrollments_staging
(enrollment_id, student_id, course_id)
VALUES
(7001, 9999, 10);

ROLLBACK;

-- Final State:
-- Invalid enrollment is not stored in database.

-- =========================================
-- TRANSACTION 3 : SAVEPOINT EXAMPLE
-- =========================================

START TRANSACTION;

UPDATE submissions_staging
SET score = 95
WHERE submission_id = 5001;

SAVEPOINT score_fixed;

UPDATE submissions_staging
SET status = 'Excellent'
WHERE submission_id = 5001;

ROLLBACK TO score_fixed;

COMMIT;

-- Final State:
-- Score update remains.
-- Invalid status update is rolled back.

-- =========================================
-- TRANSACTION 4 : RE-GRADE REQUEST
-- =========================================

START TRANSACTION;

UPDATE submissions_staging
SET score = 92
WHERE submission_id = 4001;

UPDATE regrade_requests
SET status = 'Resolved'
WHERE request_id = 101;

COMMIT;

-- Final State:
-- Score corrected and regrade request resolved together.
