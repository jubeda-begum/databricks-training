
-- =========================================================
-- QUESTION 1: Employee Compensation Classification
-- =========================================================

-- Question:
-- Write an SQL query to display the following details for each employee:
-- • Convert emp_name into:
--      - UPPER CASE
--      - lower case
--      - InitCap / Camel Case
-- • Calculate total income using:
--      - base_salary + bonus
--      - Handle NULL bonus values safely
-- • Round the total income to the nearest integer
-- • Extract the joining year from joining_date
-- • Use CASE statement to classify employees:
--      - Senior
--      - Mid
--      - Junior

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

    ROUND(base_salary + IFNULL(bonus,0))
        AS rounded_income,

    YEAR(joining_date) AS joining_year,

    TIMESTAMPDIFF(
        YEAR,
        joining_date,
        CURDATE()
    ) AS experience_years,

    CASE
        WHEN TIMESTAMPDIFF(
                YEAR,
                joining_date,
                CURDATE()
             ) > 7
            THEN 'Senior'

        WHEN TIMESTAMPDIFF(
                YEAR,
                joining_date,
                CURDATE()
             ) BETWEEN 4 AND 7
            THEN 'Mid'

        ELSE 'Junior'
    END AS employee_level

FROM employee_payments;



-- =========================================================
-- QUESTION 2: Order Delivery Delay Analysis
-- =========================================================

-- Question:
-- Write an SQL query to display:
-- • Customer name in uppercase
-- • Delivery days
-- • Replace NULL delivery date with current date
-- • Truncate order amount
-- • CASE:
--      - Same-day
--      - Delayed
--      - Pending

SELECT

    order_id,

    UPPER(customer_name)
        AS customer_name,

    order_date,

    IFNULL(delivery_date,CURDATE())
        AS final_delivery_date,

    DATEDIFF(
        IFNULL(delivery_date,CURDATE()),
        order_date
    ) AS delivery_days,

    TRUNCATE(order_amount,1)
        AS truncated_amount,

    CASE

        WHEN delivery_date IS NULL
            THEN 'Pending'

        WHEN DATEDIFF(
                delivery_date,
                order_date
             ) = 0
            THEN 'Same-day'

        WHEN DATEDIFF(
                delivery_date,
                order_date
             ) > 3
            THEN 'Delayed'

        ELSE 'Normal'

    END AS delivery_status

FROM orders_delivery;



-- =========================================================
-- QUESTION 3: Customer Spending Pattern
-- =========================================================

-- Question:
-- Write an SQL query to display:
-- • Customer name in proper case
-- • Purchase month name
-- • Rounded purchase amount
-- • Absolute purchase amount
-- • CASE:
--      - High Spender
--      - Medium Spender
--      - Low Spender

SELECT

    cust_id,

    CONCAT(
        UPPER(LEFT(cust_name,1)),
        LOWER(SUBSTRING(cust_name,2))
    ) AS customer_name,

    city,

    MONTHNAME(purchase_date)
        AS purchase_month,

    ROUND(purchase_amount)
        AS rounded_amount,

    ABS(purchase_amount)
        AS absolute_amount,

    CASE

        WHEN purchase_amount > 15000
            THEN 'High Spender'

        WHEN purchase_amount
             BETWEEN 8000 AND 15000
            THEN 'Medium Spender'

        ELSE 'Low Spender'

    END AS spending_category

FROM customer_spending;



-- =========================================================
-- QUESTION 4: Subscription Validity Check
-- =========================================================

-- Question:
-- • Extract email domain
-- • Calculate subscription duration
-- • Format fee
-- • Remaining days
-- • CASE:
--      - Active
--      - Expiring Soon
--      - Expired

SELECT

    user_id,

    SUBSTRING_INDEX(
        user_email,
        '@',
        -1
    ) AS email_domain,

    TIMESTAMPDIFF(
        MONTH,
        start_date,
        end_date
    ) AS subscription_months,

    FORMAT(subscription_fee,2)
        AS formatted_fee,

    DATEDIFF(
        end_date,
        CURDATE()
    ) AS remaining_days,

    CASE

        WHEN end_date > CURDATE()
            THEN 'Active'

        WHEN DATEDIFF(
                end_date,
                CURDATE()
             ) BETWEEN 0 AND 30
            THEN 'Expiring Soon'

        ELSE 'Expired'

    END AS subscription_status

FROM subscriptions;



-- =========================================================
-- QUESTION 5: Loan EMI Risk Categorization
-- =========================================================

