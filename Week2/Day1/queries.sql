
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


-- =========================================================
-- QUESTION 21 – Weekend Salary Credit Fraud Detection
-- =========================================================

-- Question
-- For each record:
-- • Extract bank prefix from bank_code
-- • Identify weekday name of credit_date
-- • Round salary
-- • Apply MOD on salary
-- • CASE:
--    o Weekend Fraud if credited on Saturday/Sunday
--      AND salary MOD 5 = 0
--    o Bank Review if bank is HDFC
--    o Else Normal

SELECT

    emp_id,

    LEFT(bank_code,4)
        AS bank_prefix,

    DAYNAME(credit_date)
        AS weekday_name,

    ROUND(salary)
        AS rounded_salary,

    MOD(ROUND(salary),5)
        AS salary_mod,

    CASE

        WHEN DAYNAME(credit_date)
             IN ('Saturday','Sunday')
             AND MOD(ROUND(salary),5)=0
            THEN 'Weekend Fraud'

        WHEN LEFT(bank_code,4)='HDFC'
            THEN 'Bank Review'

        ELSE 'Normal'

    END AS fraud_status

FROM salary_credit_audit;



-- =========================================================
-- QUESTION 22 – Salary Credit Time Drift Analysis
-- =========================================================

-- Question
-- For each employee:
-- • Extract hour from credit timestamp
-- • Convert emp_name to lowercase
-- • Floor salary
-- • Calculate difference between salary and hour
-- • CASE:
--    o Midnight Drift if hour between 0–3
--    o After Hours
--    o Business Hours

SELECT

    emp_id,

    LOWER(emp_name)
        AS employee_name,

    HOUR(credit_ts)
        AS credit_hour,

    FLOOR(salary)
        AS floor_salary,

    ABS(FLOOR(salary)-HOUR(credit_ts))
        AS salary_hour_difference,

    CASE

        WHEN HOUR(credit_ts) BETWEEN 0 AND 3
            THEN 'Midnight Drift'

        WHEN HOUR(credit_ts) NOT BETWEEN 9 AND 18
            THEN 'After Hours'

        ELSE 'Business Hours'

    END AS drift_status

FROM salary_time_drift;



-- =========================================================
-- QUESTION 23 – Salary Decimal Precision Audit
-- =========================================================

-- Question
-- For each record:
-- • Truncate salary to 2 decimals
-- • Calculate difference between rounded and truncated value
-- • Extract day name
-- • Get length of emp_name
-- • CASE:
--    o Precision Loss if difference > 0.01
--    o Safe

SELECT

    emp_id,

    TRUNCATE(salary,2)
        AS truncated_salary,

    ABS(
        ROUND(salary,2) -
        TRUNCATE(salary,2)
    ) AS precision_difference,

    DAYNAME(record_date)
        AS day_name,

    LENGTH(emp_name)
        AS name_length,

    CASE

        WHEN ABS(
                ROUND(salary,2) -
                TRUNCATE(salary,2)
             ) > 0.01
            THEN 'Precision Loss'

        ELSE 'Safe'

    END AS precision_status

FROM salary_precision;



-- =========================================================
-- QUESTION 24 – Salary Growth Power Index
-- =========================================================

-- Question
-- For each employee:
-- • Calculate years since last hike
-- • Apply POWER using growth_rate and years
-- • Round projected salary
-- • Uppercase emp_name
-- • CASE:
--    o Explosive Growth if projected > 150000
--    o Controlled
--    o Stagnant

SELECT

    emp_id,

    UPPER(emp_name)
        AS employee_name,

    TIMESTAMPDIFF(
        YEAR,
        last_hike,
        CURDATE()
    ) AS years_since_hike,

    ROUND(
        base_salary *
        POWER(
            growth_rate,
            TIMESTAMPDIFF(
                YEAR,
                last_hike,
                CURDATE()
            )
        )
    ) AS projected_salary,

    CASE

        WHEN ROUND(
                base_salary *
                POWER(
                    growth_rate,
                    TIMESTAMPDIFF(
                        YEAR,
                        last_hike,
                        CURDATE()
                    )
                )
             ) > 150000
            THEN 'Explosive Growth'

        WHEN ROUND(
                base_salary *
                POWER(
                    growth_rate,
                    TIMESTAMPDIFF(
                        YEAR,
                        last_hike,
                        CURDATE()
                    )
                )
             ) BETWEEN 100000 AND 150000
            THEN 'Controlled'

        ELSE 'Stagnant'

    END AS growth_status

FROM salary_growth;



-- =========================================================
-- QUESTION 25 – Salary Symmetry Check
-- =========================================================

