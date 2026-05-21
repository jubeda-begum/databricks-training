--QUESTION 1: Employee Compensation Classification

--Question:

--Write an SQL query to display the following details for each employee:

--1. Convert emp_name into:
  -- - UPPER CASE
  -- - lower case
   --- InitCap / Camel Case

2. Calculate total income using:
   - base_salary + bonus
   - Handle NULL bonus values safely

3. Round the total income to the nearest integer

4. Extract the joining year from joining_date

5. Use a CASE statement to classify employees based on experience:
   - Senior → Experience greater than 7 years
   - Mid → Experience between 4 and 7 years
   - Junior → Experience less than 4 years
Query:
SELECT 
    emp_id,

    emp_name,

    UPPER(emp_name) AS upper_name,

    LOWER(emp_name) AS lower_name,

    CONCAT(
        UPPER(LEFT(emp_name,1)),
        LOWER(SUBSTRING(emp_name,2))
    ) AS initcap_name,

    department,

    base_salary,

    bonus,

    (base_salary + IFNULL(bonus,0)) AS total_income,

    ROUND(base_salary + IFNULL(bonus,0)) AS rounded_income,

    YEAR(joining_date) AS joining_year,

    TIMESTAMPDIFF(YEAR, joining_date, CURDATE()) AS experience_years,

    CASE
        WHEN TIMESTAMPDIFF(YEAR, joining_date, CURDATE()) > 7 
            THEN 'Senior'

        WHEN TIMESTAMPDIFF(YEAR, joining_date, CURDATE()) BETWEEN 4 AND 7 
            THEN 'Mid'

        ELSE 'Junior'
    END AS employee_level

FROM employee_payments;


Question 2:

Question:

Write an SQL query to display the following details for each order:

1. Convert customer_name into UPPER CASE

2. Calculate delivery days using date difference

3. Replace NULL delivery_date with today’s date

4. Truncate order_amount to 1 decimal place

5. Use CASE statement to classify orders:
   - Same-day
   - Delayed (>3 days)
   - Pending

query:
SELECT

    order_id,

    UPPER(customer_name) AS customer_name,

    order_date,

    IFNULL(delivery_date, CURDATE()) AS final_delivery_date,

    DATEDIFF(IFNULL(delivery_date, CURDATE()), order_date) AS delivery_days,

    TRUNCATE(order_amount,1) AS truncated_amount,

    CASE

        WHEN delivery_date IS NULL
            THEN 'Pending'

        WHEN DATEDIFF(delivery_date, order_date) = 0
            THEN 'Same-day'

        WHEN DATEDIFF(delivery_date, order_date) > 3
            THEN 'Delayed'

        ELSE 'Normal'

    END AS delivery_status

FROM orders_delivery;

Question 3:

Question:

Write an SQL query to display the following details for each customer:

1. Display customer name with first letter capitalized

2. Display the month name of purchase

3. Round the purchase amount to nearest integer

4. Display absolute value of purchase amount (defensive logic)

5. Use CASE statement to classify customers:
   - High spender → purchase_amount > 15000
   - Medium spender → purchase_amount between 8000 and 15000
   - Low spender → otherwise

Query:

SELECT

    cust_id,

    CONCAT(
        UPPER(LEFT(cust_name,1)),
        LOWER(SUBSTRING(cust_name,2))
    ) AS customer_name,

    city,

    MONTHNAME(purchase_date) AS purchase_month,

    ROUND(purchase_amount) AS rounded_amount,

    ABS(purchase_amount) AS absolute_amount,

    CASE

        WHEN purchase_amount > 15000
            THEN 'High Spender'

        WHEN purchase_amount BETWEEN 8000 AND 15000
            THEN 'Medium Spender'

        ELSE 'Low Spender'

    END AS spending_category

FROM customer_spending;

Query 4:
Question:
For each user:

• Extract email domain

• Calculate subscription duration in months

• Format fee with commas

• Find remaining days from today

• CASE:

o Active

o Expiring Soon (≤30 days)

o Expired

Query:

SELECT

user_id,

SUBSTRING_INDEX(user_email,'@',-1)
    AS email_domain,

TIMESTAMPDIFF(
    MONTH,
    start_date,
    end_date
) AS subscription_months,

FORMAT(subscription_fee,2)
    AS formatted_fee,

DATEDIFF(end_date,CURDATE())
    AS remaining_days,

CASE

    WHEN end_date > CURDATE()
        THEN 'Active'

    WHEN DATEDIFF(end_date,CURDATE())
        BETWEEN 0 AND 30
        THEN 'Expiring Soon'

    ELSE 'Expired'

END AS subscription_status

FROM subscriptions;

Question 5:
Question:

• Monthly interest using POWER function

• Years since loan start

• Round EMI

• Uppercase customer name

• CASE:

o High Risk if interest > 9

o Medium Risk

o Low Risk

Query:

