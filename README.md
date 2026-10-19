# HR Analytics SQL Project

**By Shyam Singh**
MCA Student | Data Analyst | SQL | PostgreSQL | HR Analytics

---

## Project Overview

This project uses SQL and PostgreSQL to explore employee and performance data and answer practical Human Resources (HR) business questions. It practises querying relational data, joining tables, summarising workforce information, and investigating salary, performance, training, overtime, and employee exits.

> **Note:** This README describes the project and SQL techniques. Add numerical findings only after verifying them against the actual database.

---

## Dataset Structure

The project uses two related tables.

### 1. `employee`

| Column | Description |
|---|---|
| `Employee_ID` | Unique employee identifier (primary key) |
| `Gender` | Employee gender |
| `Age` | Employee age |
| `Department` | Department name |
| `Job_Role` | Employee job role |
| `Joining_Date` | Date the employee joined |
| `Salary` | Employee salary |
| `Experience_Years` | Years of experience |
| `Employment_Status` | Employment status |
| `Exit_Date` | Exit date, where applicable |

### 2. `ep` — Employee Performance

| Column | Description |
|---|---|
| `Performance_ID` | Unique performance review identifier (primary key) |
| `Employee_ID` | References `employee.Employee_ID` |
| `Review_Period` | Performance review period |
| `Performance_Rating` | Performance rating |
| `Job_Satisfaction` | Job satisfaction score |
| `Training_Hours` | Training hours recorded for the review |
| `Projects_Completed` | Projects completed |
| `Absence_Days` | Absence days recorded |
| `Overtime_Hours` | Overtime hours recorded |

**Relationship:** `employee.Employee_ID` → `ep.Employee_ID`. One employee can have multiple performance review records.

---

## Tools and Technologies

- PostgreSQL
- SQL
- pgAdmin or another PostgreSQL client

---

## SQL Concepts Practised

- `SELECT`, `WHERE`, `DISTINCT`, `BETWEEN`, `ORDER BY`, and `LIMIT`
- Aggregate functions: `COUNT`, `AVG`, `MIN`, `MAX`, and `SUM`
- `GROUP BY` and `HAVING`
- Conditional logic with `CASE WHEN`
- Date functions and employee tenure calculations
- `INNER JOIN` and `LEFT JOIN`
- Subqueries and comparisons against overall averages
- `ROUND` and percentage calculations
- `FILTER` with aggregate functions

---

## Business Questions Explored

### Basic Queries (SELECT, WHERE, ORDER BY, LIMIT)

1. Display all records from the employee table.
2. Display only `Employee_ID`, `Department`, `Job_Role`, and `Salary`.
3. Find all employees working in the IT department.
4. Find employees whose salary is greater than ₹50,000.
5. Display employees whose age is between 25 and 35.
6. Find employees who joined after 1 January 2024.
7. Display all unique department names.
8. Find employees whose employment status is Resigned.
9. Display the 10 employees with the highest salaries.
10. Find employees whose job role is Data Analyst and employment status is Active.

### Aggregate Functions and GROUP BY

11. Calculate the total number of employees.
12. Calculate the average salary of all employees.
13. Find the minimum and maximum salary.
14. Count employees in each department.
15. Calculate the average salary for each department.
16. Calculate the total salary expenditure for each department.
17. Count employees by employment status.
18. Calculate the average age of employees in each department.
19. Find the number of employees in each job role.
20. Display departments with more than 300 employees.

### CASE WHEN, Dates, and Attrition

21. Categorize employees into three age groups: Under 30 (Young), 30–40 (Mid-Career), Above 40 (Experienced).
22. Categorize salaries into three groups: Below ₹30,000 (Low), ₹30,000–₹60,000 (Medium), Above ₹60,000 (High).
23. Calculate employee tenure in years using `Joining_Date`.
24. Find employees who have an `Exit_Date`.
25. Calculate the percentage of employees who have left the organisation.
26. Find departments with an average salary greater than ₹40,000.

### Joins (INNER JOIN and LEFT JOIN)

27. Display employee IDs, departments, salaries, and performance ratings.
28. Display each employee's department and job satisfaction score.
29. Find employees whose performance rating is 5.
30. Calculate the average performance rating for each department.
31. Calculate the average job satisfaction score for each department.
32. Display employees who have more than one performance review.
33. Find employees who have never received a performance review.
34. Calculate the average training hours for each department.

### Subqueries and Advanced Analysis

35. Find the second-highest salary in the organisation.
36. Find employees earning more than the overall average salary.
37. Find the department with the highest average performance rating.
38. Identify employees whose performance rating is above the overall average rating.
39. Calculate the average overtime hours by department.

---

## Example SQL Queries

### Employee count by department

```sql
SELECT
    department,
    COUNT(employee_id) AS total_employees
FROM employee
GROUP BY department
ORDER BY total_employees DESC;
```

### Average salary by department

```sql
SELECT
    department,
    ROUND(AVG(salary)::NUMERIC, 2) AS average_salary
FROM employee
GROUP BY department
ORDER BY average_salary DESC;
```

### Department with the highest average performance rating

```sql
SELECT
    e.department,
    ROUND(AVG(ep.performance_rating)::NUMERIC, 2) AS avg_performance_rating
FROM employee AS e
INNER JOIN ep
    ON e.employee_id = ep.employee_id
GROUP BY e.department
ORDER BY avg_performance_rating DESC
LIMIT 1;
```

### Employees earning above the overall average salary

```sql
SELECT
    employee_id,
    salary
FROM employee
WHERE salary > (
    SELECT AVG(salary)
    FROM employee
);
```

### Employees with more than one performance review

```sql
SELECT
    employee_id,
    COUNT(performance_id) AS total_reviews
FROM ep
GROUP BY employee_id
HAVING COUNT(performance_id) > 1;
```

---

## Data and Interpretation Notes

- Verify metric values by running queries against the project database before publishing them.
- Former employees as a percentage of all employees in the dataset is not automatically the same as a standard annual attrition rate.
- Averages calculated from `ep` are generally review-record-level averages. If employees have different numbers of reviews, these can differ from employee-level averages.
- Use actual query outputs when adding conclusions, charts, or numerical findings.

---

## Skills Demonstrated

SQL querying · PostgreSQL · Data aggregation · Data filtering · Joins · Subqueries · Date analysis · HR metrics · Business-question analysis

---

👤 Author
Shyam Singh 🌐 Connect With Me

🌍**Portfolio:** [https://shyam-analyst.vercel.app](https://shyam-analyst.vercel.app)

💻 **GitHub:** [https://github.com/1m-shyam01](https://github.com/1m-shyam01)

🔗 LinkedIn: [https:linkedin.com/in/shyam-singh-190b7a2a6](https:linkedin.com/in/shyam-singh-190b7a2a6)
⭐ If you found this project useful, consider giving it a star!

---

*This project is part of my ongoing learning and practice in SQL and Data Analytics.*
