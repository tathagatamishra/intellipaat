--> DAY 2 - FEB 22, 2026

SQL SERVER (MSSQL) --> Microsoft SQL Server

--> Need
a) - Server
b) - SSMS (SQL Server Management Studio)

--> What is SQL?
--> Structuded Query Language

--> Database
--> Is a kind of container which we can use to store the data.

--> How to create a database?
--> Need some commands

--> CREATE
--> Use to create anything

--> CREATE DATABASE database_name
CREATE DATABASE MyFirstDatabase
--> If database name has spaces then we need to use square brackets
--> CREATE DATABASE [My First Database]
--> Select the whole line and press F5 to execute or click on Execute button
--> Database created successfully
--> Find the database in the Object Explorer on the left side of SSMS
--> Right click and click New Query to open a new query window within that database

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--> COMMAND CATEGORY
a) DDL (Data Definition Language)
b) DQL (Data Query Language)
c) DML (Data Manipulation Language)
d) DCL (Data Control Language)

----------------------------------------

--> DDL COMMANDS
--> Use to create any new thing or modifying existing structure
a) CREATE --> Use to create any new thing
b) ALTER --> Use to modify existing structure
c) DROP --> Use to delete any existing thing

--> How to create a table?
--> Syntax of CREATE TABLE
CREATE TABLE table_name

----------------------------------------
EmployeeID		EmployeeName	Age
1				John Doe		30
2				Jane Smith		25
----------------------------------------
CREATE TABLE Employees
(
	EmployeeID INT,
	EmployeeName VARCHAR(50),
	Age INT
)
--> VARCHAR(50) --> Means that column can store maximum 50 characters
--> Is it mandatory to mention max? --> Yes

Q. Write a query to create a table which will hold below Data point:
a) OrderID
b) CustomerID
c) OrderAmount
d) ProductID
e) Price
f) Qty

Answer:
CREATE TABLE Orders
(
	OrderID INT,
	CustomerID INT,
	OrderAmount INT,
	ProductID INT,
	Price INT,
	Qty INT
)
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--> DQL COMMANDS
a) SELECT --> Use to retrieve data from the database

SELECT * FROM Table_name

SELECT * FROM Orders
--> * --> Means all columns

--> Syntax of SELECT
SELECT Column_name, Column_name FROM Orders

SELECT OrderID, CustomerID FROM Orders

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--> DDL COMMANDS

ALTER --> To change any existing structe

--> To add OrderDate

CREATE TABLE Orders
(
	OrderID INT,
	CustomerID INT,
	OrderAmount INT,
	ProductID INT,
	Price INT,
	Qty INT,
	OrderDate DATE
)
--> This will give error
--> here is already an object named 'Orders' in the database

--> Syntax of ALTER
ALTER TABLE Table_name

ALTER TABLE Orders ADD OrderData DATE

--> Check if the new column added or not
SELECT * FROM Orders
--> We cannot define the column position, it will always be added at end of the table

--> ADD do not comes under DDL, its a keyword

--> Add multiple columns same time
ALTER TABLE Orders ADD ShippedDate DATE, DeliveryDate DATE

--> To change the data type of OrderAmount from INT to FLOAT
ALTER TABLE Orders ALTER COLUMN Price FLOAT

----------------------------------------

DROP --> To delete any existing thing from database

--> Syntax of DROP
DROP TABLE Table_name

DROP TABLE Orders
--> Check if the table deleted or not
SELECT * FROM Orders
--> Invalid object name 'Orders'. because we have deleted the table

--> Lets recreate table again
CREATE TABLE Orders
(
	OrderID INT,
	CustomerID INT,
	OrderAmount INT,
	ProductID INT,
	Price INT,
	Qty INT,
	OrderDate DATE
)
--> And DROP a specific column
ALTER TABLE Orders DROP COLUMN CustomerID

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--> DML COMMANDS
--> To add any new dataset or modify or delete any existing dataset
a) INSERT --> 
B) UPDATE --> 
C) DELETE --> 

--> Create a new table
CREATE TABLE Employees
(
	EmployeeID INT,
	EmployeeName VARCHAR(50),
	Age INT
)
SELECT * FROM Employees

--> INSERT
--> Add new dataset into the table

--> Syntax of INSERT
INSERT INTO Table_name (Check how many columns are there and their name) then add VALUES()

--> We also can use SELECT instead of VALUES

INSERT INTO Employees (EmployeeID, EmployeeName, Age) 
VALUES (1, 'John Doe', 30)

--> String/Character values should be in single quotes ''
--> Check the data
SELECT * FROM Employees

--> What if we want to leave a column blank?
INSERT INTO Employees (EmployeeID, Age) 
VALUES (2, 67)
--> This will add a NULL value in EmployeeName column

INSERT INTO Employees (EmployeeID, EmployeeName, Age) 
VALUES (3, '', 14)
--> This will add an empty string but it is still a data, it is not trully empty

--> We can also write without mentioning column name
INSERT INTO Employees VALUES (4, 'Tathagata', 25)
--> But we have to fill all the data, if we miss any data then it will give error
INSERT INTO Employees VALUES (5, 'Bob')
--> Error: Column name or number of supplied values does not match table definition.

--> To store multiple records at same time
INSERT INTO Employees (EmployeeID, EmployeeName, Age) 
VALUES (5, 'Bob', 40), (6, 'Alice', 35), (7, 'Charlie', 28)
--> Check the data
SELECT * FROM Employees

--> To see only a specific row
SELECT * FROM Employees WHERE EmployeeID = 4
--> To see only a specific column
SELECT EmployeeName FROM Employees

----------------------------------------

--> UPDATE
--> To modify any existing dataset
UPDATE Employees SET EmployeeID = 1
--> This will update all the records

--> Syntax of UPDATE
UPDATE Table_name SET Column_name = value WHERE condition

--> To update a specific record
UPDATE Employees SET EmployeeName='Bob Cat' WHERE EmployeeID = 5
--> Check the data
SELECT * FROM Employees

Q. Write a query to update employeename, age for employeeid 6.
Answer:
UPDATE Employees SET EmployeeName='Alice Smith', Age = 36 WHERE EmployeeID = 6
--> To update multiple columns same time

----------------------------------------

--> DELETE
--> To remove any data from our table

--> Syntax of DELETE
DELETE FROM Table_name WHERE condition

DELETE FROM Employees
--> This will delete all

--> To delete a specific record
DELETE FROM Employees WHERE EmployeeID = 7
--> Check the data
SELECT * FROM Employees

--> To remove a column from the table
ALTER TABLE Table_name DROP COLUMN Column_name