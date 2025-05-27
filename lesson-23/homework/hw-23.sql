--1
select sum(unitprice * unitsold) as total_revenue from sales;

--2
select avg(unitprice) as avg_unit_price from products;

--3
select count(*) as total_transactions from sales;

--4
select max(unitsold) as max_units_sold from sales;

--5
select category, sum(unitsold) as total_units_sold from products p join sales s on p.productid = s.productid group by category;

--6
select region, sum(unitprice * unitsold) as total_revenue from sales s join customers c on s.customerid = c.customerid group by region;

--7
select top 1 p.productname, sum(s.unitprice * s.unitsold) as revenue from sales s join products p on s.productid = p.productid group by p.productname order by revenue desc;

--8
select sale_date, sum(unitprice * unitsold) over (order by sale_date rows between unbounded preceding and current row) as running_total from sales;

--9
select category, sum(unitprice * unitsold) * 100.0 / (select sum(unitprice * unitsold) from sales) as revenue_percentage from products p join sales s on p.productid = s.productid group by category;

--10
select s.*, c.customername from sales s join customers c on s.customerid = c.customerid;

--11
select customerid, count(*) as transactions from sales group by customerid having count(*) > 5;

--12
select productid, avg(unitprice) as avg_price from sales group by productid;

--13
select distinct region from customers;

--14
select productname from products where unitprice > 100;

--15
select customername, sum(unitprice * unitsold) as total_spent from sales s join customers c on s.customerid = c.customerid group by customername order by total_spent desc;

--16
select year(sale_date) as sale_year, sum(unitprice * unitsold) as revenue from sales group by year(sale_date);

--17
select productid, count(distinct customerid) as unique_customers from sales group by productid;

--18
select category, avg(unitprice) as avg_price from products group by category;

--19
select customerid, sum(unitsold) as total_units from sales group by customerid order by total_units desc limit 10;

--20
select productname from products where discontinued = 0 order by unitprice desc limit 5;

--21
select c.region, avg(s.unitprice * s.unitsold) as avg_revenue from sales s join customers c on s.customerid = c.customerid group by c.region;

--22
select month(sale_date) as sale_month, sum(unitsold) as total_units from sales group by month(sale_date);

--23
select p.productname, s.sale_date, s.unitsold from sales s join products p on s.productid = p.productid where s.unitsold > 50;

--24
select category, sum(unitsold) as total_units, sum(unitprice * unitsold) as total_revenue from products p join sales s on p.productid = s.productid group by category order by total_revenue desc;

--25
select customername, count(*) as purchase_count from sales s join customers c on s.customerid = c.customerid group by customername having count(*) > 3 order by purchase_count desc;
