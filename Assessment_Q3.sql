-- Inactive Savings/Investments Accounts (no transaction in the last 365 days)
SELECT
    p.id AS plan_id,
    p.owner_id,
    CASE 
        WHEN p.is_regular_savings = 1 THEN 'savings'
        WHEN p.is_a_fund = 1 THEN 'investments'
        ELSE 'unknown'
    END AS type,
    MAX(s.transaction_date) AS last_transaction_date, -- Most recent transaction date for the plan
    DATEDIFF(CURRENT_DATE, MAX(s.transaction_date)) AS inactivity_days -- Number of days since the last transaction
FROM
    plans_plan p
JOIN
    savings_savingsaccount s ON s.plan_id = p.id
WHERE
    p.is_regular_savings = 1 OR p.is_a_fund = 1
GROUP BY
    p.id, p.owner_id, p.is_regular_savings, p.is_a_fund
HAVING
    MAX(s.transaction_date) IS NOT NULL -- That have at least one transaction
    AND DATEDIFF(CURRENT_DATE, MAX(s.transaction_date)) <= 365;
