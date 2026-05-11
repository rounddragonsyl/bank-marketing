-- Q5: Which customer segments are most likely to subscribe to a term deposit?
-- Business question: Where should we focus deposit acquisition efforts?
-- Ranks job + education combos by conversion rate.

SELECT
    job,
    education,
    COUNT(*)                                                                    AS total_customers,
    SUM(CASE WHEN deposit = 'yes' THEN 1 ELSE 0 END)                           AS converted,
    ROUND(
        100.0 * SUM(CASE WHEN deposit = 'yes' THEN 1 ELSE 0 END) / COUNT(*),
        2
    )                                                                           AS conversion_rate_pct
FROM bank
GROUP BY job, education
HAVING COUNT(*) >= 50   -- exclude tiny segments for statistical reliability
ORDER BY conversion_rate_pct DESC
LIMIT 15;
