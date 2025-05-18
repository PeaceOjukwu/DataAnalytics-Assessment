SELECT
    u.id AS owner_id,
-- Using alias
    CONCAT(u.first_name, ' ', u.last_name) AS name, #concatenating first name and last name to name
-- If plan type id 1 is saving and 2 investment
    COUNT(CASE WHEN p.plan_type_id = 1 THEN 1 END) AS savings_count,
    COUNT(CASE WHEN p.plan_type_id = 2 THEN 1 END) AS investment_count,
    SUM(p.amount) AS total_deposits
FROM
    users_customuser u
JOIN
    plans_plan p ON u.id = p.owner_id
GROUP BY
    u.id, u.name
HAVING
    COUNT(CASE WHEN p.plan_type_id = 1 THEN 1 END) >= 1 AND
    COUNT(CASE WHEN p.plan_type_id = 2 THEN 1 END) >= 1
ORDER BY
    total_deposits DESC;