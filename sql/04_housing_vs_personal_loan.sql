-- Q4: % of customers with housing loan vs personal loan
-- Business question: What is the current loan product penetration?
-- Helps identify cross-sell opportunities.

SELECT
    ROUND(100.0 * SUM(CASE WHEN housing = 'yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS pct_housing_loan,
    ROUND(100.0 * SUM(CASE WHEN loan    = 'yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS pct_personal_loan,
    ROUND(100.0 * SUM(CASE WHEN housing = 'yes' AND loan = 'yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS pct_both_loans,
    ROUND(100.0 * SUM(CASE WHEN housing = 'no'  AND loan = 'no'  THEN 1 ELSE 0 END) / COUNT(*), 2) AS pct_no_loans,
    COUNT(*) AS total_customers
FROM bank;
