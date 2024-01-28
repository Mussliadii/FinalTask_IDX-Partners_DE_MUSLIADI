CREATE TABLE DimCustomer (
	CustomerID int NOT NULL,
	CustomerName varchar(50) NOT  NULL,
	Age int NOT NULL,
	Gender varchar(50) NOT NULL,
	City varchar(50) NOT NULL,
	NoHp varchar(50) NOT NULL,
	CONSTRAINT PKCustomerID PRIMARY KEY (CustomerID)
);

CREATE TABLE DimProduct (
	ProductID int NOT NULL,
	ProductName varchar(255) NOT  NULL,
	ProductCategory varchar(255) NOT  NULL,
	ProductUnitPrice int NOT  NULL
	CONSTRAINT PKProductID PRIMARY KEY (ProductID)
);

CREATE TABLE DimStatusOrder (
	StatusID int NOT NULL,
	StatusOrder varchar(50) NOT  NULL,
	StatusOrderDesc varchar(50) NOT  NULL,
	CONSTRAINT PKStatusID PRIMARY KEY (StatusID)
);

CREATE TABLE FactSalesOrder (
	OrderID int NOT NULL,
	CustomerID int NOT NULL,
	ProductID int NOT NULL,
	Quantity int NOT NULL,
	Amount int NOT NULL,
	StatusID int NOT NULL,
	OrderDate date NOT NULL,
	CONSTRAINT PKOrderID PRIMARY KEY (OrderID),
	CONSTRAINT FKCustomerID FOREIGN KEY (CustomerID) REFERENCES DimCustomer (CustomerID),
	CONSTRAINT FKProductID FOREIGN KEY (ProductID) REFERENCES DimProduct (ProductID),
	CONSTRAINT FKStatusID FOREIGN KEY (CustomerID) REFERENCES DimStatusOrder (StatusID)
);

SELECT * FROM DimCustomer
SELECT * FROM DimProduct
SELECT * FROM DimStatusOrder
SELECT * FROM FactSalesOrder

CREATE PROCEDURE summary_order_status @StatusID int AS
BEGIN
	SELECT
		fo.OrderID,
		dc.CustomerName,
		dp.ProductName,
		fo.Quantity,
		ds.StatusOrder
	FROM
		FactSalesOrder AS fo
	Join
		DimCustomer AS dc
			ON fo.CustomerID = dc.CustomerID
	JOIN
		DimProduct AS dp
			ON fo.ProductID = dp.PoductID
	JOIN
		DimStatusOrder AS ds
			ON fo.StatusID = ds.StatusID
	WHERE ds.StatusID = @StatusID
END
;