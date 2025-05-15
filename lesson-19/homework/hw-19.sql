-- Create Employees table
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Employees]') AND type in (N'U'))
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Department NVARCHAR(50),
    Salary DECIMAL(10,2)
);

-- Create DepartmentBonus table
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DepartmentBonus]') AND type in (N'U'))
CREATE TABLE DepartmentBonus (
    Department NVARCHAR(50) PRIMARY KEY,
    BonusPercentage DECIMAL(5,2)
);

-- Insert sample data into Employees
TRUNCATE TABLE Employees;
INSERT INTO Employees (EmployeeID, FirstName, LastName, Department, Salary) VALUES
(1, 'John', 'Doe', 'Sales', 5000),
(2, 'Jane', 'Smith', 'Sales', 5200),
(3, 'Mike', 'Brown', 'IT', 6000),
(4, 'Anna', 'Taylor', 'HR', 4500);

-- Insert sample data into DepartmentBonus
TRUNCATE TABLE DepartmentBonus;
INSERT INTO DepartmentBonus (Department, BonusPercentage) VALUES
('Sales', 10),
('IT', 15),
('HR', 8);

-- Task 1: Stored procedure to create temp table with employee bonuses
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetEmployeeBonuses]') AND type in (N'P'))
DROP PROCEDURE [dbo].[GetEmployeeBonuses];
GO

CREATE PROCEDURE GetEmployeeBonuses
AS
BEGIN
    SET NOCOUNT ON;

    CREATE TABLE #EmployeeBonus (
        EmployeeID INT,
        FullName NVARCHAR(100),
        Department NVARCHAR(50),
        Salary DECIMAL(10,2),
        BonusAmount DECIMAL(10,2)
    );

    INSERT INTO #EmployeeBonus (EmployeeID, FullName, Department, Salary, BonusAmount)
    SELECT 
        e.EmployeeID,
        e.FirstName + ' ' + e.LastName AS FullName,
        e.Department,
        e.Salary,
        e.Salary * db.BonusPercentage / 100 AS BonusAmount
    FROM Employees e
    JOIN DepartmentBonus db ON e.Department = db.Department;

    SELECT EmployeeID, FullName, Department, Salary, BonusAmount 
    FROM #EmployeeBonus;
END;
GO

-- Task 2: Stored procedure to update salaries by department and return updated employees
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateEmployeeSalaries]') AND type in (N'P'))
DROP PROCEDURE [dbo].[UpdateEmployeeSalaries];
GO

CREATE PROCEDURE UpdateEmployeeSalaries
    @Department NVARCHAR(50),
    @IncreasePercentage DECIMAL(5,2)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Employees
    SET Salary = Salary * (1 + @IncreasePercentage / 100)
    WHERE Department = @Department;

    SELECT 
        EmployeeID,
        FirstName + ' ' + LastName AS FullName,
        Department,
        Salary
    FROM Employees
    WHERE Department = @Department;
END;
GO

-- Create Products_Current table
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Products_Current]') AND type in (N'U'))
CREATE TABLE Products_Current (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(100),
    Price DECIMAL(10,2)
);

-- Create Products_New table
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Products_New]') AND type in (N'U'))
CREATE TABLE Products_New (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(100),
    Price DECIMAL(10,2)
);

-- Insert sample data into Products_Current
TRUNCATE TABLE Products_Current;
INSERT INTO Products_Current (ProductID, ProductName, Price) VALUES
(1, 'Laptop', 1200),
(2, 'Tablet', 600),
(3, 'Smartphone', 800);

-- Insert sample data into Products_New
TRUNCATE TABLE Products_New;
INSERT INTO Products_New (ProductID, ProductName, Price) VALUES
(2, 'Tablet Pro', 700),
(3, 'Smartphone', 850),
(4, 'Smartwatch', 300);

-- Task 3: MERGE statement to synchronize Products_Current with Products_New
MERGE INTO Products_Current AS Target
USING Products_New AS Source
ON Target.ProductID = Source.ProductID
WHEN MATCHED THEN
    UPDATE SET
        Target.ProductName = Source.ProductName,
        Target.Price = Source.Price
WHEN NOT MATCHED BY TARGET THEN
    INSERT (ProductID, ProductName, Price)
    VALUES (Source.ProductID, Source.ProductName, Source.Price)
WHEN NOT MATCHED BY SOURCE THEN
    DELETE;

-- Create Tree table
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tree]') AND type in (N'U'))
CREATE TABLE Tree (
    id INT,
    p_id INT
);

-- Insert sample data into Tree
TRUNCATE TABLE Tree;
INSERT INTO Tree (id, p_id) VALUES
(1, NULL),
(2, 1),
(3, 1),
(4, 2),
(5, 2);

-- Task 4: Query to determine node types in the tree
SELECT 
    t1.id,
    CASE 
        WHEN t1.p_id IS NULL THEN 'Root'
        WHEN t1.id IN (SELECT DISTINCT p_id FROM Tree WHERE p_id IS NOT NULL) THEN 'Inner'
        ELSE 'Leaf'
    END AS type
FROM Tree t1
ORDER BY t1.id;

-- Create Signups table
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Signups]') AND type in (N'U'))
CREATE TABLE Signups (
    user_id INT PRIMARY KEY,
    time_stamp DATETIME
);

-- Create Confirmations table
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Confirmations]') AND type in (N'U'))
CREATE TABLE Confirmations (
    user_id INT,
    time_stamp DATETIME,
    action VARCHAR(10),
    CONSTRAINT CHK_action CHECK (action IN ('confirmed', 'timeout'))
);

