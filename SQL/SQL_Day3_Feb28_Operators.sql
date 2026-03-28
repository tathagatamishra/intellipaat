--> DAY 3 - FEB 28, 2026

DCL COMMANDS --> Data Control Language

a) GRANT
b) REVOKE

--> GRANT
GRANT SELECT ON Employees TO User1
--> Admin grands SELECT permission on Employees table to User1
--> User1 is SSMS user

GRANT INSERT ON Employees TO User1

GRANT INSERT, UPDATE ON Employees TO User1

--> REVOKE
REVOKE SELECT ON Employees FROM User1

----------------------------------------------------------
----------------------------------------------------------

DATA TYPES

Numeric Data Types -->

a) TINYINT --> 0 to 255
b) SMALLINT --> -32,768 to 32,767
c) INT --> -2,147,483,648 to 2,147,483,647
d) BIGINT --> -9,223,372,036,854,775,808 to 9,223,372,036,854,775,807
e) DECIMAL (p, s) --> p is precision, s is scale

TINYINT --> 1 byte
SMALLINT --> 2 bytes
INT --> 4 bytes
BIGINT --> 8 bytes
--> So we cannot store more than 8 bytes

--> Test the range of TINYINT data type
CREATE TABLE TinyIntTable
(
	ID TINYINT
)

INSERT INTO TinyIntTable(ID) VALUES(100)
INSERT INTO TinyIntTable(ID) VALUES(-10)
INSERT INTO TinyIntTable(ID) VALUES(250)
INSERT INTO TinyIntTable(ID) VALUES(256) --> Arithmetic overflow error

SELECT * FROM TinyIntTable

--> Test the range of SMALLINT data type
CREATE TABLE SmallIntTable
(
	ID SMALLINT
)

INSERT INTO SmallIntTable(ID) VALUES(-100)
INSERT INTO SmallIntTable(ID) VALUES(3000)
INSERT INTO SmallIntTable(ID) VALUES(40000) --> Arithmetic overflow error

----------------------------------------------------------

--> DECIMAL

10.67

DECEMAL(5, 2)

5 --> total length
2 --> how many values it will accept after the decimal point

--> Before decimal how many values are there?
5-2=3

--> 3 values before decimal
--> 2 values after decimal

CREATE TABLE DecimalTable
(
	Price DECIMAL(5, 2)
)

INSERT INTO DecimalTable(Price) VALUES(123.45)
INSERT INTO DecimalTable(Price) VALUES(123)
INSERT INTO DecimalTable(Price) VALUES(12.3)
INSERT INTO DecimalTable(Price) VALUES(1234.56) --> Arithmetic overflow error

INSERT INTO DecimalTable(Price) VALUES(123.1234567) 
--> It will round off the value to 2 decimal places and store it as 123.12
--> When we insert more than accepted values after decimal point, 
--> It will round off the value to make it fit into the defined length

SELECT * FROM DecimalTable

--> If we alter DECIMAL datatype into INT what will happen?
ALTER TABLE DecimalTable ALTER COLUMN Price INT
--> It will remove the decimal part and store only the integer part
--> 123.45 --> 123

--> How is FLOAT datatype different from decimal datatype? Or are they same?
--> FLOAT can store very large or very small numbers but it may not be precise
--> DECIMAL is more precise but it has a limited range

----------------------------------------------------------

String Data Types

a) CHAR --> Fixed length data type --> Max length is 8000 characters
b) VARCHAR --> Variable length data type for unicode characters --> Max length is 8000 characters
c) NVARCHAR --> Variable length data type for multi lingual characters --> Max length is 4000 characters


--> CHAR
CREATE TABLE UserInfo
(
	UserName CHAR(10) --> This colum will accept maximum 10 characters
)

INSERT INTO UserInfo(UserName) VALUES('MishraJi')
INSERT INTO UserInfo(UserName) VALUES('Tathagata')
INSERT INTO UserInfo(UserName) VALUES('DrFrankestine') --> String or binary data would be truncated
--> Truncated value: 'DrFrankest' but it will not store the truncated value

