-- Q2: Transaction Frequency Analysis
-- Categorize customers by their transaction frequency per month.

WITH transactions_per_user_month AS (
    SELECT 
        s.owner_id,
        COUNT(*) * 1.0 / (EXTRACT(MONTH FROM CURRENT_DATE) - EXTRACT(MONTH FROM MIN(s.created_at)) + 1) AS avg_tx_per_month
    FROM savings_savingsaccount s
    WHERE s.confirmed_amount > 0
    GROUP BY s.owner_id
),
categorized AS (
    SELECT 
        CASE 
            WHEN avg_tx_per_month >= 10 THEN 'High Frequency'
            WHEN avg_tx_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category,
        avg_tx_per_month
    FROM transactions_per_user_month
)
SELECT 
    frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(avg_tx_per_month), 1) AS avg_transactions_per_month
FROM categorized
GROUP BY frequency_category;
