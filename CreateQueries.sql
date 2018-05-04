-- Joins {{{

--(INNER JOIN) All stores, that have orders
SELECT Stores.Address, Stores.Phone, StoreOrders.OrderPrice
FROM Stores
	INNER JOIN StoreOrders ON Stores.ID = StoreOrders.StoreID;

--(LEFT JOIN) All stores, sorted by OrderPrice
SELECT Stores.Address, Stores.Phone, StoreOrders.OrderPrice
FROM Stores
	LEFT JOIN StoreOrders ON Stores.ID=StoreOrders.StoreID
	ORDER BY StoreOrders.OrderPrice;

--(CROSS JOIN) All types of services for all types of products
SELECT ProductCategory.Name, ServiceCategory.Name
FROM ProductCategory 
	CROSS JOIN Service Category;

--(CROSS APPLY) All stores, that have orders 
SELECT Stores.Address, Stores.Phone, StoreOrders.OrderPrice
FROM Stores
  CROSS APPLY (SELECT * 
               FROM StoreOrders
               WHERE Stores.ID = StoreOrders.StoreID) ORD

--(SELF JOIN) List of all stores, that are situated in one city
SELECT Stores.Address AS 1stStoreAddress, Stores.Address  AS 2ndStoreAddress, Stores.CityCode
FROM Stores A, Stores B
	WHERE A.ID <> B.ID
	AND A.CityCode = B.CityCode 
	ORDER BY A.CityCode;

-- }}}

-- Data Filtration {{{

--(EXISTS) Phone numbers of stores, that make big orders
SELECT Phone
	FROM Stores 
	WHERE EXISTS (SELECT ID FROM StoreOrders WHERE StoreID = Stores.ID AND OrderPrice > 25000 )

--(IN) All stores form Saratov ant St. Petersburg
SELECT * 
	FROM Stores
	WHERE CityCode IN ('8452', '812', 'UK');

--(ALL) All city codes that have all stores with specified phone number  
SELECT Code
	FROM Citites
	WHERE CityCode = ALL ( SELECT CityCode FROM Stores WHERE Phone = '50-15-17'  );

--(SOME/ANY) All city codes, that have stores with specified phone number
SELECT Code
	FROM Citites
	WHERE CityCode = ANY ( SELECT CityCode FROM Stores WHERE Phone = '50-15-17'  );

--(BETWEEN) All orders with average OrderPrice
SELECT *
	FROM StoreOrders
	WHERE OrderPrice BETWEEN 5000 AND 25000;

--(LIKE) All Employees with "v" in surname
SELECT *
	FROM Employees
	WHERE Surname LIKE '%v%'

-- }}}

-- CASEQueries {{{

SELECT StoreID, OrderPrice,
	CASE
		WHEN OrderPrice > 25000 THEN "!!!Order price is too big!!!"
		WHEN Quantity <= 25000 THEN "Order price is average"
		ELSE "Order price is something else"
	END
FROM StoreOrders; 

-- }}}

-- Built-in functions {{{

-- (CAST) Get only manufaturing date.
SELECT CAST(SELECT ManufacturingTime FROM Product AS date)

-- (CONVERT) Get only approximate product cost.
SELECT CONVERT(
	SELECT Cost 
		FROM Product 
		AS int
	)


-- (ISNULL) If delivery adress is null, then delivery to store. 
SELECT ID, ServantStoreID, ISNULL(
	DeliveryAdress, "Store Address"
	)
	FROM TheCheck

-- (NULLIF)  
SELECT NULLIF(
		
	)

--  (COALESCE) First delivery adress.
SELECT COALESCE(
	SELECT DeliveryAdress 
		FROM TheCheck
	)

-- (CHOOSE) Second delivery adress.
SELECT CHOOSE(
	2, SELECT DeliveryAdress 
		FROM TheCheck
	)

-- (IIF)
SELECT IIF(45 > 30, "DA", "NET")

-- }}}

-- Functions for working with strings {{{

-- (REPLACE) Change Ulitsa to Street
SELECT REPLACE (
	SELECT Address FROM Stores, Ulitsa, Street
	)


-- (SUBSTRING) 
SELECT SUBSTRING('I love Saratov.', 8, 7)

-- (STUFF)
SELECT STUFF('I love Saratov.', 3, 4, 'hate') 

-- (STR) round number 185.476 -> 185.48
SELECT STR(185.476, 6, 2)

-- (UNICODE) return unicode encoding of character "a"
SELECT UNICODE('a')

-- (LOWER) Lower Case City Name 
SELECT LOWER(Name) AS LowercaseCityName FROM Cities

-- (UPPER) Upper Case Product Category Name 
SELECT UPPER(Name) AS UppercaseProductCategoryName FROM ProductCategory

-- }}} 

-- DATE and TIME queries {{{

-- (DATEPART) Get employee birth year.
SELECT DATEPART(year, BirthDate) AS EmployeeBirthYear FROM Employees

-- (DATEADD) Add 2 months to employee birth date.
SELECT DATEADD(month, 2, BirthDate) AS EmployeeBirthDateMonthAdd FROM Employees

-- (DATEDIFF) Show difference between two dates.
SELECT DATEDIFF(day, '2017/07/23', '2011/04/03') 

-- (GETDATE()) Get current date.
SELECT GETDATE()

-- (SYSDATETIMEOFFSET()) Returns a datetimeoffset(7) value that contains the date and time of the computer on which the instance of SQL Server is running. The time zone offset is included.
SELECT SYSDATETIMEOFFSET()

-- }}}

-- GROUP BY + HAVING {{{

-- (GROUP BY) Count stores from one city.
SELECT COUNT(ID), CityCode FROM Stores GROUP BY CityCode

-- (HAVING) City codes, where 2 or more stores.
SELECT CityCode FROM Stores GROUP BY CityCode HAVING COUNT(ID) > 2


-- }}}


