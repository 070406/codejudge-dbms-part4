# Reliability Incident Note

## Incident

A developer accidentally executed:

UPDATE submissions
SET score = 100;

without using a WHERE clause.

---

## What Went Wrong

The query updated scores for all submissions instead of only one intended submission.

---

## Data Affected

- All submission scores became 100.
- Ranking and analytics became incorrect.
- Student performance data became unreliable.

---

## Detection

The issue could be detected by:
- checking audit logs
- comparing backup snapshots
- noticing abnormal score distribution

---

## Recovery

If the query was executed inside a transaction, ROLLBACK could restore data.

Otherwise:
- restore database backup
- recover using binary logs if available

---

## Prevention

To avoid similar incidents:
- always use WHERE clauses carefully
- test UPDATE queries using SELECT first
- use transactions during risky operations
- create backups before mass updates
- use staging tables for testing