-- Question:
-- • Calculate EMI
-- • Years since loan start
-- • Uppercase customer name
-- • CASE:
--      - High Risk
--      - Medium Risk
--      - Low Risk

SELECT

    loan_id,

    UPPER(customer_name)
        AS customer_name,

    ROUND(
        (
            loan_amount *
            POWER(
                (1 + interest_rate/100),
                1
            )
        ) / 12
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
-- =========================================================
-- QUESTION 6: Employee Attendance Evaluation
-- =========================================================

-- Question:
-- Write an SQL query to display:
-- • Attendance percentage
-- • Month name
-- • Difference between total days and present days
-- • Employee name in lowercase
-- • CASE:
--      - Excellent
--      - Average
--      - Poor

SELECT

    emp_id,

    LOWER(emp_name)
        AS employee_name,

    ROUND(
        (present_days / total_days) * 100,
        2
    ) AS attendance_percentage,

    MONTHNAME(record_date)
        AS month_name,

    (total_days - present_days)
        AS absent_days,

    CASE

        WHEN (
                (present_days / total_days) * 100
             ) >= 90
            THEN 'Excellent'

        WHEN (
                (present_days / total_days) * 100
             ) BETWEEN 75 AND 89
            THEN 'Average'

        ELSE 'Poor'

    END AS attendance_status

FROM attendance;



-- =========================================================
-- QUESTION 7: Product Discount Validation
-- =========================================================

-- Question:
-- Write an SQL query to display:
-- • Discount amount
-- • Discount percentage
-- • Day name of sale
-- • Product name in proper case
-- • CASE:
--      - Valid Discount
--      - Overpriced
--      - No Discount

SELECT

    product_id,

    CONCAT(
        UPPER(LEFT(product_name,1)),
        LOWER(SUBSTRING(product_name,2))
    ) AS proper_product_name,

    ABS(mrp - selling_price)
        AS discount_amount,

    ROUND(
        ((mrp - selling_price) / mrp) * 100,
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



-- =========================================================
-- QUESTION 8: Insurance Policy Aging
-- =========================================================

-- Question:
-- Write an SQL query to display:
-- • Policy duration in years
-- • Remaining days
-- • Rounded premium
-- • Holder name in uppercase
-- • CASE:
--      - Long Term
--      - Mid Term
--      - Expired

SELECT

    policy_id,

    UPPER(holder_name)
        AS holder_name,

    TIMESTAMPDIFF(
        YEAR,
        policy_start,
        policy_end
    ) AS policy_years,

    DATEDIFF(
        policy_end,
        CURDATE()
    ) AS remaining_days,

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



-- =========================================================
-- QUESTION 9: Salary Increment Simulation
-- =========================================================

-- Question:
-- Write an SQL query to display:
-- • Years since last hike
-- • Increment amount
-- • New salary
-- • Employee name in lowercase
-- • CASE:
--      - High Increment
--      - Moderate
--      - No Increment

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



-- =========================================================
-- QUESTION 10: Customer Account Status Evaluation
-- =========================================================

-- Question:
-- Write an SQL query to display:
-- • Absolute balance
-- • Days since last transaction
-- • Branch name in proper case
-- • Sign of balance
-- • CASE:
--      - Active
--      - Dormant
--      - Overdrawn

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


-- =========================================================
-- QUESTION 11 – Salary Risk Flagging Based on Tax Shock
-- =========================================================

-- Question
-- For each employee:
-- • Normalize name to lowercase
-- • Calculate net salary after tax and round it
-- • Extract revision year
-- • Find months since revision
-- • CASE:
--    o Flag Tax Shock if tax > 20 AND months > 24
--    o Flag Review Needed if tax between 15–20
--    o Else Stable

SELECT

    emp_id,

    LOWER(emp_name) AS employee_name,

    ROUND(
        salary - (salary * tax_percent / 100)
    ) AS net_salary,

    YEAR(last_revision) AS revision_year,

    TIMESTAMPDIFF(
        MONTH,
        last_revision,
        CURDATE()
    ) AS months_since_revision,

    CASE

        WHEN tax_percent > 20
             AND TIMESTAMPDIFF(
                    MONTH,
                    last_revision,
                    CURDATE()
                 ) > 24
            THEN 'Flag Tax Shock'

        WHEN tax_percent BETWEEN 15 AND 20
            THEN 'Flag Review Needed'

        ELSE 'Stable'

    END AS salary_status

FROM salary_audit;

-- =========================================================
-- QUESTION 12 – Bonus Abuse Detection
-- =========================================================

-- Question
-- For each record:
-- • Convert name to proper case
-- • Calculate bonus percentage of salary (rounded)
-- • Extract day name of bonus
-- • Find absolute salary–bonus difference
-- • CASE:
--    o Suspicious if bonus > 30% AND weekend
--    o Normal if bonus <= 20%
--    o Audit

SELECT

    emp_code,

    CONCAT(
        UPPER(LEFT(emp_name,1)),
        LOWER(SUBSTRING(emp_name,2))
    ) AS proper_name,

    ROUND(
        (bonus / base_salary) * 100,
        2
    ) AS bonus_percentage,

    DAYNAME(bonus_date)
        AS bonus_day,

    ABS(base_salary - bonus)
        AS salary_bonus_difference,

    CASE

        WHEN ((bonus / base_salary) * 100) > 30
             AND DAYNAME(bonus_date)
                 IN ('Saturday','Sunday')
            THEN 'Suspicious'

        WHEN ((bonus / base_salary) * 100) <= 20
            THEN 'Normal'

        ELSE 'Audit'

    END AS bonus_status

FROM bonus_monitor;



-- =========================================================
-- QUESTION 13 – Experience Parity Validation
-- =========================================================

-- Question
-- For each employee:
-- • Uppercase name
-- • Calculate actual experience from date
-- • Find difference between declared and actual experience
-- • Floor salary
-- • CASE:
--    o Overstated if declared > actual
--    o Understated if declared < actual
--    o Matched

SELECT

    emp_id,

    UPPER(emp_name)
        AS employee_name,

    TIMESTAMPDIFF(
        YEAR,
        joining_date,
        CURDATE()
    ) AS actual_experience,

    ABS(
        declared_experience -
        TIMESTAMPDIFF(
            YEAR,
            joining_date,
            CURDATE()
        )
    ) AS experience_difference,

    FLOOR(salary)
        AS floor_salary,

    CASE

        WHEN declared_experience >
             TIMESTAMPDIFF(
                YEAR,
                joining_date,
                CURDATE()
             )
            THEN 'Overstated'

        WHEN declared_experience <
             TIMESTAMPDIFF(
                YEAR,
                joining_date,
                CURDATE()
             )
            THEN 'Understated'

        ELSE 'Matched'

    END AS experience_status

FROM employee_experience;



-- =========================================================
-- QUESTION 14 – Salary Digit Pattern Analysis
-- =========================================================

-- Question
-- For each employee:
-- • Extract last two characters of name
-- • Get day of month from credit date
-- • Truncate salary to integer
-- • Use MOD on salary
-- • CASE:
--    o Pattern Match if salary MOD 10 equals day
--    o No Match otherwise

SELECT

    emp_id,

    RIGHT(emp_name,2)
        AS last_two_characters,

    DAY(credit_date)
        AS credit_day,

    TRUNCATE(salary,0)
        AS truncated_salary,

    MOD(TRUNCATE(salary,0),10)
        AS salary_mod,

    CASE

        WHEN MOD(TRUNCATE(salary,0),10) = DAY(credit_date)
            THEN 'Pattern Match'

        ELSE 'No Match'

    END AS pattern_status

FROM salary_digits;



-- =========================================================
-- QUESTION 15 – Odd–Even Salary Compliance
-- =========================================================

-- Question
-- For each employee:
-- • Lowercase name
-- • Extract weekday
-- • Round salary
-- • Apply MOD on salary
-- • CASE:
--    o Violation if even salary paid on odd weekday
--    o Compliant otherwise

SELECT

    emp_id,

    LOWER(emp_name)
        AS employee_name,

    DAYNAME(payment_date)
        AS weekday_name,

    ROUND(salary)
        AS rounded_salary,

    MOD(ROUND(salary),2)
        AS salary_mod,

    CASE

        WHEN MOD(ROUND(salary),2) = 0
             AND MOD(DAY(payment_date),2) = 1
            THEN 'Violation'

        ELSE 'Compliant'

    END AS compliance_status

FROM payroll_control;



-- =========================================================
-- QUESTION 16 – Salary Inflation Drift
-- =========================================================

-- Question
-- For each employee:
-- • Proper case name
-- • Calculate years since hike
-- • Apply POWER on years
-- • Round salary impact
-- • CASE:
--    o High Inflation Risk if years > 5
--    o Moderate
--    o Low

SELECT

    emp_id,

    CONCAT(
        UPPER(LEFT(emp_name,1)),
        LOWER(SUBSTRING(emp_name,2))
    ) AS proper_name,

    TIMESTAMPDIFF(
        YEAR,
        last_hike,
        CURDATE()
    ) AS years_since_hike,

    POWER(
        TIMESTAMPDIFF(
            YEAR,
            last_hike,
            CURDATE()
        ),
        2
    ) AS power_value,

    ROUND(
        salary * POWER(
            1.05,
            TIMESTAMPDIFF(
                YEAR,
                last_hike,
                CURDATE()
            )
        )
    ) AS salary_impact,

    CASE

        WHEN TIMESTAMPDIFF(
                YEAR,
                last_hike,
                CURDATE()
             ) > 5
            THEN 'High Inflation Risk'

        WHEN TIMESTAMPDIFF(
                YEAR,
                last_hike,
                CURDATE()
             ) BETWEEN 3 AND 5
            THEN 'Moderate'

        ELSE 'Low'

    END AS inflation_status

FROM inflation_watch;



-- =========================================================
-- QUESTION 17 – Salary Sign Integrity Check
-- =========================================================

-- Question
-- For each employee:
-- • Uppercase name
-- • Extract year
-- • Apply SIGN on salary
-- • ABS salary
-- • CASE:
--    o Negative Error
--    o Zero Salary
--    o Valid

SELECT

    emp_id,

    UPPER(emp_name)
        AS employee_name,

    YEAR(record_date)
        AS record_year,

    SIGN(salary)
        AS salary_sign,

    ABS(salary)
        AS absolute_salary,

    CASE

        WHEN salary < 0
            THEN 'Negative Error'

        WHEN salary = 0
            THEN 'Zero Salary'

        ELSE 'Valid'

    END AS salary_status

FROM salary_integrity;

-- =========================================================
-- QUESTION 18 – Name Length vs Salary Correlation
-- =========================================================

-- Question
-- For each employee:
-- • Calculate name length
-- • Calculate years of service
-- • Round salary
-- • Compare name length vs years
-- • CASE:
--    o Name Bias if length > years
--    o Neutral

SELECT

    emp_id,

    LENGTH(emp_name)
        AS name_length,

    TIMESTAMPDIFF(
        YEAR,
        join_date,
        CURDATE()
    ) AS years_of_service,

    ROUND(salary)
        AS rounded_salary,

    CASE

        WHEN LENGTH(emp_name) >
             TIMESTAMPDIFF(
                YEAR,
                join_date,
                CURDATE()
             )
            THEN 'Name Bias'

        ELSE 'Neutral'

    END AS comparison_status

FROM name_salary;



-- =========================================================
-- QUESTION 19 – Salary Spike Detection by Month
-- =========================================================

-- Question
-- For each record:
-- • Extract month name
-- • CEIL salary
-- • Check last day of month
-- • CASE:
--    o End Month Spike
--    o Regular

SELECT

    emp_id,

    MONTHNAME(paid_date)
        AS month_name,

    CEIL(salary)
        AS ceil_salary,

    LAST_DAY(paid_date)
        AS last_day_of_month,

    CASE

        WHEN paid_date = LAST_DAY(paid_date)
            THEN 'End Month Spike'

        ELSE 'Regular'

    END AS spike_status

FROM salary_monthly;



-- =========================================================
-- QUESTION 20– Salary Digit Sum Audit
-- =========================================================

-- Question
-- For each employee:
-- • Extract first character of name
-- • Truncate salary
-- • Sum digits logically
-- • Extract day
-- • CASE:
--    o Digit Alert
--    o Normal

SELECT

    emp_id,

    LEFT(emp_name,1)
        AS first_character,

    TRUNCATE(salary,0)
        AS truncated_salary,

    (
        FLOOR(TRUNCATE(salary,0) / 10000) +
        FLOOR((TRUNCATE(salary,0) % 10000) / 1000) +
        FLOOR((TRUNCATE(salary,0) % 1000) / 100) +
        FLOOR((TRUNCATE(salary,0) % 100) / 10) +
        (TRUNCATE(salary,0) % 10)
    ) AS digit_sum,

    DAY(audit_date)
        AS audit_day,

    CASE

        WHEN (
            FLOOR(TRUNCATE(salary,0) / 10000) +
            FLOOR((TRUNCATE(salary,0) % 10000) / 1000) +
            FLOOR((TRUNCATE(salary,0) % 1000) / 100) +
            FLOOR((TRUNCATE(salary,0) % 100) / 10) +
            (TRUNCATE(salary,0) % 10)
        ) > 20
            THEN 'Digit Alert'

        ELSE 'Normal'

    END AS audit_status

FROM digit_audit;
