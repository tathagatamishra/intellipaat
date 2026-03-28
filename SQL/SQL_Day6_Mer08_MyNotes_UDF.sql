--> DAY 6 - MAR 8, 2026


AGGREGATE FUNCTION

-- Types:
	a) SUM()
	b) MAX()
	c) MIN()
	d) AVG()
	e) COUNT()

----------------------

*** Important topic missed here ***

-- Joined 30 min Late in the SQL Session


--------------------------------------------------------------------
--------------------------------------------------------------------


i) SYSTEM-DEFINED FUNCTIONS
----------------------

WINDOW FUNCTION

-- Types:
	a) ROW_NUMBER()
	b) RANK()
	c) DENSE_RANK()
	d) NTILE()

----------------------

a) ROW_NUMBER() --> to display Sequence number

SELECT * FROM UserData
SELECT ROW_NUMBER()OVER(ORDER BY Salary ASC) AS RowID, * FROM UserData

SELECT ROW_NUMBER() AS RowID, * FROM UserData 
-- Getting this error: 
--> The function 'ROW_NUMBER' must have an OVER clause.

-- Question is: Do we have to use OVER function in order to use ROW_NUMBER
--> YES

-- without any sorting is it possible?
--> row number is only for sorting the data



b) RANK() --> It will compair Salary column data and assign Rank to them

INSERT INTO UserData(UserID, UserName, Age, DOB, Gender, Salary) 
VALUES(6, 'Big Bill', 27, '1995-12-10', 'M', 52000.00)

SELECT RANK()OVER(ORDER BY Salary ASC) AS RankID, * FROM UserData

RankID Salary
1	   10
1      10    --> 
3      20    --> Skip value 2
4      30
5      50



c) DENSE_RANK() --> Rank without skipping any value

SELECT DENSE_RANK()OVER(ORDER BY Salary ASC) AS RankID, * FROM UserData

RankID Salary
1	   10
1      10    
2      20    
3      30
4      50


-- Q. Write a query to display 3rd highest salary.

SELECT * FROM
(
SELECT DENSE_RANK()OVER(ORDER BY Salary DESC) AS RankID, * FROM UserData
) AS W WHERE RankID = 3



d) NTILE() --> Divide the data in multiple group

-- Syntax:
NTILE(number of groups)

-- Example:

-- Divide the data in 3 groups
SELECT * FROM UserData 

--> Total number of records = 6
--> Total group need to create = 3
--> Records contain in each group = 6/3 = 2
G1 --> 2
G2 --> 2
G3 --> 2

--> But in UserData table there are 7 records
G1 --> 2+1 = 3
G2 --> 2
G3 --> 2

--> If in UserData table there are 8 records
G1 --> 3
G2 --> 3
G3 --> 2

SELECT NTILE(3)OVER(ORDER BY Salary DESC) AS GroupID, * FROM UserData


-- Q. Write a query to display those user getting salary more than 50k
--> We need WHERE

SELECT * FROM UserData WHERE Salary > 50000

-- Q. Display in each department how much salary company is spending.

SELECT * FROM Employee

SELECT D.DepartmentName, SUM(Salary) FROM Employee AS ED
INNER JOIN Department AS D ON ED.DepartmentID=D.DepartmentID
GROUP BY D.DepartmentName

SELECT D.DepartmentName, SUM(Salary) FROM Employee AS ED
INNER JOIN Department AS D ON ED.DepartmentID=D.DepartmentID
WHERE SUM(Salary)>50000
GROUP BY D.DepartmentName
--> Wrong
--> Aggrate function will not work with WHERE

SELECT D.DepartmentName, 
SUM(Salary) 
FROM Employee AS ED
INNER JOIN Department AS D ON ED.DepartmentID=D.DepartmentID
GROUP BY D.DepartmentName
HAVING SUM(Salary)>50000
--> We need HAVING




--------------------------------------------------------------------
--------------------------------------------------------------------



ii) USER-DEFINED FUNCTIONS / UDF

-- Types:
	a) SCALAR FUNCTION
	b) TABLE VALUED FUNCTION


----------------------

a) SCALAR FUNCTION 
--> Function that return a data in a single record and single column
--> Only one value will be returned by the query

-- Syntax: 
CREATE FUNCTION function_name ( @parameter_name DATATYPE ) RETURNS DATATYPE
AS 
BEGIN
RETURN
(
-- SQL QUERY
)
END

-- Q. Write afunction which will accept a EmployeeID and it will return a EmployeeName
SELECT * FROM Employee

CREATE FUNCTION getNameById ( @EmployeeID INT ) RETURNS VARCHAR(100)
AS 
BEGIN
RETURN
(
SELECT EmployeeName FROM Employee
WHERE EmployeeID=@EmployeeID
)
END

--> Calling the function
SELECT getNameById(1)
--> Getting error: 'getNameById' is not a recognized built-in function name.

--> Whenever we try to calling USER-DEFINED SCALAR FUNCTION function we have to use dbo.function_name
SELECT dbo.getNameById(1)
--> dbo is schema

DATABASE
	SCHEMA
		OBJECT
			(TABLE/FUNCTION/STORE PROCEDURE/TRIGGER)


----------------------

--> How to modify USER-DEFINED SCALAR FUNCTION
--> Need to use ALTER

ALTER FUNCTION getNameById ( @EmployeeID INT ) RETURNS VARCHAR(50)
AS 
BEGIN
RETURN
(
SELECT EmployeeName FROM Employee
WHERE EmployeeID=@EmployeeID
)
END

--> Delete USER-DEFINED SCALAR FUNCTION
--> Need to use DROP
-- Syntax:
DROP FUNCTION function_name
DROP FUNCTION getNameById