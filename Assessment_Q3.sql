-- Q3: Account Inactivity Alert
-- Find accounts (savings or investment) with no inflow transactions in over a year (365 days).

WITH last_tx_dates AS (
    SELECT 
        id AS plan_id,
        owner_id,
        'Savings' AS type,
        MAX(last_transaction_date) AS last_transaction_date
    FROM savings_savingsaccount
    WHERE confirmed_amount > 0
    GROUP BY id, owner_id

    UNION ALL

    SELECT 
        id AS plan_id,
        owner_id,
        'Investment' AS type,
        MAX(last_transaction_date) AS last_transaction_date
    FROM plans_plan
    WHERE confirmed_amount > 0
    GROUP BY id, owner_id
)
SELECT 
    plan_id,
    owner_id,
    type,
    last_transaction_date,
    DATE_PART('day', CURRENT_DATE - last_transaction_date) AS inactivity_days
FROM last_tx_dates
WHERE CURRENT_DATE - last_transaction_date > INTERVAL '365 days';
