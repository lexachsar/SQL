USE FlowerStore
GO


-- Heap And Clustered Index {{{

-- Employee with specified INN
SELECT * FROM Employees WHERE INN = '123421754338'

CREATE CLUSTERED INDEX clustered_idx ON Employees (INN);

DROP INDEX clustered_idx ON Employees;

-- }}}

-- Nonclustered composite {{{

SELECT * FROM Employees WHERE StoreID = 1 AND Salary > 10000

CREATE INDEX noncl_composite ON Employees (StoreID, Salary);  

DROP INDEX noncl_composite ON Employees;

-- }}}

-- Nonclustered filtered {{{

SELECT ID, CheckDate FROM TheCheck WHERE CheckDate > '2007-12-21T00:00:00.000'

CREATE NONCLUSTERED INDEX noncl_filter
ON TheCheck (CheckDate, ID)
WHERE (CheckDate > '2007-12-21T00:00:00.000')

DROP INDEX noncl_filter ON TheCheck

-- }}}

-- Nonclustered covering {{{

SELECT PersonnelNumber, Name, StoreID FROM Employees WHERE Salary > 10000 GROUP BY PersonnelNumber, Name, StoreID

CREATE INDEX noncl_covering  ON Employees(Salary) INCLUDE (Name, StoreID, PersonnelNumber);  

-- }}}

-- Nonclustered unique {{{

SELECT * FROM Stores WHERE Phone = '50-15-17'

CREATE UNIQUE INDEX noncl_unique ON Stores (Phone)

DROP INDEX noncl_unique on Stores;

-- }}}

-- Nonclustered include columns {{{

-- Being delivered orders from stores from city with city code 8452
SELECT a.OrderPrice FROM StoreOrders AS a WHERE a.ExecutionStatusID = '2' AND (SELECT CityCode FROM Stores WHERE ID = a.StoreID) = 8452

CREATE INDEX noncl_include
ON StoreOrders (ExecutionStatusID)
INCLUDE (StoreID, OrderPrice)


-- }}}
