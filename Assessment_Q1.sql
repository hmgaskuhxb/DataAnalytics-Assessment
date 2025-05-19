-- Identify customers who have both a funded savings account and a funded investment plan
-- Output includes: customer ID, name, count of savings and investment plans, and total deposits

SELECT
    u.id AS owner_id,                                  -- Unique identifier for the customer
    u.name,                                            -- Full name of the customer
    COUNT(DISTINCT s.id) AS savings_count,            -- Number of funded savings accounts
    COUNT(DISTINCT p.id) AS investment_count,         -- Number of funded investment plans
    COALESCE(SUM(s.amount), 0) +                      -- Total deposits from savings
    COALESCE(SUM(p.amount), 0) AS total_deposits      -- plus deposits from investments
FROM users_customuser u
-- Join funded savings accounts
LEFT JOIN savings_savingsaccount s 
    ON u.id = s.owner_id AND s.status = 'funded'
-- Join funded investment plans
LEFT JOIN plans_plan p 
    ON u.id = p.owner_id AND p.status = 'funded'
GROUP BY u.id, u.name
-- Filter: include only customers with at least one funded savings and investment plan
HAVING COUNT(DISTINCT s.id) >= 1 AND COUNT(DISTINCT p.id) >= 1
-- Order by total deposits in descending order to prioritize high-value customers
ORDER BY total_deposits DESC;
