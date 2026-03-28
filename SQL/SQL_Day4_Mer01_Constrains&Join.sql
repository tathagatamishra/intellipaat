--> DAY 4 - MAR 1, 2026


CONSTRAINT --> It is a kind of rule which can add on table.column

--> It creates a rule

CREATE TABLE VoterList
(
	VoterID INT,
	VoterName VARCHAR(50),
	Age INT
)
--> Make a rule that Age should be greater than or equal to 18

------------------------------------------

TYPE OF CONSTRAINTS

a) NOT NULL
b) UNIQUE KEY
c) CHECK
d) DEFAULT
e) PRIMARY KEY --> One table can have only one PRIMARY KEY
f) FOREIGN KEY

------------------------------------------

a) NOT NULL --> It is used to make sure that column should not have NULL value

CREATE TABLE VoterList
(
	VoterID INT,
	VoterName VARCHAR(50),
	Age INT
)

INSERT INTO VoterList (VoterName, Age) VALUES ('John Doe', 30)
SELECT * FROM VoterList
------------------------
VoterID  VoterName   Age
NULL	 John Doe	30
------------------------

--> To avoid this we can use NOT NULL constraint
CREATE TABLE VoterList2
(
	VoterID INT NOT NULL,
	VoterName VARCHAR(50),
	Age INT
)

INSERT INTO VoterList2 (VoterName, Age) VALUES ('John Doe', 30) 
--> Cannot insert the value NULL into column 'VoterID'
--> Now its mandatory to add value in VoterID column
INSERT INTO VoterList2 (VoterID, VoterName, Age) VALUES (1, 'John Doe', 30)

------------------------------------------

b) UNIQUE KEY --> It is used to make sure that column should have unique value

CREATE TABLE BankAccounts
(
	AccountNumber INT UNIQUE,
	AccountHolderName VARCHAR(50),
	Balance INT
)
INSERT INTO BankAccounts (AccountNumber, AccountHolderName, Balance) VALUES (12345, 'Alice', 1000)
INSERT INTO BankAccounts (AccountNumber, AccountHolderName, Balance) VALUES (12345, 'Bob', 2000)
--> Violation of UNIQUE KEY constraint

------------------------------------------

c) CHECK --> It is used to make sure that column should satisfy a specific rule or condition

CREATE TABLE GovVoterList
(
	VoterID INT,
	VoterName VARCHAR(50),
	Age INT CHECK (Age >= 18)
)

INSERT INTO GovVoterList (VoterID, VoterName, Age) VALUES (12345, 'John Doe', 30)
INSERT INTO GovVoterList (VoterID, VoterName, Age) VALUES (12346, 'Alice', 17) --> throw error

SELECT * FROM GovVoterList

------------------------------------------

d) DEFAULT --> If user is not passing any value then it  will insert a default value

CREATE TABLE EmployeesTable
(
	EmployeeID INT,
	EmployeeName VARCHAR(50),
	Country VARCHAR(50) DEFAULT 'India'
)
--> if user is not passing any value in Country column then it will insert 'India' as default value

INSERT INTO EmployeesTable (EmployeeID, EmployeeName) VALUES (1, 'John Doe')
INSERT INTO EmployeesTable (EmployeeID, EmployeeName, Country) VALUES (2, 'Alice', 'USA')

SELECT * FROM EmployeesTable

--> What will happen if user is passing NULL value in Country column?

INSERT INTO EmployeesTable (EmployeeID, EmployeeName, Country) VALUES (3, 'Bob', NULL)
SELECT * FROM EmployeesTable

--> It will insert NULL
--> DEFAULT only works when we are not passing any value

------------------------------------------

e) PRIMARY KEY --> (UNIQUE + NOT NULL)

--> It is used to uniquely identify each record in the table
--> One table can have only one PRIMARY KEY constraint but it can have multiple UNIQUE

CREATE TABLE Students
(
	StudentID INT PRIMARY KEY,
	StudentName VARCHAR(50),
	Age INT
)

INSERT INTO Students (StudentID, StudentName, Age) VALUES (1, 'John Doe', 20) --> Ok
INSERT INTO Students (StudentID, StudentName, Age) VALUES (1, 'Bob Dein', 18) --> Not Ok
INSERT INTO Students (StudentID, StudentName, Age) VALUES (NULL, 'Alice', 19) --> Not Ok
INSERT INTO Students (StudentID, StudentName, Age) VALUES (2, 'Alice', 19) --> Ok
SELECT * FROM Students

------------------------------------------

--> Q. Create a table with all the constraints.
CREATE TABLE EmployeeRecords
(
	EmployeeID INT PRIMARY KEY,
	EmployeeName VARCHAR(50) NOT NULL,
	Age INT CHECK (Age >= 18),
	Email VARCHAR(50) UNIQUE,
	Country VARCHAR(50) DEFAULT 'India'
)
INSERT INTO EmployeeRecords (EmployeeID, EmployeeName, Age, Email) VALUES (1, 'John Doe', 30, 'doe@email.com')
SELECT * FROM EmployeeRecords

