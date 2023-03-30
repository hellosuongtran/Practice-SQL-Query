--PART 1: Use database Adventurework
--Task 1: Retrieve reports on transaction scenarios
--1.1 Retrieve customer orders
SELECT  * FROM SalesLT.Customer --> 847 dòng: 847 khách hàng
SELECT  * FROM SalesLT.SalesOrderHeader -->2 dòng: 32 giao dịch phát sinh 
--Relationship: Header --> Customer: CustomerID

SELECT CompanyName
   ,SalesOrderID
   ,TotalDue
FROM SalesLT.Customer AS cus
LEFT JOIN SalesLT.SalesOrderHeader AS ordh 
ON cus.customerID = ordh. CustomerID

--1.2 Retrieve customer orders with addresses
SELECT * FROM SalesLT.Address --> có 450 địa chỉ được ghi nhận
SELECT * FROM SalesLT.CustomerAddress --> có 417 khách hàng để lại địa chỉ ==> có khách hàng để lại nhiều hơn 1 địa chỉ
--> Relationship: CustomerAddress -> Address: AddressID
SELECT CustomerID
    ,AddressType
    , AddressLine1
    ,City
    ,StateProvince
    ,PostalCode
    ,CountryRegion
    
FROM SalesLT.Address AS add1
RIGHT JOIN SalesLT.CustomerAddress AS cus_add1
ON add1.AddressID = cus_add1.AddressID
WHERE AddressType LIKE 'Main Office'
-- Task 2: Retrieve customer data
SELECT pro.ProductID
      ,SUBSTRING (pro.Name,1,CHARINDEX ('-', pro.Name)-1)AS ProductName
      ,pro.SellStartDate
      ,ListPrice
      ,model.Name AS ProductModelName
      ,cat.Name AS CategoryName
FROM SalesLT.SalesOrderDetail AS ord_detail
LEFT JOIN SalesLT.Product AS pro 
ON ord_detail.ProductID = pro.ProductID
RIGHT JOIN SalesLT.ProductModel AS model
ON pro.ProductModelID = model.ProductModelID 
RIGHT JOIN SalesLT.ProductCategory AS cat
ON pro.ProductCategoryID = cat.ProductCategoryID
WHERE YEAR(pro.SellStartDate) = 2006
    AND model.Name LIKE '%Road%'
    AND cat.Name LIKE '%Bike%'
    AND CONVERT(int, Listprice) = 2443

--PART 2: Use database PayTM
--Task 1: Retrieve reports on transaction scenarios
1.1

SELECT customer_id
, transaction_id
, trans19.scenario_id
, transaction_type
, sub_category
, category
FROM dbo.fact_transaction_2019 AS trans19
JOIN dbo.dim_scenario AS scenario
ON trans19.scenario_id = scenario.scenario_id
WHERE sub_category = 'Not Payment'
AND category = 'Not Payment'

--1.2
SELECT
   customer_id
   , transaction_id
   , trans19.scenario_id
   , transaction_type
   , category
   , payment_method
   , CONVERT (varchar,transaction_time,101) AS transaction_time
   , platform_id
FROM dbo.fact_transaction_2019 AS trans19
JOIN dbo.dim_scenario AS sce
ON trans19.scenario_id = sce.scenario_id
JOIN dbo.dim_payment_channel AS paychannel
ON trans19.payment_channel_id = paychannel.payment_channel_id
WHERE 
    MONTH(transaction_time) BETWEEN 1 AND 6
AND category LIKE 'Shopping'
AND payment_method LIKE 'Bank account'
--1.3
SELECT fact_table.customer_id
, fact_table.transaction_id
, fact_table.scenario_id
, paychannel.payment_method 
, platf.payment_platform
FROM
(SELECT customer_id
    , transaction_id
    , scenario_id
    ,payment_channel_id
    ,platform_id
 FROM fact_transaction_2019 UNION
 SELECT customer_id
    , transaction_id
    , scenario_id
    ,payment_channel_id
    ,platform_id
 FROM fact_transaction_2020
) AS fact_table
LEFT JOIN dbo.dim_payment_channel as paychannel
ON fact_table.payment_channel_id = paychannel.payment_channel_id
LEFT JOIN dbo.dim_platform as platf
ON fact_table.platform_id = platf.platform_id
WHERE payment_platform LIKE 'android'
--1.4
SELECT SalesLT.Product.Name AS ProductName, SalesLT.ProductCategory.Name AS Category
FROM SalesLT.Product
INNER JOIN SalesLT.ProductCategory
ON SalesLT.Product.ProductCategoryID = SalesLT.ProductCategory.ProductCategoryID
--
SELECT p.ProductID,p.ProductNumber,p.ListPrice, p.Name
FROM SalesLT.Product AS p
INNER JOIN SalesLT.OderDetail AS od
ON 
WHERE (Name LIKE '%HL%' 
OR Name LIKE '%Mountain%')
AND ProductNumber LIKE '_________%'

