--> DAY 8 - MAR 15, 2026


--------------------------------------------------------------------


VIEW

-- Syntax:
CREATE VIEW view_name AS ---SELECT STATEMENT


-- Example:
CREATE VIEW viewAllEmployee
AS
SELECT
E.EmployeeID,
E.EmployeeName,
E.Age,
E.Salary
FROM
Employee AS E
INNER JOIN Department AS D ON E.DepartmentID=D.DepartmentID


SELECT * FROM Employee

SELECT * FROM viewAllEmployee
-- Now we can reuse the VIEW every time we need this set of data

----------------------

CREATE TABLE ProductSales (
    Id INT PRIMARY KEY,
    ProductName VARCHAR(100),
    SalesYear INT,
    SalesAmount DECIMAL(10,2)
);


INSERT INTO ProductSales (Id, ProductName, SalesYear, SalesAmount) VALUES
(1, 'Laptop', 2022, 85000.50),
(2, 'Laptop', 2023, 92000.75),
(3, 'Laptop', 2024, 98000.00),

(4, 'Smartphone', 2022, 65000.25),
(5, 'Smartphone', 2023, 71000.40),
(6, 'Smartphone', 2024, 77000.90),

(7, 'Tablet', 2022, 42000.60),
(8, 'Tablet', 2023, 45000.00),
(9, 'Tablet', 2024, 48000.30),

(10, 'Headphones', 2022, 15000.20),
(11, 'Headphones', 2023, 16500.50),
(12, 'Headphones', 2024, 17800.75);

SELECT * FROM ProductSales;


--------------------------------------------------------------------


PIVOT
--> Transform row data into column format

-- 3rd step
SELECT
ProductName, [2023], [2024] --> to use number as column, we need [ ]
FROM

-- 1st step
(
    SELECT
    ProductName, SalesYear, SalesAmount
    FROM ProductSales
) AS P

-- 2nd step
PIVOT
(
    -- Now we need to aggreate function
    SUM(SalesAmount) FOR SalesYear IN([2023], [2024])
) AS P1

-- if we have multiple years then we need Dynamic SQL (out of topic)


--------------------------------------------------------------------


UNPIVOT
--> Transform column data into row format

CREATE TABLE StudentResult (
    StuID INT PRIMARY KEY,
    Mat INT,
    Phy INT,
    Bio INT
);

INSERT INTO StudentResult (StuID, Mat, Phy, Bio) VALUES
(1, 78, 85, 90), (2, 65, 70, 72), (3, 88, 92, 81), 
(4, 55, 60, 58), (5, 91, 89, 94), (6, 73, 68, 75),
(7, 84, 80, 79), (8, 62, 66, 64);

SELECT * FROM StudentResult;

| StuID     | Mat      | Phy      | Bio      |
| --------- | -------- | -------- | -------- |
| 1         | 78       | 85       | 90       |
| 2         | 65       | 70       | 72       |
| 3         | 88       | 92       | 81       |
| 4         | 55       | 60       | 58       |
| 5         | 91       | 89       | 94       |

--> To convert the subjects (columns) into rows, you can use the UNPIVOT operator

| StuID     | Subject  | Marks | --> We are creating 2 new columns
| --------- | -------- | ----- |
| 1         | Mat      | 78    |
| 1         | Phy      | 85    |
| 1         | Bio      | 90    |
| 2         | Mat      | 65    |
| 2         | Phy      | 70    |
| 2         | Bio      | 72    |
| 3         | Mat      | 88    |
| 3         | Phy      | 92    |
| 3         | Bio      | 81    |

----------------------

-- To achive this, the steps are:

-- 3rd step
SELECT
    StuID, Subject, Marks
From

--1st step
(
    SELECT
    StuID, Mat, Phy, Bio
    FROM
    StudentResult
) AS SR

-- 2nd step
UNPIVOT
(
    Marks FOR Subject IN([Mat], [Phy], [Bio])
) AS P


-- Unpivot Table:
-- The Purpose Converts columns into rows.
-- It use To normalize data for analysis, ETL, or reporting. 
-- It makes wide tables (with many columns) easier to process in SQL or analytics tools.

--------------------------------------------------------------------


SUBQUERY
--> Query with in an another query
--> Nested Query

-- Q. Write a query to display those employee who is getting maximum salary
SELECT * FROM Employee

