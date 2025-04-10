-- 1. Top 5 employees
SELECT TOP 5 * FROM Employees;

-- 2. Unique ProductName values
SELECT DISTINCT ProductName FROM Products;

-- 3. Products with Price > 100
SELECT * FROM Products WHERE Price > 100;

-- 4. CustomerName starting with 'A'
SELECT CustomerName FROM Customers WHERE CustomerName LIKE 'A%';

-- 5. Products ordered by Price ascending
SELECT * FROM Products ORDER BY Price ASC;

-- 6. Employees with Salary >= 60000 and Department = 'HR'
SELECT * FROM Employees WHERE Salary >= 60000 AND Department = 'HR';

-- 7. Replace NULL Email with default
SELECT ISNULL(Email, 'noemail@example.com') AS Email FROM Employees;

-- 8. Products with Price between 50 and 100
SELECT * FROM Products WHERE Price BETWEEN 50 AND 100;

-- 9. Distinct Category and ProductName
SELECT DISTINCT Category, ProductName FROM Products;

-- 10. Distinct Category and ProductName ordered by ProductName DESC
SELECT DISTINCT Category, ProductName FROM Products ORDER BY ProductName DESC;


-- 11. Top 10 products by Price DESC
SELECT TOP 10 * FROM Products ORDER BY Price DESC;

-- 12. Return first non-NULL from FirstName or LastName
SELECT COALESCE(FirstName, LastName) AS FullName FROM Employees;

-- 13. Distinct Category and Price from Products
SELECT DISTINCT Category, Price FROM Products;

-- 14. Employees Age between 30–40 OR Department = 'Marketing'
SELECT * FROM Employees WHERE (Age BETWEEN 30 AND 40) OR Department = 'Marketing';

-- 15. OFFSET-FETCH: Rows 11 to 20 ordered by Salary DESC
SELECT * FROM Employees ORDER BY Salary DESC OFFSET 10 ROWS FETCH NEXT 10 ROWS ONLY;

-- 16. Products with Price <= 1000 and Stock > 50, ordered by Stock ASC
SELECT * FROM Products WHERE Price <= 1000 AND Stock > 50 ORDER BY Stock ASC;

-- 17. ProductName contains 'e'
SELECT * FROM Products WHERE ProductName LIKE '%e%';

-- 18. Employees in HR, IT, or Finance
SELECT * FROM Employees WHERE Department IN ('HR', 'IT', 'Finance');

-- 19. Customers ordered by City ASC, PostalCode DESC
SELECT * FROM Customers ORDER BY City ASC, PostalCode DESC;


-- 20. Top 10 products with highest sales
SELECT TOP 10 * FROM Products ORDER BY SalesAmount DESC;

-- 21. Combine FirstName and LastName into FullName
SELECT FirstName + ' ' + LastName AS FullName FROM Employees;

-- 22. Distinct Category, ProductName, and Price (Price > 50)
SELECT DISTINCT Category, ProductName, Price FROM Products WHERE Price > 50;

-- 23. Products with Price < 10% of average price
SELECT * FROM Products
WHERE Price < (SELECT AVG(Price) * 0.10 FROM Products);

-- 24. Employees Age < 30 and in HR or IT
SELECT * FROM Employees
WHERE Age < 30 AND Department IN ('HR', 'IT');

-- 25. Customers with Gmail emails
SELECT * FROM Customers WHERE Email LIKE '%@gmail.com%';

-- 26. Employees with Salary > ALL in Sales department
SELECT * FROM Employees
WHERE Salary > ALL (
    SELECT Salary FROM Employees WHERE Department = 'Sales'
);

-- 27. Orders placed in last 180 days
SELECT * FROM Orders
WHERE OrderDate BETWEEN DATEADD(DAY, -180, GETDATE()) AND GETDATE();
