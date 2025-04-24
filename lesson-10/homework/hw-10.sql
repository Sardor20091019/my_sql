--EASY
-- 1. Using the Employees and Departments tables, return the names and salaries of employees whose salary is greater than 50000, along with their department names.
SELECT E.EmployeeName, E.Salary, D.DepartmentName
FROM Employees E
JOIN Departments D ON E.DepartmentID = D.DepartmentID
WHERE E.Salary > 50000;

-- 2. Using the Customers and Orders tables, display customer names and order dates for orders placed in the year 2023.
SELECT C.FirstName, C.LastName, O.OrderDate
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
WHERE YEAR(O.OrderDate) = 2023;

-- 3. Using the Employees and Departments tables, show all employees along with their department names. Include employees who do not belong to any department.
SELECT E.EmployeeName, D.DepartmentName
FROM Employees E
LEFT JOIN Departments D ON E.DepartmentID = D.DepartmentID;

-- 4. Using the Products and Suppliers tables, list all suppliers and the products they supply. Show suppliers even if they don’t supply any product.
SELECT S.SupplierName, P.ProductName
FROM Suppliers S
LEFT JOIN Products P ON S.SupplierID = P.SupplierID;

-- 5. Using the Orders and Payments tables, return all orders and their corresponding payments. Include orders without payments and payments not linked to any order.
SELECT O.OrderID, O.OrderDate, P.PaymentDate, P.Amount
FROM Orders O
LEFT JOIN Payments P ON O.OrderID = P.OrderID;

-- 6. Using the Employees table, show each employee's name along with the name of their manager.
SELECT E.EmployeeName, M.EmployeeName AS ManagerName
FROM Employees E
LEFT JOIN Employees M ON E.ManagerID = M.EmployeeID;

-- 7. Using the Students, Courses, and Enrollments tables, list the names of students who are enrolled in the course named 'Math 101'.
SELECT S.StudentName, C.CourseName
FROM Students S
JOIN Enrollments E ON S.StudentID = E.StudentID
JOIN Courses C ON E.CourseID = C.CourseID
WHERE C.CourseName = 'Math 101';

-- 8. Using the Customers and Orders tables, find customers who have placed an order with more than 3 items. Return their name and the quantity they ordered.
SELECT C.FirstName, C.LastName, O.Quantity
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
WHERE O.Quantity > 3;

-- 9. Using the Employees and Departments tables, list employees working in the 'Human Resources' department.
SELECT E.EmployeeName, D.DepartmentName
FROM Employees E
JOIN Departments D ON E.DepartmentID = D.DepartmentID
WHERE D.DepartmentName = 'Human Resources';


-- MEDIUM
-- 1. Using the Employees and Departments tables, return department names that have more than 10 employees.
SELECT D.DepartmentName, COUNT(E.EmployeeID) AS EmployeeCount
FROM Departments D
JOIN Employees E ON D.DepartmentID = E.DepartmentID
GROUP BY D.DepartmentName
HAVING COUNT(E.EmployeeID) > 10;

-- 2. Using the Products and Sales tables, find products that have never been sold.
SELECT P.ProductID, P.ProductName
FROM Products P
LEFT JOIN Sales S ON P.ProductID = S.ProductID
WHERE S.ProductID IS NULL;

-- 3. Using the Customers and Orders tables, return customer names who have placed at least one order.
SELECT C.FirstName, C.LastName, COUNT(O.OrderID) AS TotalOrders
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID
HAVING COUNT(O.OrderID) > 0;

-- 4. Using the Employees and Departments tables, show only those records where both employee and department exist (no NULLs).
SELECT E.EmployeeName, D.DepartmentName
FROM Employees E
JOIN Departments D ON E.DepartmentID = D.DepartmentID;

-- 5. Using the Employees table, find pairs of employees who report to the same manager.
SELECT E1.EmployeeName AS Employee1, E2.EmployeeName AS Employee2, E1.ManagerID
FROM Employees E1
JOIN Employees E2 ON E1.ManagerID = E2.ManagerID AND E1.EmployeeID <> E2.EmployeeID;

