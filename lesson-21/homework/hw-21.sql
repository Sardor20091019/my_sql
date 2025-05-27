-- 1
select *, row_number() over (order by saledate) as row_num
from productsales;

-- 2
select productname, sum(quantity) as total_qty,
       dense_rank() over (order by sum(quantity) desc) as rank
from productsales
group by productname;

-- 3
select *
from (
    select *, rank() over (partition by customerid order by saleamount desc) as rnk
    from productsales
) t
where rnk = 1;

-- 4
select saleid, saleamount,
       lead(saleamount) over (order by saledate) as next_saleamount
from productsales;

-- 5
select saleid, saleamount,
       lag(saleamount) over (order by saledate) as prev_saleamount
from productsales;

-- 6
select saleid, saleamount,
       lag(saleamount) over (order by saledate) as prev_saleamount
from productsales
where saleamount > lag(saleamount) over (order by saledate);

-- 7
select saleid, productname, saleamount,
       saleamount - lag(saleamount) over (partition by productname order by saledate) as diff_from_prev
from productsales;

-- 8
select saleid, saleamount,
       case when lead(saleamount) over (order by saledate) is null then null
            else (lead(saleamount) over (order by saledate) - saleamount) * 100.0 / saleamount
       end as percent_change_next
from productsales;

-- 9
select saleid, productname, saleamount,
       case when lag(saleamount) over (partition by productname order by saledate) = 0 then null
            else cast(saleamount as float) / lag(saleamount) over (partition by productname order by saledate)
       end as ratio_to_prev
from productsales;

-- 10
select saleid, productname, saleamount,
       saleamount - first_value(saleamount) over (partition by productname order by saledate) as diff_from_first
from productsales;

-- 11
select saleid, productname, saleamount,
       case when lag(saleamount) over (partition by productname order by saledate) is null then 1
            when saleamount > lag(saleamount) over (partition by productname order by saledate) then 1
            else 0
       end as increasing_flag
from productsales
where productname = productname
order by productname, saledate;

-- 12
select saleid, saleamount,
       sum(saleamount) over (order by saledate rows unbounded preceding) as running_total
from productsales;

-- 13
select saleid, saleamount,
       avg(saleamount) over (order by saledate rows between 2 preceding and current row) as moving_avg_3
from productsales;

-- 14
select saleid, saleamount,
       saleamount - avg(saleamount) over () as diff_from_avg
from productsales;
