--*************************************************************************--
-- Title: Assignment07
-- Author: David Doris
-- Desc: This file demonstrates how to use Functions
-- Change Log: 2022-05-31, DDoris, Created File
--**************************************************************************--
Begin Try
	Use Master;
	If Exists(Select Name From SysDatabases Where Name = 'Assignment07DB_DDoris')
	 Begin 
	  Alter Database [Assignment07DB_DDoris] set Single_user With Rollback Immediate;
	  Drop Database Assignment07DB_DDoris;
	 End
	Create Database Assignment07DB_DDoris;
End Try
Begin Catch
	Print Error_Number();
End Catch
go
Use Assignment07DB_DDoris;

-- Create Tables (Module 01)-- 
Create Table Categories
([CategoryID] [int] IDENTITY(1,1) NOT NULL 
,[CategoryName] [nvarchar](100) NOT NULL
);
go

Create Table Products
([ProductID] [int] IDENTITY(1,1) NOT NULL 
,[ProductName] [nvarchar](100) NOT NULL 
,[CategoryID] [int] NULL  
,[UnitPrice] [money] NOT NULL
);
go

Create Table Employees -- New Table
([EmployeeID] [int] IDENTITY(1,1) NOT NULL 
,[EmployeeFirstName] [nvarchar](100) NOT NULL
,[EmployeeLastName] [nvarchar](100) NOT NULL 
,[ManagerID] [int] NULL  
);
go

Create Table Inventories
([InventoryID] [int] IDENTITY(1,1) NOT NULL
,[InventoryDate] [Date] NOT NULL
,[EmployeeID] [int] NOT NULL
,[ProductID] [int] NOT NULL
,[ReorderLevel] int NOT NULL -- New Column 
,[Count] [int] NOT NULL
);
go

-- Add Constraints (Module 02) -- 
Begin  -- Categories
	Alter Table Categories 
	 Add Constraint pkCategories 
	  Primary Key (CategoryId);

	Alter Table Categories 
	 Add Constraint ukCategories 
	  Unique (CategoryName);
End
go 

Begin -- Products
	Alter Table Products 
	 Add Constraint pkProducts 
	  Primary Key (ProductId);

	Alter Table Products 
	 Add Constraint ukProducts 
	  Unique (ProductName);

	Alter Table Products 
	 Add Constraint fkProductsToCategories 
	  Foreign Key (CategoryId) References Categories(CategoryId);

	Alter Table Products 
	 Add Constraint ckProductUnitPriceZeroOrHigher 
	  Check (UnitPrice >= 0);
End
go

Begin -- Employees
	Alter Table Employees
	 Add Constraint pkEmployees 
	  Primary Key (EmployeeId);

	Alter Table Employees 
	 Add Constraint fkEmployeesToEmployeesManager 
	  Foreign Key (ManagerId) References Employees(EmployeeId);
End
go

Begin -- Inventories
	Alter Table Inventories 
	 Add Constraint pkInventories 
	  Primary Key (InventoryId);

	Alter Table Inventories
	 Add Constraint dfInventoryDate
	  Default GetDate() For InventoryDate;

	Alter Table Inventories
	 Add Constraint fkInventoriesToProducts
	  Foreign Key (ProductId) References Products(ProductId);

	Alter Table Inventories 
	 Add Constraint ckInventoryCountZeroOrHigher 
	  Check ([Count] >= 0);

	Alter Table Inventories
	 Add Constraint fkInventoriesToEmployees
	  Foreign Key (EmployeeId) References Employees(EmployeeId);
End 
go

-- Adding Data (Module 04) -- 
Insert Into Categories 
(CategoryName)
Select CategoryName 
 From Northwind.dbo.Categories
 Order By CategoryID;
go

Insert Into Products
(ProductName, CategoryID, UnitPrice)
Select ProductName,CategoryID, UnitPrice 
 From Northwind.dbo.Products
  Order By ProductID;
go

Insert Into Employees
(EmployeeFirstName, EmployeeLastName, ManagerID)
Select E.FirstName, E.LastName, IsNull(E.ReportsTo, E.EmployeeID) 
 From Northwind.dbo.Employees as E
  Order By E.EmployeeID;
go

Insert Into Inventories
(InventoryDate, EmployeeID, ProductID, [Count], [ReorderLevel]) -- New column added this week
Select '20170101' as InventoryDate, 5 as EmployeeID, ProductID, UnitsInStock, ReorderLevel
From Northwind.dbo.Products
UNIOn
Select '20170201' as InventoryDate, 7 as EmployeeID, ProductID, UnitsInStock + 10, ReorderLevel -- Using this is to create a made up value
From Northwind.dbo.Products
UNIOn
Select '20170301' as InventoryDate, 9 as EmployeeID, ProductID, abs(UnitsInStock - 10), ReorderLevel -- Using this is to create a made up value
From Northwind.dbo.Products
Order By 1, 2
go


