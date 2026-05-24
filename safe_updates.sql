-- =========================================
-- SAFE UPDATE 1 : FIX INVALID EMAILS
-- =========================================

-- Before Update
SELECT student_id, email
FROM students_staging
WHERE email IS NULL
OR email NOT LIKE '%@%.%';

-- Update
UPDATE students_staging
SET email = CONCAT(student_id, '@student.com')
WHERE email IS NULL
OR email NOT LIKE '%@%.%';

-- After Update
SELECT student_id, email
FROM students_staging
WHERE email IS NULL
OR email NOT LIKE '%@%.%';

-- Safe because WHERE clause updates only invalid emails.

-- =========================================
-- SAFE UPDATE 2 : FIX NEGATIVE SCORES
-- =========================================

-- Before Update
SELECT submission_id, score
FROM submissions_staging
WHERE score < 0;

-- Update
UPDATE submissions_staging
SET score = 0
WHERE score < 0;

-- After Update
SELECT submission_id, score
FROM submissions_staging
WHERE score < 0;

-- Safe because only negative score rows are targeted.

-- =========================================
-- SAFE UPDATE 3 : FIX INVALID STATUS
-- =========================================

-- Before Update
SELECT submission_id, status
FROM submissions_staging
WHERE status = 'Done';

-- Update
UPDATE submissions_staging
SET status = 'Successful'
WHERE status = 'Done';

-- After Update
SELECT submission_id, status
FROM submissions_staging
WHERE status = 'Done';

-- Safe because only incorrect status values are modified.

-- =========================================
-- SAFE UPDATE 4 : FIX MISSING BATCH
-- =========================================

-- Before Update
SELECT student_id, batch_id
FROM students_staging
WHERE batch_id IS NULL;

-- Update
UPDATE students_staging
SET batch_id = 1
WHERE batch_id IS NULL;

-- After Update
SELECT student_id, batch_id
FROM students_staging
WHERE batch_id IS NULL;

-- Safe because only students with NULL batch values are updated.
