-- Q14: Top 3 highest balance customers per job category
-- Business question: Who are our most valuable customers in each segment?
-- Drives priority outreach lists for private banking or premium product offers.

WITH ranked AS (
    SELECT
        job,
        age,
        balance,
        education,
        marital,
        ROW_NUMBER() OVER (PARTITION BY job ORDER BY balance DESC) AS rn
    FROM bank
)
SELECT
    job,
    age,
    balance,
    education,
    marital,
    rn AS rank_within_job
FROM ranked
WHERE rn <= 3
ORDER BY job, rn;
