/* 
Q1. Create a table called employees with the following structure:
   - emp_id (integer, not NULL, primary key)
   - emp_name (text, not NULL)
   - age (integer, check age >= 18)
   - email (unique)
   - salary (decimal, default 30000)

create database PWskills
use PWskills
CREATE TABLE employees (
    emp_id INT NOT NULL PRIMARY KEY,
    emp_name VARCHAR(100) NOT NULL,
    age INT CHECK (age >= 18),
    email VARCHAR(100) UNIQUE,
    salary DECIMAL(10,2) DEFAULT 30000
);
*/

/* 
Q2. Explain the purpose of constraints.

Constraints ensure data integrity and consistency in the database.
Examples:
- NOT NULL → ensures a column cannot have NULL values
- UNIQUE → ensures no duplicate values
- PRIMARY KEY → uniquely identifies each row
- CHECK → enforces a condition
- DEFAULT → sets a default value if none is provided
*/

/* 
Q3. Why would you apply the NOT NULL constraint to a column? 
Can a primary key contain NULL values? Justify your answer.

Answer:
- The NOT NULL constraint is applied to a column to ensure that the column 
  must always have a value and cannot be left empty. 
  This helps maintain data integrity by preventing incomplete records.

- A PRIMARY KEY cannot contain NULL values because it must uniquely 
  identify each record in a table. 
  If NULLs were allowed, uniqueness would be violated since NULL 
  represents the absence of a value and cannot guarantee identification.

Justification:
- NOT NULL ensures mandatory data input.
- PRIMARY KEY = UNIQUE + NOT NULL, therefore it never allows NULL values.
*/

/* 
Q4. Explain the steps and SQL commands used to add or remove constraints 
on an existing table. Provide an example for both adding and removing a constraint.

Answer:
- To add a constraint: Use the ALTER TABLE command with ADD CONSTRAINT.
- To remove a constraint: Use the ALTER TABLE command with DROP CONSTRAINT (or DROP INDEX/KEY depending on the type of constraint).

Examples:
*/

/* ✅ Example: Adding a CHECK constraint to ensure salary > 0 */
ALTER TABLE employees
ADD CONSTRAINT chk_salary CHECK (salary > 0);

/* ✅ Example: Removing the CHECK constraint */
ALTER TABLE employees
DROP CHECK chk_salary;

/* ✅ Example: Adding a UNIQUE constraint on emp_name */
ALTER TABLE employees
ADD CONSTRAINT uq_emp_name UNIQUE (emp_name);

/* ✅ Example: Removing the UNIQUE constraint */
ALTER TABLE employees


/* 
Q5. Explain the consequences of attempting to insert, update, or delete data 
in a way that violates constraints. Provide an example of an error message.

Answer:
- Constraints are rules applied to columns to maintain data integrity.
- If you attempt to insert, update, or delete data that violates these rules, 
  the database will reject the operation and return an error message.

Consequences of violating constraints:
1. NOT NULL → Inserting NULL into a NOT NULL column will fail.
2. UNIQUE → Inserting duplicate values in a UNIQUE column will fail.
3. PRIMARY KEY → Inserting NULL or duplicate values in a primary key column will fail.
4. CHECK → Inserting a value that does not satisfy the condition will fail.
5. FOREIGN KEY → Inserting or updating a value that doesn’t exist in the parent table will fail, 
   or deleting a referenced row will fail.

Examples:

/* ✅ Example 1: Violating NOT NULL constraint */
INSERT INTO employees (emp_id, emp_name, age, email, salary)
VALUES (1, NULL, 25, 'test@example.com', 35000);

-- Error: ERROR 1048 (23000): Column 'emp_name' cannot be null

/* ✅ Example 2: Violating UNIQUE constraint */
INSERT INTO employees (emp_id, emp_name, age, email, salary)
VALUES (2, 'John Doe', 28, 'test@example.com', 40000);

-- Error: ERROR 1062 (23000): Duplicate entry 'test@example.com' for key 'employees.email'

/* ✅ Example 3: Violating CHECK constraint */
INSERT INTO employees (emp_id, emp_name, age, email, salary)
VALUES (3, 'Jane Doe', 15, 'jane@example.com', 30000);

