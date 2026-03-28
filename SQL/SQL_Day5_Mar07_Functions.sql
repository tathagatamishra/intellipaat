--> DAY 5 - MAR 7, 2026


SELF JOIN
-- A self join is a regular join, but the table is joined with itself.
-- It is used to compare rows within the same table or to retrieve related data from the same table.

-- Syntax:
SELECT A.column_name, B.column_name 
FROM table_name A, table_name B 
WHERE condition;

-- Example:
CREATE TABLE Family (
	ID INT PRIMARY KEY,
	Name VARCHAR(50),
	ParentID INT
);

INSERT INTO Family (ID, Name, ParentID) VALUES (1, 'John', NULL);
INSERT INTO Family (ID, Name, ParentID) VALUES (2, 'Alice', 1);
INSERT INTO Family (ID, Name, ParentID) VALUES (3, 'Bob', 1);

SELECT A.Name AS Child, B.Name AS Parent
FROM Family A, Family B
WHERE A.ParentID = B.ID;


--------------------------------------------------------------------
--------------------------------------------------------------------

AS
-- AS is a keyword in SQL that is used to assign an alias to a table or a column.
-- Syntax:
SELECT column_name AS alias_name
FROM table_name AS alias_name;

-- Example:
SELECT Name AS FullName FROM Family;


FUNCTION 
-- A function is a sql server object which we can use to solve dedicated task.

-- If we want to display current date and time:
SELECT GETDATE();

CREATE TABLE Cart
(
	ID INT PRIMARY KEY,
	ProductName VARCHAR(50),
	Price DECIMAL(10, 2)
);
INSERT INTO Cart (ID, ProductName, Price) VALUES (1, 'Laptop', 999.99);
INSERT INTO Cart (ID, ProductName, Price) VALUES (2, 'Smartphone', 499.99);
INSERT INTO Cart (ID, ProductName, Price) VALUES (3, 'Headphones', 199.99);

-- Want to sum up the price of all products in the cart:
SELECT SUM(Price) AS TotalPrice FROM Cart;

-------------------------

-- Type of Functions:

i) SYSTEM-DEFINED FUNCTIONS --> Already present in our sql server, we can directly use them without creating them.

ii) USER-DEFINED FUNCTIONS --> We can create them as per our requirement and use them whenever we want.

-------------------------

i) SYSTEM-DEFINED FUNCTIONS --> We cannot modify them, we can only use them.

--> Types of System-Defined Functions:

	1) STRING FUNCTIONS --> To perform operations on string data types
	2) NUMERIC FUNCTIONS --> To perform operations on numeric data types
	3) DATE FUNCTIONS --> To perform operations on date data types
	4) AGGREGATE FUNCTIONS --> To perform operations on a group of data and return a single value
	5) CONVERSION FUNCTIONS --> To convert data from one data type to another
	6) LOGICAL FUNCTIONS --> To perform logical operations and return a boolean value
	7) SYSTEM FUNCTIONS --> To perform operations related to the system and return information about the system
	8) INFORMATION FUNCTIONS --> To return information about the database, tables, columns, etc.
	9) RANKING FUNCTIONS --> To assign a rank to each row in a result set based on a specified order
	10) ANALYTIC FUNCTIONS --> To perform calculations across a set of rows that are related to the current row
	11) OTHER FUNCTIONS --> Other miscellaneous functions that do not fit into the above categories

--------------------------------------------------

1) STRING FUNCTIONS

	a) UPPER()
	b) LOWER()
	c) LTRIM()
	d) RTRIM()
	e) TRIM()
	f) REPLACE()
	g) LEN()
	h) SUBSTRING()
	i) REVERSE()

a) UPPER() --> It converts all the characters in a string to uppercase.

-- In Family table convert all the names to uppercase:
SELECT Name, UPPER(Name) AS NameInCap FROM Family;


b) LOWER() --> It converts all the characters in a string to lowercase.

-- In Family table convert all the names to lowercase:
SELECT Name, LOWER(Name) AS NameInSmall FROM Family;


c) LTRIM() --> It removes all the extra spaces or leading spaces from a string.

INSERT INTO Family (ID, Name, ParentID) VALUES (4, '   Charlie', 2);
-- Remove leading spaces from the left side of name:
SELECT Name, LTRIM(Name) AS Name FROM Family;


d) RTRIM() --> It removes all the extra spaces or trailing spaces from right side of a string.

INSERT INTO Family (ID, Name, ParentID) VALUES (5, 'Bob   ', 2);
-- Remove trailing spaces from the right side of name:
SELECT Name, RTRIM(Name) AS Name FROM Family;


--> To remove from both sides of a string we can use both LTRIM and RTRIM together:
SELECT RTRIM(LTRIM('     My Name     '))

-- But better way is -->
e) TRIM() --> It removes all the extra spaces from both sides of a string.

SELECT TRIM('     My Name     ')


f) REPLACE() --> It replaces a specified string value with another string value
-- Syntax:
SELECT REPLACE(column_name, 'old_string', 'new_string') AS NewColumnName

