-- Copyright Microsoft, Inc. 1994 - 2000
-- All Rights Reserved.
--
-- Create Database Northwind MariaDB (MySQL)
-- Ported by Luis A. Sierra
-- Blog: https://interesting-homemade-projects.blogspot.com
--
-- TESTED in Database Management ** phpMyAdmin **
-- https://www.phpmyadmin.net/

CREATE DATABASE IF NOT EXISTS northwind2;

USE northwind2;

-- Categories
CREATE TABLE `Categories` (
    `CategoryID` INTEGER NOT NULL AUTO_INCREMENT,
    `CategoryName` VARCHAR(15) NOT NULL,
    `Description` MEDIUMTEXT,
    `Picture` LONGBLOB,
    CONSTRAINT `PK_Categories` PRIMARY KEY (`CategoryID`)
);

-- CustomerCustomerDemo
CREATE TABLE `CustomerCustomerDemo` (
    `CustomerID` VARCHAR(5) NOT NULL,
    `CustomerTypeID` VARCHAR(10) NOT NULL,
    CONSTRAINT `PK_CustomerCustomerDemo` PRIMARY KEY (`CustomerID`, `CustomerTypeID`)
);

-- CustomerDemographics
CREATE TABLE `CustomerDemographics` (
    `CustomerTypeID` VARCHAR(10) NOT NULL,
    `CustomerDesc` MEDIUMTEXT,
    CONSTRAINT `PK_CustomerDemographics` PRIMARY KEY (`CustomerTypeID`)
);

-- Customers
CREATE TABLE `Customers` (
    `CustomerID` VARCHAR(5) NOT NULL,
    `CompanyName` VARCHAR(40) NOT NULL,
    `ContactName` VARCHAR(30),
    `ContactTitle` VARCHAR(30),
    `Address` VARCHAR(60),
    `City` VARCHAR(15),
    `Region` VARCHAR(15),
    `PostalCode` VARCHAR(10),
    `Country` VARCHAR(15),
    `Phone` VARCHAR(24),
    `Fax` VARCHAR(24),
    CONSTRAINT `PK_Customers` PRIMARY KEY (`CustomerID`)
);

-- Employees
CREATE TABLE `Employees` (
    `EmployeeID` INTEGER NOT NULL AUTO_INCREMENT,
    `LastName` VARCHAR(20) NOT NULL,
    `FirstName` VARCHAR(10) NOT NULL,
    `Title` VARCHAR(30),
    `TitleOfCourtesy` VARCHAR(25),
    `BirthDate` DATETIME,
    `HireDate` DATETIME,
    `Address` VARCHAR(60),
    `City` VARCHAR(15),
    `Region` VARCHAR(15),
    `PostalCode` VARCHAR(10),
    `Country` VARCHAR(15),
    `HomePhone` VARCHAR(24),
    `Extension` VARCHAR(4),
    `Photo` LONGBLOB,
    `Notes` MEDIUMTEXT NOT NULL,
    `ReportsTo` INTEGER,
    `PhotoPath` VARCHAR(255),
     `Salary` FLOAT,
    CONSTRAINT `PK_Employees` PRIMARY KEY (`EmployeeID`)
);

-- EmployeeTerritories
CREATE TABLE `EmployeeTerritories` (
    `EmployeeID` INTEGER NOT NULL,
    `TerritoryID` VARCHAR(20) NOT NULL
);

-- OrderDetails
CREATE TABLE `OrderDetails` (
    `OrderID` INTEGER NOT NULL,
    `ProductID` INTEGER NOT NULL,
    `UnitPrice` DECIMAL(10,4) NOT NULL DEFAULT 0,
    `Quantity` SMALLINT(2) NOT NULL DEFAULT 1,
    `Discount` REAL(8,0) NOT NULL DEFAULT 0
);

-- Orders
CREATE TABLE `Orders` (
    `OrderID` INTEGER NOT NULL AUTO_INCREMENT,
    `CustomerID` VARCHAR(5),
    `EmployeeID` INTEGER,
    `OrderDate` DATETIME,
    `RequiredDate` DATETIME,
    `ShippedDate` DATETIME,
    `ShipVia` INTEGER,
    `Freight` DECIMAL(10,4) DEFAULT 0,
    `ShipName` VARCHAR(40),
    `ShipAddress` VARCHAR(60),
    `ShipCity` VARCHAR(15),
    `ShipRegion` VARCHAR(15),
    `ShipPostalCode` VARCHAR(10),
    `ShipCountry` VARCHAR(15),
    CONSTRAINT `PK_Orders` PRIMARY KEY (`OrderID`)
);

