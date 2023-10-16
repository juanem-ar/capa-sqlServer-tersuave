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


/*
-- Laboratorio

-- use AdventureWorks2019

5. Crear una CTE con las órdenes de
venta
Tablas: Sales.SalesOrderHeader
Campos: SalesPersonID, SalesOrderID,
OrderDate

with Sales_CTE (SalesPersonID,SalesOrderID,OrderDate)
as(
	select 
		SalesPersonID, 
		SalesOrderID, 
		OrderDate
	from sales.SalesOrderHeader
)
select * from Sales_CTE
*/