-- Adding Views (Module 06) -- 
Create View vCategories With SchemaBinding
 AS
  Select CategoryID, CategoryName From dbo.Categories;
go
Create View vProducts With SchemaBinding
 AS
  Select ProductID, ProductName, CategoryID, UnitPrice From dbo.Products;
go
Create View vEmployees With SchemaBinding
 AS
  Select EmployeeID, EmployeeFirstName, EmployeeLastName, ManagerID From dbo.Employees;
go
Create View vInventories With SchemaBinding 
 AS
  Select InventoryID, InventoryDate, EmployeeID, ProductID, ReorderLevel, [Count] From dbo.Inventories;
go

-- Show the Current data in the Categories, Products, and Inventories Tables
Select * From vCategories;
go
Select * From vProducts;
go
Select * From vEmployees;
go
Select * From vInventories;
go

/********************************* Questions and Answers *********************************/
Print
'NOTES------------------------------------------------------------------------------------ 
 1) You must use the BASIC views for each table.
 2) Remember that Inventory Counts are Randomly Generated. So, your counts may not match mine
 3) To make sure the Dates are sorted correctly, you can use Functions in the Order By clause!
------------------------------------------------------------------------------------------'
-- Question 1 (5% of pts):
-- Show a list of Product names and the price of each product.
-- Use a function to format the price as US dollars.
-- Order the result by the product name.

-- <Put Your Code Here> --
-- use [Assignment07DB_DDoris]
--SELECT * FROM vProducts 

SELECT
	vp.ProductName
  , format(vp.UnitPrice,'C') as [Unit Price (US$)]
FROM
	vProducts vp 
ORDER BY
	vp.ProductName   ;

go

-- Question 2 (10% of pts): 
-- Show a list of Category and Product names, and the price of each product.
-- Use a function to format the price as US dollars.
-- Order the result by the Category and Product.
-- <Put Your Code Here> --

-- select * from categories
-- select * from products

SELECT 
	vc.CategoryName
  , vp.ProductName
  , format(vp.UnitPrice, 'C') as [Unit Price (US$)]
FROM 
	vCategories vc
JOIN
	vProducts vp
ON 
	vc.CategoryID = vp.CategoryID    
ORDER BY 
	vc.CategoryName, vp.ProductName	;   

go

-- Question 3 (10% of pts): 
-- Use functions to show a list of Product names, each Inventory Date, and the Inventory Count.
-- Format the date like 'January, 2017'.
-- Order the results by the Product and Date.

-- <Put Your Code Here> --

-- select * from vProducts
-- select * from vInventories


SELECT 
	vp.ProductName
  , format(vi.InventoryDate,'MMMM, yyyy')   as [Inventory Date]
  , vi.[Count]
FROM 
	vInventories vi
JOIN
	vProducts vp
ON 
	vi.ProductID= vp.ProductID
ORDER BY 
	vp.ProductName, vi.InventoryDate  ;    
go


-- Question 4 (10% of pts): 
-- CREATE A VIEW called vProductInventories. 
-- Shows a list of Product names, each Inventory Date, and the Inventory Count. 
-- Format the date like 'January, 2017'.
-- Order the results by the Product and Date.

-- <Put Your Code Here> --

CREATE or ALTER VIEW
	vProductInventories
	WITH SCHEMABINDING
AS SELECT TOP 10000000 
	vp.ProductName
  , format(vi.InventoryDate,'MMMM, yyyy')   as [Inventory Date]
  , vi.[Count]
FROM 
	dbo.vProducts vp
JOIN 
	dbo.Inventories vi
ON 
	vp.ProductID = vi.ProductID
ORDER BY 
	vp.ProductName, vi.InventoryDate   ;

-- Check that it works: Select * From vProductInventories;
go


-- Question 5 (10% of pts): 
-- CREATE A VIEW called vCategoryInventories. 
-- Shows a list of Category names, Inventory Dates, and a TOTAL Inventory Count BY CATEGORY
-- Format the date like 'January, 2017'.
-- Order the results by the Product and Date.

-- <Put Your Code Here> --
CREATE or ALTER VIEW
	vCategoryInventories
	WITH SCHEMABINDING
AS SELECT TOP 1000000
	vc.CategoryName 
  , subtotal.InventoryDate
  , sum(subtotal.productCount) as categoryCount
 FROM dbo.vCategories vc
 JOIN (	SELECT 
			vp.ProductID
		  , vp.CategoryID
		  , sum(vi.[Count]) as productCount
		  , vi.InventoryDate 
		FROM 
			dbo.vProducts vp
		JOIN 
			dbo.vInventories vi
		ON 
			vp.ProductID = vi.ProductID
		GROUP BY 
			vp.ProductID
		  , vi.InventoryDate
		  , vp.CategoryID) subtotal
		ON 
			vc.CategoryID = subtotal.CategoryID