-- Error: ERROR 3819 (HY000): Check constraint 'employees_chk_1' is violated.


/* 
Q6. You created a products table without constraints as follows:

CREATE TABLE products (
    product_id INT,
    product_name VARCHAR(50),
    price DECIMAL(10,2)
);

Now, you realise that:
 - The product_id should be a PRIMARY KEY
 - The price should have a DEFAULT value of 50.00
*/

/* ✅ Step 1: Add PRIMARY KEY to product_id */
ALTER TABLE products
ADD CONSTRAINT pk_product PRIMARY KEY (product_id);

/* ✅ Step 2: Set DEFAULT value for price */
ALTER TABLE products
ALTER COLUMN price SET DEFAULT 50.00;

/*
Explanation:
- ALTER TABLE is used to modify an existing table.
- ADD CONSTRAINT pk_product PRIMARY KEY (product_id) makes product_id 
  the primary key so each product is unique and not NULL.
- ALTER COLUMN price SET DEFAULT 50.00 ensures that if no price is given 
  when inserting, the default value 50.00 will be used automatically.
*/


/* 
Q7. You have two tables:

Students:
+------------+--------------+---------+
| student_id | student_name | class_id|
+------------+--------------+---------+
| 1          | Alice        | 101     |
| 2          | Bob          | 102     |
| 3          | Charlie      | 101     |
+------------+--------------+---------+

Classes:
+---------+------------+
| class_id| class_name |
+---------+------------+
| 101     | Math       |
| 102     | Science    |
| 103     | History    |
+---------+------------+

Write a query to fetch the student_name and class_name 
for each student using an INNER JOIN.
*/

SELECT s.student_name, c.class_name
FROM Students s
INNER JOIN Classes c
ON s.class_id = c.class_id;

/* 
Q8. Consider the following three tables:

Orders:
+---------+------------+-------------+
| order_id| order_date | customer_id |
+---------+------------+-------------+
| 1       | 2024-01-01 | 101         |
| 2       | 2024-01-03 | 102         |
+---------+------------+-------------+

Customers:
+-------------+---------------+
| customer_id | customer_name |
+-------------+---------------+
| 101         | Alice         |
| 102         | Bob           |
+-------------+---------------+

Products:
+-----------+-------------+---------+
| product_id| product_name| order_id|
+-----------+-------------+---------+
| 1         | Laptop      | 1       |
| 2         | Phone       | NULL    |
+-----------+-------------+---------+

Task:
Write a query that shows all order_id, customer_name, and product_name,
ensuring that all products are listed even if they are not associated with an order.

Hint: Use INNER JOIN and LEFT JOIN
*/

SELECT o.order_id, c.customer_name, p.product_name
FROM Products p
LEFT JOIN Orders o ON p.order_id = o.order_id
LEFT JOIN Customers c ON o.customer_id = c.customer_id;


/* 
Q8. Consider the following three tables:

Orders:
+---------+------------+-------------+
| order_id| order_date | customer_id |
+---------+------------+-------------+
| 1       | 2024-01-01 | 101         |
| 2       | 2024-01-03 | 102         |
+---------+------------+-------------+

Customers:
+-------------+---------------+
| customer_id | customer_name |
+-------------+---------------+
| 101         | Alice         |
| 102         | Bob           |
+-------------+---------------+

Products:
+-----------+-------------+---------+
| product_id| product_name| order_id|
+-----------+-------------+---------+
| 1         | Laptop      | 1       |
| 2         | Phone       | NULL    |
+-----------+-------------+---------+

Task:
Write a query that shows all order_id, customer_name, and product_name,
ensuring that all products are listed even if they are not associated with an order.

Hint: Use INNER JOIN and LEFT JOIN
*/

SELECT o.order_id, c.customer_name, p.product_name
FROM Products p
LEFT JOIN Orders o ON p.order_id = o.order_id
LEFT JOIN Customers c ON o.customer_id = c.customer_id;



/* 
9. Given the following tables:

Sales:
+---------+------------+--------+
| sale_id | product_id | amount |
+---------+------------+--------+
|    1    |    101     |  500   |
|    2    |    102     |  300   |
|    3    |    101     |  700   |
+---------+------------+--------+

Products:
+------------+--------------+
| product_id | product_name |
+------------+--------------+
|    101     | Laptop       |
|    102     | Phone        |
+------------+--------------+

Write a query to find the total sales amount for each product 
using an INNER JOIN and the SUM() function.
*/

