USE FlowerStore
GO

CREATE TABLE ProductCategory(
	ID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	Name nvarchar(30) NOT NULL UNIQUE
)
GO

CREATE TABLE Product(
	Barcode int NOT NULL PRIMARY KEY,
	Name nvarchar(30) NOT NULL,
	Dimensions nvarchar(30) NOT NULL,
	WeightInGrams int NOT NULL,
	ShelfLife time NOT NULL,
	ManufacturingTime datetime NOT NULL,
	CategoryID int NOT NULL,
	SupplyID int NOT NULL,
	ManufacturerID int NOT NULL,
	Cost int NOT NULL
)
GO

CREATE TABLE Supplies(
	ID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	SupplierID int NOT NULL,
	StoreID int NOT NULL,
	SupplyDate datetime NOT NULL,
	ProductCount int NOT NULL,
	ShopOrderID int NOT NULL
)
GO

CREATE TABLE Suppliers(
	ID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	Name nvarchar(30) NOT NULL,
	LegalAddress nvarchar(100) NOT NULL,
	MailingAddress nvarchar(100) NOT NULL,
	Phone nvarchar(12) NOT NULL
)
GO

CREATE TABLE Manufacturers(
	ID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	Name nvarchar(30) NOT NULL,
	LegalAddress nvarchar(100) NOT NULL,
	MailingAddress nvarchar(100) NOT NULL,
	Phone nvarchar(12) NOT NULL
)
GO

CREATE TABLE Clients(
	CardNumber int NOT NULL PRIMARY KEY,
	Surname nvarchar(30) NOT NULL,
	MiddleName nvarchar(30) NOT NULL,
	Name nvarchar(30) NOT NULL,
	Birth date NOT NULL,
	Phone nvarchar(12) NOT NULL,
	EMail nvarchar(30) NOT NULL,
	TotalCosts int NOT NULL
)
GO

CREATE TABLE Employees(
	PersonnelNumber int NOT NULL PRIMARY KEY,
	Surname nvarchar(30) NOT NULL,
	MiddleName nvarchar(30) NOT NULL,
	Name nvarchar(30) NOT NULL,
	StoreID int NOT NULL,
	-- Should I set to money type
	Salary int NOT NULL,
	PositionID int NOT NULL,
	INN nvarchar(12) NOT NULL,
	Passport nvarchar(10) NOT NULL
)
GO

CREATE TABLE Positions(
	ID int NOT NULL PRIMARY KEY,
	Name nvarchar(30) NOT NULL,
	MinamalSalary int NOT NULL
)
GO

CREATE TABLE Stores(
	ID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	Address nvarchar(100) NOT NULL,
	Phone nvarchar(12) NOT NULL,
	WarehouseCapacity int NOT NULL,
	RefrigeratorCapacity int NOT NULL,
	CityCode int NOT NULL
)
GO

CREATE TABLE StoreOrders(
	ID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	StoreID int NOT NULL,
	-- Money type
	OrderPrice int NOT NULL,
	ExecutionStatusID int NOT NULL
)
GO

CREATE TABLE ExecutionStatuses(	
	ID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	Name nvarchar(30) NOT NULL
)
GO

CREATE TABLE Cities(
	CityCode int NOT NULL PRIMARY KEY,
	Name nvarchar(30) NOT NULL,
	DiscountCoefficient int NOT NULL
)
GO

CREATE TABLE ServiceCategory(
	ID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	Name nvarchar(30) NOT NULL,
	PerformerPositionID int NOT NULL
)
GO

CREATE TABLE TheServices(
	ID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	PerfomerPersonnelNumber int NOT NULL,
	CheckID int NOT NULL,
	-- Money type
	Price int NOT NULL, 
	ExecutionDate datetime NOT NULL
)
GO

CREATE TABLE TheCheck(
	ID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	ClientCardNumber int NOT NULL,
	ServantStoreID int NOT NULL,
	ServantEmployeeID int NOT NULL,
	CheckDate datetime NOT NULL,
	-- Money type
	Cost int NOT NULL,
	-- Allow NULL?
	DeliveryAdress nvarchar(100) NOT NULL,
	DeliveryDate datetime NOT NULL
)
GO


CREATE TABLE Sales(
	CheckID int NOT NULL,
	ProductBarcode int NOT NULL,
	CONSTRAINT PK_Sales PRIMARY KEY (CheckID, ProductBarcode),
	Amount int NOT NULL
)
GO

--ALTER TABLE Child  ADD FOREIGN KEY(FIELD_CHILD) rEferences PARENT(PARENT_FIELD) 

ALTER TABLE Product ADD FOREIGN KEY (CategoryID) REFERENCES ProductCategory(ID)
GO

ALTER TABLE Product ADD FOREIGN KEY (SupplyID) REFERENCES Supplies(ID)
GO
ALTER TABLE Product ADD FOREIGN KEY (ManufacturerID) REFERENCES Manufacturers(ID)
GO

ALTER TABLE Supplies ADD FOREIGN KEY (SupplierID) REFERENCES Suppliers(ID)
GO
ALTER TABLE Supplies ADD FOREIGN KEY (StoreID) REFERENCES Stores(ID)
GO
ALTER TABLE Supplies ADD FOREIGN KEY (ShopOrderID) REFERENCES StoreOrders(ID)
GO

ALTER TABLE Stores ADD FOREIGN KEY (CityCode) REFERENCES Cities(CityCode)
GO

ALTER TABLE Employees ADD FOREIGN KEY (StoreID) REFERENCES Stores(ID)
GO
ALTER TABLE Employees ADD FOREIGN KEY (PositionID) REFERENCES Positions(ID)
GO

ALTER TABLE ServiceCategory ADD FOREIGN KEY (PerformerPositionID) REFERENCES Positions(ID)
GO

ALTER TABLE TheCheck ADD FOREIGN KEY (ClientCardNumber) REFERENCES Clients(CardNumber)
GO
ALTER TABLE TheCheck ADD FOREIGN KEY (ServantStoreID) REFERENCES Stores(ID)
GO
ALTER TABLE TheCheck ADD FOREIGN KEY (ServantEmployeeID) REFERENCES Employees(PersonnelNumber)
GO

ALTER TABLE StoreOrders ADD FOREIGN KEY (StoreID) REFERENCES Stores(ID)
GO
ALTER TABLE StoreOrders ADD FOREIGN KEY (ExecutionStatusID) REFERENCES ExecutionStatuses(ID)
GO

ALTER TABLE Sales ADD FOREIGN KEY (CheckID) REFERENCES TheCheck(ID)
GO
ALTER TABLE Sales ADD FOREIGN KEY (ProductBarcode) REFERENCES Product(Barcode)
GO

ALTER TABLE TheServices ADD FOREIGN KEY (ID) REFERENCES ServiceCategory(ID)
GO
ALTER TABLE TheServices ADD FOREIGN KEY (PerfomerPersonnelNumber) REFERENCES Employees(PersonnelNumber)
GO
ALTER TABLE TheServices ADD FOREIGN KEY (CheckID) REFERENCES TheCheck(ID)
GO