-- Products
CREATE TABLE `Products` (
    `ProductID` INTEGER NOT NULL AUTO_INCREMENT,
    `ProductName` VARCHAR(40) NOT NULL,
    `SupplierID` INTEGER,
    `CategoryID` INTEGER,
    `QuantityPerUnit` VARCHAR(20),
    `UnitPrice` DECIMAL(10,4) DEFAULT 0,
    `UnitsInStock` SMALLINT(2) DEFAULT 0,
    `UnitsOnOrder` SMALLINT(2) DEFAULT 0,
    `ReorderLevel` SMALLINT(2) DEFAULT 0,
    `Discontinued` BIT NOT NULL DEFAULT 0,
    CONSTRAINT `PK_Products` PRIMARY KEY (`ProductID`)
);

-- Region
CREATE TABLE `Region` (
    `RegionID` INTEGER NOT NULL,
    `RegionDescription` VARCHAR(50) NOT NULL,
    CONSTRAINT `PK_Region` PRIMARY KEY (`RegionID`)
);

-- Shippers
CREATE TABLE `Shippers` (
    `ShipperID` INTEGER NOT NULL AUTO_INCREMENT,
    `CompanyName` VARCHAR(40) NOT NULL,
    `Phone` VARCHAR(24),
    CONSTRAINT `PK_Shippers` PRIMARY KEY (`ShipperID`)
);

-- Suppliers
CREATE TABLE `Suppliers` (
    `SupplierID` INTEGER NOT NULL AUTO_INCREMENT,
    `CompanyName` VARCHAR(40) NOT NULL,
    `ContactName` VARCHAR(30),
    `ContactTitle` VARCHAR(30),
    `Address` VARCHAR(60),
    `City` VARCHAR(15),
    `Region` VARCHAR(15),
    `PostalCode` VARCHAR(10),
    `Country` VARCHAR(15),
    `Phone` VARCHAR(24),
    `Fax` VARCHAR(24),
    `HomePage` MEDIUMTEXT,
    CONSTRAINT `PK_Suppliers` PRIMARY KEY (`SupplierID`)
);

-- Territories
CREATE TABLE `Territories` (
    `TerritoryID` VARCHAR(20) NOT NULL,
    `TerritoryDescription` VARCHAR(50) NOT NULL,
    `RegionID` INTEGER NOT NULL,
    CONSTRAINT `PK_Territories` PRIMARY KEY (`TerritoryID`)
);

-- Alphabetical list of products
CREATE VIEW `Alphabetical_list_of_products`
AS
SELECT Products.*, 
       Categories.CategoryName
FROM Categories 
   INNER JOIN Products ON Categories.CategoryID = Products.CategoryID
WHERE (((Products.Discontinued)=0));

-- Current Product List
CREATE VIEW `Current_Product_List`
AS
SELECT ProductID,
       ProductName 
FROM Products 
WHERE Discontinued=0;

-- Customer and Suppliers by City
CREATE VIEW `Customer_and_Suppliers_by_City`
AS
SELECT City, 
       CompanyName, 
       ContactName, 
       'Customers' AS Relationship 
FROM Customers
UNION 
SELECT City, 
       CompanyName, 
       ContactName, 
       'Suppliers'
FROM Suppliers 
ORDER BY City, CompanyName;

-- Invoices
CREATE VIEW `Invoices`
AS
SELECT Orders.ShipName,
       Orders.ShipAddress,
       Orders.ShipCity,
       Orders.ShipRegion, 
       Orders.ShipPostalCode,
       Orders.ShipCountry,
       Orders.CustomerID,
       Customers.CompanyName AS CustomerName, 
       Customers.Address,
       Customers.City,
       Customers.Region,
       Customers.PostalCode,
       Customers.Country,
       (Employees.FirstName + ' ' + Employees.LastName) AS Salesperson, 
       Orders.OrderID,
       Orders.OrderDate,
       Orders.RequiredDate,
       Orders.ShippedDate, 
       Shippers.CompanyName As ShipperName,
       `OrderDetails`.ProductID,
       Products.ProductName, 
       `OrderDetails`.UnitPrice,
       `OrderDetails`.Quantity,
       `OrderDetails`.Discount, 
       (((`OrderDetails`.UnitPrice*Quantity*(1-Discount))/100)*100) AS ExtendedPrice,
       Orders.Freight 
