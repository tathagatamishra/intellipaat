--> DAY 10 - MAR 22, 2026


--------------------------------------------------------------------
-- Creating new database, table to perform today's queries
CREATE DATABASE Day10Database
USE Day10Database
CREATE TABLE Employee
(
	EmployeeID INT PRIMARY KEY,
	EmployeeName VARCHAR(50) NOT NULL,
	Age INT CHECK (Age >= 18),
	Salary INT CHECK (Salary > 0),
	Sex VARCHAR(2),
	DepartmentID INT
)
CREATE TABLE Department
(
	DepartmentID INT PRIMARY KEY,
	DepartmentName VARCHAR(50) NOT NULL UNIQUE
)
INSERT INTO Employee (EmployeeID, EmployeeName, Age, Salary, Sex, DepartmentID) VALUES
(1, 'John Doe', 30, 50000, 'M', 2),
(2, 'Alice', 28, 60000, 'F', 1),
(3, 'Bob', 35, 55000, 'M', 3),
(4, 'Charlie', 32, 70000, 'M', 2),
(5, 'Eve', 27, 65000, 'F', 4),
(6, 'David', 29, 48000, 'M', 5),
(10, 'Spoit', 18, 78000, NULL, 1);
INSERT INTO Department (DepartmentID, DepartmentName) VALUES
(3, 'Finance'),
(1, 'HR'),
(2, 'IT'),
(4, 'Marketing'),
(5, 'Sales');
SELECT * FROM Employee
SELECT * FROM Department
--------------------------------------------------------------------
--------------------------------------------------------------------



--OPERATORS

a) UNION
b) UNION ALL
c) EXCEPT
d) INTERSECT

--Rule for all of the above OPERATORS:

--1. Number of column should be always same in each SELECT statement
--2. In each SELECT statement crossponding column should have same datatype


-------------------------

SELECT * FROM Employee WHERE DepartmentID=2

SELECT * FROM Employee WHERE EmployeeID=1

-- To combine all these SELECT statement and data will return as single output
-- We need UNION

-------------------------


--a) UNION

-- UNION always return unique data, and remove any duplicate data
SELECT * FROM Employee WHERE DepartmentID=2
UNION
SELECT * FROM Employee WHERE EmployeeID=5


--Q. Can we use different table?
--> Yes

SELECT * FROM Employee WHERE EmployeeID=5
UNION
SELECT * FROM Department WHERE DepartmentID=2
--> Error

--Rule:
--1. Number of column should be always same in each SELECT statement
--2. In each SELECT statement crossponding column should have same datatype

SELECT EmployeeName FROM Employee WHERE EmployeeID=1
UNION
SELECT DepartmentName FROM Department WHERE DepartmentID=2


-------------------------

--b) UNION ALL

-- same as UNION but keeps duplicates

SELECT * FROM Employee WHERE DepartmentID = 2
UNION ALL
SELECT * FROM Employee WHERE EmployeeID = 4

-- EmployeeID=4 already belongs to DepartmentID=2,
-- so it appears TWICE (duplicate kept)

-------------------------

--c) EXCEPT

--> Return all the data from 1st SELECT statement
--> But only those records will be considered which is not present in the other SELECT statement

SELECT * FROM Employee WHERE DepartmentID=1
EXCEPT
SELECT * FROM Employee WHERE EmployeeID=2 OR DepartmentID=3


-------------------------

--d) INTERSECT

-- This will return only those record which is present in every SELECT statement
-- Returns only rows common to both SELECT statements

SELECT * FROM Employee WHERE DepartmentID = 2
INTERSECT
SELECT * FROM Employee WHERE EmployeeID = 4
-- Only EmployeeID=4 appears in BOTH → only that row is returned

SELECT * FROM Employee WHERE Salary > 50000
INTERSECT
SELECT * FROM Employee WHERE Age < 30
-- Returns employees who BOTH earn >50000 AND are younger than 30
-- Result: Alice (28, 60000), Eve (27, 65000)


--------------------------------------------------------------------

--------------------------------------------------------------------


CREATE TABLE CardTable (CardID INT, CardName VARCHAR(10))
CREATE TABLE CardCount (CardCount INT)

SELECT * FROM CardTable
SELECT * FROM CardCount

INSERT INTO CardCount(CardCount)VALUES(0)


-------------------------

-- TRIGGER

--> A object that eill auto executed when defined event occured.

--Types:
a) DML TRIGGER
b) DDL TRIGGER


-------------------------

--a) DML TRIGGER
-- We want to update the CardCount value automaticaly increase base on CardTable

--Syntax:
CREATE TRIGGER trigger_name ON Table_name
AFTER DML_OPERATION 
AS
BEGIN 
--SQL Query
END


