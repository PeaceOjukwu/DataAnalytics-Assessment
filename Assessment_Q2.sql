-- Count number of transactions per user per month
WITH monthly_tx_counts AS (
    SELECT
        sa.owner_id,
-- Truncate date to the first of the month for monthly grouping
        DATE_FORMAT(sa.transaction_date, '%Y-%m-01') AS month,
        COUNT(*) AS tx_count
    FROM
        savings_savingsaccount sa
    GROUP BY
        sa.owner_id, month
),

-- Average number of transactions per user
avg_tx_per_user AS (
    SELECT
        owner_id,
        AVG(tx_count) AS avg_tx_per_month
    FROM
        monthly_tx_counts
    GROUP BY
        owner_id
),
-- Categorizing users to High frequency, medium and low based on average transaction count
categorized_users AS (
    SELECT
        CASE
            WHEN avg_tx_per_month >= 10 THEN 'High Frequency'
            WHEN avg_tx_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category,
        avg_tx_per_month
    FROM
        avg_tx_per_user
)
-- Reporting on each frequency category
SELECT
    frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(avg_tx_per_month), 1) AS avg_transactions_per_month #Rounding up average transaction to 1
FROM
    categorized_users
GROUP BY
    frequency_category
ORDER BY -- Custom ordering 
    field(frequency_category, 'High Frequency', 'Medium Frequency', 'Low Frequency');
