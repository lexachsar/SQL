-- If employee age is < 14, then delete this employee.
CREATE TRIGGER checkEmoloyeeAge
ON Employees
AFTER INSERT
AS
BEGIN
    DECLARE @age INT
    --DECLARE @id INT
    --SELECT @id = PersonnelNumber FROM inserted
 
    SELECT DISTINCT @age = DATEPART(YEAR, GETDATE()) - (SELECT DATEPART(YEAR, ( SELECT BirthDate FROM inserted)))
    IF ( @age < 14)
    BEGIN
        raiserror('Employee age is under 14.', 16, 1);
        ROLLBACK TRANSACTION;
	END;
END;

-- Insert employee of age=0
INSERT Employees(Surname, MiddleName, Name, StoreID, Salary, PositionID, INN, Passport, BirthDate) VALUES
('Yniy', 'Petrovich', 'Ivan', '1', '10001', '2', '123121754338', '8653312387', GETDATE())
GO



CREATE TRIGGER checkEmployeeSalary
ON Employees
AFTER INSERT
AS
BEGIN
	DECLARE @salary MONEY
	DECLARE @minSalary MONEY

	SELECT @salary = salary FROM inserted
	SELECT @minSalary = Positions.MinamalSalary FROM Positions WHERE Positions.ID = (SELECT inserted.PositionID FROM inserted)

	IF ( @salary < @minSalary )
	BEGIN
		PRINT('Зарплата сотрудника слишком мала. Дополняем.');
		UPDATE Employees SET Employees.salary = @minSalary WHERE Employees.PersonnelNumber = (SELECT inserted.PersonnelNumber FROM inserted)
	END;
END;

-- Insert employee with small salary.
INSERT Employees(Surname, MiddleName, Name, StoreID, Salary, PositionID, INN, Passport, BirthDate) VALUES
('Nezarplatin', 'Petrovich', 'Ivan', '1', '3000', '2', '122312175438', '1253232387', '1967/08/25')
SELECT * FROM Employees WHERE Surname = 'Nezarplatin'
GO

-- Instead of delete StoreOrder -- change it's ExecutionStatus
CREATE TRIGGER changeStoreOrderExecutionStatus
ON StoreOrders
INSTEAD OF DELETE
AS
BEGIN
	
	UPDATE StoreOrders SET StoreOrders.ExecutionStatusID = 3

END;

SELECT * FROM StoreOrders WHERE id = '2'
-- Trying to delete StoreOrder
DELETE FROM StoreOrders WHERE id = '2'
SELECT * FROM StoreOrders WHERE id = '2'

CREATE TRIGGER 
ON Product
FOR DELETE
AS
BEGIN
	
	IF 

END;


CREATE TRIGGER employeeSalaryUpdate
ON Employees
AFTER UPDATE
AS
BEGIN
	DECLARE @salary MONEY
	DECLARE @minSalary MONEY

	SELECT @salary = salary FROM inserted
	SELECT @minSalary = Positions.MinamalSalary FROM Positions WHERE Positions.ID = (SELECT inserted.PositionID FROM inserted)

	IF ( @salary < @minSalary )
	BEGIN
		raiserror('Employee salary is too small.', 16, 1);
        ROLLBACK TRANSACTION;
	END;
END;

CREATE TRIGGER employeeSalaryUpdate
ON Employees
INSTEAD OF UPDATE
AS
BEGIN
	DECLARE @salary MONEY
	DECLARE @minSalary MONEY

	SELECT @salary = salary FROM inserted
	SELECT @minSalary = Positions.MinamalSalary FROM Positions WHERE Positions.ID = (SELECT inserted.PositionID FROM inserted)

	IF ( @salary < @minSalary )
	BEGIN
		raiserror('Employee salary is too small.', 16, 1);
        ROLLBACK TRANSACTION;
	END;
END;