-- Find the max salary
SELECT MAX(Salary) FROM Employee

SELECT * FROM Employee WHERE Salary = 78000 --> Hard coding, this is not dynamic, not good

-- So the proper way is to write SUBQUERY
SELECT * FROM Employee 
WHERE Salary = (SELECT MAX(Salary) FROM Employee)


--------------------------------------------------------------------


CO-Related SUBQUERY
--> It is the extension of subquery
--> Here both query are dependent to each other

-- Q. Write a  query to display employee who is getting max salary department wise.
SELECT * FROM Employee
SELECT * FROM Department

SELECT * FROM Employee AS A
WHERE Salary = ( --> = operator in SUBQUERY
    SELECT MAX(Salary) 
    FROM Employee AS B
    WHERE A.DepartmentID = B.DepartmentID
)

-- Q. Write a query to display those employee who does not have any department info?

SELECT FROM Employee WHERE DepartmentID IS NULL --> IS operator in SUBQUERY
--> We can not use DepartmentID = NULL


--------------------------------------------------------------------


-- Till now we created Parment Table

TEMP TABLE
--> Only accessable within the query window session it was created
--> It wont get save in DB
--> But while creating, all temp table have to have unique name
--> But parma table and temp table can have same name

SELECT * FROM Employee --> Will works in any SQLQuery file inside this Database

-- Every query window has its unique session id
SELECT @@SPID

CREATE TABLE StudentInfo (Id INT, Name VARCHAR(50)) --> This will create parmanent table

INSERT INTO StudentInfo (Id, Name) VALUES
(1, 'Rahul'),(2, 'Amit'),(3, 'Priya'),
(4, 'Sneha'),(5, 'Arjun'),(6, 'Karan'),
(7, 'Neha'),(8, 'Riya');

SELECT * FROM StudentInfo; 

--> To create a temporary table just put # infront of table name
--> To perform any CRUD operation, we have to use #

CREATE TABLE #StudentInfo (Id INT, Name VARCHAR(50)) --> This will create a temporary table

INSERT INTO #StudentInfo (Id, Name) VALUES
(1, 'Rahul'),(2, 'Amit'),(3, 'Priya'),
(4, 'Sneha'),(5, 'Arjun'),(6, 'Karan'),
(7, 'Neha'),(8, 'Riya');

SELECT * FROM #StudentInfo;

----------------------

-- Q. Write a PROCEDURE which will accept a DepartmentID and 
-- we have to return employies who are getting more salary than agrage salary of that department.


SELECT * FROM Employee

-- This is Sahil Jaiswal's Code
ALTER PROCEDURE usp_get_employee_Salary_morethan_avgsalary
(
@DepartmentID INT
)
AS 
BEGIN 

CREATE TABLE #EmployeeFilteredData 
(
EmployeeID INT,
FIrstName VARCHAR(50),
LastName VARCHAR(50),
Salary INT,
DepartmentID INT
)

INSERT INTO #EmployeeFilteredData
(
EmployeeID,FIrstName,LastName,Salary,DepartmentID
)

SELECT
EmployeeID,FIrstName,LastName,Salary,DepartmentID
FROM 
Employee 
WHERE DepartmentID=@DepartmentID

CREATE TABLE #DepartmentAvgSalary 
(
DepartmentID INT,
AverageSalary INT
)

INSERT INTO #DepartmentAvgSalary(DepartmentID,AverageSalary)
SELECT 
DepartmentID,
AVG(Salary) 
FROM 
#EmployeeFilteredData
GROUP BY DepartmentID

SELECT 
* 
FROM 
#EmployeeFilteredData AS EF 
INNER JOIN #DepartmentAvgSalary AS DA ON EF.DepartmentID=DA.DepartmentID
WHERE EF.Salary>DA.AverageSalary
END

-- so the PROCEDURE was not executing because of parma table, 
-- so we need temp table, but we cannot create temp table with same name again, 
-- then how we are able to execute the PROCEDURE again

-- so for every bd calls there new query window/session will get created


--------------------------------------------------------------------

-- Temp table take up memory space within the session
-- To delete all temp table

COMMON TABLE EXPRESSION (CTE)
--> only accessable for next line

-- Syntax:
;WITH cte_name
AS (
    SELECT * FROM table_name WHERE column_name=row_data
)

SELECT * FROM cte_name

--> There was a big query, I was not able to write

-- Session End