-- Question
-- For each record:
-- • Remove decimals from salary
-- • Reverse salary digits
-- • Extract weekday
-- • Proper case emp_name
-- • CASE:
--    o Symmetric Pay if reversed equals original
--    o Asymmetric

SELECT

    emp_id,

    CONCAT(
        UPPER(LEFT(emp_name,1)),
        LOWER(SUBSTRING(emp_name,2))
    ) AS proper_name,

    TRUNCATE(salary,0)
        AS integer_salary,

    REVERSE(TRUNCATE(salary,0))
        AS reversed_salary,

    DAYNAME(processed_date)
        AS weekday_name,

    CASE

        WHEN TRUNCATE(salary,0) =
             REVERSE(TRUNCATE(salary,0))
            THEN 'Symmetric Pay'

        ELSE 'Asymmetric'

    END AS symmetry_status

FROM salary_symmetry;



-- =========================================================
-- QUESTION 26 – Leap Year Salary Adjustment Audit
-- =========================================================

-- Question
-- For each employee:
-- • Extract year
-- • Check leap year logic
-- • CEIL salary
-- • Calculate day of year
-- • CASE:
--    o Leap Credit
--    o Non-Leap Credit

SELECT

    emp_id,

    YEAR(credit_date)
        AS credit_year,

    CEIL(salary)
        AS ceil_salary,

    DAYOFYEAR(credit_date)
        AS day_of_year,

    CASE

        WHEN (
            (YEAR(credit_date) % 4 = 0
             AND YEAR(credit_date) % 100 != 0)
             OR YEAR(credit_date) % 400 = 0
        )
        THEN 'Leap Credit'

        ELSE 'Non-Leap Credit'

    END AS leap_status

FROM leap_salary;

-- =========================================================
-- QUESTION 27 – Fiscal Year Boundary Salary Check
-- =========================================================

-- Question
-- For each record:
-- • Determine fiscal year
-- • Extract month
-- • Format salary
-- • Lowercase emp_name
-- • CASE:
--    o Year End Credit
--    o Year Start Credit
--    o Mid Year

SELECT

    emp_id,

    LOWER(emp_name)
        AS employee_name,

    CASE

        WHEN MONTH(credit_date) >= 4
            THEN CONCAT(
                    YEAR(credit_date),
                    '-',
                    YEAR(credit_date)+1
                 )

        ELSE CONCAT(
                YEAR(credit_date)-1,
                '-',
                YEAR(credit_date)
             )

    END AS fiscal_year,

    MONTHNAME(credit_date)
        AS month_name,

    FORMAT(salary,2)
        AS formatted_salary,

    CASE

        WHEN MONTH(credit_date)=3
             AND DAY(credit_date)>=29
            THEN 'Year End Credit'

        WHEN MONTH(credit_date)=4
             AND DAY(credit_date)<=5
            THEN 'Year Start Credit'

        ELSE 'Mid Year'

    END AS fiscal_status

FROM fiscal_salary;



-- =========================================================
-- QUESTION 28 – Salary Random Sampling for Audit
-- =========================================================

-- Question
-- For each record:
-- • Generate random value
-- • Round salary
-- • Extract day name
-- • Extract first character of emp_name
-- • CASE:
--    o Sampled if RAND() > 0.7
--    o Skipped

SELECT

    emp_id,

    ROUND(RAND(),2)
        AS random_value,

    ROUND(salary)
        AS rounded_salary,

    DAYNAME(record_date)
        AS day_name,

    LEFT(emp_name,1)
        AS first_character,

    CASE

        WHEN RAND() > 0.7
            THEN 'Sampled'

        ELSE 'Skipped'

    END AS audit_status

FROM salary_sampling;



-- =========================================================
-- QUESTION 29 – Salary ASCII Integrity Check
-- =========================================================

-- Question
-- For each employee:
-- • Extract ASCII value of first character
-- • Calculate years since joining
-- • Floor salary
-- • Compare ASCII vs years
-- • CASE:
--    o Name Dominates
--    o Experience Dominates

SELECT

    emp_id,

    ASCII(
        LEFT(emp_name,1)
    ) AS ascii_value,

    TIMESTAMPDIFF(
        YEAR,
        join_date,
        CURDATE()
    ) AS years_since_joining,

    FLOOR(salary)
        AS floor_salary,

    CASE

        WHEN ASCII(
                LEFT(emp_name,1)
             ) >
             TIMESTAMPDIFF(
                YEAR,
                join_date,
                CURDATE()
             )
            THEN 'Name Dominates'

        ELSE 'Experience Dominates'

    END AS integrity_status

