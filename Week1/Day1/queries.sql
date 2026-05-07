-- **Basic Select Queries**

-- Query1: Select all columns from the Employee table
SELECT * FROM Employee;

-- Query2: Select only the name and salary columns
SELECT name, salary FROM Employee;

-- Query3: Select employees older than 30
SELECT * FROM Employee
WHERE age > 30;

-- Query4: Select all department names
SELECT * FROM Department;

-- Query5: Select employees working in the IT department
SELECT * FROM Employee WHERE department = 'IT';

--** String Matching Queries**

-- Query6: Employees whose names start with 'J'
SELECT * FROM Employee
WHERE name LIKE 'J%';

-- Query7: Employees whose names end with 'e'
SELECT * FROM Employee
WHERE name LIKE '%e';

-- Query8: Employees whose names contain 'a'
SELECT * FROM Employee
WHERE name LIKE '%a%';

-- Query9: Employees whose names are exactly 9 characters
SELECT * FROM Employee
WHERE name LIKE '_________';

-- Query10: Employees whose second character is 'o'
SELECT * FROM Employee
WHERE name LIKE '_o%';

-- **Date Queries**

-- Query11: Employees hired in 2020
SELECT * FROM Employee
WHERE YEAR(hire_date) = 2020;

-- Query12: Employees hired in January
SELECT * FROM Employee
WHERE MONTH(hire_date) = 1;

-- Query13: Employees hired before 2019
SELECT * FROM Employee
WHERE YEAR(hire_date) < 2019;

-- Query14: Employees hired on or after March 1, 2021
SELECT * FROM Employee
WHERE hire_date >= '2021-03-01';

-- Query15: Employees hired in the last 2 years
SELECT * FROM Employee
WHERE hire_date >= DATE_SUB(CURDATE(), INTERVAL 2 YEAR);


-- **Aggregate Queries**

-- Query16: Total salary of all employees
SELECT SUM(salary) AS total_salary
FROM Employee;

-- Query17: Average salary of employees
SELECT AVG(salary) AS average_salary
FROM Employee;

-- Query18: Minimum salary in Employee table
SELECT MIN(salary) AS minimum_salary
FROM Employee;

-- Query19: Number of employees in each department
SELECT department, COUNT(*) AS employee_count
FROM Employee
GROUP BY department;

-- Query20: Average salary in each department
SELECT department, AVG(salary) AS average_salary
FROM Employee
GROUP BY department;

-- Group By Queries

-- Query21: Select the total salary for each department
SELECT department_id, SUM(salary) AS total_salary
FROM Employee
GROUP BY department_id;

-- Query22: Select the average age of employees in each department
SELECT department_id, AVG(age) AS average_age
FROM Employee
GROUP BY department_id;

-- Query23: Select the number of employees hired in each year
SELECT YEAR(hire_date) AS hire_year, COUNT(*) AS total_employees
FROM Employee
GROUP BY YEAR(hire_date);

-- Query24: Select the highest salary in each department
SELECT department_id, MAX(salary) AS highest_salary
FROM Employee
GROUP BY department_id;

-- Query25: Select the department with the highest average salary
SELECT department_id, AVG(salary) AS average_salary
FROM Employee
GROUP BY department_id
ORDER BY average_salary DESC
LIMIT 1;


-- Having Queries

-- Query26: Select departments with more than 2 employees
SELECT department_id, COUNT(*) AS total_employees
FROM Employee
GROUP BY department_id
HAVING COUNT(*) > 2;

-- Query27: Select departments with an average salary greater than 55000
SELECT department_id, AVG(salary) AS average_salary
FROM Employee
GROUP BY department_id
HAVING AVG(salary) > 55000;

-- Query28: Select years with more than 1 employee hired
SELECT YEAR(hire_date) AS hire_year, COUNT(*) AS total_employees
FROM Employee
GROUP BY YEAR(hire_date)
HAVING COUNT(*) > 1;

-- Query29: Select departments with a total salary expense less than 100000
SELECT department_id, SUM(salary) AS total_salary
FROM Employee
GROUP BY department_id
HAVING SUM(salary) < 100000;

