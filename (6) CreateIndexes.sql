USE FlowerStore
GO

-- Clustered index composite {{{

CREATE CLUSTERED INDEX CL_INDEX_Order_material_COMPOSITE --ÑÎÑÒÀÂÍÎÉ
ON [dbo].[Employees]([Salary], [PersonnelNumber])

PRINT('Time check for clustered index.')
SET STATISTICS TIME ON;

PRINT('CHECK 1st OPERATION')
SELECT PersonnelNumber, Salary FROM Employees WHERE Salary < 1000000

-- }}}