SELECT p.product_name, 
       SUM(s.amount) AS total_sales
FROM Sales s
INNER JOIN Products p 
    ON s.product_id = p.product_id
GROUP BY p.product_name;


/* 
10. You are given three tables:

Orders:
+---------+------------+-------------+
| order_id | order_date | customer_id |
+---------+------------+-------------+
|    1    | 2024-01-02 |      1      |
|    2    | 2024-01-05 |      2      |
+---------+------------+-------------+

Customers:
+-------------+---------------+
| customer_id | customer_name |
+-------------+---------------+
|      1      | Alice         |
|      2      | Bob           |
+-------------+---------------+

Order_Details:
+---------+------------+----------+
| order_id | product_id | quantity |
+---------+------------+----------+
|    1    |    101     |    2     |
|    1    |    102     |    1     |
|    2    |    101     |    3     |
+---------+------------+----------+

Task:
Write a query to display the order_id, customer_name, 
and the quantity of products ordered by each customer 
using an INNER JOIN between all three tables.
*/

SELECT o.order_id, 
       c.customer_name, 
       od.quantity
FROM Orders o
INNER JOIN Customers c 
    ON o.customer_id = c.customer_id
INNER JOIN Order_Details od 
    ON o.order_id = od.order_id;
--------------------------------------------------------------------------------------

USE mavenmovies;
show tables;

-- 1-Identify the primary keys and foreign keys in maven movies db. Discuss the differences

SELECT first_name, last_name
FROM actor;

-- 2- List all details of actors
SELECT *
FROM actor;

-- 3 -List all customer information from DB.
SELECT *
FROM customer;

-- 4 -List different countries.
SELECT DISTINCT country
FROM country;

-- 5 -Display all active customers.
SELECT *
FROM customer
WHERE active = 1;

-- 6 -List of all rental IDs for customer with ID 1.
SELECT rental_id
FROM rental
WHERE customer_id = 1;

-- 7 - Display all the films whose rental duration is greater than 5 .
SELECT *
FROM film
WHERE rental_duration > 5;

-- 8 - List the total number of films whose replacement cost is greater than $15 and less than $20
SELECT COUNT(*)
FROM film
WHERE replacement_cost BETWEEN 15 AND 20;

-- 9 - Display the count of unique first names of actors
SELECT COUNT(DISTINCT first_name)
FROM actor;

-- 10- Display the first 10 records from the customer table .
SELECT *
FROM customer
LIMIT 10;

-- 11 - Display the first 3 records from the customer table whose first name starts with ‘b’.
SELECT *
FROM customer
WHERE first_name LIKE 'B%'
LIMIT 3;

-- 12 -Display the names of the first 5 movies which are rated as ‘G’.
SELECT title
FROM film
WHERE rating = 'G'
LIMIT 5;


-- 13-Find all customers whose first name starts with "a".
SELECT *
FROM customer
WHERE first_name LIKE 'a%';

-- 14- Find all customers whose first name ends with "a".
SELECT *
FROM customer
WHERE first_name LIKE '%a';

-- 15- Display the list of first 4 cities which start and end with ‘a’ .
SELECT *
FROM city
WHERE city LIKE 'a%a'
LIMIT 4;

-- 16- Find all customers whose first name have "NI" in any position.
SELECT *
FROM customer
WHERE first_name LIKE '%NI%';

-- 17- Find all customers whose first name have "r" in the second position .
SELECT *
FROM customer
WHERE first_name LIKE '_r%';

-- 18 - Find all customers whose first name starts with "a" and are at least 5 characters in length.
SELECT *
FROM customer
WHERE first_name LIKE 'a%' AND LENGTH(first_name) >= 5;

-- 19- Find all customers whose first name starts with "a" and ends with "o".
SELECT *
FROM customer
WHERE first_name LIKE 'a%o';

-- 20 - Get the films with pg and pg-13 rating using IN operator
SELECT *
FROM film
WHERE rating IN ('PG', 'PG-13');

