USE FlowerStore
GO

-- Heap And Clustered Index {{{

-- Employee with specified INN
SELECT * FROM Employees WHERE INN = 123421754338

CREATE CLUSTERED INDEX clustered_idx ON Employees (INN);

-- }}}

-- Nonclustered composite{{{

SELECT * FROM Employees WHERE StoreID = 1 AND Salary > 10000

CREATE INDEX nonclustered_composite  ON Employees (StoreID, Salary);  

-- }}}

-- Nonclustered filtered {{{

SELECT ID, OrderPrice FROM StoreOrders WHERE OrderPrice BETWEEN '10000' AND '20000'

CREATE INDEX noncl_filter
ON StoreOrders (OrderPrice, ID)
WHERE (OrderPrice > '10000')]

-- }}}

-- Nonclustered covering {{{

SELECT * FROM Employees WHERE Salary > 10000 GROUP BY Name, StoreID, ID

CREATE INDEX noncl_covering  ON Employees(Salary) INCLUDE (Name, StoreID, ID);  

-- }}}

-- Nonclustered unique {{{

SELECT * FROM Stores WHERE Phone = '50-15-17'

CREATE UNIQUE INDEX noncl_unique ON Stores (Phone)

-- }}}

-- Nonclustered include columns {{{

-- Being delivered orders from stores from city with city code 8452
SELECT a.OrderPrice FROM StoreOrders AS a WHERE a.ExecuyionStatusID = '2' AND (SELECT CityCode FROM Stores WHERE ID = a.StoreID) = 8452

CREATE INDEX noncl_include
ON StoreOrders (ExecutionStatusID)
INCLUDE (StoreID, OrderPrice)


-- }}}