SELECT

loan_id,

UPPER(customer_name)
    AS customer_name,

ROUND(
    (loan_amount *
    POWER((1 + interest_rate/100),1))/12
) AS emi,

TIMESTAMPDIFF(
    YEAR,
    loan_start,
    CURDATE()
) AS years_since_start,

CASE

    WHEN interest_rate > 9
        THEN 'High Risk'

    WHEN interest_rate BETWEEN 8 AND 9
        THEN 'Medium Risk'

    ELSE 'Low Risk'

END AS risk_level

FROM loan_details;

Questio 6:
Question

Calculate:

• Attendance percentage (rounded)

• Month name

• Difference between total and present days

• Lowercase employee name

• CASE:

o Excellent ≥90%

o Average 75–89%

o Poor otherwise

Query:

SELECT

emp_id,

LOWER(emp_name)
    AS employee_name,

ROUND(
    (present_days/total_days)*100,
    2
) AS attendance_percentage,

MONTHNAME(record_date)
    AS month_name,

(total_days - present_days)
    AS absent_days,

CASE

    WHEN ((present_days/total_days)*100) >= 90
        THEN 'Excellent'

    WHEN ((present_days/total_days)*100)
        BETWEEN 75 AND 89
        THEN 'Average'

    ELSE 'Poor'

END AS attendance_status

FROM attendance;

Question 7:

Question

Derive:

• Discount amount

• Discount percentage

• Day name of sale

• Proper case product name

• CASE:

o Valid Discount

o Overpriced

o No Discount

Answer Query

SELECT

product_id,

CONCAT(
    UPPER(LEFT(product_name,1)),
    LOWER(SUBSTRING(product_name,2))
) AS proper_product_name,

ABS(mrp-selling_price)
    AS discount_amount,

ROUND(
    ((mrp-selling_price)/mrp)*100,
    2
) AS discount_percentage,

DAYNAME(sale_date)
    AS sale_day,

CASE

    WHEN selling_price < mrp
        THEN 'Valid Discount'

    WHEN selling_price > mrp
        THEN 'Overpriced'

    ELSE 'No Discount'

END AS discount_status

FROM product_sales;

Question 8:

Question

Show:

• Policy duration in years

• Remaining days

• Rounded premium

• Uppercase holder name

• CASE:

    o Long Term

    o Mid Term

    o Expired

Query:

SELECT

    policy_id,

    UPPER(holder_name)
        AS holder_name,

    TIMESTAMPDIFF(
        YEAR,
        policy_start,
        policy_end
    ) AS policy_years,

    DATEDIFF(policy_end,CURDATE())
        AS remaining_days,

    ROUND(premium_amount)
        AS rounded_premium,

    CASE

        WHEN policy_end < CURDATE()
            THEN 'Expired'

        WHEN TIMESTAMPDIFF(
            YEAR,
            policy_start,
            policy_end
        ) >= 3
            THEN 'Long Term'

        ELSE 'Mid Term'

    END AS policy_status

FROM insurance_policies;

Query 9:
Question:
Calculate:

• Years since last hike

• Increment using rating logic

• New salary

• Lowercase employee name

• CASE:

    o High Increment

    o Moderate

    o No Increment

  Query:

SELECT

    emp_id,

    LOWER(emp_name)
        AS employee_name,

    TIMESTAMPDIFF(
        YEAR,
        last_hike,
        CURDATE()
    ) AS years_since_hike,

    CASE

        WHEN rating = 5
            THEN current_salary * 0.20

        WHEN rating = 4
            THEN current_salary * 0.10

        ELSE 0

    END AS increment_amount,

    ROUND(
        current_salary +
        CASE

            WHEN rating = 5
                THEN current_salary * 0.20

            WHEN rating = 4
                THEN current_salary * 0.10

            ELSE 0

        END
    ) AS new_salary,

    CASE

        WHEN rating = 5
            THEN 'High Increment'

        WHEN rating = 4
            THEN 'Moderate'

        ELSE 'No Increment'

    END AS increment_status

FROM salary_revision;

Question 10:
Question

Determine:

• Absolute balance

• Days since last transaction

• Proper case branch name

• Sign of balance

• CASE:

    o Active

    o Dormant

    o Overdrawn
Query:

SELECT

    account_id,

    ABS(balance)
        AS absolute_balance,

    DATEDIFF(
        CURDATE(),
        last_transaction
    ) AS inactive_days,

    CONCAT(
        UPPER(LEFT(branch,1)),
        LOWER(SUBSTRING(branch,2))
    ) AS proper_branch,

    SIGN(balance)
        AS balance_sign,

    CASE

        WHEN balance < 0
            THEN 'Overdrawn'

        WHEN DATEDIFF(
            CURDATE(),
            last_transaction
        ) > 365
            THEN 'Dormant'

        ELSE 'Active'

    END AS account_status

FROM bank_accounts;
