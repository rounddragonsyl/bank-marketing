-- Q10: Default rate by age group and job type
-- Business question: Which age-job combinations are highest risk?
-- Used to calibrate credit scoring models.

SELECT
    CASE
        WHEN age < 25              THEN 'Under 25'
        WHEN age BETWEEN 25 AND 34 THEN '25-34'
        WHEN age BETWEEN 35 AND 44 THEN '35-44'
        WHEN age BETWEEN 45 AND 54 THEN '45-54'
        WHEN age BETWEEN 55 AND 64 THEN '55-64'
        ELSE '65+'
    END                                                                         AS age_group,
    job,
    COUNT(*)                                                                    AS total_customers,
    SUM(CASE WHEN default = 'yes' THEN 1 ELSE 0 END)                           AS defaulted,
    ROUND(
        100.0 * SUM(CASE WHEN default = 'yes' THEN 1 ELSE 0 END) / COUNT(*),
        2
    )                                                                           AS default_rate_pct
FROM bank
GROUP BY age_group, job
HAVING COUNT(*) >= 20
ORDER BY default_rate_pct DESC
LIMIT 20;
