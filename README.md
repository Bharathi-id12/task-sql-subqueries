# task-sql-subqueries
 Sample Data Recap

employees table:

emp_id	name	department	salary

1	Raj	HR	40000
2	Priya	IT	70000
3	Kiran	IT	60000
4	Sneha	HR	45000
5	Arjun	Finance	50000


departments table:

department	location

HR	Delhi
IT	Bangalore
Finance	Mumbai



---

✅ Outputs of Each Query


---

1. Employees earning more than average salary

SELECT * FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

🔹 Average salary = (40000 + 70000 + 60000 + 45000 + 50000) / 5 = 53000

Output:

emp_id	name	department	salary

2	Priya	IT	70000
3	Kiran	IT	60000



---

2. Each employee with average salary of all

SELECT name, salary,
       (SELECT AVG(salary) FROM employees) AS average_salary
FROM employees;

Output:

name	salary	average_salary

Raj	40000	53000
Priya	70000	53000
Kiran	60000	53000
Sneha	45000	53000
Arjun	50000	53000



---

3. Average salary by department (using subquery in FROM)

SELECT department, AVG(salary) AS avg_salary
FROM (
    SELECT * FROM employees
) AS sub
GROUP BY department;

Output:

department	avg_salary

HR	42500
IT	65000
Finance	50000



---

4. Employees in departments listed in department table

SELECT * FROM employees
WHERE department IN (SELECT department FROM departments);

All departments in employees match the ones in departments.

Output:

emp_id	name	department	salary

1	Raj	HR	40000
2	Priya	IT	70000
3	Kiran	IT	60000
4	Sneha	HR	45000
5	Arjun	Finance	50000



---

5. Departments that have employees (EXISTS)

SELECT DISTINCT d.department
FROM departments d
WHERE EXISTS (
    SELECT 1
    FROM employees e
    WHERE e.department = d.department
);

All departments have at least one employee.

Output:

department

HR
IT
Finance



---

6. Employees earning more than department average (correlated subquery)

SELECT e1.name, e1.department, e1.salary
FROM employees e1
WHERE e1.salary > (
    SELECT AVG(e2.salary)
    FROM employees e2
    WHERE e1.department = e2.department
);

HR average: (40000 + 45000) / 2 = 42500 → Sneha > 42500 , Raj < 42500 

IT average: (70000 + 60000) / 2 = 65000 → Priya > 65000 

Finance average: 50000 → Arjun == 50000 


Output:

name	department	salary

Priya	IT	70000