FROM salary_ascii;



-- =========================================================
-- QUESTION 30 – Salary vs Calendar Symmetry Logic
-- =========================================================

-- Question
-- For each record:
-- • Extract day and month
-- • Extract last two digits of salary
-- • Uppercase emp_name
-- • Absolute difference between day and month
-- • CASE:
--    o Calendar Match if day = month
--      OR salary digits match
--    o Calendar Drift

SELECT

    emp_id,

    UPPER(emp_name)
        AS employee_name,

    DAY(credit_date)
        AS credit_day,

    MONTH(credit_date)
        AS credit_month,

    RIGHT(
        TRUNCATE(salary,0),
        2
    ) AS last_two_digits,

    ABS(
        DAY(credit_date) -
        MONTH(credit_date)
    ) AS day_month_difference,

    CASE

        WHEN DAY(credit_date)=MONTH(credit_date)
             OR RIGHT(
                    TRUNCATE(salary,0),
                    2
                ) = LPAD(
                        MONTH(credit_date),
                        2,
                        '0'
                    )
            THEN 'Calendar Match'

        ELSE 'Calendar Drift'

    END AS calendar_status

FROM salary_calendar;

-- =========================================================
-- QUESTION 31 – Employee Login Discipline & Performance Classification
-- =========================================================

-- Question
-- For each employee:
-- • Convert emp_name to proper case
-- • Identify whether login date is Weekday or Weekend
-- • Calculate total working hours (logout – login)
-- • Round working hours to 2 decimals
-- • Use CASE:
--    o Good Performer if weekday AND working hours ≥ 8
--    o Bad Performer if weekday AND working hours < 6
--    o Weekend Login otherwise

SELECT

    emp_id,

    CONCAT(
        UPPER(LEFT(emp_name,1)),
        LOWER(SUBSTRING(emp_name,2))
    ) AS proper_name,

    CASE

        WHEN DAYNAME(login_time)
             IN ('Saturday','Sunday')
            THEN 'Weekend'

        ELSE 'Weekday'

    END AS login_day_type,

    ROUND(
        TIMESTAMPDIFF(
            MINUTE,
            login_time,
            logout_time
        ) / 60,
        2
    ) AS working_hours,

    CASE

        WHEN DAYNAME(login_time)
             NOT IN ('Saturday','Sunday')
             AND (
                 TIMESTAMPDIFF(
                    MINUTE,
                    login_time,
                    logout_time
                 ) / 60
             ) >= 8
            THEN 'Good Performer'

        WHEN DAYNAME(login_time)
             NOT IN ('Saturday','Sunday')
             AND (
                 TIMESTAMPDIFF(
                    MINUTE,
                    login_time,
                    logout_time
                 ) / 60
             ) < 6
            THEN 'Bad Performer'

        ELSE 'Weekend Login'

    END AS performance_status

FROM employee_login;



-- =========================================================
-- QUESTION 32 – Past 7 Days Attendance & Productivity Check
-- =========================================================

-- Question
-- For each record:
-- • Uppercase employee name
-- • Check if login_date falls within last 7 days from today
-- • Identify Weekday / Weekend
-- • Calculate working hours using TIMEDIFF
-- • Use CASE:
--    o Active & Productive if last 7 days AND hours ≥ 8
--    o Active but Low Hours if last 7 days AND hours < 8
--    o Absent from Last 7 Days

SELECT

    emp_id,

    UPPER(emp_name)
        AS employee_name,

    CASE

        WHEN login_date >= CURDATE() - INTERVAL 7 DAY
            THEN 'Within Last 7 Days'

        ELSE 'Old Record'

    END AS attendance_status,

    CASE

        WHEN DAYNAME(login_date)
             IN ('Saturday','Sunday')
            THEN 'Weekend'

        ELSE 'Weekday'

    END AS day_type,

    TIME_TO_SEC(
        TIMEDIFF(
            logout_time,
            login_time
        )
    ) / 3600 AS working_hours,

    CASE

        WHEN login_date >= CURDATE() - INTERVAL 7 DAY
             AND (
                 TIME_TO_SEC(
                    TIMEDIFF(
                        logout_time,
                        login_time
                    )
                 ) / 3600
             ) >= 8
            THEN 'Active & Productive'

        WHEN login_date >= CURDATE() - INTERVAL 7 DAY
             AND (
                 TIME_TO_SEC(
                    TIMEDIFF(
                        logout_time,
                        login_time
                    )
                 ) / 3600
             ) < 8
            THEN 'Active but Low Hours'

        ELSE 'Absent from Last 7 Days'

    END AS productivity_status

