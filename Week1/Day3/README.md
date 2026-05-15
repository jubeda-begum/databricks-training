# SQL Joins Assignment

## Overview
This project demonstrates the use of SQL Joins in MySQL using a simple Online Learning Platform database.

The assignment focuses on:

- LEFT JOIN
- RIGHT JOIN
- FULL OUTER JOIN simulation
- CROSS JOIN
- Finding unmatched records
- Combining multiple tables

---

# Database Schema

The database contains the following tables:

1. students
2. instructors
3. courses
4. enrollments

---

# Tables Description

## 1. students
Stores student details.

| Column Name   | Data Type     | Description              |
|---------------|---------------|--------------------------|
| student_id    | INT           | Primary Key              |
| student_name  | VARCHAR(100)  | Student Name             |
| email         | VARCHAR(100)  | Student Email            |

---

## 2. instructors
Stores instructor details.

| Column Name      | Data Type     | Description          |
|------------------|---------------|----------------------|
| instructor_id    | INT           | Primary Key          |
| instructor_name  | VARCHAR(100)  | Instructor Name      |

---

## 3. courses
Stores course details.

| Column Name    | Data Type     | Description                    |
|----------------|---------------|--------------------------------|
| course_id      | INT           | Primary Key                    |
| course_name    | VARCHAR(100)  | Course Name                    |
| instructor_id  | INT           | Foreign Key from instructors   |

---

## 4. enrollments
Stores student enrollment details.

| Column Name      | Data Type | Description                 |
|------------------|-----------|-----------------------------|
| enrollment_id    | INT       | Primary Key                 |
| student_id       | INT       | Foreign Key from students   |
| course_id        | INT       | Foreign Key from courses    |
| enrollment_date  | DATE      | Enrollment Date             |

---

# Concepts Used

## LEFT JOIN
Returns all records from the left table and matching records from the right table.

## RIGHT JOIN
Returns all records from the right table and matching records from the left table.

## FULL OUTER JOIN
MySQL does not support FULL OUTER JOIN directly.

