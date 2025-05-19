SELECT
    u.id AS owner_id,
    CONCAT(u.first_name, ' ', u.last_name) AS name,  
    TIMESTAMPDIFF(MONTH, u.date_joined, CURRENT_DATE) AS tenure_months,  -- Account tenure in months since date_joined
    COUNT(sa.confirmed_amount) AS total_transactions,-- Total transactions for user
    AVG(sa.confirmed_amount * 0.001) AS avg_profit_per_transaction,-- Average profit per transaction (0.1% of confirmed_amount)
    -- Estimated CLV calculation
    CASE
        WHEN TIMESTAMPDIFF(MONTH, u.date_joined, CURRENT_DATE) > 0 THEN
            (COUNT(sa.confirmed_amount) / TIMESTAMPDIFF(MONTH, u.date_joined, CURRENT_DATE)) * 12 * AVG(sa.confirmed_amount * 0.001)
        ELSE 0
    END AS estimated_clv
FROM
    users_customuser u
LEFT JOIN
    savings_savingsaccount sa ON sa.owner_id = u.id   -- direct join on owner_id
GROUP BY
    u.id, name, u.date_joined
ORDER BY
    estimated_clv DESC;