-- 21 - Get the films with length between 50 to 100 using between operator.
SELECT *
FROM film
WHERE length BETWEEN 50 AND 100;

-- 22 - Get the top 50 actors using limit operator
SELECT *
FROM actor
LIMIT 50;

-- 23 - Get the distinct film ids from inventory table.
SELECT DISTINCT film_id
FROM inventory;

-----------------------------------------------------------------------------------------
-- "FUNCTIONS"
-- 1. Retrieve the total number of rentals made in the Sakila database.
SELECT COUNT(rental_id) FROM rental;

-- 2. Find the average rental duration (in days) of movies rented from the Sakila database.
SELECT AVG(rental_duration) AS average_rental_duration
FROM film;

-- 3. Display the first name and last name of customers in uppercase.
SELECT
    UPPER(first_name),
    UPPER(last_name)
FROM
    customer;


-- 4. Extract the month from the rental date and display it alongside the rental ID.
SELECT rental_id, MONTH(rental_date) AS rental_month
FROM rental;


-- 5. Retrieve the count of rentals for each customer (display customer ID and the count of rentals)
SELECT customer_id, COUNT(rental_id) AS rental_count
FROM rental
GROUP BY customer_id;

-- 6. Find the total revenue generated by each store.
SELECT
    s.store_id,
    SUM(p.amount) AS total_revenue
FROM
    store AS s
JOIN
    staff AS st ON s.store_id = st.store_id
JOIN
    payment AS p ON st.staff_id = p.staff_id
GROUP BY
    s.store_id;
    
    
-- 7. Determine the total number of rentals for each category of movies.
SELECT
    c.name AS category_name,
    COUNT(r.rental_id) AS rental_count
FROM
    category AS c
JOIN
    film_category AS fc ON c.category_id = fc.category_id
JOIN
    inventory AS i ON fc.film_id = i.film_id
JOIN
    rental AS r ON i.inventory_id = r.inventory_id
GROUP BY
    c.name
ORDER BY
    rental_count DESC;
    
-- 8. Find the average rental rate of movies in each language.
SELECT 
    l.name AS language_name, 
    AVG(f.rental_rate) AS average_rental_rate
FROM 
    film AS f
JOIN 
    language AS l ON f.language_id = l.language_id
GROUP BY 
    l.name;
    
    
-- 9. Display the title of the movie, customer s first name, and last name who rented it.
SELECT
    f.title AS movie_title,
    c.first_name AS customer_first_name,
    c.last_name AS customer_last_name
FROM
    film AS f
JOIN
    inventory AS i ON f.film_id = i.film_id
JOIN
    rental AS r ON i.inventory_id = r.inventory_id
JOIN
    customer AS c ON r.customer_id = c.customer_id;
    

-- 10. Retrieve the names of all actors who have appeared in the film "Gone with the Wind."
SELECT
    a.first_name,
    a.last_name
FROM
    actor AS a
JOIN
    film_actor AS fa ON a.actor_id = fa.actor_id
JOIN
    film AS f ON fa.film_id = f.film_id
WHERE
    f.title = 'Gone with the Wind';
    
    
-- 11. Retrieve the customer names along with the total amount they've spent on rentals.
SELECT
    c.first_name,
    c.last_name,
    SUM(p.amount) AS total_spent
FROM
    customer AS c
JOIN
    payment AS p ON c.customer_id = p.customer_id
GROUP BY
    c.customer_id
ORDER BY
    total_spent DESC;


-- 12. List the titles of movies rented by each customer in a particular city (e.g., 'London')
SELECT
    c.first_name,
    c.last_name,
    f.title AS movie_title
FROM
    customer AS c
JOIN
    address AS a ON c.address_id = a.address_id
JOIN
    city AS ci ON a.city_id = ci.city_id
JOIN
    rental AS r ON c.customer_id = r.customer_id
JOIN
    inventory AS i ON r.inventory_id = i.inventory_id
JOIN
    film AS f ON i.film_id = f.film_id
WHERE
    ci.city = 'London';
    
-- 13. Display the top 5 rented movies along with the number of times they've been rented
SELECT
    f.title,
    COUNT(r.rental_id) AS rental_count
FROM
    film AS f
JOIN
    inventory AS i ON f.film_id = i.film_id
