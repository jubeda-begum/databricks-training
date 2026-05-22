-- =========================================================
-- QUESTION 1
-- TABLE + INSERTION
-- =========================================================

CREATE TABLE employee_payments (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(30),
    base_salary DECIMAL(10,2),
    bonus DECIMAL(10,2),
    joining_date DATE
);

INSERT INTO employee_payments VALUES

(1,'karthik','Data',75000.75,5000.50,'2019-03-15'),

(2,'veena','HR',65000.40,4000.25,'2021-06-20'),

(3,'ravi','Data',85000.90,6000.75,'2016-01-10'),

(4,'anil','Finance',70000.10,NULL,'2020-09-01'),

(5,'suresh','HR',60000.55,3000.30,'2022-11-25');



-- =========================================================
-- QUESTION 2
-- TABLE + INSERTION
-- =========================================================

CREATE TABLE orders_delivery (
    order_id INT,
    customer_name VARCHAR(50),
    order_date DATE,
    delivery_date DATE,
    order_amount DECIMAL(10,2)
);

INSERT INTO orders_delivery VALUES

(101,'rajesh','2025-01-01','2025-01-05',12500.75),

(102,'meena','2025-01-10','2025-01-10',8400.40),

(103,'arun','2025-01-15','2025-01-20',15600.90),

(104,'pooja','2025-01-18',NULL,9200.10);



-- =========================================================
-- QUESTION 3
-- TABLE + INSERTION
-- =========================================================

CREATE TABLE customer_spending (
    cust_id INT,
    cust_name VARCHAR(50),
    city VARCHAR(30),
    purchase_amount DECIMAL(10,2),
    purchase_date DATE
);

INSERT INTO customer_spending VALUES

(1,'amit','mumbai',12000.75,'2024-12-01'),

(2,'neha','delhi',8500.40,'2024-12-15'),

(3,'rohit','mumbai',15500.90,'2024-11-20'),

(4,'kavya','chennai',6000.10,'2024-10-05');



-- =========================================================
-- QUESTION 4
-- TABLE + INSERTION
-- =========================================================

CREATE TABLE subscriptions (
    user_id INT,
    user_email VARCHAR(100),
    start_date DATE,
    end_date DATE,
    subscription_fee DECIMAL(10,2)
);

INSERT INTO subscriptions VALUES

(1,'karthik@gmail.com','2024-01-01','2025-01-01',12000.50),

(2,'veena@yahoo.com','2024-06-15','2024-12-15',8500.75),

(3,'ravi@hotmail.com','2023-03-01','2024-03-01',15000.90);



-- =========================================================
-- QUESTION 5
-- TABLE + INSERTION
-- =========================================================

CREATE TABLE loan_details (
    loan_id INT,
    customer_name VARCHAR(50),
    loan_amount DECIMAL(12,2),
    interest_rate DECIMAL(5,2),
    loan_start DATE
);

INSERT INTO loan_details VALUES

(201,'suresh',500000.75,8.5,'2022-01-10'),

(202,'mahesh',750000.40,9.2,'2021-05-20'),

(203,'anita',300000.90,7.8,'2023-07-01');



-- =========================================================
-- QUESTION 6
-- TABLE + INSERTION
-- =========================================================

CREATE TABLE attendance (
    emp_id INT,
    emp_name VARCHAR(50),
    total_days INT,
    present_days INT,
    record_date DATE
);

INSERT INTO attendance VALUES

(1,'karthik',30,28,'2025-01-31'),

(2,'veena',30,22,'2025-01-31'),

(3,'ravi',30,18,'2025-01-31');



-- =========================================================
-- QUESTION 7
-- TABLE + INSERTION
-- =========================================================

CREATE TABLE product_sales (
    product_id INT,
    product_name VARCHAR(50),
    mrp DECIMAL(10,2),
    selling_price DECIMAL(10,2),
    sale_date DATE
);

INSERT INTO product_sales VALUES

(1,'Laptop',75000.75,68000.50,'2025-01-10'),

