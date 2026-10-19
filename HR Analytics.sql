CREATE TABLE employee(
	Employee_ID VARCHAR(20) PRIMARY KEY,
	Gender VARCHAR(20),
	Age INT,
	Department VARCHAR(50),
	Job_Role VARCHAR(50),
	Joining_Date DATE,
	Salary INT,
	Experience_Years INT,
	Employment_Status VARCHAR(20),
	Exit_Date DATE
);

CREATE TABLE ep (
    Performance_ID VARCHAR(15) PRIMARY KEY,
    Employee_ID VARCHAR(20) REFERENCES employee(Employee_ID),
    Review_Period VARCHAR(10),
    Performance_Rating INT,
    Job_Satisfaction INT,
    Training_Hours INT,
    Projects_Completed INT,
    Absence_Days INT,
    Overtime_Hours INT
);

--Display all records from the employees table
SELECT * FROM employee;
 
--Display only Employee_ID, Department, Job_Role, and Salary.
SELECT employee_id,department,job_role,salary FROM employee;

--Find all employees working in the IT department.
SELECT * FROM employee
WHERE department='IT';

--Find employees whose salary is greater than ₹50,000.
SELECT * FROM employee
WHERE salary >50000;

--Display employees whose age is between 25 and 35.
SELECT * FROM employee
WHERE age BETWEEN 25 AND 35;

--Find employees who joined after 1 January 2024.
SELECT * FROM employee
WHERE joining_date>'2024-01-01';

--Display all unique department names.
SELECT DISTINCT department FROM employee;

--Find employees whose employment status is Resigned.
SELECT * FROM employee
WHERE employment_status='Resigned';

--Display the 10 employees with the highest salaries.
SELECT * FROM employee
ORDER BY salary DESC
LIMIT 10;

--Find employees whose job role is Data Analyst and employment status Active.
SELECT * FROM employee
WHERE job_role='Data Analyst' AND employment_status = 'Active';

--Calculate the total number of employees.
SELECT COUNT(employee_id) AS Total_employees 
FROM employee;

--Calculate the average salary of all employees.
SELECT AVG(salary) AS average_salary
FROM employee;

--Find the minimum and maximum salary.
SELECT MIN(salary) FROM employee;
SELECT MAX(salary) FROM employee;

--Count employees in each department.
SELECT  department, COUNT(employee_id) AS Total_employees
FROM employee
GROUP BY department;

--Calculate the average salary for each department.
SELECT  department, AVG(salary) AS average_salary
FROM employee
GROUP BY department;

--Calculate the total salary expenditure for each department.
SELECT  department, SUM(salary) AS total_salary_expenditure
FROM employee
GROUP BY department;

--Count employees by employment status.
SELECT employment_status, COUNT(employee_id) as Total_employees
FROM employee
GROUP BY employment_status;

--Calculate the average age of employees in each department.
SELECT department, AVG(age) AS average_age
FROM employee
GROUP BY DEPARTMENT;

--Find the number of employees in each job role.
SELECT job_role, COUNT(employee_id) AS total_employees
FROM employee
GROUP BY job_role;

--Display departments with more than 300 employees.
SELECT department, COUNT(employee_id) 
FROM employee
GROUP BY department
HAVING COUNT(employee_id)>300;

/*Categorize employees into three age groups:
Under 30: Young
30–40: Mid-Career
Above 40: Experienced*/
SELECT employee_id,
age,
 CASE 
	 WHEN age<30 THEN 'Young'
	 WHEN age BETWEEN 30 AND 40 THEN 'Mid Career'
	 ELSE 'Experienced'
 END AS Age_Group
FROM employee;

/*Categorize salaries into three groups:
Below ₹30,000: Low Salary
₹30,000–₹60,000: Medium Salary
Above ₹60,000: High Salary*/
SELECT employee_id,
salary,
 CASE 
	 WHEN salary<30000 THEN 'Low Salary'
	 WHEN salary BETWEEN 30000 AND 60000 THEN 'Medium Salary'
	 ELSE 'High Salary'
 END AS Salary_Group
