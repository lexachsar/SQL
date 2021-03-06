--INSERT author(snp,ID) VALUES
--('Selli\\',78),
--()

--select * FROM 

USE FlowerStore

INSERT ProductCategory(Name) VALUES
('Rose'),
('Tulip'),
('Papaver'),
('Camomile')

SELECT * FROM ProductCategory

INSERT Cities(CityCode, Name, DiscountCoefficient) VALUES
('8452', 'Saratov', '0.7'),
('499', 'Moscow', '0.4'),
('812', 'St. Petersburg', '0.3'),
('4212', 'Khabarovsk', '0.9'),
('846', 'Samara', '0.6')

SELECT * FROM Cities

INSERT Stores(Address, Phone, CityCode) VALUES
('Vavilova, 43', '50-15-17', '8452'),
('Bolshaya Kazachya, 56','27-54-79', '8452'),
('Leninskiy Prospekt, 39', '517-41-14', '499'),
('Karavannaya Ulitsa, 12', '640-16-16', '812'),
('Khabarovskaya Ulitsa, 8', '267-44-44', '4212'),
('Ulitsa Aviatsionnaya, 8', '998-63-63', '846')

SELECT * From Stores

INSERT Positions(Name, MinamalSalary) VALUES
('Florist', '10000'),
('Loader', '5000'),
('Driver', '10000'),
('Administrator', '20000')

SELECT * FROM Positions

INSERT Employees(Surname, MiddleName, Name, StoreID, Salary, PositionID, INN, Passport, BirthDate) VALUES
('Ivanov', 'Ivanovich', 'Ivan', '1', '10001', '2', '123421754338', '8653557853', '1977/08/25'),
('Petrov', 'Petovich', 'Petr', '3', '20001', '1', '453532434353', '3423234215', '1983/09/04'),
('Ivanov', 'Petrovich', 'Ivan', '5', '5001', '2', '213141456764', '9483723419', '1973/03/03'),
('Chernevskiy', 'Dmitrievich', 'Aleksey', '2', '20201', '1', '231556448965', '9875632198', '1997/09/09')

SELECT * FROM Employees

INSERT ServiceCategory(Name, PerformerPositionID) VALUES
('Delivery', '3'),
('Bouquet creation', '1')

SELECT * FROM ServiceCategory

INSERT ExecutionStatuses(Name) VALUES
('Ready'),
('Being delivered'),
('Finished')

SELECT * FROM ExecutionStatuses

INSERT StoreOrders(StoreID, OrderPrice, ExecutionStatusID) VALUES
('1', '20000', '1'),
('2', '30000', '2'),
('4', '5000', '1')

SELECT * FROM StoreOrders