(2,'Mobile',35000.40,33000.25,'2025-01-12'),

(3,'Tablet',25000.90,26000.75,'2025-01-15');



-- =========================================================
-- QUESTION 8
-- TABLE + INSERTION
-- =========================================================

CREATE TABLE insurance_policies (
    policy_id INT,
    holder_name VARCHAR(50),
    premium_amount DECIMAL(10,2),
    policy_start DATE,
    policy_end DATE
);

INSERT INTO insurance_policies VALUES

(301,'arjun',12000.50,'2023-01-01','2026-01-01'),

(302,'megha',8500.75,'2022-06-15','2025-06-15'),

(303,'vinod',15000.90,'2021-03-01','2024-03-01');



-- =========================================================
-- QUESTION 9
-- TABLE + INSERTION
-- =========================================================

CREATE TABLE salary_revision (
    emp_id INT,
    emp_name VARCHAR(50),
    current_salary DECIMAL(10,2),
    rating INT,
    last_hike DATE
);

INSERT INTO salary_revision VALUES

(1,'karthik',75000.75,5,'2023-01-01'),

(2,'veena',65000.40,4,'2024-01-01'),

(3,'ravi',85000.90,3,'2022-01-01');



-- =========================================================
-- QUESTION 10
-- TABLE + INSERTION
-- =========================================================

CREATE TABLE bank_accounts (
    account_id INT,
    customer_name VARCHAR(50),
    balance DECIMAL(12,2),
    last_transaction DATE,
    branch VARCHAR(30)
);

INSERT INTO bank_accounts VALUES

(501,'ramesh',125000.75,'2024-12-20','hyderabad'),

(502,'sita',8500.40,'2023-06-15','delhi'),

(503,'manoj',-2500.90,'2025-01-05','mumbai');

-- =========================================================
-- QUESTION 11
-- =========================================================

CREATE TABLE salary_audit (

    emp_id INT,

    emp_name VARCHAR(50),

    salary DECIMAL(10,2),

    tax_percent DECIMAL(5,2),

    last_revision DATE

);

INSERT INTO salary_audit VALUES

(1,'karthik',75000.75,10.5,'2022-01-15'),

(2,'veena',65000.40,18.0,'2023-06-01'),

(3,'ravi',85000.90,25.0,'2020-11-20');



-- =========================================================
-- QUESTION 12
-- =========================================================

CREATE TABLE bonus_monitor (

    emp_code INT,

    emp_name VARCHAR(50),

    base_salary DECIMAL(10,2),

    bonus DECIMAL(10,2),

    bonus_date DATE

);

INSERT INTO bonus_monitor VALUES

(101,'Anil',70000.10,30000.00,'2025-01-10'),

(102,'Suresh',60000.55,3000.30,'2024-03-15'),

(103,'Ravi',85000.90,15000.75,'2023-12-01');



-- =========================================================
-- QUESTION 13
-- =========================================================

CREATE TABLE employee_experience (

    emp_id INT,

    emp_name VARCHAR(50),

    joining_date DATE,

    declared_experience INT,

    salary DECIMAL(10,2)

);

INSERT INTO employee_experience VALUES

(1,'Veena','2018-07-01',4,65000.40),

(2,'Ravi','2014-01-10',12,85000.90),

(3,'Anil','2020-09-01',3,70000.10);



-- =========================================================
-- QUESTION 14
-- =========================================================

CREATE TABLE salary_digits (

    emp_id INT,

    emp_name VARCHAR(50),

    salary DECIMAL(10,2),

    credit_date DATE

);

INSERT INTO salary_digits VALUES

(1,'Karthik',75000.75,'2025-01-01'),

(2,'Veena',65000.40,'2025-01-02'),

(3,'Suresh',60000.55,'2025-01-03');



-- =========================================================
-- QUESTION 15
-- =========================================================

CREATE TABLE payroll_control (

    emp_id INT,

    emp_name VARCHAR(50),

    salary DECIMAL(10,2),

    payment_date DATE

);

