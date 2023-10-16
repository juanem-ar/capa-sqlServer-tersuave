-- use Northwind
/*
-- SUBCONSULTAS
-- Mostrar los art�culos cuyo precio sea mayor al promedio

select 
	p.ProductName,
	p.ProductID id,
	p.UnitPrice precio
from [dbo].[Products] as p
where UnitPrice > 28.86	

-- calcula el promedio 
select avg(unitPrice) from [dbo].[Products] -- 28.86

-- con subconsulta
select 
	p.ProductName,
	p.ProductID id,
	p.UnitPrice precio
from [dbo].[Products] as p
where UnitPrice > (select avg(unitPrice) from [dbo].[Products])

select 
	p.ProductName,
	p.ProductID id,
	p.UnitPrice precio,
	(select avg(unitPrice) from [dbo].[Products]) as Promedio
from [dbo].[Products] as p
where UnitPrice > (select avg(unitPrice) from [dbo].[Products])


-- mostrar los pedidos de clientes de argentina con subconsulta
-- 1era forma
select
*
from [dbo].[Orders] od
inner join [dbo].[Customers] c on od.CustomerID = c.CustomerID
where c.Country = 'Argentina'

-- 2da forma
select
*
from [dbo].[Orders] od, [dbo].[Customers] c 
where od.CustomerID = c.CustomerID
and c.Country = 'Argentina'

-- 3ra forma con subconsulta
select
*
from [dbo].[Orders] od 
where od.CustomerID in ( select c.CustomerID from [dbo].[Customers] c where c.Country = 'Argentina')

-- subconsultas en el select 

SELECT ProductID, ListPrice,(SELECT AVG(ListPrice) FROM
Production.Product)
FROM Production.Product;

-- subconsultas en el from

SELECT pp.ProductID, pp.ListPrice, x.promedio
FROM Production.Product pp
INNER JOIN (
 SELECT ProductID, avg(LineTotal) promedio
 FROM Sales.SalesOrderDetail
 GROUP BY ProductID
 ) x
ON pp.ProductID=x.ProductID;

-- subconsulta en el where

SELECT ProductID, ListPrice
FROM Production.Product
WHERE ListPrice < ( SELECT AVG(LineTotal) FROM Sales.SalesOrderDetail
);

-- subconsultas subrelacionadas

SELECT p1.ProductSubcategoryID, p1.ProductID,
p1.ListPrice
FROM Production.Product p1
WHERE ListPrice =(
 SELECT MIN (ListPrice)
 FROM Production.Product p2
 WHERE p2.ProductSubcategoryID =
p1.ProductSubcategoryID
 )
ORDER BY p1.ProductSubcategoryID;

-- subconsultas con IN

SELECT FirstName, MiddleName, LastName
FROM Person.Person
WHERE BusinessEntityID IN (
 SELECT BusinessEntityID
 FROM Sales.SalesPerson
 );

 SELECT FirstName, MiddleName, LastName
FROM Person.Person
WHERE BusinessEntityID NOT IN (
 SELECT BusinessEntityID
 FROM Sales.SalesPerson
 );

 -- subconsultas con exists

 SELECT FirstName, LastName
FROM Person.Person p
WHERE EXISTS (
 SELECT BusinessEntityID
 FROM Sales.SalesPerson s
 WHERE p.BusinessEntityID=s.BusinessEntityID
 );

 SELECT FirstName, LastName
FROM Person.Person p
WHERE NOT EXISTS (
SELECT BusinessEntityID
FROM Sales.SalesPerson s
WHERE p.BusinessEntityID=s.BusinessEntityID
 );

 -- subconsultas con some | any

 SELECT Name, ListPrice
FROM Production.Product
WHERE ListPrice > ANY (
 SELECT AVG(ListPrice) Promedio
 FROM Production.Product
 );

 -- subconsultas con all

 SELECT Name, ListPrice
FROM Production.Product
WHERE ListPrice <> ALL (
SELECT AVG(ListPrice) Promedio
 FROM Production.Product
 );

-- LABORATORIO SUBCONSULTAS

-- use AdventureWorks2019

1. Listar todos los productos cuyo precio sea
inferior al precio promedio de todos los
productos.
Tablas: Production.Product
Campos: Name, ListPrice
promedio y diferencia de precios entre
cada producto y el valor promedio general.
Tablas: Production.Product
Campos: Name, ListPrice
m�s caro.
Tablas: Production.Product
Campos: ProductID,ListPrice
subcategor�a. mostrar subcategor�a, c�digo
de producto y el precio de lista m�s barato
ordenado por subcategor�a.
Tablas: Production.Product
Campos: ProductSubcategoryID, ProductID,
ListPrice
presentes en la subcategor�a de ruedas.
Tablas: Production.Product,
Production.ProductSubcategory
Campos: ProductSubcategoryID, Name
vendidos.
Tablas: Production.Product, Sales.SalesOrderDetail
Campos: Name, ProductID
vendedores.
Tablas: Person.Person, Sales.SalesPerson
Campos: BusinessEntityID
y apellido) que no tengan asignado un
territorio de ventas.
Tablas: Person.Person, Sales.SalesPerson
Campos: BusinessEntityID, TerritoryID,
LastName, FirstName
facturado en territorio de estado unidos
�nicamente 'us'.
Tablas: Sales.SalesOrderHeader, Sales.SalesTerritory
Campos: CountryRegionCode, TerritoryID
e Inglaterra.
Tablas: Sales.SalesOrderHeader, Sales.SalesTerritory
Campos: CountryRegionCode, TerritoryID
3. Mostrar los nombres de los diez productos
m�s caros.
Tablas: Production.Product
Campos: ListPrice
cantidad de pedidos de venta sea
igual o superior a 20.
Tablas: Production.Product,
Sales.SalesOrderDetail
Campos: Name, ProductID , OrderQty
	Name producto 
from Production.Product 
where ProductID in (select ProductID 
					from Sales.SalesOrderDetail
					where OrderQty >=20)
order by Name

-- LABORATORIO ALL / ANY

1. Mostrar los nombres de todos los productos de ruedas
que fabrica adventure works cycles
Tablas: Production.Product, Production.ProductSubcategory
Campos: Name, ProductSubcategoryID

select
	pp.Name
from Production.Product pp
where pp.ProductSubcategoryID = any (select p.ProductSubcategoryID 
									from Production.ProductSubcategory p
									where p.Name = 'Wheels')

2. Mostrar los clientes ubicados en un territorio no cubierto
por ning�n vendedor
Tablas: Sales.Customer, Sales.SalesPerson
Campos: TerritoryID

select *
from Sales.Customer
where TerritoryID <> all (select TerritoryID
						  from	 Sales.SalesPerson);

3. Listar los productos cuyos precios de venta sean mayores
o iguales que el precio de venta m�ximo de cualquier
subcategor�a de producto.
Tablas: Production.Product
Campos: Name, ListPrice, ProductSubcategoryID

select 
	p.Name producto
FROM Production.Product p
WHERE p.ListPrice >= any (
						select MAX(ListPrice)
						from Production.Product
						group by ProductSubcategoryID
						)
*/