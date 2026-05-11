-- Q15: Month-over-month change in average customer balance
-- Business question: Is the customer base growing in wealth over time?
-- Tracks macro trends in deposit health across the campaign period.

WITH monthly_avg AS (
    SELECT
        month,
        CASE month
            WHEN 'jan' THEN 1  WHEN 'feb' THEN 2  WHEN 'mar' THEN 3
            WHEN 'apr' THEN 4  WHEN 'may' THEN 5  WHEN 'jun' THEN 6
            WHEN 'jul' THEN 7  WHEN 'aug' THEN 8  WHEN 'sep' THEN 9
            WHEN 'oct' THEN 10 WHEN 'nov' THEN 11 WHEN 'dec' THEN 12
        END                        AS month_num,
        ROUND(AVG(balance), 2)     AS avg_balance
    FROM bank
    GROUP BY month
)
SELECT
    month,
    avg_balance,
    LAG(avg_balance) OVER (ORDER BY month_num)  AS prev_month_avg,
    ROUND(
        avg_balance - LAG(avg_balance) OVER (ORDER BY month_num),
        2
    )                                           AS mom_change,
    ROUND(
        100.0 * (avg_balance - LAG(avg_balance) OVER (ORDER BY month_num))
              / NULLIF(LAG(avg_balance) OVER (ORDER BY month_num), 0),
        2
    )                                           AS mom_change_pct
FROM monthly_avg
ORDER BY month_num;