FROM Customers 
  JOIN Orders ON Customers.CustomerID = Orders.CustomerID  
    JOIN Employees ON Employees.EmployeeID = Orders.EmployeeID    
     JOIN `OrderDetails` ON Orders.OrderID = `OrderDetails`.OrderID     
      JOIN Products ON Products.ProductID = `OrderDetails`.ProductID      
       JOIN Shippers ON Shippers.ShipperID = Orders.ShipVia;
	   
-- Orders Qry
CREATE VIEW `Orders_Qry` AS
SELECT Orders.OrderID,
       Orders.CustomerID,
       Orders.EmployeeID, 
       Orders.OrderDate, 
       Orders.RequiredDate,
       Orders.ShippedDate, 
       Orders.ShipVia, 
       Orders.Freight,
       Orders.ShipName, 
       Orders.ShipAddress, 
       Orders.ShipCity,
       Orders.ShipRegion,
       Orders.ShipPostalCode,
       Orders.ShipCountry,
       Customers.CompanyName,
       Customers.Address,
       Customers.City,
       Customers.Region,
       Customers.PostalCode, 
       Customers.Country
FROM Customers 
     JOIN Orders ON Customers.CustomerID = Orders.CustomerID; 
	 
-- Order Subtotals
CREATE VIEW `Order_Subtotals` AS
SELECT `OrderDetails`.OrderID, 
Sum((`OrderDetails`.UnitPrice*Quantity*(1-Discount)/100)*100) AS Subtotal
FROM `OrderDetails`
GROUP BY `OrderDetails`.OrderID;

-- Product Sales for 1997
CREATE VIEW `Product_Sales_for_1997` AS
SELECT Categories.CategoryName, 
       Products.ProductName, 
       Sum((`OrderDetails`.UnitPrice*Quantity*(1-Discount)/100)*100) AS ProductSales
FROM Categories
 JOIN    Products On Categories.CategoryID = Products.CategoryID
    JOIN  `OrderDetails` on Products.ProductID = `OrderDetails`.ProductID     
     JOIN  `Orders` on Orders.OrderID = `OrderDetails`.OrderID 
WHERE Orders.ShippedDate Between '1997-01-01' And '1997-12-31'
GROUP BY Categories.CategoryName, Products.ProductName;

-- Products Above Average Price
CREATE VIEW `Products_Above_Average_Price` AS
SELECT Products.ProductName, 
       Products.UnitPrice
FROM Products
WHERE Products.UnitPrice>(SELECT AVG(UnitPrice) From Products);

-- Products by Category
CREATE VIEW `Products_by_Category` AS
SELECT Categories.CategoryName, 
       Products.ProductName, 
       Products.QuantityPerUnit, 
       Products.UnitsInStock, 
       Products.Discontinued
FROM Categories 
     INNER JOIN Products ON Categories.CategoryID = Products.CategoryID
WHERE Products.Discontinued <> 1;

-- Quarterly_Orders
CREATE VIEW `Quarterly_Orders` AS
SELECT DISTINCT Customers.CustomerID, 
                Customers.CompanyName, 
                Customers.City, 
                Customers.Country
FROM Customers 
     JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE Orders.OrderDate BETWEEN '1997-01-01' And '1997-12-31';

-- Sales Totals by Amount
CREATE VIEW `Sales_Totals_by_Amount` AS
SELECT `Order_Subtotals`.Subtotal AS SaleAmount, 
                  Orders.OrderID, 
               Customers.CompanyName, 
                  Orders.ShippedDate
FROM Customers 
 JOIN Orders ON Customers.CustomerID = Orders.CustomerID
    JOIN `Order_Subtotals` ON Orders.OrderID = `Order_Subtotals`.OrderID 
WHERE (`Order_Subtotals`.Subtotal > 2500) 
AND (Orders.ShippedDate BETWEEN '1997-01-01' And '1997-12-31');

