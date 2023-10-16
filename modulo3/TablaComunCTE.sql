-- use AdventureWorks2019
with Sales_CTE (SalesPersonID,SalesOrderID,SalesYear)
as(
	select 
		SalesPersonID, 
		SalesOrderID, 
		year(OrderDate) as SalesYear
	from sales.SalesOrderHeader 
	where SalesOrderID=43659
)
select * from Sales_CTE