INSERT INTO payroll_control VALUES

(1,'Ravi',85000.90,'2025-01-15'),

(2,'Anil',70000.10,'2025-01-16'),

(3,'Veena',65000.40,'2025-01-17');



-- =========================================================
-- QUESTION 16
-- =========================================================

CREATE TABLE inflation_watch (

    emp_id INT,

    emp_name VARCHAR(50),

    salary DECIMAL(10,2),

    last_hike DATE

);

INSERT INTO inflation_watch VALUES

(1,'Karthik',75000.75,'2019-01-01'),

(2,'Veena',65000.40,'2022-01-01'),

(3,'Ravi',85000.90,'2017-01-01');



-- =========================================================
-- QUESTION 17
-- =========================================================

CREATE TABLE salary_integrity (

    emp_id INT,

    emp_name VARCHAR(50),

    salary DECIMAL(10,2),

    record_date DATE

);

INSERT INTO salary_integrity VALUES

(1,'Anil',-70000.10,'2025-01-10'),

(2,'Veena',65000.40,'2025-01-10'),

(3,'Ravi',0.00,'2025-01-10');



-- =========================================================
-- QUESTION 18
-- =========================================================

CREATE TABLE name_salary (

    emp_id INT,

    emp_name VARCHAR(50),

    salary DECIMAL(10,2),

    join_date DATE

);

INSERT INTO name_salary VALUES

(1,'Karthik',75000.75,'2019-03-15'),

(2,'Veena',65000.40,'2021-06-20'),

(3,'Ravi',85000.90,'2016-01-10');



-- =========================================================
-- QUESTION 19
-- =========================================================

CREATE TABLE salary_monthly (

    emp_id INT,

    emp_name VARCHAR(50),

    salary DECIMAL(10,2),

    paid_date DATE

);

INSERT INTO salary_monthly VALUES

(1,'Karthik',75000.75,'2025-01-31'),

(2,'Veena',65000.40,'2025-02-28'),

(3,'Ravi',85000.90,'2025-03-31');



-- =========================================================
-- QUESTION 20
-- =========================================================

CREATE TABLE digit_audit (

    emp_id INT,

    emp_name VARCHAR(50),

    salary DECIMAL(10,2),

    audit_date DATE

);

INSERT INTO digit_audit VALUES

(1,'Anil',70000.10,'2025-01-01'),

(2,'Veena',65000.40,'2025-01-02');

-- =========================================================
-- ALL SCHEMAS + INSERTIONS (QUESTION 11 TO QUESTION 16)
-- =========================================================


-- =========================================================
-- QUESTION 21
-- =========================================================

CREATE TABLE salary_credit_audit (

    emp_id INT,

    emp_name VARCHAR(50),

    salary DECIMAL(10,2),

    credit_date DATE,

    bank_code VARCHAR(10)

);

INSERT INTO salary_credit_audit VALUES

(1,'Karthik',75000.75,'2025-01-04','HDFC01'),

(2,'Veena',65000.40,'2025-01-06','ICIC02'),

(3,'Ravi',85000.90,'2025-01-05','SBIN03'),

(4,'Anil',70000.10,'2025-01-07','AXIS04'),

(5,'Suresh',60000.55,'2025-01-11','HDFC01');



-- =========================================================
-- QUESTION 22
-- =========================================================

CREATE TABLE salary_time_drift (

    emp_id INT,

    emp_name VARCHAR(50),

    salary DECIMAL(10,2),

    credit_ts DATETIME

);

INSERT INTO salary_time_drift VALUES

(1,'Karthik',75000.75,'2025-01-10 23:45:00'),

(2,'Veena',65000.40,'2025-01-10 09:15:00'),

(3,'Ravi',85000.90,'2025-01-11 00:10:00'),

(4,'Anil',70000.10,'2025-01-09 18:30:00'),

(5,'Suresh',60000.55,'2025-01-10 02:50:00');



-- =========================================================
-- QUESTION 23
-- =========================================================

