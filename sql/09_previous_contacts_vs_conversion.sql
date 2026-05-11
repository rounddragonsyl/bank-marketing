-- Q9: Does number of previous campaign contacts affect conversion rate?
-- Business question: Do prior-touched customers convert better?
-- Informs re-engagement strategy for lapsed prospects.

SELECT
    CASE
        WHEN previous = 0            THEN '0 - Never contacted'
        WHEN previous BETWEEN 1 AND 2 THEN '1-2 prior contacts'
        WHEN previous BETWEEN 3 AND 5 THEN '3-5 prior contacts'
        ELSE '6+ prior contacts'
    END                                                                         AS prior_contact_band,
    COUNT(*)                                                                    AS total_customers,
    SUM(CASE WHEN deposit = 'yes' THEN 1 ELSE 0 END)                           AS conversions,
    ROUND(
        100.0 * SUM(CASE WHEN deposit = 'yes' THEN 1 ELSE 0 END) / COUNT(*),
        2
    )                                                                           AS conversion_rate_pct
FROM bank
GROUP BY prior_contact_band
ORDER BY conversion_rate_pct DESC;
