-- DROP table if it already exists
DROP TABLE IF EXISTS Employees;

-- CREATE Employees Table
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    Department VARCHAR(30),
    City VARCHAR(30),
    Salary INT,
    HireDate DATE
);

-- INSERT Data According to PDF Table
INSERT INTO Employees VALUES
(101, 'Rahul Mehta', 'Sales',     'Delhi',     55000, '2020-04-12'),
(102, 'Priya Sharma', 'HR',       'Mumbai',    62000, '2019-09-25'),
(103, 'Aman Singh',   'IT',       'Bengaluru', 72000, '2021-03-10'),
(104, 'Neha Patel',   'Sales',    'Delhi',     48000, '2022-01-14'),
(105, 'Karan Joshi',  'Marketing','Pune',      45000, '2018-07-22'),
(106, 'Divya Nair',   'IT',       'Chennai',   81000, '2019-12-11'),
(107, 'Raj Kumar',    'HR',       'Delhi',     60000, '2020-05-28'),
(108, 'Simran Kaur',  'Finance',  'Mumbai',    58000, '2021-08-03'),
(109, 'Arjun Reddy',  'IT',       'Hyderabad', 70000, '2022-02-18'),
(110, 'Anjali Das',   'Sales',    'Kolkata',   51000, '2023-01-15');

-- Question 1: Show employees working in either the ‘IT’ or ‘HR’ departments.
SELECT *
FROM Employees
WHERE Department IN ('IT', 'HR');

-- Question 2: Retrieve employees whose department is in ‘Sales’, ‘IT’, or ‘Finance’. 
SELECT *
FROM Employees
WHERE Department IN ('Sales', 'IT', 'Finance');

-- Question 3: Display employees whose salary is between ₹50,000 and ₹70,000. 
SELECT *
FROM Employees
WHERE Salary BETWEEN 50000 AND 70000;

-- Question 4: List employees whose names start with the letter ‘A’. 
SELECT *
FROM Employees
WHERE EmpName LIKE 'A%';

-- Question 5: Find employees whose names contain the substring ‘an’.
SELECT *
FROM Employees
WHERE EmpName LIKE '%an%';

-- Question 6: Show employees who are from ‘Delhi’ or ‘Mumbai’ and earn more than ₹55,000.
SELECT *
FROM Employees
WHERE City IN ('Delhi', 'Mumbai')
  AND Salary > 55000;

-- Question 7: Display all employees except those from the ‘HR’ department.
SELECT *
FROM Employees
WHERE Department <> 'HR';

-- Question 8: Get all employees hired between 2019 and 2022, ordered by HireDate (oldest first).
SELECT *
FROM Employees
WHERE HireDate BETWEEN '2019-01-01' AND '2022-12-31'
ORDER BY HireDate ASC;

