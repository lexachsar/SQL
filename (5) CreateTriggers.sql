-- If employee age is < 14, then delete this employee.
CREATE TRIGGER checkEmoloyeeAge
ON Employees
AFTER INSERT
AS
    DECLARE @age INT
    --DECLARE @id INT
    --SELECT @id = PersonnelNumber FROM inserted
 
    SELECT DISTINCT @age = DATEPART(YEAR, GETDATE()) - (SELECT DATEPART(YEAR, ( SELECT BirthDate FROM inserted)))
    IF ( @age < 14)
    BEGIN
        raiserror('Employee age is under 14.', 16, 1);
        ROLLBACK TRANSACTION;
	END;

-- Insert employee of age=1
INSERT Employees(Surname, MiddleName, Name, StoreID, Salary, PositionID, INN, Passport, BirthDate) VALUES
('Ivanov', 'Petrovich', 'Ivan', '1', '10001', '2', '123121754338', '8653312387', '2017/08/25')
GO

CREATE TRIGGER checkEmployeeSalary
ON Employees
AFTER INSERT
AS
	DECLARE @salary MONEY
	DECLARE @minSalary MONEY

	SELECT @salary = salary FROM inserted
	SELECT @minSalary = Positions.MinamalSalary FROM Positions WHERE Positions.ID = (SELECT inserted.PositionID FROM inserted)

	IF ( @salary < @minSalary )
	BEGIN
		PRINT('Зарплата сотрудника слишком мала. Дополняем.');
		
	END;
