--INSERT author(snp,ID) VALUES
--('Selli\\',78),
--()

--select * FROM 

USE FlowerStore

INSERT ProductCategory(Name) VALUES
('Rose'),
('Tulip'),
('')

SELECT * FROM ProductCategory

INSERT Cities(CityCode, Name, DiscountCoefficient) VALUES
('8452', 'Saratov', '0.7')
('499', 'Moscow', '0.4')
('812', 'St. Petersburg', '0.3')
('4212', 'Khabarovsk', '0.9')
('846', 'Samara', '0.6')

SELECT * FROM Cities

INSERT Stores(Address, Phone, CityCode)
('Vavilova, 43', '50-15-17', '8452')
('Bolshaya Kazachya, 56','27-54-79', '8452')
('Leninskiy Prospekt, 39', '517-41-14', '499')
('', '', '')
('', '', '')
('', '', '')

SELECT * From Stores

INSERT Product(Barcode, Name, Dimensions, WeightInGrams, ShelfLife, ManufacturingTime, CategoryID, SupplyID, ManufacturerID, Cost) VALUES
('1234567890', 'Роза Красная', 'Небольшой', '20', '20:36', '09.09.1997 20:00', '1', '1', '1', '20'),
('1234567891', 'Роза Белая', 'Небольшой', '23', '17:27', '02.09.1997 17:12', '1', '1', '1', '40')

SELECT * FROM Product
