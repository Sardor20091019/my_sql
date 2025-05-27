-- 1
select productid, sum(quantity) as totalquantity, sum(quantity * p.price) as totalrevenue into #monthlysales from sales s join products p on s.productid = p.productid where format(saledate,'yyyy-MM') = format(getdate(),'yyyy-MM') group by productid;

-- 2
create view vw_productsalessummary as select p.productid, p.productname, p.category, sum(s.quantity) as totalquantitysold from products p left join sales s on p.productid = s.productid group by p.productid, p.productname, p.category;

-- 3
create function fn_gettotalrevenueforproduct(@productid int) returns decimal(18,2) as begin declare @revenue decimal(18,2); select @revenue = sum(s.quantity * p.price) from sales s join products p on s.productid = p.productid where s.productid = @productid; return @revenue; end;

-- 4
create function fn_getsalesbycategory(@category varchar(50)) returns table as return select p.productname, sum(s.quantity) as totalquantity, sum(s.quantity * p.price) as totalrevenue from products p join sales s on p.productid = s.productid where p.category = @category group by p.productname;

-- 5
create function dbo.fn_isprime (@number int) returns varchar(3) as begin if @number <= 1 return 'no'; declare @i int = 2; while @i * @i <= @number begin if @number % @i = 0 return 'no'; set @i += 1; end return 'yes'; end;

-- 6
create function fn_getnumbersbetween(@start int, @end int) returns @numbers table (number int) as begin declare @i int = @start; while @i <= @end begin insert into @numbers values (@i); set @i += 1; end return; end;

-- 7
create function getnthhighestsalary(@n int) returns int as begin return (select distinct salary from (select salary, dense_rank() over(order by salary desc) as rnk from employee) as t where rnk = @n); end;

-- 8
select top 1 id, count(*) as num from (select requester_id as id from requestaccepted union all select accepter_id as id from requestaccepted) as all_friends group by id order by num desc;

-- 9
create view vw_customerordersummary as select c.customer_id, c.name, count(o.order_id) as total_orders, sum(o.amount) as total_amount, max(o.order_date) as last_order_date from customers c left join orders o on c.customer_id = o.customer_id group by c.customer_id, c.name;

-- 10
select rownumber, (select top 1 testcase from gaps g2 where g2.rownumber <= g1.rownumber and testcase is not null order by g2.rownumber desc) as workflow from gaps g1 order by rownumber;
