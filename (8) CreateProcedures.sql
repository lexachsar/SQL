USE FlowerStore

-- All checks that was given to specified person in specified period {{{

DROP PROCEDURE Total_Check_Income_From_Person

CREATE PROCEDURE Total_Check_Income_From_Person @DTstart datetime, @DTfinish datetime, @Income float OUTPUT
AS
SELECT @Income = SUM(Cost) 
	FROM TheCheck 
	WHERE (CheckDate BETWEEN @DTStart AND @DTFinish)


DECLARE @varIncome float;
SET @varIncome = 0;
EXEC Cost_of_supplies @DTstart = '01.12.2012', @DTfinish = '31.12.2018', @Income = @varIncome  OUTPUT;
PRINT @varIncome 

-- }}}

-- Full price of all services and all products for specified check {{{

DROP PROCEDURE Full_Cost_Of_All_Services

CREATE PROCEDURE Full_Cost_Of_All_Services @CheckID int, @Cost float OUTPUT
AS
SELECT @Cost = (
	ISNULL((SELECT SUM(Price) FROM TheServices WHERE CheckID = @CheckID), 0)
	+
	ISNULL((SELECT (Product.Cost * Sales.Amount) FROM Product INNER JOIN Sales ON Sales.ProductBarcode = Product.Barcode WHERE Sales.CheckID = @CheckID), 0) )

DECLARE @varCost float;
SET @varCost = 0;
EXEC Full_Cost_Of_All_Services @CheckID = 71, @Cost = @varCost OUTPUT;
PRINT @varCost 

-- }}}

-- (Pocedure With Cursor) List Of all Employees And Their Posizotions {{{

CREATE PROCEDURE Procedure_With_Cursor @varCursor CURSOR VARYING OUTPUT
AS
SET NOCOUNT ON;
SET @varCursor = CURSOR
FORWARD_ONLY STATIC FOR
	SELECT E.Surname as 'Employee Surname',
	P.Name as 'Employee Position'
	FROM Employees as E
	INNER JOIN Positions as P ON P.ID = E.PositionID
OPEN @varCursor
GO

DECLARE @varCursor2 CURSOR
EXEC Procedure_With_Cursor @varCursor = @varCursor2 OUTPUT
WHILE(@@FETCH_STATUS = 0)
BEGIN
	FETCH NEXT FROM @varCursor2
END

CLOSE @varCursor2
DEALLOCATE @varCursor2
GO

DROP PROCEDURE Procedure_With_Cursor

-- }}}

-- (Prodcedure With Wile Statement){{{

CREATE PROCEDURE sp_clientsorder
@Bound int
AS
DECLARE @i int;
SET @i = 0;

WHILE(@i < @Bound)
BEGIN
SELECT C.CardNumber as 'Client Card Number',
C.Surname as 'Client Surname',
C.Name as 'Client Name',
TC.Cost as 'Check Total Cost',
TC.CheckDate as 'Check Date',
TC.DeliveryDate as 'Check Delivery Date'
FROM TheCheck as TC
INNER JOIN Clients as C ON TC.ClientCardNumber = C.CardNumber
WHERE TC.ID = @i
SET @i = @i+1
END
GO

EXEC sp_clientsorder 900
GO
DROP PROCEDURE sp_clientsorder

-- }}}

-- With IF Statement {{{

CREATE PROCEDURE Procedure_With_Cursor @varCursor CURSOR VARYING OUTPUT
AS                                                                                                                                                                      
SET NOCOUNT ON;
SET @varCursor = CURSOR
FORWARD_ONLY STATIC FOR
	IF((SELECT DeliveryDate FROM TheCheck) < GETDATE())
		BEGIN
			ERROR_MESSAGE('Delivery date is out. Please delivery the order.');
		END
	ELSE
		BEGIN
			SELECT DeliveryDate FROM TheCheck;
		END
OPEN @varCursor
GO

DECLARE @varCursor2 CURSOR
EXEC Procedure_With_Cursor @varCursor = @varCursor2 OUTPUT
WHILE(@@FETCH_STATUS = 0)
BEGIN
        FETCH NEXT FROM @varCursor2
END

CLOSE @varCursor2
DEALLOCATE @varCursor2
GO

-- }}}