JOIN
    rental AS r ON i.inventory_id = r.inventory_id
GROUP BY
    f.title
ORDER BY
    rental_count DESC
LIMIT 5;

-- 14. Determine the customers who have rented movies from both stores (store ID 1 and store ID 2).
SELECT
    c.first_name,
    c.last_name
FROM
    customer AS c
JOIN
    rental AS r ON c.customer_id = r.customer_id
JOIN
    inventory AS i ON r.inventory_id = i.inventory_id
WHERE
    i.store_id IN (1, 2)
GROUP BY
    c.customer_id, c.first_name, c.last_name
HAVING
    COUNT(DISTINCT i.store_id) = 2;
    
 ----------------------------------------------------------------------------------------------   
-- WINDOWS FUNCTION 

-- 1. Rank the customers based on the total amount they've spent on rentals.
SELECT
    c.first_name,
    c.last_name,
    SUM(p.amount) AS total_spent
FROM
    customer AS c
JOIN
    payment AS p ON c.customer_id = p.customer_id
GROUP BY
    c.customer_id, c.first_name, c.last_name
ORDER BY
    total_spent DESC;
    
    
-- 2. Calculate the cumulative revenue generated by each film over time.
SELECT
    f.title,
    p.payment_date,
    p.amount,
    SUM(p.amount) OVER (PARTITION BY f.title ORDER BY p.payment_date) AS cumulative_revenue
FROM
    payment AS p
JOIN
    rental AS r ON p.rental_id = r.rental_id
JOIN
    inventory AS i ON r.inventory_id = i.inventory_id
JOIN
    film AS f ON i.film_id = f.film_id
ORDER BY
    f.title,
    p.payment_date;
    

-- 3. Determine the average rental duration for each film, considering films with similar lengths.
SELECT
    f.title,
    AVG(DATEDIFF(r.return_date, r.rental_date)) AS average_rental_duration
FROM
    film AS f
JOIN
    inventory AS i ON f.film_id = i.film_id
JOIN
    rental AS r ON i.inventory_id = r.inventory_id
WHERE
    r.return_date IS NOT NULL
GROUP BY
    f.film_id, f.title
ORDER BY
    f.title;
    

-- 4. Identify the top 3 films in each category based on their rental counts.
WITH RankedFilms AS (
    SELECT
        c.name AS category_name,
        f.title AS film_title,
        COUNT(r.rental_id) AS rental_count,
        RANK() OVER (PARTITION BY c.name ORDER BY COUNT(r.rental_id) DESC) AS ranking
    FROM
        category AS c
    JOIN
        film_category AS fc ON c.category_id = fc.category_id
    JOIN
        film AS f ON fc.film_id = f.film_id
    JOIN
        inventory AS i ON f.film_id = i.film_id
    JOIN
        rental AS r ON i.inventory_id = r.inventory_id
    GROUP BY
        c.name, f.title
)
SELECT
    category_name,
    film_title,
    rental_count
FROM
    RankedFilms
WHERE
    ranking <= 3;
    
    
-- 5. Calculate the difference in rental counts between each customer's total rentals and the average rentals across all customers.
WITH CustomerRentalCounts AS (
    SELECT
        customer_id,
        COUNT(rental_id) AS total_rentals
    FROM
        rental
    GROUP BY
        customer_id
)
SELECT
    c.first_name,
    c.last_name,
    crc.total_rentals,
    AVG(crc.total_rentals) OVER() AS average_rentals_per_customer,
    crc.total_rentals - AVG(crc.total_rentals) OVER() AS rental_difference
FROM
    customer AS c
JOIN
    CustomerRentalCounts AS crc ON c.customer_id = crc.customer_id
ORDER BY
    rental_difference DESC;
    

-- 6. Find the monthly revenue trend for the entire rental store over time.
SELECT
    DATE_FORMAT(payment_date, '%Y-%m') AS payment_month,
    SUM(amount) AS total_revenue
FROM
    payment
GROUP BY
    payment_month
ORDER BY
    payment_month;
    
    
