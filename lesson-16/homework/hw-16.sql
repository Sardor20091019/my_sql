
with numbers as (
    select 1 as n
    union all
    select n + 1 from numbers where n < 1000
)
select * from numbers
option (maxrecursion 1000);


select e.employeeid, e.firstname, e.lastname, s.totalsales
from employees e
join (
    select employeeid, sum(salesamount) as totalsales
    from sales
    group by employeeid
) s on e.employeeid = s.employeeid;


with avgsalary as (
    select avg(salary) as avg_sal from employees
)
select * from avgsalary;


select p.productname, x.productid, x.max_sale
from (
    select productid, max(salesamount) as max_sale
    from sales
    group by productid
) x
join products p on p.productid = x.productid;


with doubles as (
    select 1 as val
    union all
    select val * 2 from doubles where val * 2 < 1000000
)
select * from doubles
option (maxrecursion 100);


with salecount as (
    select employeeid, count(*) as total_sales
    from sales
    group by employeeid
)
select e.firstname, e.lastname, s.total_sales
from salecount s
join employees e on e.employeeid = s.employeeid
where s.total_sales > 5;


with bigsales as (
    select productid, salesamount
    from sales
    where salesamount > 500
)
select distinct p.productname
from bigsales bs
join products p on p.productid = bs.productid;


with avg_salary as (
    select avg(salary) as avg_sal from employees
)
select e.firstname, e.lastname, e.salary
from employees e
cross join avg_salary a
where e.salary > a.avg_sal;


select top 5 e.employeeid, e.firstname, e.lastname, s.total_orders
from (
    select employeeid, count(*) as total_orders
    from sales
    group by employeeid
) s
join employees e on e.employeeid = s.employeeid
order by s.total_orders desc;


select pr.categoryid, sum(s.salesamount) as total_sales
from sales s
join products pr on s.productid = pr.productid
group by pr.categoryid;


with factorial as (
    select number, cast(1 as bigint) as result, number as n
    from numbers1
    union all
    select f.number, result * n, n - 1
    from factorial f
    where n > 1
)
select number, max(result) as factorial
from factorial
group by number;


with recursive_chars as (
    select id, string, 1 as pos, substring(string, 1, 1) as ch
    from example
    where len(string) > 0
    union all
    select id, string, pos + 1, substring(string, pos + 1, 1)
    from recursive_chars
    where pos + 1 <= len(string)
)
select * from recursive_chars
order by id, pos
option (maxrecursion 100);


with monthly_sales as (
    select
        format(saledate, 'yyyy-MM') as month,
        sum(salesamount) as total_sales
    from sales
    group by format(saledate, 'yyyy-MM')
),
diffs as (
    select
        month,
        total_sales,
        lag(total_sales) over (order by month) as prev_month_sales
    from monthly_sales
)
select *, total_sales - prev_month_sales as difference
from diffs;


select x.employeeid, e.firstname, e.lastname, x.quarter, x.total_sales
from (
    select
        employeeid,
        datepart(quarter, saledate) as quarter,
        sum(salesamount) as total_sales
    from sales
    group by employeeid, datepart(quarter, saledate)
) x
join employees e on e.employeeid = x.employeeid
where x.total_sales > 45000;


with fib (n, a, b) as (
    select 1, 0, 1
    union all
    select n + 1, b, a + b from fib where n < 20
)
select n, a as fibonacci_number from fib
option (maxrecursion 100);


select *
from findsamecharacters
where vals is not null
and len(vals) > 1
and vals not like '%[^' + substring(vals, 1, 1) + ']%';


with seq as (
    select 1 as level, cast('1' as varchar(100)) as num
    union all
    select level + 1, num + cast(level + 1 as varchar)
    from seq
    where level < 5
)
select * from seq;


select top 5 e.employeeid, e.firstname, e.lastname, sum(s.salesamount) as total_sales
from sales s
join employees e on e.employeeid = s.employeeid
where saledate >= dateadd(month, -6, getdate())
group by e.employeeid, e.firstname, e.lastname
order by total_sales desc;


with cleaned as (
    select
        pawanname,
        pawan_slug_name,
        trim(value) as token
    from removeduplicateintsfromnames
    cross apply string_split(pawan_slug_name, '-') 
),
filtered as (
    select pawanname, token
    from cleaned
    where isnumeric(token) = 1 and len(token) > 1
),
deduped as (
    select pawanname, string_agg(distinct token, '-') as cleaned_str
    from filtered
    group by pawanname
)
select r.pawanname, coalesce(d.cleaned_str, '') as cleaned_slug
from removeduplicateintsfromnames r
left join deduped d on r.pawanname = d.pawanname;
