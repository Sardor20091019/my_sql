
select category, count(*) from products group by category

select avg(price) from products where category = 'electronics'

select * from customers where city like 'l%'


select productname from products where productname like '%er'

select * from customers where country like '%a'

select max(price) from products

select productname, quantity, iif(quantity < 30, 'low stock', 'sufficient') as stockstatus from products
  
select country, count(*) from customers group by country

select min(quantity), max(quantity) from orders

select customerid from orders where year(orderdate) = 2023  
except  
select customerid from invoices

select productname from products  
union all  
select productname from products_discounted

select productname from products  
union  
select productname from products_discounted;

select year(orderdate) as orderyear, avg(orderamount) as avgamount  
from orders  
group by year(orderdate)

select productname,  
case  
when price < 100 then 'low'  
when price between 100 and 500 then 'mid'  
else 'high'  
end as pricegroup  
from products

select distinct city from customers order by city

select productid, sum(salesamount) from sales group by productid

select productname from products where productname like '%oo%'

select productid from products  
intersect  
select productid from products_discounted

select top 3 customerid, sum(invoiceamount) as totalspent  
from invoices  
group by customerid  
order by totalspent desc

select productid, productname from products  
except  
select productid, productname from products_discounted

select p.productname, count(s.saleid) as timessold  
from products p  
join sales s on p.productid = s.productid  
group by p.productname

select top 5 productid, sum(quantity) as totalquantity  
from orders  
group by productid  
order by totalquantity desc
