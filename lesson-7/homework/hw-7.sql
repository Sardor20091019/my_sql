-- Easy Task 1
SELECT MIN(Price) FROM Products;

-- Easy Task 2
SELECT MAX(Salary) FROM Employees;

-- Easy Task 3
SELECT COUNT(*) FROM Customers;

-- Easy Task 4
SELECT COUNT(DISTINCT Category) FROM Products;

-- Easy Task 5
SELECT SUM(SalesAmount) FROM Sales WHERE ProductID = 7;

-- Easy Task 6
SELECT AVG(Age) FROM Employees;

-- Easy Task 7
SELECT DeptID, COUNT(*) FROM Employees GROUP BY DeptID;

-- Easy Task 8
SELECT Category, MIN(Price), MAX(Price) FROM Products GROUP BY Category;

-- Easy Task 9
SELECT CustomerID, SUM(SalesAmount) FROM Sales GROUP BY CustomerID;

-- Easy Task 10
SELECT DeptID, COUNT(*) FROM Employees GROUP BY DeptID HAVING COUNT(*) > 5;

-- Medium Task 1
SELECT Category, SUM(SalesAmount), AVG(SalesAmount) FROM Sales GROUP BY Category;

-- Medium Task 2
SELECT COUNT(EmployeeID) FROM Employees WHERE Department = 'HR';

-- Medium Task 3
SELECT DeptID, MAX(Salary), MIN(Salary) FROM Employees GROUP BY DeptID;

-- Medium Task 4
SELECT DeptID, AVG(Salary) FROM Employees GROUP BY DeptID;

-- Medium Task 5
SELECT DeptID, AVG(Salary), COUNT(*) FROM Employees GROUP BY DeptID;

-- Medium Task 6
SELECT Category, AVG(Price) FROM Products GROUP BY Category HAVING AVG(Price) > 400;

-- Medium Task 7
SELECT YEAR(SaleDate), SUM(SalesAmount) FROM Sales GROUP BY YEAR(SaleDate);

-- Medium Task 8
SELECT CustomerID, COUNT(*) FROM Orders GROUP BY CustomerID HAVING COUNT(*) >= 3;

-- Medium Task 9
SELECT DeptID, SUM(Salary) FROM Employees GROUP BY DeptID HAVING SUM(Salary) > 500000;

-- Hard Task 1
SELECT Category, AVG(SalesAmount) FROM Sales GROUP BY Category HAVING AVG(SalesAmount) > 200;

-- Hard Task 2
SELECT CustomerID, SUM(SalesAmount) FROM Sales GROUP BY CustomerID HAVING SUM(SalesAmount) > 1500;

-- Hard Task 3
SELECT DeptID, SUM(Salary), AVG(Salary) FROM Employees GROUP BY DeptID HAVING AVG(Salary) > 65000;

-- Hard Task 4
SELECT CustomerID, MAX(OrderValue), MIN(OrderValue) FROM Orders GROUP BY CustomerID HAVING MIN(OrderValue) >= 50;

-- Hard Task 5
SELECT MONTH(SaleDate), SUM(SalesAmount), COUNT(DISTINCT ProductID) FROM Sales GROUP BY MONTH(SaleDate) HAVING COUNT(DISTINCT ProductID) > 8;

-- Hard Task 6
SELECT YEAR(OrderDate), MIN(Quantity), MAX(Quantity) FROM Orders GROUP BY YEAR(OrderDate);