--Example:

CREATE TRIGGER TriggerCardCount ON CardTable
AFTER INSERT 
AS
BEGIN 
UPDATE CardCount SET CardCount=CardCount+1
END

SELECT * FROM CardTable
SELECT * FROM CardCount

INSERT INTO CardTable(CardID, CardName) VALUES(1, 'Pikachu')
INSERT INTO CardTable(CardID, CardName) VALUES(2, 'Charizard')
INSERT INTO CardTable(CardID, CardName) VALUES(3, 'Squirtle')


--Q. Create a TRIGGER that decrease the count when removing the data from CardTable
CREATE TRIGGER DTriggerCardCount ON CardTable
AFTER DELETE 
AS
BEGIN 
UPDATE CardCount SET CardCount-=1
END

DELETE FROM CardTable
WHERE CardID=1;

--Q. How to show an update message
CREATE TRIGGER <name> ON <table>
AFTER UPDATE 
AS
BEGIN 
SELECT 'update message'
END

--Q. How to drop the DML TRIGGER
DROP TRIGGER trigger_name


-------------------------

PRINT 'created';  -- ✅ correct
SELECT 'created'; -- ❌ not ideal in triggers

-------------------------

FOR = AFTER in DDL triggers
-- No behavioral difference
-- FOR is recommended purely for:
	--consistency
	--clarity
	--convention

-------------------------


--b) DDL TRIGGER

--Q. Want to display a message when someone created/altered/dropped a table

CREATE TRIGGER TriggerCreateMsg ON DATABASE
FOR CREATE_TABLE 
AS
BEGIN 
	PRINT 'created'
END;

CREATE TRIGGER TriggerAlterMsg ON DATABASE
FOR ALTER_TABLE 
AS
BEGIN 
	PRINT 'altered'
END;

CREATE TRIGGER TriggerDropMsg ON DATABASE
FOR DROP_TABLE 
AS
BEGIN 
	PRINT 'deleted'
END;

--Q. How to drop the DDL TRIGGER
DROP TRIGGER TriggerCreateMsg ON DATABASE
DROP TRIGGER TriggerAlterMsg ON DATABASE
DROP TRIGGER TriggerDropMsg ON DATABASE

--Testing TriggerCreateMsg:
CREATE TABLE computers (
    computer_id INT PRIMARY KEY,
    brand VARCHAR(100),
    model VARCHAR(100)
);

CREATE TABLE components (
    component_id INT PRIMARY KEY,
    component_name VARCHAR(100),
    type VARCHAR(50),
    computer_id INT,
    FOREIGN KEY (computer_id) REFERENCES computers(computer_id)
);

INSERT INTO computers VALUES
(1, 'Dell', 'XPS 15'),
(2, 'Apple', 'MacBook Pro'),
(3, 'HP', 'Pavilion');

INSERT INTO components VALUES
(101, 'Intel i7', 'CPU', 1),
(102, '16GB RAM', 'RAM', 1),
(103, 'M2 Chip', 'CPU', 2),
(104, '8GB RAM', 'RAM', 3);

--Testing TriggerCreateMsg:
ALTER TABLE components ADD manufacturer VARCHAR(100);


--------------------------------------------------------------------


-- INDEX

-- A table which have almost 1m records
-- If we want to fetch a data then it will iterate 1m records to get the data

-- Example: 
-- We have 2 books:
BOOK A --has(Index Page) --> in the 1st page we have all the information about the book
BOOK B --dont have index page

SELECT * FROM BookA WHERE Story='Once Upon A Time'


--Types:
a) CLUSTERED Index  
--> in each table max we can create 1 CLUSTERED index.
--> When we create a primary key, SQL create CLUSTERED index itself.
--> We cant create CLUSTERED Index anymore if there is primary key

b) NONCLUSTERED Index
-->

--b) NONCLUSTERED Index

CREATE NONCLUSTERED INDEX IndexName ON TableName(ColumnName)

-- How to drop index?
DROP INDEX IndexName ON TableName

--Test:
CREATE TABLE BookA (
    page_id INT PRIMARY KEY,
    page_number INT UNIQUE,
    title VARCHAR(100)
);




--------------------------------------------------------------------


-- ROLLUP

--> Its an extended vesirson of GROUP BY claus
-- Creates hierarchical aggregation:
    --Detailed rows
    --Subtotals
    --Grand total

--Syntax:
SELECT column1, column2, AGG_FUNC(column)
FROM table
GROUP BY ROLLUP (column1, column2);

-- Test:

CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    continent VARCHAR(50),
    country VARCHAR(50),
    city VARCHAR(50),
    amount INT
);

