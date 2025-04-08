--TASK 1
-- BULK INSERT is used to import large data from a file into a SQL Server table.

--TASK 2
-- CSV, TXT, XML, JSON

--TASK 3
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Price DECIMAL(10, 2)
);

--TASK 4
INSERT INTO Products (ProductID, ProductName, Price)
VALUES 
(1, 'Laptop', 999.99),
(2, 'Phone', 499.99),
(3, 'Tablet', 299.99);

--TASK 5
CREATE TABLE TestNulls (
    ID INT,
    Name VARCHAR(50) NOT NULL,
    Description VARCHAR(100) NULL
);

--TASK 6
ALTER TABLE Products
ADD CONSTRAINT UQ_ProductName UNIQUE (ProductName);

--TASK 7
SELECT * FROM Products;

--TASK 8
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50) UNIQUE
);

--TASK 9
CREATE TABLE TestIdentity (
    ID INT IDENTITY(1,1),
    Name VARCHAR(50)
);

--TASK 10
BULK INSERT Products
FROM 'C:\Data\products.txt'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

--TASK 11
ALTER TABLE Products
ADD CategoryID INT;

ALTER TABLE Products
ADD CONSTRAINT FK_Products_Categories
FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID);

--TASK 12
-- PRIMARY KEY: Uniquely identifies each row, only one per table
-- UNIQUE KEY: Ensures uniqueness, can have multiple

--TASK 13
ALTER TABLE Products
ADD CONSTRAINT CHK_Price_Positive
CHECK (Price > 0);

--TASK 14
ALTER TABLE Products
ADD Stock INT NOT NULL DEFAULT 0;

--TASK 15
SELECT ProductID, ISNULL(Stock, 0) AS StockValue
FROM Products;

--TASK 16
-- FOREIGN KEY links tables to maintain referential integrity.

--TASK 17
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT CHECK (Age >= 18)
);

--TASK 18
CREATE TABLE AutoNumberTest (
    ID INT IDENTITY(100,10),
    Name VARCHAR(50)
);

--TASK 19
CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    PRIMARY KEY (OrderID, ProductID)
);

--TASK 20
SELECT COALESCE(NULL, NULL, 'Value') AS Result1,
       ISNULL(NULL, 'Default') AS Result2;

--TASK 21
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(50),
    Email VARCHAR(100) UNIQUE
);

--TASK 22
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    CONSTRAINT FK_Orders_Customers
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
