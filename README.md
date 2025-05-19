# Data Analytics SQL Assessment

## Question 1
**Approach:**
I joined the users_customuser table with plans_plan.
Concatenated first name and last name as name
I Used conditional COUNT(CASE WHEN ...) to tally savings and investment plans separately.
I use HAVING to filter users with at least one of each.
I used SUM(amount) for total deposits.
Sort by total deposits using Order by

## Question 2
**Approach:**
I use a WITH clause (CTE) to:
Count monthly transactions per user.
Calculate the average monthly transaction count per user.
Categorize users using CASE: High (≥10), Medium (3–9), Low (≤2).
Group by category to get counts and averages.
Used Field() in Order by to make custom sorting 
