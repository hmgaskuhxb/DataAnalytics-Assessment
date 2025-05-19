-- Q4: Customer Lifetime Value (CLV) Estimation
-- CLV = (total_transactions / tenure_months) * 12 * avg_profit_per_txn

WITH user_tenure AS (
    SELECT 
        u.id AS customer_id,
        CONCAT(u.first_name, ' ', u.last_name) AS name,
        DATE_PART('month', AGE(CURRENT_DATE, u.date_joined)) AS tenure_months
    FROM users_customuser u
),
user_tx AS (
    SELECT 
        s.owner_id,
        COUNT(*) AS total_transactions,
        SUM(s.confirmed_amount) AS total_tx_value
    FROM savings_savingsaccount s
    WHERE s.confirmed_amount > 0
    GROUP BY s.owner_id
)
SELECT 
    u.customer_id,
    u.name,
    u.tenure_months,
    tx.total_transactions,
    ROUND((tx.total_transactions::numeric / u.tenure_months) * 12 * (0.001 * tx.total_tx_value / tx.total_transactions) / 100.0, 2) AS estimated_clv
FROM user_tenure u
JOIN user_tx tx ON tx.owner_id = u.customer_id
ORDER BY estimated_clv DESC;