--> Q. Create a table with multiple constraints in same column.
CREATE TABLE ProductInventory
(
	ProductID INT PRIMARY KEY,
	ProductName VARCHAR(50) NOT NULL UNIQUE,
	Price INT CHECK (Price > 0) NOT NULL
)
INSERT INTO ProductInventory (ProductID, ProductName, Price) VALUES (1, 'Laptop', 1000)
INSERT INTO ProductInventory (ProductID, ProductName, Price) VALUES (2, 'Laptop', 1500) --> Not Ok
INSERT INTO ProductInventory (ProductID, ProductName, Price) VALUES (3, 'Phone', -500) --> Not Ok
INSERT INTO ProductInventory (ProductID, ProductName, Price) VALUES (4, 'Tablet', NULL) --> Not Ok
SELECT * FROM ProductInventory

------------------------------------------

f) FOREIGN KEY --> It is used to create a relationship between two tables

--> Learn when we will learn about JOINS
--> Without the help of a PRIMARY KEY we cannot create a FOREIGN KEY constraint



---------------------------------------------------------------
---------------------------------------------------------------

TYPE OF JOINS

a) INNER JOIN
b) LEFT JOIN
c) RIGHT JOIN
d) FULL OUTER JOIN
e) CROSS JOIN

------------------------------------------

--> Create a Department table and Employee table
CREATE TABLE Department
(
	DepartmentID INT PRIMARY KEY,
	DepartmentName VARCHAR(50) NOT NULL UNIQUE
)
INSERT INTO Department (DepartmentID, DepartmentName) VALUES (1, 'HR')
INSERT INTO Department (DepartmentID, DepartmentName) VALUES (2, 'IT')
INSERT INTO Department (DepartmentID, DepartmentName) VALUES (3, 'Finance')
INSERT INTO Department (DepartmentID, DepartmentName) VALUES (4, 'Marketing')
INSERT INTO Department (DepartmentID, DepartmentName) VALUES (5, 'Sales')
SELECT * FROM Department

--> Now create Employee table with DepartmentID
CREATE TABLE Employee
(
	EmployeeID INT PRIMARY KEY,
	EmployeeName VARCHAR(50) NOT NULL,
	Age INT CHECK (Age >= 18),
	Salary INT CHECK (Salary > 0),
	Sex VARCHAR(2),
	DepartmentID INT
)
INSERT INTO Employee (EmployeeID, EmployeeName, Age, Salary, Sex, DepartmentID) VALUES (1, 'John Doe', 30, 50000, 'M', 2)
INSERT INTO Employee (EmployeeID, EmployeeName, Age, Salary, Sex, DepartmentID) VALUES (2, 'Alice', 28, 60000, 'F', 1)
INSERT INTO Employee (EmployeeID, EmployeeName, Age, Salary, Sex, DepartmentID) VALUES (3, 'Bob', 35, 55000, 'M', 3)
INSERT INTO Employee (EmployeeID, EmployeeName, Age, Salary, Sex, DepartmentID) VALUES (4, 'Charlie', 32, 70000, 'M', 2)
INSERT INTO Employee (EmployeeID, EmployeeName, Age, Salary, Sex, DepartmentID) VALUES (5, 'Eve', 27, 65000, 'F', 4)
INSERT INTO Employee (EmployeeID, EmployeeName, Age, Salary, Sex, DepartmentID) VALUES (6, 'David', 29, 48000, 'M', 5)

SELECT * FROM Employee

--> Show data --> EmployeeID, EmployeeName, DepartmentName
--> We have to combine data from both tables

------------------------------------------

a) INNER JOIN --> It returns only those data which are present in both tables

SELECT EmployeeID, EmployeeName, DepartmentName FROM Employee INNER JOIN Department.DepartmentName=Employee.DepartmentName --> Error
--> Wrong syntax

SELECT EmployeeID, EmployeeName, DepartmentName FROM Employee INNER JOIN Department ON DepartmentName=DepartmentName
--> Wrong syntax --> Need to specify which DepartmentName is from which table

SELECT EmployeeID, EmployeeName, DepartmentName 
FROM Employee 
INNER JOIN Department ON Employee.DepartmentID=Department.DepartmentID
--> Correct syntax

------------------------------------------

--> Rules of JOIN

--> If there is a NULL value in the JOIN condition then it will not return that record in Output
--> If a value is not matching in the JOIN condition then it will not return that record in Output

------------------------------------------
------------------------------------------

FOREIGN KEY CONSTRAINTS
--> Lets learn about FOREIGN KEY

--> Create a Department table and Employee table
CREATE TABLE DepartmentNew
(
	DepartmentID INT PRIMARY KEY, --> It is mandatory to have a PRIMARY KEY
	DepartmentName VARCHAR(50) NOT NULL UNIQUE
)
INSERT INTO DepartmentNew (DepartmentID, DepartmentName) VALUES (1, 'HR')
INSERT INTO DepartmentNew (DepartmentID, DepartmentName) VALUES (2, 'IT')
INSERT INTO DepartmentNew (DepartmentID, DepartmentName) VALUES (3, 'Finance')
INSERT INTO DepartmentNew (DepartmentID, DepartmentName) VALUES (4, 'Marketing')
INSERT INTO DepartmentNew (DepartmentID, DepartmentName) VALUES (5, 'Sales')
SELECT * FROM DepartmentNew