-- 7. Identify the customers whose total spending on rentals falls within the top 20% of all customers.
WITH CustomerSpending AS (
    -- Step 1: Calculate the total spending for each customer
    SELECT
        customer_id,
        SUM(amount) AS total_spent
    FROM
        payment
    GROUP BY
        customer_id
),
RankedCustomers AS (
    -- Step 2: Rank customers into 5 groups (quintiles) based on spending
    SELECT
        customer_id,
        total_spent,
        NTILE(5) OVER (ORDER BY total_spent DESC) AS quintile
    FROM
        CustomerSpending
)
-- Step 3: Select customers from the top quintile (NTILE = 1)
SELECT
    c.first_name,
    c.last_name,
    rc.total_spent
FROM
    customer AS c
JOIN
    RankedCustomers AS rc ON c.customer_id = rc.customer_id
WHERE
    rc.quintile = 1
ORDER BY
    rc.total_spent DESC;


-- 8. Calculate the running total of rentals per category, ordered by rental count.
WITH CategoryRentals AS (
    SELECT
        c.name AS category_name,
        COUNT(r.rental_id) AS rental_count
    FROM
        category AS c
    JOIN
        film_category AS fc ON c.category_id = fc.category_id
    JOIN
        inventory AS i ON fc.film_id = i.film_id
    JOIN
        rental AS r ON i.inventory_id = r.inventory_id
    GROUP BY
        c.name
)
SELECT
    category_name,
    rental_count,
    SUM(rental_count) OVER (ORDER BY rental_count DESC) AS running_total_rentals
FROM
    CategoryRentals
ORDER BY
    rental_count DESC;
    

-- 9. Find the films that have been rented less than the average rental count for their respective categories.
WITH FilmRentalCounts AS (
    -- Step 1: Calculate the total rentals for each film within its category
    SELECT
        f.title AS film_title,
        fc.category_id,
        COUNT(r.rental_id) AS film_rental_count
    FROM
        film AS f
    JOIN
        film_category AS fc ON f.film_id = fc.film_id
    JOIN
        inventory AS i ON f.film_id = i.film_id
    JOIN
        rental AS r ON i.inventory_id = r.inventory_id
    GROUP BY
        f.title, fc.category_id
),
CategoryAverages AS (
    -- Step 2: Calculate the average rental count for each category
    SELECT
        category_id,
        AVG(film_rental_count) AS average_category_rental_count
    FROM
        FilmRentalCounts
    GROUP BY
        category_id
)
-- Step 3: Find films whose rental count is less than their category's average
SELECT
    c.name AS category_name,
    FRC.film_title,
    FRC.film_rental_count,
    CA.average_category_rental_count
FROM
    FilmRentalCounts AS FRC
JOIN
    CategoryAverages AS CA ON FRC.category_id = CA.category_id
JOIN
    category AS c ON FRC.category_id = c.category_id
WHERE
    FRC.film_rental_count < CA.average_category_rental_count
ORDER BY
    c.name, FRC.film_rental_count DESC;


-- 10.  Identify the top 5 months with the highest revenue and display the revenue generated in each month.
SELECT
    DATE_FORMAT(payment_date, '%Y-%m') AS payment_month,
    SUM(amount) AS total_revenue
FROM
    payment
GROUP BY
    payment_month
ORDER BY
    total_revenue DESC
LIMIT 5;

------------------------------------------------------------------------------------------------------------
-- Normalisation & CTE

/*  1,  Identify a table in the Sakila database that violates 1NF. Explain how you would normalize it to achieve 1NF
1NF Violation: The actor table would violate First Normal Form (1NF) if it had a films_acted_in column containing a list of multiple film titles.

The Rule: 1NF requires that each cell in a table holds only a single, atomic value, not a list or a repeating group of values.

Normalization: To fix this, you must create a new table called film_actor. This table acts as a linking table that connects records from the actor and film tables.

New Structure:

The original actor table remains with actor_id, first_name, and last_name.

The new film_actor table contains actor_id and film_id, with each row representing a single instance of an actor being in a film.

This new structure ensures all data is atomic, thus satisfying 1NF.
*/