-- Query30: Select departments with the maximum salary above 75000
SELECT department_id, MAX(salary) AS max_salary
FROM Employee
GROUP BY department_id
HAVING MAX(salary) > 75000;


-- Order By Queries

-- Query31: Select all employees ordered by their salary in ascending order
SELECT *
FROM Employee
ORDER BY salary ASC;

-- Query32: Select all employees ordered by their age in descending order
SELECT *
FROM Employee
ORDER BY age DESC;

-- Query33: Select all employees ordered by their hire date in ascending order
SELECT *
FROM Employee
ORDER BY hire_date ASC;

-- Query34: Select employees ordered by their department and then by their salary
SELECT *
FROM Employee
ORDER BY department_id, salary;

-- Query35: Select departments ordered by the total salary of their employees
SELECT department_id, SUM(salary) AS total_salary
FROM Employee
GROUP BY department_id
ORDER BY total_salary DESC;


-- Join Queries

-- Query36: Select employee names along with their department names
SELECT e.emp_name, d.department_name
FROM Employee e
JOIN Department d
ON e.department_id = d.department_id;

-- Query37: Select project names along with the department names they belong to
SELECT p.project_name, d.department_name
FROM Project p
JOIN Department d
ON p.department_id = d.department_id;

-- Query38: Select employee names and their corresponding project names
SELECT e.emp_name, p.project_name
FROM Employee e
JOIN Project p
ON e.department_id = p.department_id;

-- Query39: Select all employees and their departments, including those without a department
SELECT e.emp_name, d.department_name
FROM Employee e
LEFT JOIN Department d
ON e.department_id = d.department_id;

-- Query40: Select all departments and their employees, including departments without employees
SELECT d.department_name, e.emp_name
FROM Department d
LEFT JOIN Employee e
ON d.department_id = e.department_id;

-- Query41: Select employees who are not assigned to any project
SELECT e.emp_name
FROM Employee e
LEFT JOIN Project p
ON e.department_id = p.department_id
WHERE p.project_id IS NULL;

-- Query42: Select employees and the number of projects their department is working on
SELECT e.emp_name, COUNT(p.project_id) AS total_projects
FROM Employee e
LEFT JOIN Project p
ON e.department_id = p.department_id
GROUP BY e.emp_name;

-- Query43: Select the departments that have no employees
SELECT d.department_name
FROM Department d
LEFT JOIN Employee e
ON d.department_id = e.department_id
WHERE e.emp_id IS NULL;

-- Query44: Select employee names who share the same department with 'John Doe'
SELECT emp_name
FROM Employee
WHERE department_id = (
    SELECT department_id
    FROM Employee
    WHERE emp_name = 'John Doe'
);

-- Query45: Select the department name with the highest average salary
SELECT d.department_name, AVG(e.salary) AS avg_salary
FROM Employee e
JOIN Department d
ON e.department_id = d.department_id
GROUP BY d.department_name
ORDER BY avg_salary DESC
LIMIT 1;


-- Nested and Correlated Queries

-- Query46: Select the employee with the highest salary
SELECT emp_name, salary
FROM Employee
WHERE salary = (
    SELECT MAX(salary)
    FROM Employee
);

-- Query47: Select employees whose salary is above the average salary
SELECT emp_name, salary
FROM Employee
WHERE salary > (
    SELECT AVG(salary)
    FROM Employee
);

-- Query48: Select the second highest salary from the Employee table
SELECT MAX(salary) AS second_highest_salary
FROM Employee
WHERE salary < (
    SELECT MAX(salary)
    FROM Employee
);

-- Query49: Select the department with the most employees
SELECT department_id, COUNT(*) AS total_employees
FROM Employee
GROUP BY department_id
ORDER BY total_employees DESC
LIMIT 1;

-- Query50: Select employees who earn more than the average salary of their department
SELECT emp_name, salary
FROM Employee e
WHERE salary > (
    SELECT AVG(salary)
    FROM Employee
    WHERE department_id = e.department_id
);
