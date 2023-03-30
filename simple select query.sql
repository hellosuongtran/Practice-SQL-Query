--TASK 1: Retrieve data for transportation reports
--1.1 Retrieve a list of cities
SELECT DISTINCT City
, StateProvince
FROM SalesLT.Address
ORDER BY StateProvince ASC, City DESC

--1.2 Retrieve the heaviest products information
SELECT TOP (10) PERCENT Name
,Weight
FROM SalesLT.Product
ORDER BY Weight DESC

--Task 2: Retrieve product data
--2.1 Filter products by color and size 
SELECT 
Name
,ProductNumber
,Color
,Size
FROM SalesLT.Product
WHERE 
Color IN ('Black','Red','White')
AND Size IN ('S','M') 
-- Sua BT
SELECT 
    [Name]
    , ProductNumber
    , Color
    , Size
FROM SalesLT.Product
WHERE 
    Color IN ('Black', 'Red', 'White') -- ( Color = 'Black' OR Color = 'White' OR Color = 'Red' ) AND ( Size = 'S' OR Size = 'M' )  
    AND Size IN ('S','M')
--2.2 Filter products by color, size and product number
SELECT ProductID,ProductNumber,Name,Color,Size
FROM SalesLT.Product 
WHERE ProductNumber LIKE ('BK-[^T]%-[0-9][0-9]' ) AND (Color IN ('Black','Red','White') OR (Size IN ('S','M')))

--2.3 Retrieve specific products by product ID 
SELECT p.Name As ProductName, p.ProductID, p.ListPrice, p.ProductNumber, od.OrderQty
FROM SalesLT.Product AS p
JOIN SalesLT.SalesOrderDetail AS od
ON p.ProductID = od.ProductID
WHERE (p.Name LIKE '%HL%' OR p.Name LIKE '%Mountain%')
AND ProductNumber LIKE '_________%'-- có ít nhất 8 ký tự
AND OrderQty = 0
--> sửa bài tập: