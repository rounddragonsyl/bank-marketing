-- Q13: Running total of successful term deposit conversions by month
-- Business question: Are we on track cumulatively throughout the year?
-- Useful for pacing campaign targets month by month.

WITH monthly_conversions AS (
    SELECT
        month,
        SUM(CASE WHEN deposit = 'yes' THEN 1 ELSE 0 END) AS monthly_conversions
    FROM bank
    GROUP BY month
)
SELECT
    month,
    monthly_conversions,
    SUM(monthly_conversions) OVER (
        ORDER BY CASE month
            WHEN 'jan' THEN 1  WHEN 'feb' THEN 2  WHEN 'mar' THEN 3
            WHEN 'apr' THEN 4  WHEN 'may' THEN 5  WHEN 'jun' THEN 6
            WHEN 'jul' THEN 7  WHEN 'aug' THEN 8  WHEN 'sep' THEN 9
            WHEN 'oct' THEN 10 WHEN 'nov' THEN 11 WHEN 'dec' THEN 12
        END
    )                        AS running_total_conversions
FROM monthly_conversions
ORDER BY CASE month
    WHEN 'jan' THEN 1  WHEN 'feb' THEN 2  WHEN 'mar' THEN 3
    WHEN 'apr' THEN 4  WHEN 'may' THEN 5  WHEN 'jun' THEN 6
    WHEN 'jul' THEN 7  WHEN 'aug' THEN 8  WHEN 'sep' THEN 9
    WHEN 'oct' THEN 10 WHEN 'nov' THEN 11 WHEN 'dec' THEN 12
END;
