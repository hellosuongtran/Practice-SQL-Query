--Task 1: 
--1.1 
SELECT CustomerID
,CONCAT ((ISNULL (SUBSTRING(Title,1,2), '-')),' '+ FirstName) AS CustomerName
,SUBSTRING (SalesPerson, CHARINDEX('\',SalesPerson)+1, len(SalesPerson)) AS SalesPerson
,REPLACE(phone,'-', ' ') AS CustomerPhoneNumber
FROM SalesLT.Customer

--1.2 
SELECT TOP (10)PERCENT Weight
,ProductNumber
,Name
,SellStartDate
,SellEndDate
,DATEDIFF (DAY,SellStartDate, ISNULL (SellEndDate, GETDATE())) AS NumberOfSalesDay
FROM SalesLT.Product
ORDER BY weight DESC

--Task 2: Retrieve customer order data 
--2.1
SELECT CustomerID
,CompanyName
,CONCAT_WS(':',customerID,CompanyName) AS CustomerCompany
FROM SalesLT.Customer
--2.2
SELECT 
SalesOrderNumber 
, RevisionNumber
,CONCAT(SalesOrderNumber,'(', RevisionNumber, ')') AS NewSalesOrderNumber
,CONVERT(nvarchar,OrderDate,102)AS DateOrder
FROM SalesLT.SalesOrderHeader
--Task 3: Retrieve customer contact details (hard) 
--3.1
SELECT FirstName
,MiddleName
,LastName
,CONCAT(FirstName,ISNULL(' '+MiddleName,''),' '+LastName) AS CustomerName
FROM SalesLT.customer
--3.2
--Option1:
SELECT CustomerID
,EmailAddress
,Phone
,IIF(EmailAddress IS NULL,Phone,EmailAddress) AS PrimaryContact
FROM SalesLT.Customer
CusNULL

--Option 2:
SELECT CustomerID
,COALESCE(EmailAddress, Phone) AS PrimaryContact
FROM SalesLT.Customer
--3.3
SELECT CustomerID
,CONCAT_WS(' ',FirstName, LastName) AS Name
,CompanyName
,Phone
FROM SalesLT.Customer
WHERE CustomerID NOT IN(SELECT CustomerID FROM SalesLT.CustomerAddress)

SELECT