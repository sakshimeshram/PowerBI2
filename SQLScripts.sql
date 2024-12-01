Add column profitmargin 
-----------------------------------------------------------------------------------------------------

alter table sales add column profitmargin double precision;

update sales
set profitmargin= (Profit / 
SalesAmount) * 100;

Add column agegroup 
-----------------------------------------------------------------------------------------------------

alter table customer add column agegroup varchar;
update customer
set agegroup=(
case when age between 18 and 25 then 'Youth'
     when age between 26 and 40 then 'Young Adult'
	 when age between 41 and 60 then 'Adult'
	 else 'Senior' end
);

-----------------------------------------------------------------------------------------------------
First Query:

select s.customerid,s.productid, sum(s.salesamount)Totalsales,
sum(s.profit)TotalProfit,round(avg(s.profitmargin))AvgProfitMargin,s.region,p.category,p.subcategory
to_char( s.orderdate,'Month')monthname
from sales s inner join products p
on s.productid=p.productid
group by s.region,p.category,p.subcategory, s.customerid,s.productid,monthname;

-----------------------------------------------------------------------------------------------------
Second Query:

select s.customerid,sum(s.salesamount) as TotalSales
from sales s
group by s.customerid
order by TotalSales desc
limit 10;

-----------------------------------------------------------------------------------------------------
Third Query:

select p.productid,p.productname,p.category,p.subcategory,max(s.profitmargin) as Profitmargin from products p
inner join sales s
on p.productid=s.productid
group by p.productid,p.productname,p.category,p.subcategory
order by Profitmargin desc limit 10;
