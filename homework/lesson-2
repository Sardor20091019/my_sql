-- TASK 1
CREATE TABLE Employees (
    EmpID INT,
    Name VARCHAR(50),
    Salary DECIMAL(10,2)
);

-- TASK 2
INSERT INTO Employees (EmpID, Name, Salary) VALUES (1, 'Alice', 6000.00);
INSERT INTO Employees VALUES (2, 'Bob', 4500.00);
INSERT INTO Employees (EmpID, Name, Salary) VALUES (3, 'Charlie', 5200.00);

-- TASK 3
UPDATE Employees SET Salary = 6500.00 WHERE EmpID = 1;

-- TASK 4
DELETE FROM Employees WHERE EmpID = 2;

-- TASK 5
CREATE TABLE TestTable (ID INT);
INSERT INTO TestTable VALUES (1), (2), (3);
DELETE FROM TestTable;
TRUNCATE TABLE TestTable;
DROP TABLE TestTable;

-- TASK 6
ALTER TABLE Employees ALTER COLUMN Name VARCHAR(100);

-- TASK 7
ALTER TABLE Employees ADD Department VARCHAR(50);

-- TASK 8
ALTER TABLE Employees ALTER COLUMN Salary FLOAT;

-- TASK 9
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

-- TASK 10
DELETE FROM Employees;

-- TASK 11
INSERT INTO Employees (EmpID, Name, Salary, Department) VALUES
(1, 'Alice', 6500.00, 'Sales'),
(2, 'Ben', 4300.00, 'HR'),
(3, 'Carol', 5100.00, 'Support'),
(4, 'David', 7000.00, 'IT'),
(5, 'Eva', 5800.00, 'HR');

-- TASK 12
UPDATE Employees SET Department = 'Management' WHERE Salary > 5000;

-- TASK 13
DELETE FROM Employees;

-- TASK 14
ALTER TABLE Employees DROP COLUMN Department;

-- TASK 15
EXEC sp_rename 'Employees', 'StaffMembers';

-- TASK 16
DROP TABLE Departments;

-- TASK 17
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    Description VARCHAR(255)
);

-- TASK 18
ALTER TABLE Products ADD CONSTRAINT CHK_Price_Positive CHECK (Price > 0);

-- TASK 19
ALTER TABLE Products ADD StockQuantity INT DEFAULT 50;

-- TASK 20
EXEC sp_rename 'Products.Category', 'ProductCategory', 'COLUMN';

-- TASK 21
INSERT INTO Products (ProductID, ProductName, ProductCategory, Price, Description) VALUES
(1, 'Laptop', 'Electronics', 1200.00, 'Gaming Laptop'),
(2, 'Phone', 'Electronics', 700.00, 'Smartphone'),
(3, 'Chair', 'Furniture', 150.00, 'Office Chair'),
(4, 'Desk', 'Furniture', 300.00, 'Wooden Desk'),
(5, 'Book', 'Stationery', 20.00, 'Hardcover Book');

-- TASK 22
SELECT * INTO Products_Backup FROM Products;

-- TASK 23
EXEC sp_rename 'Products', 'Inventory';

-- TASK 24
ALTER TABLE Inventory ALTER COLUMN Price FLOAT;

-- TASK 25
ALTER TABLE Inventory ADD ProductCode INT IDENTITY(1000, 5);
