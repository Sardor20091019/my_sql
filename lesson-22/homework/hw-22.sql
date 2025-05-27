\-- 1
select customer\_id, order\_date, sum(total\_amount) over (partition by customer\_id order by order\_date rows between unbounded preceding and current row) as running\_total\_sales from sales\_data;

\-- 2
select product\_category, count(\*) as number\_of\_orders from sales\_data group by product\_category;

\-- 3
select product\_category, max(total\_amount) as max\_total\_amount from sales\_data group by product\_category;

\-- 4
select product\_category, min(unit\_price) as min\_price from sales\_data group by product\_category;

\-- 5
select order\_date, avg(total\_amount) over (order by order\_date rows between 1 preceding and 1 following) as moving\_avg\_3\_days from sales\_data group by order\_date order by order\_date;

\-- 6
select region, sum(total\_amount) as total\_sales from sales\_data group by region;

\-- 7
select customer\_id, sum(total\_amount) as total\_purchase\_amount, rank() over (order by sum(total\_amount) desc) as rank from sales\_data group by customer\_id order by rank;

\-- 8
select sale\_id, customer\_id, total\_amount, total\_amount - lag(total\_amount) over (partition by customer\_id order by order\_date) as difference\_from\_previous\_sale from sales\_data;

\-- 9
select product\_category, product\_name, unit\_price, rank() over (partition by product\_category order by unit\_price desc) as rank from sales\_data where rank <= 3;

\-- 10
select region, order\_date, sum(total\_amount) over (partition by region order by order\_date rows between unbounded preceding and current row) as cumulative\_sum from sales\_data order by region, order\_date;

\-- medium

\-- 11
select product\_category, order\_date, sum(total\_amount) over (partition by product\_category order by order\_date rows between unbounded preceding and current row) as cumulative\_revenue from sales\_data order by product\_category, order\_date;

\-- 12
select id, sum(id) over (order by id rows between unbounded preceding and current row) as sumprevalues from (select 1 as id union all select 2 union all select 3 union all select 4 union all select 5) as t;

\-- 13
select value, sum(value) over (order by value rows between unbounded preceding and current row) as sum\_of\_previous from onecolumn order by value;

\-- 14
select id, vals, case when row\_number() over (partition by id order by vals) = 1 then 1 else 1 + row\_number() over (partition by id order by vals) end as rownumber from row\_nums order by id, vals;

\-- 15
select customer\_id from sales\_data group by customer\_id having count(distinct product\_category) > 1;

\-- 16
select customer\_id from (select customer\_id, region, sum(total\_amount) as total\_spending from sales\_data group by customer\_id, region) as t1 join (select region, avg(total\_amount) as avg\_spending from sales\_data group by region) as t2 on t1.region = t2.region where t1.total\_spending > t2.avg\_spending;

\-- 17
select customer\_id, region, total\_spending, rank() over (partition by region order by total\_spending desc) as rank from (select customer\_id, region, sum(total\_amount) as total\_spending from sales\_data group by customer\_id, region) as t;

\-- 18
select customer\_id, order\_date, sum(total\_amount) over (partition by customer\_id order by order\_date rows between unbounded preceding and current row) as cumulative\_sales from sales\_data order by customer\_id, order\_date;

\-- 19
select to\_char(order\_date, 'yyyy-mm') as month, sum(total\_amount) as monthly\_sales, (sum(total\_amount) - lag(sum(total\_amount)) over (order by to\_char(order\_date, 'yyyy-mm'))) / lag(sum(total\_amount)) over (order by to\_char(order\_date, 'yyyy-mm')) \* 100 as growth\_rate from sales\_data group by to\_char(order\_date, 'yyyy-mm') order by month;

\-- 20
select s1.customer\_id, s1.total\_amount from sales\_data s1 join (select customer\_id, lag(total\_amount) over (partition by customer\_id order by order\_date) as last\_amount from sales\_data) s2 on s1.customer\_id = s2.customer\_id where s1.total\_amount > s2.last\_amount;

\-- hard

\-- 21
select \* from sales\_data where unit\_price > (select avg(unit\_price) from sales\_data);

\-- 22
select id, grp, val1, val2, case when row\_number() over (partition by grp order by id) = 1 then sum(val1 + val2) over (partition by grp) else null end as tot from mydata order by id;

\-- 23
select id, sum(cost) as cost, sum(quantity) as quantity from thesumpuzzle group by id;

\-- 24
with numbered as (select seatnumber, row\_number() over (order by seatnumber) as rn from seats), gaps as (select rn, seatnumber, lead(rn) over (order by rn) as next\_rn, lead(seatnumber) over (order by rn) as next\_seat from numbered) select coalesce(next\_seat - (next\_rn - rn),1) as gap\_start, (seatnumber - 1) as gap\_end from gaps where next\_seat is not null and next\_seat - seatnumber > 1;

\-- 25
select id, vals, case when row\_number() over (partition by id order by vals) = 1 then 2 else 2 + row\_number() over (partition by id order by vals) end as changed from row\_nums order by id, vals;
