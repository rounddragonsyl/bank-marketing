-- Q2: Average account balance by education level
-- Business question: Does higher education correlate with higher balances?
-- Informs wealth management product targeting.

SELECT
    education,
    COUNT(*)                        AS total_customers,
    ROUND(AVG(balance), 2)          AS avg_balance,
    ROUND(MIN(balance), 2)          AS min_balance,
    ROUND(MAX(balance), 2)          AS max_balance,
    ROUND(STDDEV(balance), 2)       AS std_balance
FROM bank
GROUP BY education
ORDER BY avg_balance DESC;