SELECT p.Name As ProductName, p.ProductID, p.ListPrice, p.ProductNumber, od.OrderQty
FROM SalesLT.Product AS p
JOIN SalesLT.SalesOrderDetail AS od
ON p.ProductID = od.ProductID
WHERE (p.Name LIKE '%HL%' 
OR p.Name LIKE '%Mountain%')
AND ProductNumber LIKE '_________%'
AND OrderQty = 0

--Task 2: Retrieve customer data
SELECT top 2 * from SalesLT.SalesOrderDetail --> 542 đơn hàng đã order
SELECT * from SalesLT.Product --> 295 sản phẩm
SELECT top 2* from SalesLT.ProductModel
SELECT top 2* from SalesLT.ProductCategory
--> Relationship: From SalesLT.SalesOrderDetail -> Product: ProductID
                  From Product -> Model : ProductModelID

SELECT pro.ProductID
      ,SUBSTRING (pro.Name,1,CHARINDEX ('-', pro.Name)-1)AS NameProduct
      ,pro.SellStartDate
      ,ListPrice
      ,model.Name
      ,cat.Name
FROM SalesLT.SalesOrderDetail AS ord_detail
LEFT JOIN SalesLT.Product AS pro 
ON ord_detail.ProductID = pro.ProductID
RIGHT JOIN SalesLT.ProductModel AS model
ON pro.ProductModelID = model.ProductModelID 
RIGHT JOIN SalesLT.ProductCategory AS cat
ON pro.ProductCategoryID = cat.ProductCategoryID
WHERE YEAR(pro.SellStartDate) = 2006
    AND model.Name LIKE '%Road%'
    AND cat.Name LIKE '%Bike%'
    AND convert(int, Listprice) = 2443


--1.2 
SELECT
   customer_id
   , transaction_id
   , trans19.scenario_id
   , transaction_type
   , category
   , payment_method
   , CONVERT (varchar,transaction_time,101) AS transaction_time
   , platform_id
FROM dbo.fact_transaction_2019 AS trans19
JOIN dbo.dim_scenario AS sce
ON trans19.scenario_id = sce.scenario_id
JOIN dbo.dim_payment_channel AS paychannel
ON trans19.payment_channel_id = paychannel.payment_channel_id
WHERE 
    MONTH(transaction_time) BETWEEN 1 AND 6
AND category LIKE 'Shopping'
AND payment_method LIKE 'Bank account'

--1.3
SELECT fact_table.customer_id
, fact_table.transaction_id
, fact_table.scenario_id
, paychannel.payment_method 
, platf.payment_platform
FROM
(SELECT customer_id
    , transaction_id
    , scenario_id
    ,payment_channel_id
    ,platform_id
 FROM fact_transaction_2019 UNION
 SELECT customer_id
    , transaction_id
    , scenario_id
    ,payment_channel_id
    ,platform_id
 FROM fact_transaction_2020
) AS fact_table
LEFT JOIN dbo.dim_payment_channel as paychannel
ON fact_table.payment_channel_id = paychannel.payment_channel_id
LEFT JOIN dbo.dim_platform as platf
ON fact_table.platform_id = platf.platform_id
WHERE payment_platform LIKE 'android'


--1.4
--> Đánh giá dữ liệu: nhìn vào data ta thấy ở tất cả tables không có giá trị NULL --> Tất cả khách hàng đều phát sinh giao dịch trong năm 2019 &2020
   SELECT trans19.customer_id
   , trans19.transaction_id
   , trans19.scenario_id
   , payment_method 
   , payment_platform
    FROM dbo.fact_transaction_2019 as trans19
    JOIN  dbo.dim_platform as platf
    ON trans19.platform_id = platf.platform_id
    JOIN dbo.dim_payment_channel as channel
    ON trans19.payment_channel_id = channel.payment_channel_id
    WHERE MONTH(transaction_time)=1
    AND platf.payment_platform = 'ios'
UNION
   SELECT
    trans20.customer_id
   , trans20.transaction_id
   , trans20.scenario_id
   , payment_method 
   , payment_platform
   FROM dbo.fact_transaction_2020 as trans20
   JOIN  dbo.dim_platform as platf
   ON trans20.platform_id = platf.platform_id
   JOIN dbo.dim_payment_channel as channel
   ON trans20.payment_channel_id = channel.payment_channel_id
   WHERE MONTH(transaction_time)=1
   AND platf.payment_platform = 'ios'
   AND customer_id IN 
        (SELECT customer_id
        FROM dbo.fact_transaction_2019 
        WHERE (MONTH(transaction_time))=1)

