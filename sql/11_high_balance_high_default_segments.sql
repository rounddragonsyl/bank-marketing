-- Q11: Segments with both high balance and high default risk
-- Business question: Are there paradoxically risky affluent customers?
-- Identifies segments needing early intervention despite high assets.

WITH segment_stats AS (
    SELECT
        job,
        education,
        COUNT(*)                                                                AS total_customers,
        ROUND(AVG(balance), 2)                                                  AS avg_balance,
        ROUND(
            100.0 * SUM(CASE WHEN default = 'yes' THEN 1 ELSE 0 END) / COUNT(*),
            2
        )                                                                       AS default_rate_pct
    FROM bank
    GROUP BY job, education
    HAVING COUNT(*) >= 30
)
SELECT *
FROM segment_stats
WHERE avg_balance > (SELECT AVG(balance) FROM bank)
  AND default_rate_pct > (
        SELECT 100.0 * SUM(CASE WHEN default = 'yes' THEN 1 ELSE 0 END) / COUNT(*)
        FROM bank
    )
ORDER BY default_rate_pct DESC, avg_balance DESC;
