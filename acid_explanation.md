# ACID Properties Explanation

## Example Used

Transaction 1: Student Submission and Test Result Insert

---

## Atomicity

Both submission and test-result insertion happen together.

If one query fails, the entire transaction can be rolled back.

This prevents partial data insertion.

---

## Consistency

The transaction maintains database rules.

The inserted submission_id is correctly linked with the test_results table.

No foreign key rules are violated.

---

## Isolation

If multiple students submit solutions at the same time, each transaction works independently.

One transaction does not interfere with another transaction.

---

## Durability

After COMMIT, the inserted submission and test-result records remain permanently stored even if the system crashes afterward.
