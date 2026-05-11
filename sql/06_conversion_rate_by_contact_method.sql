-- Q6: Conversion rate by contact method (telephone vs cellular)
-- Business question: Is one channel more cost-effective for deposit campaigns?
-- Guides channel strategy and budget allocation.

SELECT
    contact,
    COUNT(*)                                                                    AS total_contacts,
    SUM(CASE WHEN deposit = 'yes' THEN 1 ELSE 0 END)                           AS conversions,
    ROUND(
        100.0 * SUM(CASE WHEN deposit = 'yes' THEN 1 ELSE 0 END) / COUNT(*),
        2
    )                                                                           AS conversion_rate_pct
FROM bank
WHERE contact IS NOT NULL
GROUP BY contact
ORDER BY conversion_rate_pct DESC;
