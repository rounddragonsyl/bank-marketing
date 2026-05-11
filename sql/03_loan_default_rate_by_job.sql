-- Q3: Loan default rate by job segment
-- Business question: Which job types carry the highest credit risk?
-- Supports credit risk policy and loan approval rules.

SELECT
    job,
    COUNT(*)                                                            AS total_customers,
    SUM(CASE WHEN default = 'yes' THEN 1 ELSE 0 END)                   AS defaulted,
    ROUND(
        100.0 * SUM(CASE WHEN default = 'yes' THEN 1 ELSE 0 END) / COUNT(*),
        2
    )                                                                   AS default_rate_pct
FROM bank
GROUP BY job
ORDER BY default_rate_pct DESC;
