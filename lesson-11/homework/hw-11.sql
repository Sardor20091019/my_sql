-- **1. show all orders placed after 2022 along with the names of the customers who placed them:**
select orders.orderid, concat(customers.firstname, ' ', customers.lastname) as customername, orders.orderdate
from orders
join customers on orders.customerid = customers.customerid
where orders.orderdate > '2022-12-31';

-- **2. display the names of employees who work in either the sales or marketing department:**
select employees.employeename, departments.departmentname
from employees
join departments on employees.departmentid = departments.departmentid
where departments.departmentname in ('sales', 'marketing');

-- **3. for each department, show the name of the employee who earns the highest salary:**
select departments.departmentname, employees.employeename as topemployeename, max(employees.salary) as maxsalary
from employees
join departments on employees.departmentid = departments.departmentid
group by departments.departmentname;

-- **4. list all customers from the usa who placed orders in the year 2023:**
select concat(customers.firstname, ' ', customers.lastname) as customername, orders.orderid, orders.orderdate
from customers
join orders on customers.customerid = orders.customerid
where customers.country = 'usa' and year(orders.orderdate) = 2023;

-- **5. show how many orders each customer has placed:**
select concat(customers.firstname, ' ', customers.lastname) as customername, count(orders.orderid) as totalorders
from customers
left join orders on customers.customerid = orders.customerid
group by customers.customerid;

-- **6. display the names of products that are supplied by either gadget supplies or clothing mart:**
select products.productname, suppliers.suppliername
from products
join suppliers on products.supplierid = suppliers.supplierid
where suppliers.suppliername in ('gadget supplies', 'clothing mart');

-- **7. for each customer, show their most recent order. include customers who haven't placed any orders:**
select concat(customers.firstname, ' ', customers.lastname) as customername, 
       max(orders.orderdate) as mostrecentorderdate, orders.orderid
from customers
left join orders on customers.customerid = orders.customerid
group by customers.customerid;

-- **8. show the customers who have placed an order where the total amount is greater than 500:**
select concat(customers.firstname, ' ', customers.lastname) as customername, orders.orderid, orders.totalamount
from orders
join customers on orders.customerid = customers.customerid
where orders.totalamount > 500;

-- **9. list product sales where the sale was made in 2022 or the sale amount exceeded 400:**
select products.productname, sales.saledate, sales.saleamount
from sales
join products on sales.productid = products.productid
where year(sales.saledate) = 2022 or sales.saleamount > 400;

-- **10. display each product along with the total amount it has been sold for:**
select products.productname, sum(sales.saleamount) as totalsalesamount
from sales
join products on sales.productid = products.productid
group by products.productname;

-- **11. show the employees who work in the hr department and earn a salary greater than 50000:**
select employees.employeename, departments.departmentname, employees.salary
from employees
join departments on employees.departmentid = departments.departmentid
where departments.departmentname = 'hr' and employees.salary > 50000;

-- **12. list the products that were sold in 2023 and had more than 50 units in stock at the time:**
select products.productname, sales.saledate, products.stockquantity
from products
join sales on products.productid = sales.productid
where year(sales.saledate) = 2023 and products.stockquantity > 50;

-- **13. show employees who either work in the sales department or were hired after 2020:**
select employees.employeename, departments.departmentname, employees.hiredate
from employees
join departments on employees.departmentid = departments.departmentid
where departments.departmentname = 'sales' or employees.hiredate > '2020-12-31';

-- **14. list all orders made by customers in the usa whose address starts with 4 digits:**
select concat(customers.firstname, ' ', customers.lastname) as customername, orders.orderid, customers.address, orders.orderdate
from orders
join customers on orders.customerid = customers.customerid
where customers.country = 'usa' and customers.address like '____%' and isnumeric(substring(customers.address, 1, 4)) = 1;

-- **15. display product sales for items in the electronics category or where the sale amount exceeded 350:**
select products.productname, products.category, sales.saleamount
from products
join sales on products.productid = sales.productid
where products.category = 'electronics' or sales.saleamount > 350;

-- **16. show the number of products available in each category:**
select categories.categoryname, count(products.productid) as productcount
from products
join categories on products.categoryid = categories.categoryid
group by categories.categoryname;

-- **17. list orders where the customer is from los angeles and the order amount is greater than 300:**
select concat(customers.firstname, ' ', customers.lastname) as customername, customers.city, orders.orderid, orders.totalamount
from orders
join customers on orders.customerid = customers.customerid
where customers.city = 'los angeles' and orders.totalamount > 300;

-- **18. display employees who are in the hr or finance department, or whose name contains at least 4 vowels:**
select employees.employeename, departments.departmentname
from employees
join departments on employees.departmentid = departments.departmentid
where departments.departmentname in ('hr', 'finance') or 
      length(replace(replace(replace(replace(replace(employees.employeename, 'a', ''), 'e', ''), 'i', ''), 'o', ''), 'u', '')) <= length(employees.employeename) - 4;

-- **19. list products that had a sales quantity above 100 and a price above 500:**
select products.productname, sales.quantitysold, products.price
from sales
join products on sales.productid = products.productid
where sales.quantitysold > 100 and products.price > 500;

-- **20. show employees who are in the sales or marketing department and have a salary above 60000:**
select employees.employeename, departments.departmentname, employees.salary
from employees
join departments on employees.departmentid = departments.departmentid
where departments.departmentname in ('sales', 'marketing') and employees.salary > 60000;