SELECT * FROM UserInfo
--> if inserted string length is less than defined lenght then it will add spaces to make it fit into the defined length
MishraJi  --> 8 characters + 2 spaces
Tathagata --> 9 characters + 1 space

----------------

--> VARCHAR
--> It will only store the actual string without adding spaces
CREATE TABLE UserInfo2
(
	UserName VARCHAR(10) --> This column will accept maximum 10 characters
)

INSERT INTO UserInfo2(UserName) VALUES('Mishra')
INSERT INTO UserInfo2(UserName) VALUES('Tathagata')
INSERT INTO UserInfo2(UserName) VALUES('DrFrankestine') --> String or binary data would be truncated and will not store
SELECT * FROM UserInfo2

INSERT INTO UserInfo2(UserName) VALUES('ありがとう') 
--> We can not store multi lingual characters in VARCHAR data type

----------------

--> NVARCHAR
--> It can store multi lingual characters

CREATE TABLE UserInfo3
(
	UserName NVARCHAR(10) --> This column will accept maximum 10 characters
)

INSERT INTO UserInfo3(UserName) VALUES('John')
INSERT INTO UserInfo3(UserName) VALUES(N'ありがとう') 
--> Have to put N infront of the 'ありがとう' otherwise data becomes corrupted / replaced with ????

SELECT * FROM UserInfo3

----------------

--> MAX

CREATE TABLE UserInfo4
(
	UserName NVARCHAR(MAX) --> This column can accept maximum limit
)
CREATE TABLE UserInfo5
(
	UserName VARCHAR(MAX) --> This column can accept maximum limit
)

----------------------------------------------------------
----------------------------------------------------------

Date and Time Data Types

a) DATE --> Store only date in YYYY-MM-DD format
b) TIME --> HH:MM:SS
c) DATETIME --> Store both date and time YYYY-MM-DD HH:MM:SS
d) DATETIME2 --> Store nanosecounds YYYY-MM-DD HH:MM:SS.nnnnnnn

--> DATE
CREATE TABLE DateTimeTable
(
	EmployeeID INT,
	JoiningDate DATE
)

INSERT INTO DateTimeTable(EmployeeID, JoiningDate) VALUES(1, '2025-01-15')
INSERT INTO DateTimeTable(EmployeeID, JoiningDate) VALUES(2, '2026-08-12')

SELECT * FROM DateTimeTable

--> TIME
CREATE TABLE ShoppingCart
(
	OrderID INT,
	CustomerID INT,
	OrderDate DATE,
	OrderTime TIME
)
INSERT INTO ShoppingCart(OrderID, CustomerID, OrderDate, OrderTime) VALUES(1, 101, '2025-02-20', '14:30:00')
SELECT * FROM ShoppingCart

--> DATETIME
CREATE TABLE EventSchedule
(
	EventID INT,
	EventName VARCHAR(50),
	EventDateTime DATETIME
)
INSERT INTO EventSchedule(EventID, EventName, EventDateTime) VALUES(1, 'Conference', '2025-03-10 09:00:00')
SELECT * FROM EventSchedule


----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------

OPERATORS

a) Arithmetic Operators --> +, -, *, /, %
b) Comparison Operators --> =, <>, >, <, >=, <=
c) Logical Operators --> AND, OR, NOT

--> AND --> If both conditions are true then it will return true otherwise false
--> OR --> If any one condition is true then it will return true otherwise false
--> NOT --> It will reverse the result of any condition

--> Q. Write a query to display employeeid 1 data from employeedetails?

CREATE TABLE EmployeeDetails
(
	EmployeeID INT,
	EmployeeName VARCHAR(50)
)
INSERT INTO EmployeeDetails(EmployeeID, EmployeeName) VALUES(1, 'John Doe')

SELECT * FROM EmployeeDetails WHERE EmployeeID = 1 --> Comparison


--> Q. Write a query to display data for employeeid 1 and 2?

INSERT INTO EmployeeDetails(EmployeeID, EmployeeName) VALUES(2, 'Jane Smith')
INSERT INTO EmployeeDetails(EmployeeID, EmployeeName) VALUES(3, 'Alice Johnson')

