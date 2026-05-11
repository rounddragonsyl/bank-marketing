-- Q1: Age distribution of customers by job type
-- Business question: Which job segments skew older or younger?
-- This helps target campaigns by life stage and job role.

SELECT
    job,
    COUNT(*)                                        AS total_customers,
    ROUND(AVG(age), 1)                              AS avg_age,
    MIN(age)                                        AS min_age,
    MAX(age)                                        AS max_age,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY age) AS median_age
FROM bank
GROUP BY job
ORDER BY avg_age DESC;
