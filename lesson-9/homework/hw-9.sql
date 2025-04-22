
select p.productname, s.suppliername
from products p, suppliers s;

select d.departmentname, e.employeename
from departments d, employees e;

select s.suppliername, p.productname
from products p
join suppliers s on p.supplierid = s.supplierid;

select c.customername, o.orderid
from orders o
join customers c on o.customerid = c.customerid;

select s.studentname, c.coursename
from students s, courses c;

select p.productname, o.orderid
from products p
join orders o on p.productid = o.productid;

select e.employeename, d.departmentname
from employees e
join departments d on e.departmentid = d.departmentid;

select s.studentname, e.courseid
from students s
join enrollments e on s.studentid = e.studentid;

select p.paymentid, o.orderid
from payments p
join orders o on p.orderid = o.orderid;

select o.orderid, p.productname, p.price
from orders o
join products p on o.productid = p.productid
where p.price > 100;

select e.employeename, d.departmentname
from employees e, departments d
where e.departmentid != d.departmentid;

select o.orderid, p.productname
from orders o
join products p on o.productid = p.productid
where o.quantity > p.stockquantity;

select c.customername, s.productid
from customers c
join sales s on c.customerid = s.customerid
where s.saleamount >= 500;

select s.studentname, c.coursename
from students s
join enrollments e on s.studentid = e.studentid
join courses c on e.courseid = c.courseid;

select p.productname, s.suppliername
from products p
join suppliers s on p.supplierid = s.supplierid
where s.suppliername like '%tech%';


select o.orderid, p.paymentamount, o.totalamount
from orders o
join payments p on o.orderid = p.orderid
where p.paymentamount < o.totalamount;

select e.employeename
from employees e
join employees m on e.managerid = m.employeeid
where e.salary > m.salary;

select p.productname
from products p
join categories c on p.categoryid = c.categoryid
where c.categoryname in ('electronics', 'furniture');

select s.saleid, c.customername
from sales s
join customers c on s.customerid = c.customerid
where c.country = 'usa';


select o.orderid, c.customername
from orders o
join customers c on o.customerid = c.customerid
where c.country = 'germany' and o.totalamount > 100;




select e1.employeename as employee1, e2.employeename as employee2
from employees e1
join employees e2 on e1.employeeid != e2.employeeid
where e1.departmentid != e2.departmentid;

select p.paymentid, o.orderid, p.amountpaid, o.quantity * pr.price as expectedamount
from payments p
join orders o on p.orderid = o.orderid
join products pr on o.productid = pr.productid
where p.amountpaid != o.quantity * pr.price;

select s.studentname
from students s
left join enrollments e on s.studentid = e.studentid
where e.courseid is null;

select m.employeename as manager, e.employeename as employee
from employees e
join employees m on e.managerid = m.employeeid
where m.salary <= e.salary;

select c.customername, o.orderid
from orders o
join customers c on o.customerid = c.customerid
left join payments p on o.orderid = p.orderid
where p.paymentid is null;
