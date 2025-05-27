-- 1
select distinct customername from #sales s where exists (select 1 from #sales where month(saledate) = 3 and year(saledate) = 2024 and customername = s.customername);

-- 2
select top 1 product from #sales group by product order by sum(quantity * price) desc;

-- 3
select max(saleamount) from (select quantity * price as saleamount from #sales) t where saleamount < (select max(quantity * price) from #sales);

-- 4
select format(saledate, 'yyyy-MM') as month, (select sum(quantity) from #sales s2 where format(s2.saledate, 'yyyy-MM') = format(s1.saledate, 'yyyy-MM')) as totalquantity from #sales s1 group by format(saledate, 'yyyy-MM');

-- 5
select distinct a.customername from #sales a where exists (select 1 from #sales b where a.customername <> b.customername and a.product = b.product);

-- 6
select name, sum(case when fruit = 'Apple' then 1 else 0 end) as Apple, sum(case when fruit = 'Orange' then 1 else 0 end) as Orange, sum(case when fruit = 'Banana' then 1 else 0 end) as Banana from fruits group by name;

-- 7
with cte as (select parentid, childid from family union all select f.parentid, c.childid from family f join cte c on f.childid = c.parentid) select * from cte order by parentid, childid;

-- 8
select * from #orders where deliverystate = 'TX' and customerid in (select distinct customerid from #orders where deliverystate = 'CA');

-- 9
update r set fullname = substring(address, charindex('name=', address) + 5, charindex(' ', address + ' ', charindex('name=', address) + 5) - charindex('name=', address) - 5) from #residents r where fullname is null;

-- 10
with paths as (
    select departurecity, arrivalcity, cast(departurecity + ' - ' + arrivalcity as varchar(max)) as route, cost from #routes
    union all
    select p.departurecity, r.arrivalcity, cast(p.route + ' - ' + r.arrivalcity as varchar(max)), p.cost + r.cost from paths p join #routes r on p.arrivalcity = r.departurecity where p.route not like '%' + r.arrivalcity + '%')
select route, cost from paths where departurecity = 'Tashkent' and arrivalcity = 'Khorezm';

-- 11
with ranks as (
    select *, count(case when vals = 'Product' then 1 end) over(order by id) as grp from #rankingpuzzle)
select id, vals, dense_rank() over(partition by grp order by id) as rnk from ranks;

-- 12
select * from #employeesales e where salesamount > (select avg(salesamount) from #employeesales where department = e.department);

-- 13
select * from #employeesales e where exists (select 1 from #employeesales x where x.salesmonth = e.salesmonth and x.salesamount < e.salesamount group by x.salesmonth having count(*) = (select count(*) - 1 from #employeesales where salesmonth = e.salesmonth));

-- 14
select employeeid, employeename from #employeesales e where not exists (select 1 from (select distinct salesmonth from #employeesales) m where not exists (select 1 from #employeesales e2 where e2.employeeid = e.employeeid and e2.salesmonth = m.salesmonth));

-- 15
select name from products where price > (select avg(price) from products);

-- 16
select name from products where stock < (select max(stock) from products);

-- 17
select name from products where category = (select category from products where name = 'Laptop');

-- 18
select name from products where price > (select min(price) from products where category = 'Electronics');

-- 19
select name from products p where price > (select avg(price) from products where category = p.category);

-- 20
select distinct p.name from products p join orders o on p.productid = o.productid;

-- 21
select p.name from products p join orders o on p.productid = o.productid group by p.name having sum(o.quantity) > (select avg(quantity) from orders);

-- 22
select name from products where productid not in (select distinct productid from orders);

-- 23
select top 1 p.name from products p join orders o on p.productid = o.productid group by p.name order by sum(o.quantity) desc;