CREATE TABLE salary_precision (

    emp_id INT,

    emp_name VARCHAR(50),

    salary DECIMAL(10,4),

    record_date DATE

);

INSERT INTO salary_precision VALUES

(1,'Karthik',75000.7567,'2025-01-01'),

(2,'Veena',65000.4044,'2025-01-02'),

(3,'Ravi',85000.9099,'2025-01-03'),

(4,'Anil',70000.1001,'2025-01-04'),

(5,'Suresh',60000.5555,'2025-01-05');



-- =========================================================
-- QUESTION 24
-- =========================================================

CREATE TABLE salary_growth (

    emp_id INT,

    emp_name VARCHAR(50),

    base_salary DECIMAL(10,2),

    growth_rate DECIMAL(5,2),

    last_hike DATE

);

INSERT INTO salary_growth VALUES

(1,'Karthik',75000.75,1.08,'2019-01-01'),

(2,'Veena',65000.40,1.05,'2021-01-01'),

(3,'Ravi',85000.90,1.12,'2017-01-01'),

(4,'Anil',70000.10,1.03,'2022-01-01'),

(5,'Suresh',60000.55,1.06,'2020-01-01');



-- =========================================================
-- QUESTION 25
-- =========================================================

CREATE TABLE salary_symmetry (

    emp_id INT,

    emp_name VARCHAR(50),

    salary DECIMAL(10,2),

    processed_date DATE

);

INSERT INTO salary_symmetry VALUES

(1,'Karthik',75557.75,'2025-01-15'),

(2,'Veena',64446.40,'2025-01-16'),

(3,'Ravi',85858.90,'2025-01-17'),

(4,'Anil',70007.10,'2025-01-18'),

(5,'Suresh',60000.55,'2025-01-19');



-- =========================================================
-- QUESTION 26
-- =========================================================

CREATE TABLE leap_salary (

    emp_id INT,

    emp_name VARCHAR(50),

    salary DECIMAL(10,2),

    credit_date DATE

);

INSERT INTO leap_salary VALUES

(1,'Karthik',75000.75,'2024-02-29'),

(2,'Veena',65000.40,'2025-02-28'),

(3,'Ravi',85000.90,'2020-02-29'),

(4,'Anil',70000.10,'2023-02-28'),

(5,'Suresh',60000.55,'2024-02-28');

-- =========================================================
-- QUESTION 27
-- =========================================================

CREATE TABLE fiscal_salary (

    emp_id INT,

    emp_name VARCHAR(50),

    salary DECIMAL(10,2),

    credit_date DATE

);

INSERT INTO fiscal_salary VALUES

(1,'Karthik',75000.75,'2025-03-31'),

(2,'Veena',65000.40,'2025-04-01'),

(3,'Ravi',85000.90,'2024-03-30'),

(4,'Anil',70000.10,'2024-04-02'),

(5,'Suresh',60000.55,'2025-03-29');



-- =========================================================
-- QUESTION 28
-- =========================================================

CREATE TABLE salary_sampling (

    emp_id INT,

    emp_name VARCHAR(50),

    salary DECIMAL(10,2),

    record_date DATE

);

INSERT INTO salary_sampling VALUES

(1,'Karthik',75000.75,'2025-01-01'),

(2,'Veena',65000.40,'2025-01-02'),

(3,'Ravi',85000.90,'2025-01-03'),

(4,'Anil',70000.10,'2025-01-04'),

(5,'Suresh',60000.55,'2025-01-05'),

(6,'Amit',72000.60,'2025-01-06'),

(7,'Neha',68000.80,'2025-01-07');



-- =========================================================
-- QUESTION 29
-- =========================================================

CREATE TABLE salary_ascii (

    emp_id INT,

    emp_name VARCHAR(50),

    salary DECIMAL(10,2),

    join_date DATE

);

INSERT INTO salary_ascii VALUES

(1,'Karthik',75000.75,'2019-03-15'),

(2,'Veena',65000.40,'2021-06-20'),