-- 6. Using the Orders and Customers tables, list all orders placed in 2022 along with the customer name.
SELECT O.OrderID, O.OrderDate, C.FirstName, C.LastName
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
WHERE YEAR(O.OrderDate) = 2022;

-- 7. Using the Employees and Departments tables, return employees from the 'Sales' department whose salary is above 60000.
SELECT E.EmployeeName, E.Salary, D.DepartmentName
FROM Employees E
JOIN Departments D ON E.DepartmentID = D.DepartmentID
WHERE D.DepartmentName = 'Sales' AND E.Salary > 60000;

-- 8. Using the Orders and Payments tables, return only those orders that have a corresponding payment.
SELECT O.OrderID, O.OrderDate, P.PaymentDate, P.Amount
FROM Orders O
JOIN Payments P ON O.OrderID = P.OrderID;

-- 9. Using the Products and Orders tables, find products that were never ordered.
SELECT P.ProductID, P.ProductName
FROM Products P
LEFT JOIN Orders O ON P.ProductID = O.ProductID
WHERE O.ProductID IS NULL;

--HARD


-- 1. Using the Employees table, find employees whose salary is greater than the average salary of all employees.
SELECT E.EmployeeName, E.Salary
FROM Employees E
WHERE E.Salary > (SELECT AVG(Salary) FROM Employees);

-- 2. Using the Orders and Payments tables, list all orders placed before 2020 that have no corresponding payment.
SELECT O.OrderID, O.OrderDate
FROM Orders O
LEFT JOIN Payments P ON O.OrderID = P.OrderID
WHERE YEAR(O.OrderDate) < 2020 AND P.PaymentID IS NULL;

-- 3. Using the Products and Categories tables, return products that do not have a matching category.
SELECT P.ProductID, P.ProductName
FROM Products P
LEFT JOIN Categories C ON P.CategoryID = C.CategoryID
WHERE C.CategoryID IS NULL;

-- 4. Using the Employees table, find employees who report to the same manager and earn more than 60000.
SELECT E1.EmployeeName AS Employee1, E2.EmployeeName AS Employee2, E1.ManagerID, E1.Salary
FROM Employees E1
JOIN Employees E2 ON E1.ManagerID = E2.ManagerID AND E1.EmployeeID <> E2.EmployeeID
WHERE E1.Salary > 60000;

-- 5. Using the Employees and Departments tables, return employees who work in departments whose name starts with the letter 'M'.
SELECT E.EmployeeName, D.DepartmentName
FROM Employees E
JOIN Departments D ON E.DepartmentID = D.DepartmentID
WHERE D.DepartmentName LIKE 'M%';

-- 6. Using the Products and Sales tables, list sales where the amount is greater than 500, including product names.
SELECT S.SaleID, P.ProductName, S.SaleAmount
FROM Sales S
JOIN Products P ON S.ProductID = P.ProductID
WHERE S.SaleAmount > 500;

-- 7. Using the Students, Courses, and Enrollments tables, find students who have not enrolled in the course 'Math 101'.
SELECT S.StudentID, S.StudentName
FROM Students S
LEFT JOIN Enrollments E ON S.StudentID = E.StudentID
LEFT JOIN Courses C ON E.CourseID = C.CourseID
WHERE C.CourseName != 'Math 101' OR C.CourseName IS NULL;

-- 8. Using the Orders and Payments tables, return orders that are missing payment details.
SELECT O.OrderID, O.OrderDate, P.PaymentID
FROM Orders O
LEFT JOIN Payments P ON O.OrderID = P.OrderID
WHERE P.PaymentID IS NULL;

-- 9. Using the Products and Categories tables, list products that belong to either the 'Electronics' or 'Furniture' category.
SELECT P.ProductID, P.ProductName, C.CategoryName
FROM Products P
JOIN Categories C ON P.CategoryID = C.CategoryID
WHERE C.CategoryName IN ('Electronics', 'Furniture');