/* 2. Choose a table in Sakila and describe how you would determine whether it is in 2NF. If it violates 2NF, explain the steps to normalize it.
Choosing a Table: The film_actor table is a good example for explaining 2NF because it has a composite primary key (film_id, actor_id).

Determining 2NF: A table is in 2NF if it meets two conditions:

It is in 1NF (each column holds a single value).

All non-key attributes are fully dependent on the entire primary key. This means no non-key column depends on only part of the composite key.

Hypothetical Violation: Let's imagine the film_actor table also included a rental_rate column from the film table. This would violate 2NF because rental_rate depends only on the film_id, which is just a part of the composite key (film_id, actor_id).

Normalization Steps:

Identify Partial Dependency: Recognize that rental_rate is dependent solely on film_id.

Move the Dependent Column: Transfer the rental_rate column to the film table, where it will be fully dependent on the film_id (which is the primary key of that table).

Result: The film_actor table is now normalized to 2NF as it only contains the composite key and no partially dependent columns.
*/

/*  3.  Identify a table in Sakila that violates 3NF. Describe the transitive dependencies present and outline the steps to normalize the table to 3NF.
Choosing a Table: The film table is a good example to explain Third Normal Form (3NF).

Determining 3NF: A table is in 3NF if:

It is in 2NF.

There are no transitive dependencies. This means no non-key attribute is dependent on another non-key attribute.

Hypothetical Violation: Imagine the film table also included a language_name column. The language_name is determined by language_id, which is a non-key attribute. This creates a transitive dependency: film_id (PK) -> language_id (non-key) -> language_name (non-key).

Normalization Steps:

Identify Transitive Dependency: Recognize that language_name depends on language_id, which is not the primary key.

Create a New Table: Move the transitively dependent column (language_name) and the determinant (language_id) to a new table, language.

Adjust the Original Table: The film table keeps the language_id (as a foreign key) but removes the language_name column.

Resulting Normalized Schema:

film table: Contains film_id (PK) and language_id (FK).

language table: Contains language_id (PK) and language_name.
*/

/* 4. Take a specific table in Sakila and guide through the process of normalizing it from the initial unnormalized form up to at least 2NF.
-- Normalization Process: From Unnormalized to 2NF (Hypothetical Example)

-- Step 1: Unnormalized Form (UNF) - No code to execute, this is a theoretical starting point.
-- Imagine a single table with all film, actor, and category information, including repeating groups.
-- Example Table Structure:
-- CREATE TABLE film_unnormalized (
--     film_id INT,
--     title VARCHAR(255),
--     rental_rate DECIMAL(4,2),
--     language_name VARCHAR(50),
--     category_name VARCHAR(50),
--     actor_name VARCHAR(255),
-- );

-- Step 2: Normalize to First Normal Form (1NF)
-- Action: Break the table into separate entities to eliminate repeating groups and non-atomic values.
-- We create a linking table (film_actor) to handle the many-to-many relationship.

-- Assuming 'film' and 'category' are already 1NF tables, we create a new 'film_actor' table.
CREATE TABLE IF NOT EXISTS actor (
    actor_id INT PRIMARY KEY,
    actor_name VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS film_actor (
    film_id INT,
    actor_id INT,
    PRIMARY KEY (film_id, actor_id) -- Composite Primary Key
);

-- Step 3: Normalize to Second Normal Form (2NF)
-- Action: Ensure all non-key attributes are fully dependent on the entire primary key.
-- In our 'film_actor' table, 'actor_name' depends only on 'actor_id', which is only part of the composite key. This is a partial dependency.

-- We remove the 'actor_name' column from 'film_actor' and put it in the 'actor' table where it's fully dependent on the primary key ('actor_id').
-- We've already defined a correct 'actor' table above, so no new table creation is needed.

-- The resulting normalized tables are:
-- film_actor (now in 2NF):
-- film_id (part of PK, FK)
-- actor_id (part of PK, FK)

-- actor (now in 2NF):
-- actor_id (PK)
-- actor_name

-- This demonstrates the normalization process by creating and structuring tables to meet the 1NF and 2NF requirements.
*/

-- 5. Write a query using a CTE to retrieve the distinct list of actor names and the number of films they have acted in from the actor
WITH ActorFilmCounts AS (
    SELECT
        a.first_name,
        a.last_name,
        COUNT(fa.film_id) AS number_of_films
    FROM
        actor AS a
    JOIN
        film_actor AS fa ON a.actor_id = fa.actor_id
    GROUP BY
        a.actor_id, a.first_name, a.last_name
)
SELECT
    first_name,
    last_name,
    number_of_films
