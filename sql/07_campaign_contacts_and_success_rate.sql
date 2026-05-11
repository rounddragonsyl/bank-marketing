-- Q7: Contacts made per campaign call count and success rate
-- Business question: After how many contacts does the success rate drop off?
-- Informs optimal call cadence policy.

SELECT
    campaign                                                                    AS contacts_this_campaign,
    COUNT(*)                                                                    AS total_customers,
    SUM(CASE WHEN deposit = 'yes' THEN 1 ELSE 0 END)                           AS conversions,
    ROUND(
        100.0 * SUM(CASE WHEN deposit = 'yes' THEN 1 ELSE 0 END) / COUNT(*),
        2
    )                                                                           AS conversion_rate_pct
FROM bank
GROUP BY campaign
ORDER BY campaign;