-- Insert sample data into Signups
TRUNCATE TABLE Signups;
INSERT INTO Signups (user_id, time_stamp) VALUES 
(3, '2020-03-21 10:16:13'),
(7, '2020-01-04 13:57:59'),
(2, '2020-07-29 23:09:44'),
(6, '2020-12-09 10:39:37');

-- Insert sample data into Confirmations
TRUNCATE TABLE Confirmations;
INSERT INTO Confirmations (user_id, time_stamp, action) VALUES 
(3, '2021-01-06 03:30:46', 'timeout'),
(3, '2021-07-14 14:00:00', 'timeout'),
(7, '2021-06-12 11:57:29', 'confirmed'),
(7, '2021-06-13 12:58:28', 'confirmed'),
(7, '2021-06-14 13:59:27', 'confirmed'),
(2, '2021-01-22 00:00:00', 'confirmed'),
(2, '2021-02-28 23:59:59', 'timeout');

-- Task 5: Query to calculate confirmation rate
SELECT 
    s.user_id,
    ROUND(
        ISNULL(
            SUM(CASE WHEN c.action = 'confirmed' THEN 1.0 ELSE 0 END) / 
            NULLIF(COUNT(c.action), 0), 
            0.0
        ), 
        2
    ) AS confirmation_rate
FROM Signups s
LEFT JOIN Confirmations c ON s.user_id = c.user_id
GROUP BY s.user_id
ORDER BY s.user_id;

-- Create employees table for Task 6
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[employees]') AND type in (N'U'))
CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10,2)
);

-- Insert sample data for Task 6
TRUNCATE TABLE employees;
INSERT INTO employees (id, name, salary) VALUES
(1, 'Alice', 50000),
(2, 'Bob', 60000),
(3, 'Charlie', 50000);

-- Task 6: Query to find employees with lowest salary
SELECT id, name, salary
FROM employees
WHERE salary = (SELECT MIN(salary) FROM employees);

-- Create Products table
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Products]') AND type in (N'U'))
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(100),
    Category NVARCHAR(50),
    Price DECIMAL(10,2)
);

-- Create Sales table
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Sales]') AND type in (N'U'))
CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    Quantity INT,
    SaleDate DATE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Insert sample data into Products
TRUNCATE TABLE Sales;
TRUNCATE TABLE Products;
INSERT INTO Products (ProductID, ProductName, Category, Price) VALUES
(1, 'Laptop Model A', 'Electronics', 1200),
(2, 'Laptop Model B', 'Electronics', 1500),
(3, 'Tablet Model X', 'Electronics', 600),
(4, 'Tablet Model Y', 'Electronics', 700),
(5, 'Smartphone Alpha', 'Electronics', 800),
(6, 'Smartphone Beta', 'Electronics', 850),
(7, 'Smartwatch Series 1', 'Wearables', 300),
(8, 'Smartwatch Series 2', 'Wearables', 350),
(9, 'Headphones Basic', 'Accessories', 150),
(10, 'Headphones Pro', 'Accessories', 250),
(11, 'Wireless Mouse', 'Accessories', 50),
(12, 'Wireless Keyboard', 'Accessories', 80),
(13, 'Desktop PC Standard', 'Computers', 1000),
(14, 'Desktop PC Gaming', 'Computers', 2000),
(15, 'Monitor 24 inch', 'Displays', 200),
(16, 'Monitor 27 inch', 'Displays', 300),
(17, 'Printer Basic', 'Office', 120),
(18, 'Printer Pro', 'Office', 400),
(19, 'Router Basic', 'Networking', 70),
(20, 'Router Pro', 'Networking', 150);

-- Insert sample data into Sales
INSERT INTO Sales (SaleID, ProductID, Quantity, SaleDate) VALUES
(1, 1, 2, '2024-01-15'),
(2, 1, 1, '2024-02-10'),
(3, 1, 3, '2024-03-08'),
(4, 2, 1, '2024-01-22'),
(5, 3, 5, '2024-01-20'),
(6, 5, 2, '2024-02-18'),
(7, 5, 1, '2024-03-25'),
(8, 6, 4, '2024-04-02'),
(9, 7, 2, '2024-01-30'),
(10, 7, 1, '2024-02-25'),
(11, 7, 1, '2024-03-15'),
(12, 9, 8, '2024-01-18'),
(13, 9, 5, '2024-02-20'),
(14, 10, 3, '2024-03-22'),
(15, 11, 2, '2024-02-14'),
(16, 13, 1, '2024-03-10'),
(17, 14, 2, '2024-03-22'),
(18, 15, 5, '2024-02-01'),
(19, 15, 3, '2024-03-11'),
(20, 19, 4, '2024-04-01');

-- Task 7: Stored procedure GetProductSalesSummary
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetProductSalesSummary]') AND type in (N'P'))
DROP PROCEDURE [dbo].[GetProductSalesSummary];
GO

CREATE PROCEDURE GetProductSalesSummary
    @ProductID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        p.ProductName,
        SUM(s.Quantity) AS TotalQuantitySold,
        SUM(s.Quantity * p.Price) AS TotalSalesAmount,
        MIN(s.SaleDate) AS FirstSaleDate,
        MAX(s.SaleDate) AS LastSaleDate
    FROM Products p
    LEFT JOIN Sales s ON p.ProductID = s.ProductID
    WHERE p.ProductID = @ProductID
    GROUP BY p.ProductName;
END;
GO