-- Example:
SELECT REPLACE('My Name', ' ', '');

-- Q. Write a query to replace 'i' with 'b' from name column in family table.
SELECT Name, REPLACE(Name, 'i', 'b') AS NameFix FROM Family;


g) LEN() --> It will count the number of characters of a string data

SELECT LEN('My Name') --> 7
--          1234567


h) SUBSTRING() --> To extract specific set of string from a string data

-- Syntax:
SUBSTRING(ColumnName, String Index Number, How many char we want to extract)

-- 'My Name' --> Extract first 2 letter
--  1234567

SELECT SUBSTRING('My Name', 1, 2)

-- Q. Write a query to display to 2nd and 3rd letter from 'Charlie'
SELECT SUBSTRING('Charlie', 2, 2)
--> 2nd and 3rd = total 2 char = 2 char we want to extract = SUBSTRING('Charlie', 2, 2)


i) REVERSE() --> Change the sequence of a string data

SELECT REVERSE('Charlie')

--------------------------------------------------

-- Q. Write a query to display Name value where first letter will be capital and rest of the letter in smallcase

--> Trainner's solution
SELECT
UPPER(SUBSTRING('cHARLIE', 1, 1)),
LOWER(SUBSTRING('cHARLIE', 2, LEN('cHARLIE') - 1))

--> Next concat
SELECT
UPPER(SUBSTRING('cHARLIE', 1, 1)) +
LOWER(SUBSTRING('cHARLIE', 2, LEN('cHARLIE') - 1))

--> My Solution Working fine
SELECT
REPLACE(LOWER('cHARLIE'), SUBSTRING('cHARLIE', 1, 1), UPPER(SUBSTRING('cHARLIE', 1, 1)));

-- Syntax:
REPLACE(ColumnName/'String', 'old_string', 'new_string')
'old_string' = SUBSTRING('cHARLIE', 1, 1) = c
'new_string' = UPPER(SUBSTRING('cHARLIE', 1, 1)) = C

--------------------------------------------------

2) NUMERIC FUNCTIONS
	
	a) GETDATE()
	b) DAY()
	c) MONTH()
	d) YEAR()
	e) DATEADD()
	f) DATEDIFF()
	g) DATENAME()
	h) DATEPART()

a) GETDATE() --> to display current date and time

b) DAY() --> To extract Day number from the date value
SELECT DAY(GETDATE())

c) MONTH() --> to display the month number
SELECT MONTH(GETDATE())

d) YEAR() --> display only the year
SELECT YEAR(GETDATE())

e) DATEADD() --> to add number of days/months/year to a date
-- Paramaters:
	i) interval 
		dd
		mm
		yy
	ii) number which we want to add --> this can be positive or negitive
	iii) Column name/Date value

-- Syntax: 
DATEADD(interval, number which we want to add, Column name/Date value)

-- Q. Write a query to add 10 days in '2026-03-07' value
SELECT DATEADD(dd, 10, '2026-03-07')

-- Q. Write a query to add 2 months in current date value
SELECT DATEADD(mm, 2, GETDATE())

-- Q. Write a query to add 5 years in current date value
SELECT DATEADD(yy, 5, GETDATE())

-- Q. Write a query to add 5 years 6 months 20 days in current date value
SELECT DATEADD(yy, 5, DATEADD(mm, 6, DATEADD(dd, 20, GETDATE())))
SELECT DATEADD(dd, 20, DATEADD(mm, 6, DATEADD(yy, 5, GETDATE())))
-- both works fine

f) DATEDIFF() --> to calculate difference between two dates
-- Parameter:
	i) interval
		dd
		mm
		yy
	ii) start date
	iii) End date

-- Syntax:
DATEDIFF(interval, start date, end date)

-- Example:
-- Difference between '2026-01-15' and '2026-01-20'


g) DATENAME() --> display name of the month, day
-- Parameter:
	i) mm
	ii) weekday

SELECT DATENAME(mm, GETDATE())
SELECT DATENAME(weekday, GETDATE())

h) DATEPART() -- display the current week of the year
SELECT DATEPART(WEEK, GETDATE())

--------------------------------------------------

3) MATHEMATICAL CATEGORY:
	a) POWER()
	b) SQRT()
	c) ABS()
	d) FLOOR()
	e) CEILING()

a) POWER() --> To calculate specific power of a number
-- Syntax: 
POWER(number, power)

--> 2^3 = POWER(2, 3) = 2*2*2
SELECT POWER(2, 3)

b) SQRT() --> calculate square root
SELECT SQRT(10)

c) ABS() --> convert negative data into positive value
SELECT ABS(-10) --> 10
SELECT ABS(10)  --> 10
SELECT ABS(-10.12) --> 10

d) FLOOR() --> roundup into nearest smallest int value
SELECT FLOOR(100.123)
SELECT FLOOR(100.897)

d) CEILING() --> roundup into nearest largest int value
SELECT CEILING(100.123)
SELECT CEILING(100.897)
SELECT CEILING(-100.897)

SELECT CEILING(ABS(-10.12))
SELECT ABS(CEILING(-10.12))