(3,'Ravi',85000.90,'2016-01-10'),

(4,'Anil',70000.10,'2020-09-01'),

(5,'Suresh',60000.55,'2022-11-25');



-- =========================================================
-- QUESTION 30
-- =========================================================

CREATE TABLE salary_calendar (

    emp_id INT,

    emp_name VARCHAR(50),

    salary DECIMAL(10,2),

    credit_date DATE

);

INSERT INTO salary_calendar VALUES

(1,'Karthik',75000.75,'2025-01-15'),

(2,'Veena',65000.40,'2025-02-14'),

(3,'Ravi',85000.90,'2025-03-31'),

(4,'Anil',70000.10,'2025-04-04'),

(5,'Suresh',60000.55,'2025-05-05');

-- =========================================================
-- QUESTION 31
-- =========================================================

CREATE TABLE employee_login (

    emp_id INT,

    emp_name VARCHAR(50),

    login_time DATETIME,

    logout_time DATETIME

);

INSERT INTO employee_login VALUES

(1,'Karthik','2025-01-15 09:05:00','2025-01-15 18:10:00'),

(2,'Veena','2025-01-14 10:30:00','2025-01-14 16:00:00'),

(3,'Ravi','2025-01-13 09:00:00','2025-01-13 20:00:00'),

(4,'Anil','2025-01-12 11:00:00','2025-01-12 14:00:00'),

(5,'Suresh','2025-01-11 09:15:00','2025-01-11 17:00:00');



-- =========================================================
-- QUESTION 32
-- =========================================================

CREATE TABLE attendance_log (

    emp_id INT,

    emp_name VARCHAR(50),

    login_date DATE,

    login_time TIME,

    logout_time TIME

);

INSERT INTO attendance_log VALUES

(1,'Karthik','2025-01-14','09:00:00','18:00:00'),

(2,'Karthik','2025-01-13','09:15:00','17:30:00'),

(3,'Veena','2025-01-12','10:00:00','15:00:00'),

(4,'Ravi','2025-01-10','09:00:00','19:00:00'),

(5,'Anil','2025-01-08','11:00:00','14:00:00');



-- =========================================================
-- QUESTION 33
-- =========================================================

CREATE TABLE weekend_monitor (

    emp_id INT,

    emp_name VARCHAR(50),

    work_date DATE,

    login_time TIME,

    logout_time TIME

);

INSERT INTO weekend_monitor VALUES

(1,'Ravi','2025-01-11','09:00:00','21:00:00'),

(2,'Veena','2025-01-12','10:00:00','13:00:00'),

(3,'Karthik','2025-01-10','09:00:00','18:00:00'),

(4,'Anil','2025-01-09','11:00:00','14:00:00');



-- =========================================================
-- QUESTION 34
-- =========================================================

CREATE TABLE login_discipline (

    emp_id INT,

    emp_name VARCHAR(50),

    login_datetime DATETIME,

    logout_datetime DATETIME

);

INSERT INTO login_discipline VALUES

(1,'Karthik','2025-01-15 08:55:00','2025-01-15 18:10:00'),

(2,'Veena','2025-01-15 10:45:00','2025-01-15 16:00:00'),

(3,'Ravi','2025-01-15 09:00:00','2025-01-15 20:30:00'),

(4,'Anil','2025-01-15 11:30:00','2025-01-15 14:00:00');



-- =========================================================
-- QUESTION 35
-- =========================================================

CREATE TABLE performance_tracker (

    emp_id INT,

    emp_name VARCHAR(50),

    work_date DATE,

    login_time TIME,

    logout_time TIME

);

INSERT INTO performance_tracker VALUES

(1,'Karthik','2025-01-09','09:00:00','18:00:00'),

(2,'Karthik','2025-01-10','09:10:00','17:50:00'),

(3,'Veena','2025-01-05','10:00:00','15:00:00'),

(4,'Ravi','2025-01-14','09:00:00','19:00:00'),

(5,'Anil','2025-01-03','11:00:00','14:00:00');
