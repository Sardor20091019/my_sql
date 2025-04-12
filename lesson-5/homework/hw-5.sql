-- 1. Rename ProductName to Name using alias
SELECT ProductName AS Name
FROM Products;

-- 2. Alias the Customers table as Client
SELECT *
FROM Customers AS Client;

-- 3. Combine product names from Products and Products_Discounted using UNION (removes duplicates)
SELECT ProductName FROM Products
UNION
SELECT ProductName FROM Products_Discounted;

-- 4. Find common product names using INTERSECT
SELECT ProductName FROM Products
INTERSECT
SELECT ProductName FROM Products_Discounted;

-- 5. Get distinct customer names and countries
SELECT DISTINCT CustomerName, Country
FROM Customers;

-- 6. Create a conditional column: 'High' if Price > 1000, otherwise 'Low'
SELECT ProductName, Price,
       CASE 
           WHEN Price > 1000 THEN 'High'
           ELSE 'Low'
       END AS PriceCategory
FROM Products;

-- 7. Use IIF to show 'Yes' if StockQuantity > 100, otherwise 'No'
SELECT ProductName, StockQuantity,
       IIF(StockQuantity > 100, 'Yes', 'No') AS HighStock
FROM Products_Discounted;

-- 8. Combine product names from Products and OutOfStock using UNION
SELECT ProductName FROM Products
UNION
SELECT ProductName FROM OutOfStock;

-- 9. Show products in Products that are not in Products_Discounted using EXCEPT
SELECT ProductName FROM Products
EXCEPT
SELECT ProductName FROM Products_Discounted;

-- 10. Create a column with IIF: 'Expensive' if Price > 1000, else 'Affordable'
SELECT ProductName, Price,
       IIF(Price > 1000, 'Expensive', 'Affordable') AS PriceLevel
FROM Products;

-- 11. Find employees who are younger than 25 or earn more than 60000
SELECT * FROM Employees
WHERE Age < 25 OR Salary > 60000;

-- 12. Increase salary by 10% for employees in HR department or with EmployeeID = 5
UPDATE Employees
SET Salary = Salary * 1.10
WHERE Department = 'HR' OR EmployeeID = 5;

-- 13. Show common products between Products and Products_Discounted using INTERSECT
SELECT ProductName FROM Products
INTERSECT
SELECT ProductName FROM Products_Discounted;

-- 14. Use CASE to create tiers based on SaleAmount in Sales table
SELECT SaleID, SaleAmount,
       CASE
           WHEN SaleAmount > 500 THEN 'Top Tier'
           WHEN SaleAmount BETWEEN 200 AND 500 THEN 'Mid Tier'
           ELSE 'Low Tier'
       END AS Tier
FROM Sales;

-- 15. Find customers who placed orders but have no matching record in Invoices
SELECT CustomerID FROM Orders
EXCEPT
SELECT CustomerID FROM Invoices;

-- 16. Assign discount percentage based on Quantity in Orders table
SELECT CustomerID, Quantity,
       CASE 
           WHEN Quantity = 1 THEN '3%'
           WHEN Quantity BETWEEN 2 AND 3 THEN '5%'
           ELSE '7%'
       END AS DiscountPercentage
FROM Orders;