SELECT * FROM EmployeeDetails WHERE EmployeeID = 1 OR EmployeeID = 2 --> Logical

SELECT * FROM EmployeeDetails WHERE EmployeeID = 1 OR EmployeeID = 4

----------------

--> Creating a table with lots of user data to test different arithmetic operators
CREATE TABLE UserData
(
	UserID INT,
	UserName VARCHAR(50),
	Age INT,
	DOB DATE,
	Gender CHAR(1),
	Salary DECIMAL(10, 2)
)
INSERT INTO UserData(UserID, UserName, Age, DOB, Gender, Salary) VALUES(1, 'John Doe', 30, '1995-01-15', 'M', 50000.00)
INSERT INTO UserData(UserID, UserName, Age, DOB, Gender, Salary) VALUES(2, 'Jane Smith', 25, '2000-05-20', 'F', 60000.00)
INSERT INTO UserData(UserID, UserName, Age, DOB, Gender, Salary) VALUES(3, 'Alice Johnson', 28, '1997-08-10', 'F', 55000.00)
INSERT INTO UserData(UserID, UserName, Age, DOB, Gender, Salary) VALUES(4, 'Bob Brown', 35, '1990-12-05', 'M', 70000.00)
INSERT INTO UserData(UserID, UserName, Age, DOB, Gender, Salary) VALUES(5, 'Charlie Davis', 22, '2003-03-25', 'M', 45000.00)
INSERT INTO UserData(UserID, UserName, Age, DOB, Gender, Salary) VALUES(6, 'Emily Wilson', 27, '1996-07-30', 'F', 52000.00)

----------------

IN --> It is used to comare more than one value in a same column

--> Q. Write a query to display a data for UserID 2, 4 from UserData?
SELECT * FROM UserData WHERE UserID IN (2, 4)

--> Q. Write a query to display all data except for UserID 3 from UserData?
--> NOT EQUAL (!=, <>)
SELECT * FROM UserData WHERE UserID <> 3
SELECT * FROM UserData WHERE UserID != 3

--> Q. Write a query to display all user data except for UserID 1 and 5?
SELECT * FROM UserData WHERE UserID NOT IN (1, 5)

----------------

--> Q. Write a query to display those users who is getting salary 55000?
SELECT * FROM UserData WHERE Salary = 55000.00

--> Q. Write a query to display those users whose are getting salary between 45000 to 60000?
SELECT * FROM UserData WHERE Salary >= 45000.00 AND Salary <= 60000.00

--> Q. Write a query to display the male users whoes are getting salary more than 55000?
SELECT * FROM UserData WHERE Gender = 'M' AND Salary > 55000.00

----------------
--> Q. Write a query to display the users those are male or getting salary more than 55000?
SELECT * FROM UserData WHERE Gender = 'M' OR Salary > 55000.00

----------------

BETWEEN --> It is used to compare a value with a range of values

--> Q. Write a query to display the users getting salary between 52000 to 60000?

SELECT * FROM UserData WHERE Salary >= 52000.00 AND Salary <= 60000.00
SELECT * FROM UserData WHERE Salary BETWEEN 52000.00 AND 60000.00

----------------

LIKE --> It is used to compare a value with a pattern

--> Q. Write a query to display the users whose name is 'Alice Johnson'?
SELECT * FROM UserData WHERE UserName = 'Alice Johnson'

--> Q. Write a query to display the users whose name starts with 'J'?
SELECT * FROM UserData WHERE UserName LIKE 'j%' 
-- > It will return all the names starting with 'J' or 'j'

--> Q. Write a query to display the users whose name ends with 'on'?
SELECT * FROM UserData WHERE UserName LIKE '%on'

--> Q. Write a query to display the users whose name has 'o' in it?
SELECT * FROM UserData WHERE UserName LIKE '%o%'

--> Q. Write a query to display the user's userName second character is 'a'?
SELECT * FROM UserData WHERE UserName LIKE '_a%'

--> Q. Write a query to display the user's userName second last character is 'i'?
SELECT * FROM UserData WHERE UserName LIKE '%i_'