FROM attendance_log;



-- =========================================================
-- QUESTION 33 – Weekend Work Abuse Detection
-- =========================================================

-- Question
-- For each employee:
-- • Extract day name from work_date
-- • Lowercase employee name
-- • Calculate working hours
-- • Apply CEIL on hours
-- • Use CASE:
--    o Weekend Overtime if Saturday/Sunday AND hours ≥ 8
--    o Suspicious Login if weekend AND hours < 4
--    o Normal Working Day

SELECT

    emp_id,

    LOWER(emp_name)
        AS employee_name,

    DAYNAME(work_date)
        AS day_name,

    CEIL(
        TIME_TO_SEC(
            TIMEDIFF(
                logout_time,
                login_time
            )
        ) / 3600
    ) AS working_hours,

    CASE

        WHEN DAYNAME(work_date)
             IN ('Saturday','Sunday')
             AND (
                 TIME_TO_SEC(
                    TIMEDIFF(
                        logout_time,
                        login_time
                    )
                 ) / 3600
             ) >= 8
            THEN 'Weekend Overtime'

        WHEN DAYNAME(work_date)
             IN ('Saturday','Sunday')
             AND (
                 TIME_TO_SEC(
                    TIMEDIFF(
                        logout_time,
                        login_time
                    )
                 ) / 3600
             ) < 4
            THEN 'Suspicious Login'

        ELSE 'Normal Working Day'

    END AS work_status

FROM weekend_monitor;



-- =========================================================
-- QUESTION 34 – Login Time Deviation & Discipline Score
-- =========================================================

-- Question
-- For each employee:
-- • Extract login hour
-- • Calculate total working hours
-- • Truncate working hours to 1 decimal
-- • Get weekday name
-- • Use CASE:
--    o Disciplined if weekday AND login before 9 AND hours ≥ 8
--    o Late Comer if weekday AND login after 10
--    o Poor Discipline otherwise

SELECT

    emp_id,

    HOUR(login_datetime)
        AS login_hour,

    TRUNCATE(
        TIMESTAMPDIFF(
            MINUTE,
            login_datetime,
            logout_datetime
        ) / 60,
        1
    ) AS working_hours,

    DAYNAME(login_datetime)
        AS weekday_name,

    CASE

        WHEN DAYNAME(login_datetime)
             NOT IN ('Saturday','Sunday')
             AND HOUR(login_datetime) < 9
             AND (
                 TIMESTAMPDIFF(
                    MINUTE,
                    login_datetime,
                    logout_datetime
                 ) / 60
             ) >= 8
            THEN 'Disciplined'

        WHEN DAYNAME(login_datetime)
             NOT IN ('Saturday','Sunday')
             AND HOUR(login_datetime) > 10
            THEN 'Late Comer'

        ELSE 'Poor Discipline'

    END AS discipline_status

FROM login_discipline;



-- =========================================================
-- QUESTION 35 – Absenteeism vs Performance Correlation
-- =========================================================

-- Question
-- For each record:
-- • Identify whether work_date is within last 7 days
-- • Identify weekday or weekend
-- • Calculate total hours worked
-- • Apply FLOOR to hours
-- • Use CASE:
--    o Consistent Performer if last 7 days
--      AND weekday AND hours ≥ 8
--    o Irregular Performer if hours < 6
--    o Absent / Old Record

SELECT

    emp_id,

    CASE

        WHEN work_date >= CURDATE() - INTERVAL 7 DAY
            THEN 'Recent Record'

        ELSE 'Old Record'

    END AS record_status,

    CASE

        WHEN DAYNAME(work_date)
             IN ('Saturday','Sunday')
            THEN 'Weekend'

        ELSE 'Weekday'

    END AS day_type,

    FLOOR(
        TIME_TO_SEC(
            TIMEDIFF(
                logout_time,
                login_time
            )
        ) / 3600
    ) AS total_hours,

    CASE

        WHEN work_date >= CURDATE() - INTERVAL 7 DAY
             AND DAYNAME(work_date)
                 NOT IN ('Saturday','Sunday')
             AND (
                 TIME_TO_SEC(
                    TIMEDIFF(
                        logout_time,
                        login_time
                    )
                 ) / 3600
             ) >= 8
            THEN 'Consistent Performer'

        WHEN (
                TIME_TO_SEC(
                    TIMEDIFF(
                        logout_time,
                        login_time
                    )
                ) / 3600
             ) < 6
            THEN 'Irregular Performer'

        ELSE 'Absent / Old Record'

    END AS performance_status

FROM performance_tracker;
