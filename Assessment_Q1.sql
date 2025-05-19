-- Customers with at least one savings and one investment plan, sorted by total deposits
SELECT
    u.id AS owner_id,
    CONCAT(u.first_name, ' ', u.last_name) AS name,  -- Concatenate first and last name
    -- If is_regular_savings = 1 is saving and is_a_fund =1 is investment
    COUNT(CASE WHEN p.is_regular_savings = 1 THEN 1 END) AS savings_count,
    COUNT(CASE WHEN p.is_a_fund = 1 THEN 1 END) AS investment_count,
    -- Total confirmed deposits from the savings_savingsaccount table
    SUM(sa.confirmed_amount) AS total_deposits
FROM
    users_customuser u
-- Join with plans to get each user's plans
JOIN
    plans_plan p ON u.id = p.owner_id
-- Join with savings_savingsaccount to get confirmed deposits
LEFT JOIN
    savings_savingsaccount sa ON sa.plan_id = p.id
GROUP BY
    u.id, name
-- Only include users who have at least one savings and one investment plan
HAVING
    COUNT(CASE WHEN p.is_regular_savings = 1 THEN 1 END) >= 1
    AND COUNT(CASE WHEN p.is_a_fund = 1 THEN 1 END) >= 1
ORDER BY
    total_deposits DESC;