FROM
    ActorFilmCounts
ORDER BY
    number_of_films DESC,
    last_name ASC;

-- 6. Create a CTE that combines information from the film and language tables to display the film title, language name, and rental rate.
WITH FilmLanguageInfo AS (
    SELECT
        f.title,
        l.name AS language_name,
        f.rental_rate
    FROM
        film AS f
    JOIN
        language AS l ON f.language_id = l.language_id
)
SELECT
    title,
    language_name,
    rental_rate
FROM
    FilmLanguageInfo
ORDER BY
    title;


-- 7. Write a query using a CTE to find the total revenue generated by each customer (sum of payments) from the customer  and payment tables.
WITH CustomerRevenue AS (
    SELECT
        customer_id,
        SUM(amount) AS total_revenue
    FROM
        payment
    GROUP BY
        customer_id
)
SELECT
    c.first_name,
    c.last_name,
    cr.total_revenue
FROM
    customer AS c
JOIN
    CustomerRevenue AS cr ON c.customer_id = cr.customer_id
ORDER BY
    cr.total_revenue DESC;
    
-- 8. Utilize a CTE with a window function to rank films based on their rental duration from the film table.
WITH FilmRank AS (
    SELECT
        title,
        rental_duration,
        RANK() OVER (ORDER BY rental_duration DESC) AS duration_rank
    FROM
        film
)
SELECT
    title,
    rental_duration,
    duration_rank
FROM
    FilmRank
WHERE
    duration_rank <= 10; -- Example: retrieving the top 10 ranked films
    
-- 9.  Create a CTE to list customers who have made more than two rentals, and then join this CTE with the customer table to retrieve additional customer details
-- CTE to find customers with more than two rentals
WITH FrequentCustomers AS (
    SELECT
        customer_id
    FROM
        rental
    GROUP BY
        customer_id
    HAVING
        COUNT(rental_id) > 2
)
-- Join the CTE with the customer table to get details
SELECT
    c.first_name,
    c.last_name,
    c.email,
    c.address_id
FROM
    customer AS c
JOIN
    FrequentCustomers AS fc ON c.customer_id = fc.customer_id
ORDER BY
    c.last_name, c.first_name;
    

-- 10. Write a query using a CTE to find the total number of rentals made each month, considering the rental_date from the rental table
WITH MonthlyRentals AS (
    SELECT
        DATE_FORMAT(rental_date, '%Y-%m') AS rental_month,
        COUNT(rental_id) AS total_rentals
    FROM
        rental
    GROUP BY
        rental_month
)
SELECT
    rental_month,
    total_rentals
FROM
    MonthlyRentals
ORDER BY
    rental_month;
    
-- 11. Create a CTE to generate a report showing pairs of actors who have appeared in the same film together, using the film_actor table.
WITH ActorFilmPairs AS (
    SELECT
        fa1.actor_id AS actor_id_1,
        fa2.actor_id AS actor_id_2,
        fa1.film_id
    FROM
        film_actor AS fa1
    JOIN
        film_actor AS fa2
        ON fa1.film_id = fa2.film_id AND fa1.actor_id < fa2.actor_id
)
SELECT
    a1.first_name AS actor_1_first_name,
    a1.last_name AS actor_1_last_name,
    a2.first_name AS actor_2_first_name,
    a2.last_name AS actor_2_last_name,
    f.title AS film_title
FROM
    ActorFilmPairs AS afp
JOIN
    actor AS a1 ON afp.actor_id_1 = a1.actor_id
JOIN
    actor AS a2 ON afp.actor_id_2 = a2.actor_id
JOIN
    film AS f ON afp.film_id = f.film_id
ORDER BY
    film_title, actor_1_last_name, actor_2_last_name;
    
    
-- 12. Implement a recursive CTE to find all employees in the staff table who report to a specific manager, considering the reports_to column.
SELECT
    s1.first_name,
    s1.last_name,
    s2.first_name AS manager_first_name,
    s2.last_name AS manager_last_name
FROM
    staff AS s1
JOIN
    staff AS s2 ON s1.reports_to = s2.staff_id
WHERE
    s2.staff_id = 1; -- Replace 1 with the manager's staff_id









