USE FlowerStore
GO

-- Task 1 {{{

-- 1st Part {{{
CREATE VIEW View_Employee_1
AS
SELECT PersonnelNumber, Name, PositionID, Salary
FROM     Employees
WHERE  (Salary > 10000)

SELECT * from View_Employee_1

sp_helptext View_Employee_1

-- }}}

-- 2nd Part (With Encryption) {{{

CREATE VIEW View_Employee_WITH_ENCRYPTION_1
WITH ENCRYPTION
AS
SELECT  PersonnelNumber, Name, PositionID, Salary
FROM Employees
WHERE  (Salary > 10000)

SELECT * from View_Employee_WITH_ENCRYPTION_1

sp_helptext View_Employee_WITH_ENCRYPTION_1

-- }}}

-- 3rd Part {{{ 

CREATE VIEW View_Check_1
AS
SELECT ID, ServantStoreID, ClientCardNumber, CheckDate
FROM     TheCheck
WHERE  (CheckDate > CONVERT(DATETIME, '2012-12-12 00:00:00', 102))

SELECT * from View_Check_1

sp_helptext View_Check_1

-- }}}

-- }}}

-- Task 2  (WITH CHECK OPTION) {{{

--drop view View_ProductCategory_2

CREATE VIEW View_ProductCategory_2
AS
SELECT *
FROM   ProductCategory
WHERE  (Name LIKE '%a%')
WITH CHECK OPTION

INSERT INTO View_ProductCategory_2 values ('Grass');
INSERT INTO View_ProductCategory_2 values ('Oak-Tree');

SELECT * from View_ProductCategory_2 where name = 'Grass'
SELECT * from View_ProductCategory_2 where name = 'Oak-Tree'

SELECT * FROM ProductCategory where name = 'Grass'
SELECT * FROM ProductCategory where name = 'Oak-Tree'

-- }}}

-- Task 3 (WITH SCHEMABINDING) {{{

SET NUMERIC_ROUNDABORT OFF;
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL,
ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON;

--drop view View_Product_3
CREATE VIEW View_Product_3
WITH SCHEMABINDING
AS
SELECT Barcode, Name, ManufacturingTime, CategoryID, Cost
FROM     dbo.Product
WHERE Name LIKE '%A%'

CREATE UNIQUE CLUSTERED INDEX clustered_idx  
ON View_Product_3 (Barcode);  

--estimated subtree cost: 0.0033029
SELECT Barcode, Name, ManufacturingTime, CategoryID, Cost
FROM     View_Product_3
WITH (NOEXPAND INDEX (clustered_idx))
WHERE Name LIKE '%A%';

--estimated subtree cost: 0.0033139
SELECT Barcode, Name, ManufacturingTime, CategoryID, Cost
FROM    Product 
WHERE Name LIKE '%A%';

-- }}}