INSERT INTO sales VALUES
(1, 'Asia', 'India', 'Delhi', 500),
(2, 'Asia', 'India', 'Mumbai', 700),
(3, 'Asia', 'China', 'Beijing', 800),
(4, 'Asia', 'China', 'Shanghai', 600),

(5, 'Europe', 'Germany', 'Berlin', 650),
(6, 'Europe', 'Germany', 'Munich', 550),
(7, 'Europe', 'France', 'Paris', 900),
(8, 'Europe', 'France', 'Lyon', 400),

(9, 'North America', 'USA', 'New York', 1000),
(10, 'North America', 'USA', 'Los Angeles', 850),
(11, 'North America', 'Canada', 'Toronto', 600),
(12, 'North America', 'Canada', 'Vancouver', 500);

SELECT * FROM sales

SELECT 
continent, country, SUM(amount) 
FROM sales
GROUP BY continent, country

SELECT 
continent, country, SUM(amount) 
FROM sales
GROUP BY ROLLUP(continent, country)

SELECT 
continent, country, city, SUM(amount) 
FROM sales
GROUP BY ROLLUP(continent, country, city)


--------------------------------------------------------------------

-- CUBE
-- Generates all possible combinations of grouping

-- Example:
SELECT continent, country, SUM(amount)
FROM sales
GROUP BY CUBE(continent, country);


-------------------------
-- 😓 Have no idea what is ROLLUP & CUBE actually do 
-- Why NULLs are there in the output?
-------------------------


--------------------------------------------------------------------
--------------------------------------------------------------------


--Useful Functions

a) CAST() 
b) CONVERT()
c) IIF()
d) ISNULL()
e) COALESCE()

-------------------------


--a) CAST() 
-- Convert one datatype into another datatype
SELECT CAST(GETDATE() AS date)
SELECT CAST(GETDATE() AS date)

SELECT CAST(1 AS VARCHAR(1)) + 'A'  --> '1' + 'A'

-------------------------

--b) CONVERT()
-- To display date as yyyy-mm-dd / dd-mm-yyyy / dd-mon-yyyy
SELECT CONVERT(VARCHAR(20), GETDATE(), 101)
SELECT CONVERT(VARCHAR(20), GETDATE(), 102)
SELECT CONVERT(VARCHAR(20), GETDATE(), 103)
SELECT CONVERT(VARCHAR(20), GETDATE(), 104)
SELECT CONVERT(VARCHAR(20), GETDATE(), 105)
SELECT CONVERT(VARCHAR(20), GETDATE(), 106)

-------------------------

--c) IIF()
--Parameters:
i) Expression
ii) True
iii) False

-- To perform some operation based on some condition

SELECT * FROM Employee
-- Here if Sex = 'M' then show Male else Female

SELECT *, IIF(Sex='M', 'Male', 'Female') FROM Employee

-- To handle NULL we need Nested IIF

SELECT *,
IIF(Sex IS NULL, 'Not Specified',
    IIF(Sex = 'M', 'Male', 'Female')
) 
AS Gender
FROM Employee;

-------------------------

--d) ISNULL()

INSERT INTO Employee (EmployeeID, EmployeeName, Age, Salary, Sex, DepartmentID)
VALUES (11, 'Test User', 25, NULL, 'M', 2);
SELECT * FROM Employee

SELECT 
    EmployeeID,
    EmployeeName,
    Age,
    ISNULL(Salary, 0) AS Salary,
    Sex,
    DepartmentID
FROM Employee;

-------------------------

--e) COALESCE()

-- We want to set-
-- if Address1 is NULL then Address2, if Address2 is null then Address3 so on

CREATE TABLE EmployeeAddress (
    EmployeeID INT,
    Address1 VARCHAR(100),
    Address2 VARCHAR(100),
    Address3 VARCHAR(100)
);

INSERT INTO EmployeeAddress VALUES
(1, '123 Main St', 'Near Park', 'Delhi'),
(2, NULL, 'Lake Road', 'Mumbai'),
(3, NULL, NULL, 'Bangalore'),
(4, NULL, NULL, NULL);

SELECT * FROM EmployeeAddress


SELECT EmployeeID,
COALESCE(Address1, Address2, Address3, 'No Address') AS FinalAddress
FROM EmployeeAddress;

--Output look like this

| EmployeeID | FinalAddress |
| ---------- | ------------ |
| 1          | 123 Main St  |
| 2          | Lake Road    |
| 3          | Bangalore    |
| 4          | No Address   |

-------------------------

-- Difference of ISNULL & COALESCE

| Function              | Capability      |
| --------------------- | --------------- |
| ISNULL(a, b)          | Only 2 values   |
| COALESCE(a, b, c, d)  | Multiple values |
