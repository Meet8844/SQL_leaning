-- SELECT Statement

select *
from Parks_and_Recreation.employee_demographics;

select first_name, 
last_name, 
birth_date,
age,
(age + 10) * 10 + 10
from Parks_and_Recreation.employee_demographics;
# PEMDAS


select Distinct first_name,gender
from Parks_and_Recreation.employee_demographics;

select Distinct gender
from Parks_and_Recreation.employee_demographics;


-- WHERE Clause

SELECT *
FROM employee_salary
WHERE first_name ='Leslie'
;

SELECT *
FROM employee_salary
WHERE salary <= 50000
;

SELECT *
FROM employee_demographics
WHERE GENDER != 'FEMALE'
;


-- AND OR NOT -- Logical Operators
SELECT *
FROM employee_demographics
WHERE birth_date > '1985-01-01'
AND gender = 'Male'
;

SELECT *
FROM employee_demographics
WHERE birth_date > '1985-01-01'
OR NOT gender = 'Male'
;

SELECT *
FROM employee_demographics
WHERE (first_name = 'Leslie' AND age = 44) OR age > 55
;


-- Like Statement
-- % and _
SELECT *
FROM employee_demographics
WHERE first_name LIKE 'Jer%' 
;


SELECT *
FROM employee_demographics
WHERE first_name LIKE 'a%' 
;

SELECT *
FROM employee_demographics
WHERE first_name LIKE 'a___%' 
;

SELECT *
FROM employee_demographics
WHERE birth_date LIKE '1989%' 
;


-- Group By
SELECT *
FROM employee_demographics
;

SELECT gender
FROM employee_demographics
Group By gender
;

SELECT gender, AVG(age)
FROM employee_demographics
Group By gender
;


SELECT *
FROM employee_salary
;

SELECT occupation, Salary
FROM employee_salary
Group By occupation, Salary
;

SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
FROM employee_demographics
Group By gender
;


-- ORDER BY
SELECT *
FROM employee_demographics
ORDER BY first_name DESC
;

SELECT *
FROM employee_demographics
ORDER BY Gender
;

SELECT *
FROM employee_demographics
ORDER BY Gender, age
;


-- HAVING VS WHERE
SELECT gender, AVG(age)
FROM employee_demographics
GROUP BY gender
HAVING AVG(age) > 40
;

SELECT *
FROM employee_salary
;

SELECT occupation, AVG(salary)
FROM employee_salary
WHERE occupation LIKE '%manager%'
GROUP BY occupation
HAVING AVG(salary) > 75000
;


-- Limit & Aliasing
SELECT *
FROM employee_demographics
;

SELECT *
FROM employee_demographics
ORDER BY age DESC
LIMIT 2,1
;


-- Aliasing
SELECT gender, AVG(age) AS avg_age
FROM employee_demographics
GROUP BY gender
HAVING avg_age > 40;



-- Joins
SELECT *
FROM employee_salary
;

SELECT *
FROM employee_demographics
;

SELECT dem.employee_id, age, occupation
FROM employee_demographics AS dem
INNER JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
;


-- Outer Join
SELECT *
FROM employee_demographics AS dem
LEFT JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
;

SELECT *
FROM employee_demographics AS dem
RIGHT JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
;


-- Self Join
SELECT *
FROM employee_salary emp1
JOIN employee_salary emp2
	ON emp1.employee_id + 1 = emp2.employee_id
;


SELECT emp1.employee_id AS emp_santa,
emp1.first_name AS first_name_santa,
emp1.last_name AS last_name_santa,
emp2.employee_id AS emp_name,
emp2.first_name AS first_name_emp,
emp2.last_name AS last_name_emp
FROM employee_salary emp1
JOIN employee_salary emp2
	ON emp1.employee_id + 1 = emp2.employee_id
;



-- Joining multiple tables together
SELECT *
FROM employee_demographics AS dem
INNER JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
INNER JOIN parks_departments AS pd
	ON sal.dept_id = pd.department_id
;

SELECT *
FROM parks_departments
;