--> Now create Employee table with DepartmentID
CREATE TABLE EmployeeNew
(
	EmployeeID INT PRIMARY KEY,
	EmployeeName VARCHAR(50) NOT NULL,
	Age INT CHECK (Age >= 18),
	Salary INT CHECK (Salary > 0),
	Sex VARCHAR(2),
	DepartmentID INT, --> This column have to be present in EmployeeNew table to create FOREIGN KEY
	FOREIGN KEY (DepartmentID) REFERENCES DepartmentNew(DepartmentID)
)
--> Without DepartmentID of DepartmentNew having PRIMARY KEY we cannot create FOREIGN KEY
INSERT INTO EmployeeNew (EmployeeID, EmployeeName, Age, Salary, Sex, DepartmentID) VALUES (1, 'John Doe', 30, 50000, 'M', 2)
INSERT INTO EmployeeNew (EmployeeID, EmployeeName, Age, Salary, Sex, DepartmentID) VALUES (2, 'Alice', 28, 60000, 'F', 1)
INSERT INTO EmployeeNew (EmployeeID, EmployeeName, Age, Salary, Sex, DepartmentID) VALUES (3, 'Bob', 35, 55000, 'M', 3)
INSERT INTO EmployeeNew (EmployeeID, EmployeeName, Age, Salary, Sex, DepartmentID) VALUES (4, 'Charlie', 32, 70000, 'M', 2)
INSERT INTO EmployeeNew (EmployeeID, EmployeeName, Age, Salary, Sex, DepartmentID) VALUES (5, 'Eve', 27, 65000, 'F', 4)
INSERT INTO EmployeeNew (EmployeeID, EmployeeName, Age, Salary, Sex, DepartmentID) VALUES (6, 'David', 29, 48000, 'M', 5)

SELECT * FROM EmployeeNew

------------------------------------------
------------------------------------------

--> Q. Write a query to display those working in IT department
SELECT * FROM EmployeeNew 
INNER JOIN DepartmentNew ON EmployeeNew.DepartmentID=DepartmentNew.DepartmentID 
WHERE DepartmentName='IT'

------------------------------------------

b) LEFT JOIN --> Left to Right

--> It will return all the data from left table and matching records from right table
--> But which is left table and which is right table?

SELECT EmployeeID, EmployeeName, DepartmentName 
FROM 
Employee LEFT JOIN Department ON Employee.DepartmentID=Department.DepartmentID
-->                Left table || Right table

--> Output will be same as INNER JOIN
--> All the data from left will be returned 
--> even if there is no matching record in right table
--> even if there is NULL value

------------------------------------------

c) RIGHT JOIN --> Right to Left

--> It will return all the data from Right table and matching records from Left table

SELECT EmployeeID, EmployeeName, DepartmentName 
FROM 
Employee RIGHT JOIN Department ON Employee.DepartmentID=Department.DepartmentID
-->                 Left table || Right table

--> If there is no matching record in left table then it will add NULL value for that column

------------------------------------------

d) FULL OUTER JOIN --> I is combanation of LEFT JOIN and RIGHT JOIN

--> It will return all the data from both tables even if there is no matching records

SELECT EmployeeID, EmployeeName, DepartmentName 
FROM 
Employee FULL OUTER JOIN Department ON Employee.DepartmentID=Department.DepartmentID
-->                      Left table || Right table

------------------------------------------

e) CROSS JOIN --> It will return all possible combinations of records from both tables

SELECT EmployeeID, EmployeeName, DepartmentName 
FROM Employee CROSS JOIN Department

--> CROSS JOIN = Cartesian Product = Left Table Records * Right Table Records

-- EXAMPLE
------------------------
Table1			Table2
1				A
2				B
3				C
------------------------
Output of CROSS JOIN
------------------------
1	A
1	B
1	C
2	A
2	B
2	C
3	A
3	B
3	C


------------------------------------------
------------------------------------------

-- In EmployeeNew and DepartmentNew

--Q. Write a query to display those employees who are mapped with any department?
--> Return EmployeeID, EmployeeName, DepartmentName

SELECT EmployeeID, EmployeeName, DepartmentName 
FROM EmployeeNew INNER JOIN DepartmentNew ON EmployeeNew.DepartmentID=DepartmentNew.DepartmentID


--Q. Write a query to display all employees who are working with our organization?
--> Return EmployeeID, EmployeeName, DepartmentName

SELECT EmployeeID, EmployeeName, DepartmentName 
FROM EmployeeNew LEFT JOIN DepartmentNew ON EmployeeNew.DepartmentID=DepartmentNew.DepartmentID
