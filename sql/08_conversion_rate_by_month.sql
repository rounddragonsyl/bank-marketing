-- Q8: Campaign conversion rate by month
-- Business question: Which months are best for deposit campaigns?
-- Supports campaign calendar planning.

SELECT
    month,
    COUNT(*)                                                                    AS total_contacts,
    SUM(CASE WHEN deposit = 'yes' THEN 1 ELSE 0 END)                           AS conversions,
    ROUND(
        100.0 * SUM(CASE WHEN deposit = 'yes' THEN 1 ELSE 0 END) / COUNT(*),
        2
    )                                                                           AS conversion_rate_pct
FROM bank
GROUP BY month
ORDER BY conversion_rate_pct DESC;
