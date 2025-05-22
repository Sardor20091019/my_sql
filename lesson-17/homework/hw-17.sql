--1
drop table if exists #regionsales;
create table #regionsales (
    region varchar(100),
    distributor varchar(100),
    sales integer not null,
    primary key (region, distributor)
);
insert into #regionsales (region, distributor, sales) values
('north','ace',10), ('south','ace',67), ('east','ace',54),
('north','acme',65), ('south','acme',9), ('east','acme',1), ('west','acme',7),
('north','direct parts',8), ('south','direct parts',7), ('west','direct parts',12);

with all_regions as (
    select distinct region from #regionsales
),
all_distributors as (
    select distinct distributor from #regionsales
),
all_combinations as (
    select d.distributor, r.region
    from all_distributors d
    cross join all_regions r
)
select 
    c.region,
    c.distributor,
    isnull(rs.sales, 0) as sales
from all_combinations c
left join #regionsales rs
    on rs.region = c.region and rs.distributor = c.distributor
order by c.distributor, c.region;


--2

truncate table employee;
insert into employee (id, name, department, managerid) values
(101, 'john', 'a', null), (102, 'dan', 'a', 101), (103, 'james', 'a', 101),
(104, 'amy', 'a', 101), (105, 'anne', 'a', 101), (106, 'ron', 'b', 101);

select name
from employee
where id in (
    select managerid
    from employee
    where managerid is not null
    group by managerid
    having count(*) >= 5
);


--3 
truncate table products;
insert into products (product_id, product_name, product_category) values
(1, 'leetcode solutions', 'book'),
(2, 'jewels of stringology', 'book'),
(3, 'hp', 'laptop'), (4, 'lenovo', 'laptop'), (5, 'leetcode kit', 't-shirt');

truncate table orders;
insert into orders (product_id, order_date, unit) values
(1,'2020-02-05',60),(1,'2020-02-10',70),
(2,'2020-01-18',30),(2,'2020-02-11',80),
(3,'2020-02-17',2),(3,'2020-02-24',3),
(4,'2020-03-01',20),(4,'2020-03-04',30),(4,'2020-03-04',60),
(5,'2020-02-25',50),(5,'2020-02-27',50),(5,'2020-03-01',50);

select 
    p.product_name,
    sum(o.unit) as unit
from products p
join orders o on p.product_id = o.product_id
where o.order_date >= '2020-02-01' and o.order_date < '2020-03-01'
group by p.product_name
having sum(o.unit) >= 100;


--4
drop table if exists orders;
create table orders (
    orderid integer primary key,
    customerid integer not null,
    [count] money not null,
    vendor varchar(100) not null
);
insert into orders values
(1,1001,12,'direct parts'), (2,1001,54,'direct parts'), (3,1001,32,'acme'),
(4,2002,7,'acme'), (5,2002,16,'acme'), (6,2002,5,'direct parts');

with vendor_totals as (
    select customerid, vendor, sum([count]) as total_count
    from orders
    group by customerid, vendor
),
ranked as (
    select *, row_number() over(partition by customerid order by total_count desc) as rank
    from vendor_totals
)
select customerid, vendor
from ranked
where rank = 1;


--5
declare @check_prime int = 100
declare @i int = 2;
declare @is_prime bit = 1;

while @i * @i <= @check_prime
begin
    if @check_prime % @i = 0
    begin
        set @is_prime = 0;
        break;
    end
    set @i = @i + 1;
end

if @check_prime < 2
    print 'this number is not prime'
else if @is_prime = 1
    print 'this number is prime'
else
    print 'this number is not prime';


--6
create table device (
    device_id int,
    locations varchar(25)
);
truncate table device;
insert into device values
(12,'bangalore'), (12,'bangalore'), (12,'bangalore'), (12,'bangalore'),
(12,'hosur'), (12,'hosur'),
(13,'hyderabad'), (13,'hyderabad'), (13,'secunderabad'),
(13,'secunderabad'), (13,'secunderabad');

with location_counts as (
    select device_id, locations, count(*) as signal_count
    from device
    group by device_id, locations
),
max_location as (
    select *,
           row_number() over(partition by device_id order by signal_count desc) as rank
    from location_counts
)
select 
    d.device_id,
    count(distinct d.locations) as no_of_location,
    max(case when m.rank = 1 then m.locations end) as max_signal_location,
    count(*) as no_of_signals
from device d
join max_location m on d.device_id = m.device_id and d.locations = m.locations
group by d.device_id;


--7
truncate table employeee;
insert into Employeee(empid, empname, salary, deptid) values
(1001,'mark',60000,2), (1002,'antony',40000,2), (1003,'andrew',15000,1),
(1004,'peter',35000,1), (1005,'john',55000,1), (1006,'albert',25000,3), (1007,'donald',35000,3);

select empid, empname, salary
from employee e
where salary > (
    select avg(salary) from employee where deptid = e.deptid
);


--8
create table winning_numbers (number int);
insert into winning_numbers values (25), (45), (78);

create table tickets (ticket_id varchar(10), number int);
insert into tickets values
('a23423', 25), ('a23423', 45), ('a23423', 78),
('b35643', 25), ('b35643', 45), ('b35643', 98),
('c98787', 67), ('c98787', 86), ('c98787', 91);

with matches as (
    select t.ticket_id, count(distinct t.number) as total_matched
    from tickets t
    join winning_numbers w on t.number = w.number
    group by t.ticket_id
)
select sum(
    case 
        when total_matched = 3 then 100
        when total_matched between 1 and 2 then 10
        else 0
    end
) as total_winnings
from matches;


--9
truncate table spending;
insert into spending values
(1,'2019-07-01','mobile',100),
(1,'2019-07-01','desktop',100),
(2,'2019-07-01','mobile',100),
(2,'2019-07-02','mobile',100),
(3,'2019-07-01','desktop',100),
(3,'2019-07-02','desktop',100);

with platforms as (
    select user_id, spend_date,
        max(case when platform = 'mobile' then 1 else 0 end) as used_mobile,
        max(case when platform = 'desktop' then 1 else 0 end) as used_desktop,
        sum(case when platform = 'mobile' then amount else 0 end) as mobile_amt,
        sum(case when platform = 'desktop' then amount else 0 end) as desktop_amt
    from spending
    group by user_id, spend_date
),
classified as (
    select spend_date,
        case 
            when used_mobile = 1 and used_desktop = 1 then 'both'
            when used_mobile = 1 then 'mobile'
            when used_desktop = 1 then 'desktop'
        end as platform,
        mobile_amt + desktop_amt as total_amount,
        user_id
    from platforms
)
select 
    row_number() over(order by spend_date, platform) as row,
    spend_date,
    platform,
    sum(total_amount) as total_amount,
    count(distinct user_id) as total_users
from classified
group by spend_date, platform;


--10
drop table if exists grouped;
create table grouped (
    product varchar(100) primary key,
    quantity integer not null
);
insert into grouped (product, quantity) values
('pencil', 3), ('eraser', 4), ('notebook', 2);

with numbers as (
    select top 1000 row_number() over(order by (select null)) as n
    from sys.all_objects
)
select g.product, 1 as quantity
from grouped g
join numbers n on n.n <= g.quantity;