-- Summary of Sales by Quarter
CREATE VIEW `Summary_of_Sales_by_Quarter` AS
SELECT Orders.ShippedDate, 
       Orders.OrderID, 
       `Order_Subtotals`.Subtotal
FROM Orders 
     INNER JOIN `Order_Subtotals` ON Orders.OrderID = `Order_Subtotals`.OrderID
WHERE Orders.ShippedDate IS NOT NULL;

-- Summary of Sales by Year
CREATE VIEW `Summary_of_Sales_by_Year` AS
SELECT      Orders.ShippedDate, 
            Orders.OrderID, 
 `Order_Subtotals`.Subtotal
FROM Orders 
     INNER JOIN `Order_Subtotals` ON Orders.OrderID = `Order_Subtotals`.OrderID
WHERE Orders.ShippedDate IS NOT NULL;

CREATE VIEW Category_Sales_for_1997 AS
SELECT  Product_Sales_for_1997.CategoryName, 
       Sum(Product_Sales_for_1997.ProductSales) AS CategorySales
FROM Product_Sales_for_1997
GROUP BY Product_Sales_for_1997.CategoryName;

-- Order Details Extended 
CREATE VIEW  Order_Details_Extended  AS
SELECT OrderDetails.OrderID, 
        OrderDetails.ProductID, 
       Products.ProductName, 
	    OrderDetails.UnitPrice, 
        OrderDetails.Quantity, 
        OrderDetails.Discount, 
      (OrderDetails.UnitPrice*Quantity*(1-Discount)/100)*100 AS ExtendedPrice
FROM Products 
     JOIN  OrderDetails  ON Products.ProductID =  OrderDetails.ProductID;
	 
-- Sales by Category
CREATE VIEW `Sales_by_Category` AS
SELECT Categories.CategoryID, 
       Categories.CategoryName, 
         Products.ProductName, 
	Sum(`Order_Details_Extended`.ExtendedPrice) AS ProductSales
FROM  Categories 
    JOIN Products 
      ON Categories.CategoryID = Products.CategoryID
       JOIN `Order_Details_Extended` 
         ON Products.ProductID = `Order_Details_Extended`.ProductID                
           JOIN Orders 
             ON Orders.OrderID = `Order_Details_Extended`.OrderID 
WHERE Orders.OrderDate BETWEEN '1997-01-01' And '1997-12-31'
GROUP BY Categories.CategoryID, Categories.CategoryName, Products.ProductName;

-- sp_Employees_Insert
DELIMITER $$
CREATE PROCEDURE `sp_Employees_Insert`(
In _LastName VARCHAR(20),
In _FirstName VARCHAR(10),
In _Title VARCHAR(30),
In _TitleOfCourtesy VARCHAR(25),
In _BirthDate DateTime,
In _HireDate DateTime,
In _Address VARCHAR(60),
In _City VARCHAR(15),
In _Region VARCHAR(15),
In _PostalCode VARCHAR(10),
In _Country VARCHAR(15),
In _HomePhone VARCHAR(24),
In _Extension VARCHAR(4),
In _Photo LONGBLOB,
In _Notes MEDIUMTEXT,
In _ReportsTo INTEGER,
IN _PhotoPath VARCHAR(255),
IN _Salary DECIMAL(18,2),
OUT _ReturnID INTEGER
)
BEGIN
Insert Into Employees
			(LastName,
			FirstName,
			Title,
			TitleOfCourtesy,
			BirthDate,
			HireDate,
			Address,
			City,
			Region,
			PostalCode,
			Country,
			HomePhone,
			Extension,
			Photo,
			Notes,
			ReportsTo,
			PhotoPath,
			Salary)
Values
			(_LastName,
			_FirstName,
			_Title,
			_TitleOfCourtesy,
			_BirthDate,
			_HireDate,
			_Address,
			_City,
			_Region,
			_PostalCode,
			_Country,
			_HomePhone,
			_Extension,
			_Photo,
			_Notes,
			_ReportsTo,
			_PhotoPath,
			_Salary);

	SELECT _ReturnID = LAST_INSERT_ID();
	
END
$$
DELIMITER ;

-- sp_Employees_SelectAll
DELIMITER $$
CREATE PROCEDURE `sp_Employees_SelectAll`()
BEGIN

  SELECT * FROM Employees;

