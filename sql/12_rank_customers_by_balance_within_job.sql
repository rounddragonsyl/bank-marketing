-- Q12: Rank customers by account balance within each job segment
-- Business question: Who are the top-value customers in each job category?
-- Supports priority tiering for relationship managers.

SELECT
    job,
    age,
    balance,
    education,
    RANK()       OVER (PARTITION BY job ORDER BY balance DESC) AS balance_rank_in_job,
    PERCENT_RANK() OVER (PARTITION BY job ORDER BY balance)    AS balance_percentile
FROM bank
ORDER BY job, balance_rank_in_job
LIMIT 50;
