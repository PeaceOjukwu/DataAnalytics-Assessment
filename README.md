# Data Analytics SQL Assessment

## Question 1
**Approach:**
I joined the users_customuser table with plans_plan.
Concatenated first name and last name as name
I Used conditional COUNT(CASE WHEN ...) to tally savings and investment plans separately.
I use HAVING to filter users with at least one of each.
I used SUM(confirmed amount) for total deposits.
Sort by total deposits using Order by

**Challenge**
The challenge i had in question 1 was selecting what table to use for total deposit, as plan had amount and savings_savingsaccount had amount
But i used savings_savingsaccount with confirmed amount as is the value of inflow

## Question 2
**Approach:**
I use a WITH clause (CTE) to:
Count monthly transactions per user.
Calculate the average monthly transaction count per user.
Categorize users using CASE: High (≥10), Medium (3–9), Low (≤2).
Group by category to get counts and averages.
Used Field() in Order by to make custom sorting 

## Question 3
**Approach:**
Using is_regular_savings = 1 and is_a_fund as savings and investment plan
I used MAX(s.transaction_date) to get most recent transaction date for the plan
and DATEDIFF(CURRENT_DATE, MAX(s.transaction_date)) Number of days since the last transaction
and date less than 365

## Question 3
**Approach:**
i join users_customuser and savings_savingsaccount on u.id = sa.owner_id.
Calculated tenure: months between date_joined and today.
Counted total transactions: each row in savings_savingsaccount is a transaction.
Calculated profit per transaction: confirmed_amount × 0.001.
Got average profit per transaction using AVG().
Used the CLV formula.
Grouped by user, sorted by CLV.