-- Unions
SELECT first_name, last_name
FROM employee_demographics
UNION ALL
SELECT first_name, last_name
FROM employee_salary
;


SELECT first_name, last_name, "Old Man" AS Label
FROM employee_demographics
WHERE AGE > 40 AND gender ='Male'
UNION
SELECT first_name, last_name, "Old Lady" AS Label
FROM employee_demographics
WHERE AGE > 40 AND gender = 'Female'
UNION
SELECT first_name, last_name, "Highly Paid Employee" AS Label
FROM employee_salary
WHERE Salary > 70000
ORDER BY first_name, last_name
;


-- String Functions
SELECT LENGTH('Skyfall')
;

SELECT first_name, LENGTH(first_name)
FROM employee_demographics
ORDER BY 2
;

SELECT UPPER('sky');
SELECT LOWER ('SKY');

SELECT first_name, UPPER(first_name)
FROM employee_demographics
;

select TRIM('         sky         ');
select RTRIM('         sky         ');
select LTRIM('         sky         ');

SELECT first_name,
LEFT (first_name, 4),
RIGHT (first_name, 4),
SUBSTRING(first_name, 3, 2),
birth_date,
SUBSTRING(birth_date, 6,2) AS birth_month
FROM employee_demographics;


SELECT first_name, REPLACE(first_name, 'a', 'z')
FROM employee_demographics;

SELECT LOCATE('x', 'Alexander');

SELECT first_name, LOCATE('An', first_name)
FROM employee_demographics;
    
SELECT first_name, last_name,
CONCAT(first_name,' ', last_name) AS full_name
FROM employee_demographics;



-- Case Statement
SELECT first_name,
last_name,
age,
CASE
	WHEN age <= 30 THEN 'Young'
    WHEN age BETWEEN 30 and 50  THEN 'Old'
    WHEN age >= 51 THEN "On Death's Door"
END AS age_bracket
FROM employee_demographics
;


-- Pay Increase and Bonus
-- < 50000 = 5%
-- > 50000 = 7%
-- Finance = 10% Bonus

SELECT *
FROM employee_salary;

SELECT first_name, last_name, salary,
CASE
	WHEN salary < 50000 THEN salary + (salary * 0.05)
	WHEN salary > 50000 THEN salary + (salary * 0.07)
END AS new_salary,
CASE 
	WHEN dept_id = 6 THEN salary + (salary * 0.10)
END AS Bonus
FROM employee_salary
;


-- Subqueries

SELECT *
FROM employee_demographics
WHERE employee_id IN 
				(SELECT employee_id
                FROM employee_salary
                WHERE dept_id = 1)
;

SELECT first_name, salary, 
(SELECT AVG(salary)
FROM employee_salary)
FROM employee_salary;

SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
FROM employee_demographics
GROUP BY gender
;

SELECT  AVG(max_age)
FROM
(SELECT gender, 
AVG(age) AS avg_age,
MAX(age) AS max_age,
MIN(age) AS min_age,
COUNT(age)
FROM employee_demographics
GROUP BY gender) AS Agg_table
;


-- Window Function
SELECT gender, AVG(salary) AS avg_salary
FROM employee_demographics AS dem
JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
;


SELECT dem.first_name, dem.last_name, gender, AVG(salary) AS avg_salary
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
GROUP BY dem.first_name, dem.last_name, gender
;


SELECT dem.first_name, dem.last_name, gender,
SUM(salary) OVER(PARTITION BY gender)
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
;


SELECT dem.first_name, dem.last_name, gender, salary,
SUM(salary) OVER(PARTITION BY gender ORDER BY dem.employee_id) AS Rollling_Total
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
;


SELECT dem.first_name, dem.last_name, gender, salary, 
ROW_NUMBER() OVER(PARTITION BY gender ORDER  BY salary DESC) AS row_num,
RANK() OVER(PARTITION BY gender ORDER  BY salary DESC) AS rank_num,
DENSE_RANK() OVER(PARTITION BY gender ORDER  BY salary DESC) AS dense_rank_num
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
;







