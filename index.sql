CREATE DATABASE company_db;

CREATE TABLE employees(
   emp_id INT PRIMARY KEY AUTO_INCREMENT,
   emp_name VARCHAR(50),
   department VARCHAR(20),
   salary INT,
   manager_id INT,
   city VARCHAR(20)
);

INSERT INTO employees (emp_name,department,salary,manager_id,city)
VALUES
("Noor", "HR", 50000, 3, "Beirut"),
("Hassan", "IT", 60000, 4, "Baalback"),
("Hady", "HR", 70000, NULL, "Beirut"),
("Ali", "IT", 80000, NULL, "Tripoli"),
("Mouhammad", "Sales", 45000, 6, "Saida"),
("Zayn", "Sales", 65000, NULL, "Beq");

SELECT DISTINCT department
FROM employees;

SELECT emp_name,salary
FROM employees
WHERE salary > 50000 AND (department = "IT" OR department = "HR");

SELECT emp_name
FROM employees
WHERE emp_name LIKE "H%";

SELECT emp_name
FROM employees
ORDER BY salary DESC
LIMIT 3;

SELECT SUM(salary) AS "summation_salary_of_each_department", department
FROM employees GROUP BY department;

SELECT department, SUM(salary) AS "summation_salary_of_each_department"
FROM employees 
GROUP BY department WITH ROLLUP;

SELECT emp_name
FROM employees
WHERE city = "Beirut"
UNION ALL
SELECT emp_name
FROM employees
WHERE city = "Beq";

SELECT e.emp_name AS "Employee_Name", m.emp_name AS "Manager_Name"
FROM employees AS e INNER JOIN employees AS m
ON e.manager_id = m.emp_id;

SELECT emp_name
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

CREATE VIEW IT_employees AS
SELECT emp_name, department, salary
FROM employees
WHERE department = "IT";

SELECT * 
FROM IT_employees

--l)

DELIMITER $$
CREATE PROCEDURE GetAllEmployees()
BEGIN 
    SELECT * FROM employees;
END $$
DELIMITER ;

CALL GetAllEmployees();

--m)

DELIMITER $$
CREATE PROCEDURE GetEmployeesByDepartment(IN department VARCHAR(50))
BEGIN 
    SELECT emp_name 
    FROM employees
    WHERE employees.department = department;
END $$
DELIMITER ;

CALL GetEmployeesByDepartment("IT");

--n)

DELIMITER $$
CREATE PROCEDURE GetEmployeesBySalary(IN amount INT)
BEGIN
    SELECT emp_name
    FROM employees
    WHERE salary > amount;
END $$
DELIMITER ;

CALL GetEmployeesBySalary(70000);