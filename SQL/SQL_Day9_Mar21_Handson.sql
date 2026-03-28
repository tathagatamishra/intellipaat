--> DAY 9 - MAR 21, 2026

--HANDS-ON SESSION
--------------------------------------------------------------------

--Q. Create a database
CREATE DATABASE FakeDatabase

USE FakeDatabase

-------------------------

--Q. 5 Difference between VARCHAR and CHAR
-- Difference, Examples, Efficiency, Padding

--CHAR
1. Fixed length of memory
2. Extra/rest of the memory filled with spaces known as padding
4. Indexes are faster and more predictable because of fixed size keys
5. Use when length is constant, Example: PIN, Gender, Country Code, Phone

--VARCHAR
1. Variable length space 
2. (n chars = n bytes) + extra bytes for matadata such as length of the string
3. Take 1 or 2 bytes to store metadata
4. Performance wise its slightly slow
5. Storage is getting allocated dynamically while inserting
6. No padding of spaces, it just stores the metadata
7. Use when length varies, Example: Name, Email, Address

-------------------------

--Q. Find the difference between NCHAR and NVARCHAR

--NCHAR
1. Wastes storage
   AddNCHAR(5) storing 'GG' → 'GG   '

2. Faster because
   - Fixed-length operations
   - Predictable row size

3. CPU Cost = Low

4. Faster in CPU-bound scenarios

5. 16 bits or 2 bytes per character

--NVARCHAR
1. More efficient storage
   NVARCHAR(5) storing 'GG' → 'GG'

2. stores Actual data + length metadata (2 bytes)

3. CPU Cost = Higher

4. Faster in real-world large datasets due to less disk I/O

-------------------------

--Q. Create a table with id and name with int and varchar datatype.
-- If inserting hindi name, will there be an error?
-- What kind of error?
-- Test it by doing it.

CREATE TABLE RandomTable (
    id INT,
    name VARCHAR(50)
);

INSERT INTO RandomTable VALUES (1, 'ありがとう');

SELECT * FROM RandomTable

-- No runtime error
-- But data becomes corrupted / replaced with ????

-------------------------

--Q. Create a table with id and name with int and nvarchar datatype.
-- If inserting hindi name, will there be an error?
-- What kind of error?
-- Test it by doing it.

CREATE TABLE AnotherTable (
    id INT,
    name NVARCHAR(50)
);

INSERT INTO AnotherTable VALUES (1, N'ありがとう');

SELECT * FROM AnotherTable

-------------------------

--Q. Explain all SQL commands

-- COMMAND CATEGORY

a) DDL (Data Definition Language)
-- CREATE, ALTER, DROP, TRUNCATE, RENAME

b) DQL (Data Query Language)
-- SELECT

c) DML (Data Manipulation Language) --> Works on row level
-- INSERT, UPDATE, DELETE, MERGE
-- MERGE = Combine INSERT + UPDATE

d) DCL (Data Control Language)
-- GRANT, REVOKE

e) TCL (Transaction Control Language)
-- COMMIT, ROLLBACK, SAVEPOINT, SET TRANSACTION

--------------------------------------------------------------------


CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    address VARCHAR(150),
    city VARCHAR(50),
    state VARCHAR(50),
    zip VARCHAR(10)
);


INSERT INTO customer VALUES
(1, 'Gaurav', 'Sharma', 'gaurav@gmail.com', 'Street 1', 'SanJose', 'CA', '95101'),
(2, 'Geeta', 'Verma', 'geeta@yahoo.com', 'Street 2', 'SanJose', 'CA', '95102'),
(3, 'Rohan', 'Mehta', 'rohan@gmail.com', 'Street 3', 'Dallas', 'TX', '75001'),
(4, 'Gita', 'Kapoor', 'gita@gmail.com', 'Street 4', 'SanJose', 'CA', '95103'),
(5, 'Ankit', 'Gupta', 'ankit@gmail.com', 'Street 5', 'NewYork', 'NY', '10001');

SELECT * FROM customer


--Q. Select those records where 'first-name' starts with "G" and city is 'SanJose'

SELECT *
FROM customer
WHERE first_name LIKE 'G%'
  AND city = 'SanJose';


--Q. Select those records where Email has gmail

SELECT *
FROM customer
WHERE email LIKE '%@gmail.com';

'%@gmail.com' --> Will check if ends with
'%@gmail.com%' --> If there is a data with @gmail.com.in, that will also incuded


--Q. Select those records where the 'last_name' doesnt end with "A"
SELECT *
FROM customer
WHERE last_name NOT LIKE '%A';

-- Without using LIKE
-- RIGHT
SELECT *
FROM customer
WHERE RIGHT(last_name, 1) != 'A';

-- LEFT
SELECT *
FROM customer
WHERE LEFT(REVERSE(last_name), 1) <> 'A';



--------------------------------------------------------------------


CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    order_date DATE,
    amount DECIMAL(10,2),
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

INSERT INTO Orders (order_id, order_date, amount, customer_id)
VALUES
(101, '2024-01-10', 250.00, 1),
(102, '2024-01-15', 500.00, 2),
(103, '2024-01-20', 750.00, 3),
(104, '2024-01-25', 300.00, 4),
(105, '2024-01-30', 450.00, 5);


--Q. Make left join on 'customer' and 'Orders' table on the 'customer_id' column
SELECT * FROM customer c
LEFT JOIN Orders o
ON c.customer_id = o.customer_id;

-- If we dont mention which JOIN then it will by default INNER JOIN


--Q. Extract the unmatching rows left table
SELECT c.customer_id
FROM customer c
LEFT JOIN Orders o
ON c.customer_id = o.customer_id
WHERE o.customer_id IS NULL;