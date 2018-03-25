--INSERT author(snp,ID) VALUES
--('Selli\\',78),
--()

--select * FROM 

USE FlowerStore

INSERT ProductCategory(Name) VALUES
('Роза'),
('Тюльпан'),
('Лютик')

SELECT * FROM ProductCategory

INSERT Supplies(SupplierID, StoreID,
	SupplyDate datetime NOT NULL,
	ProductCount int NOT NULL,
	ShopOrderID int NOT NULL
)
GO

INSERT Product(Barcode, Name, Dimensions, WeightInGrams, ShelfLife, ManufacturingTime, CategoryID, SupplyID, ManufacturerID, Cost) VALUES
('1234567890', 'Роза Красная', 'Небольшой', '20', '20:36', '09.09.1997 20:00', '1', '1', '1', '20'),
('1234567891', 'Роза Белая', 'Небольшой', '23', '17:27', '02.09.1997 17:12', '1', '1', '1', '40')

SELECT * FROM Product