GROUP BY 
	vc.CategoryName
  , subtotal.InventoryDate
ORDER BY 
	vc.CategoryName
  , subtotal.InventoryDate  ;

-- Check that it works: Select * From vCategoryInventories;
go


-- Question 6 (10% of pts): 
-- CREATE ANOTHER VIEW called vProductInventoriesWithPreviouMonthCounts. 
-- Show a list of Product names, Inventory Dates, Inventory Count, AND the Previous Month Count.
-- Use functions to set any January NULL counts to zero. 
-- Order the results by the Product and Date. 
-- This new view must use your vProductInventories view.

-- <Put Your Code Here> --
--use Assignment07DB_DDoris;
--select top 5 * from vProductInventories


CREATE or ALTER VIEW
	vProductInventoriesWithPreviousMonthCounts
AS SELECT TOP 1000000
	vi.ProductName
  , vi.[Inventory Date]
  , vi.[Count] as [current month inventory]
  , IIF( MONTH(vi.[Inventory Date]) = 1, 0, LAG(vi.[count]) 
		 OVER ( ORDER BY vi.ProductName, MONTH(vi.[inventory date]) )
	   ) as [previous month inventory]
FROM 
	vProductInventories vi  ; 

-- Check that it works: Select * From vProductInventoriesWithPreviousMonthCounts;
go

-- Question 7 (15% of pts): 
-- CREATE a VIEW called vProductInventoriesWithPreviousMonthCountsWithKPIs.
-- Show columns for the Product names, Inventory Dates, Inventory Count, Previous Month Count. 
-- The Previous Month Count is a KPI. The result can show only KPIs with a value of either 1, 0, or -1. 
-- Display months with increased counts as 1, same counts as 0, and decreased counts as -1. 
-- Varify that the results are ordered by the Product and Date.

-- <Put Your Code Here> --
-- select * from vProductInventoriesWithPreviousMonthCounts 

CREATE or ALTER VIEW
	vProductInventoriesWithPreviousMonthCountsWithKPIs
AS SELECT TOP 1000000
	v.productname
  , v.[inventory date]
  , v.[current month inventory]
  , v.[previous month inventory] ,
CASE 
	WHEN 
		v.[current month inventory] > v.[previous month inventory] 
	THEN 
		1
	WHEN 
		v.[current month inventory] = v.[previous month inventory] 
	THEN 
		0
	WHEN 
		v.[current month inventory] < v.[previous month inventory] 
	THEN 
		-1
END AS 
	Current_vs_previous_KPI
FROM 
	vProductInventoriesWithPreviousMonthCounts v ; 

-- Important: This new view must use your vProductInventoriesWithPreviousMonthCounts view!
-- Check that it works: Select * From vProductInventoriesWithPreviousMonthCountsWithKPIs;
GO


-- Question 8 (25% of pts): 
-- CREATE a User Defined Function (UDF) called fProductInventoriesWithPreviousMonthCountsWithKPIs.
-- Show columns for the Product names, Inventory Dates, Inventory Count, the Previous Month Count. 
-- The Previous Month Count is a KPI. The result can show only KPIs with a value of either 1, 0, or -1. 
-- Display months with increased counts as 1, same counts as 0, and decreased counts as -1. 
-- The function must use the ProductInventoriesWithPreviousMonthCountsWithKPIs view.
-- Varify that the results are ordered by the Product and Date.

-- <Put Your Code Here> --

CREATE OR ALTER FUNCTION 
	fProductInventoriesWithPreviousMonthCountsWithKPIs(@value1 integer)
RETURNS TABLE AS RETURN 	
	SELECT top 1000000
		v.ProductName as [Product Name]
	  , v.[Inventory Date]
	  , v.[current month inventory]
	  , v.[previous month inventory] 
	  , v.Current_vs_previous_KPI
	FROM 	
		vProductInventoriesWithPreviousMonthCountsWithKPIs v
	WHERE 
		v.Current_vs_previous_KPI = @value1
	ORDER BY 
		v.ProductName
	  , MONTH(v.[Inventory Date])

GO


/* Check that it works:
Select * From fProductInventoriesWithPreviousMonthCountsWithKPIs(1);
Select * From fProductInventoriesWithPreviousMonthCountsWithKPIs(0);
Select * From fProductInventoriesWithPreviousMonthCountsWithKPIs(-1);
*/
go

/***************************************************************************************/