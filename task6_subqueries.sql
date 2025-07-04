CREATE DATABASE IF NOT EXISTS task6_db;
USE task6_db;
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    salary INT
);

CREATE TABLE departments (
    department VARCHAR(50),
    location VARCHAR(50)
    );
    INSERT INTO employees (emp_id, name, department, salary) VALUES
(1, 'Raj', 'HR', 40000),
(2, 'Priya', 'IT', 70000),
(3, 'Kiran', 'IT', 60000),
(4, 'Sneha', 'HR', 45000),
(5, 'Arjun', 'Finance', 50000);

INSERT INTO departments (department, location) VALUES
('HR', 'Delhi'),
('IT', 'Bangalore'),
('Finance', 'Mumbai');
SELECT * FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);
SELECT name, salary,
       (SELECT AVG(salary) FROM employees) AS average_salary
FROM employees;
SELECT department, AVG(salary) AS avg_salary
FROM (
    SELECT * FROM employees
) AS sub
GROUP BY department;
SELECT * FROM employees
WHERE department IN (SELECT department FROM departments);
SELECT DISTINCT d.department
FROM departments d
WHERE EXISTS (
    SELECT 1
    FROM employees e
    WHERE e.department = d.department
);
SELECT e1.name, e1.department, e1.salary
FROM employees e1
WHERE e1.salary > (
    SELECT AVG(e2.salary)
    FROM employees e2
    WHERE e1.department = e2.department
);
-- Employees with salary above average
SELECT * FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