FROM employee;

--Calculate employee tenure in years using Joining_Date
SELECT
    Employee_ID,
    Joining_Date,
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, Joining_Date)) AS Tenure_Years
FROM employee;


--Find employees who have an Exit_Date.
SELECT * FROM employee
WHERE exit_date IS NOT NULL;

--Calculate the percentage of employees who have left the organisation.
SELECT
    ROUND(
        COUNT(*) FILTER (
            WHERE employment_status IN ('Resigned', 'Terminated')
        ) * 100.0 / COUNT(*),
        2
    ) AS former_employee_percentage
FROM employee;


--Find departments with an average salary greater than ₹40,000.
SELECT department, AVG(salary) AS average_salary FROM employee
GROUP BY department
HAVING AVG(salary) > 40000;

--Display employee names or IDs, departments, salaries, and performance ratings.
SELECT 
e.employee_id,
e.department,
e.salary,
ep.performance_rating
FROM employee AS e
INNER JOIN ep
ON e.employee_id=ep.employee_id;

--Display each employee's department and job satisfaction score.
SELECT
e.employee_id,
e.department,
ep.job_satisfaction,
ep.review_period
FROM employee AS e
INNER JOIN ep
ON e.employee_id=ep.employee_id;

--Find employees whose performance rating is 5.
SELECT 
e.employee_id,
ep.performance_rating
FROM employee AS e
INNER JOIN ep
ON e.employee_id=ep.employee_id
WHERE ep.performance_rating=5;


--Calculate the average performance rating for each department.
SELECT
e.department,
ROUND(AVG(ep.performance_rating),2) AS average_performance_rating
FROM employee AS e
INNER JOIN ep
ON e.employee_id=ep.employee_id
GROUP BY e.department;

--Calculate the average job satisfaction score for each department.
SELECT
e.department,
ROUND(AVG(ep.job_satisfaction),2) AS average_performance_rating
FROM employee AS e
INNER JOIN ep
ON e.employee_id=ep.employee_id
GROUP BY e.department;


--Display employees who have more than one performance review.
SELECT
    Employee_ID,
    COUNT(Performance_ID) AS Total_Reviews
FROM ep
GROUP BY Employee_ID
HAVING COUNT(Performance_ID) > 1;



--Find employees who have never received a performance review.
SELECT
    e.Employee_ID,
    e.Department
FROM employee AS e
LEFT JOIN ep
    ON e.Employee_ID = ep.Employee_ID
WHERE ep.Employee_ID IS NULL;


--Calculate the average training hours for each department.
SELECT
    e.department,
    ROUND(AVG(ep.training_hours),2) AS avg_training_hour
FROM employee AS e
LEFT JOIN ep
    ON e.Employee_ID = ep.Employee_ID
GROUP BY e.department;


--Find the second-highest salary in the organisation.
SELECT employee_id,salary FROM employee
WHERE salary=(
	SELECT DISTINCT Salary
	FROM employee
	ORDER BY Salary DESC
	LIMIT 1 OFFSET 1
);


--Find employees earning more than the overall average salary.
SELECT employee_id, salary
FROM employee
WHERE salary >(SELECT AVG(salary) FROM employee 
);


--Find the department with the highest average performance rating.
SELECT 
e.department,
ROUND(AVG(ep.performance_rating),2) AS high_per
FROM employee as e
LEFT JOIN ep
ON e.employee_id=ep.employee_id
GROUP BY e.department
ORDER BY high_per DESC
LIMIT 1;
`

--Identify employees whose performance rating is above the overall average rating.
SELECT employee_id, performance_rating
FROM ep
WHERE performance_rating >(SELECT AVG(performance_rating) FROM ep 
);


--Calculate the average overtime hours by department.
SELECT
e.department,
ROUND(AVG(ep.overtime_hours),2) AS avg_overtime
FROM employee as e
INNER JOIN ep
ON e.employee_id=ep.employee_id
GROUP BY department;