END
$$
DELIMITER ;

-- sp_Employees_SelectRow
DELIMITER $$
CREATE PROCEDURE `sp_Employees_SelectRow`(In _EmployeeID INTEGER)
BEGIN

  SELECT * FROM Employees Where EmployeeID = _EmployeeID;

END
$$
DELIMITER ;

-- sp_Employees_Update
DELIMITER $$
CREATE PROCEDURE `sp_Employees_Update`(
In _EmployeeID INTEGER,
In _LastName VARCHAR(20),
In _FirstName VARCHAR(10),
In _Title VARCHAR(30),
In _TitleOfCourtesy VARCHAR(25),
In _BirthDate DateTime,
In _HireDate DateTime,
In _Address VARCHAR(60),
In _City VARCHAR(15),
In _Region VARCHAR(15),
In _PostalCode VARCHAR(10),
In _Country VARCHAR(15),
In _HomePhone VARCHAR(24),
In _Extension VARCHAR(4),
In _Photo LONGBLOB,
In _Notes MEDIUMTEXT,
In _ReportsTo INTEGER,
IN _PhotoPath VARCHAR(255),
IN _Salary DECIMAL(18,2)
)
BEGIN

Update Employees
	Set
		LastName = _LastName,
		FirstName = _FirstName,
		Title = _Title,
		TitleOfCourtesy = _TitleOfCourtesy,
		BirthDate = _BirthDate,
		HireDate = _HireDate,
		Address = _Address,
		City = _City,
		Region = _Region,
		PostalCode = _PostalCode,
		Country = _Country,
		HomePhone = _HomePhone,
		Extension = _Extension,
		Photo = _Photo,
		Notes = _Notes,
		ReportsTo = _ReportsTo,
        PhotoPath = _PhotoPath
	Where
		EmployeeID = _EmployeeID;

END
$$
DELIMITER ;

-- MyRound
DELIMITER $$
CREATE FUNCTION `MyRound`(Operand DOUBLE,Places INTEGER) RETURNS DOUBLE
DETERMINISTIC
BEGIN

DECLARE x DOUBLE;
DECLARE i INTEGER;
DECLARE ix DOUBLE;

  SET x = Operand*POW(10,Places);
  SET i=x;
  
  IF (i-x) >= 0.5 THEN                   
    SET ix = 1;                  
  ELSE
    SET ix = 0;                 
  END IF;     

  SET x=i+ix;
  SET x=x/POW(10,Places);

RETURN x;

END
$$
DELIMITER ;

-- LookByFName
DELIMITER $$
CREATE PROCEDURE `LookByFName`(IN _FirstLetter CHAR(1))
BEGIN
  
  SELECT * FROM Employees  Where LEFT(FirstName, 1) = _FirstLetter;

END
$$
DELIMITER ;

-- DateOnly
DELIMITER $$
CREATE FUNCTION `DateOnly` (_DateTime datetime) RETURNS VARCHAR(10)
BEGIN

  DECLARE MyOutput varchar(10);
	SET MyOutput = DATE_FORMAT(_DateTime,'%Y-%m-%d');

  RETURN MyOutput;

END
$$
DELIMITER ;

-- sp_employees_rownum
DELIMITER $$
CREATE PROCEDURE `sp_employees_rownum`()
BEGIN

SELECT * FROM
       (select @rownum:=@rownum + 1 as RowNum, p.* from employees p,(SELECT @rownum:=0) R order by firstname desc limit 10) a
    WHERE a.RowNum >= 2 AND a.RowNum<= 4;
	
END
$$
DELIMITER ;

-- sp_employees_rollup
DELIMITER $$
CREATE PROCEDURE `sp_employees_rollup`()
BEGIN

  SELECT Distinct City ,Sum(Salary) Salary_By_City FROM employees
  GROUP BY City WITH ROLLUP;

END
$$
DELIMITER ;

-- sp_employees_rank
DELIMITER $$
CREATE PROCEDURE `sp_employees_rank`()
BEGIN
  select * from 
           (select a.Title, a.EmployeeID, a.FirstName, a.Salary,(select 1 + count(*)
           from Employees b
           where b.Title = a.Title and b.Salary > a.Salary) RANK
           from Employees as a) as x
           order by x.Title, x.RANK;
END
$$
DELIMITER ;
