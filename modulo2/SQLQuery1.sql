-- use AdventureWorks2019
-- UNION (omite duplicados) 
/*
select [BusinessEntityID]
from [HumanResources].[Employee] --290 filas a empleado
UNION
select [BusinessEntityID]
from [Purchasing].[Vendor] -- 104 a vendedores

-- obtener un conjunto de registros que incluya tanto a los empleados como a los vendedores sin omitir duplicados
-- UNION ALL

select [BusinessEntityID] --19972 
from [Person].[Person]
UNION ALL
select [BusinessEntityID] -- 290
from [HumanResources].[Employee] 

-- SELECT DISTINCT
select FirstName, LastName -- 19972
from Person.Person
union
select FirstName, LastName -- 19972
from Person.Person

select 
	BusinessEntityID
from sales.SalesPerson
union -- me evita los duplicados
select
	BusinessEntityID
from HumanResources.Employee

select 
	BusinessEntityID
from sales.SalesPerson
union all -- NO evita los duplicados
select
	BusinessEntityID
from HumanResources.Employee


SELECT ProductLine,
Category = CASE ProductLine
 WHEN 'R' THEN 'Road'
 WHEN 'M' THEN 'Mountain'
 WHEN 'T' THEN 'Touring'
 ELSE 'Not for sale'
END
FROM Production.Product;

SELECT LastName, CountryRegionName
FROM Sales.vSalesPerson
WHERE TerritoryName IS NOT NULL
ORDER BY CASE WHEN CountryRegionName='United States'
 THEN LastName END DESC,
 CASE WHEN CountryRegionName<>'United States' THEN
LastName END ASC;

-- INNER JOIN

-- use Northwind

-- mostrar apellido, nombre del vendedor(empleado), nombre del cliente y el contacto
-- de los pedidos del año 1996
-- orders, employee, customers
select
*
from Employees as e
inner join Orders as o on o.EmployeeID = e.EmployeeID
inner join Customers as c on c.CustomerID = o.CustomerID
where year(o.OrderDate) = 1996

-- mostrar toda la info de productos, ocn los nombres de las categorias y los nombres de los proveedores

select
*
from Products as p
inner join Categories as c on p.CategoryID = c.CategoryID
inner join Suppliers as s on p.SupplierID = s.SupplierID


-- OUTER JOINS -  LEFT / RIGTH

-- mostrar toda la info de productos, ocn los nombres de las categorias y los nombres de los proveedores

select
*
from Products as p
left join Categories as c on p.CategoryID = c.CategoryID
inner join Suppliers as s on p.SupplierID = s.SupplierID

-- mostrar los pedidos y los clientes aunque haya clientes que no hicieron pedidos
select
 o.OrderID,
 o.EmployeeID,
 o.CustomerID,
 c.ContactName
from Customers as c
left join Orders as o on o.CustomerID = c.CustomerID
where o.OrderId is null

-- SELF JOIN: Relacion sobre la misma tabla. Por ejemplo en una tabla donde hay idEmpleado y idJefe

select
e.LastName + ',' + e.FirstName as Empleado,
	iif(j.LastName is null,'SIN JEFE',j.LastName + ',' + j.FirstName) as Jefe 
from Employees as e
left join Employees as j on j.EmployeeID = e.ReportsTo 
order by Jefe

-- CROSS JOIN: producto cartesiano

-- Resultado: multiplicación de cada registro de la tabla de la izquierda * cada registro de la tabla derecha

select
	o.OrderID,
	o.OrderDate,
	c.ContactName
from Orders as o
cross join Customers as c

-- Ejemplo de uso de CROSS JOIN

insert into Equipos(Nombre) values ('River');
insert into Equipos(Nombre) values ('Boca');
insert into Equipos(Nombre) values ('Instituto');

select
	l.Nombre as Local,
	'VS' as Versus,
	v.Nombre as Visitante
from Equipos as l
cross join Equipos as v
where l.Nombre <> v.Nombre

-- Ejercicios 

-- mostrar los 20 productos mas caros

select distinct top 15 with ties -- trae los q coinciden con el corte del 15
*
from Products as p
order by p.UnitPrice desc

-- determinar cuantos pedidos tuvo el vendedor 'Suyama' en el año 1996

select
count(*) as cantidadPedidos
from Orders as o
inner join Employees as e on o.EmployeeID = e.EmployeeID
where year(o.OrderDate) = 1996
and e.LastName = 'Suyama'

-- Mostrar un ranking de los primeros 10 productos ( los nombres y cantidad de unidades) mas pedidos en 1997, ordenados desc x cantidad de unidades pedidas

select top 10
	p.ProductName,
	sum(od.Quantity) as Total
from Products as p
inner join [Order Details] as od on p.ProductID=od.ProductID
inner join Orders as o on od.OrderID = o.OrderID
where year(o.OrderDate) = 1997
group by p.ProductName
order by Total desc

-- Mostrar los productos (id + nombre) del proveedor 'Tokyo Traders' que hayan sido enviados por la cia 'FederalShipping'
select
	p.ProductID,
	p.ProductName
from Products as p
inner join [Order Details] as od on p.ProductID=od.ProductID
inner join Orders as o on od.OrderID = o.OrderID
inner join Suppliers as su on p.SupplierID = su.SupplierID
inner join Shippers as sh on o.ShipVia = sh.ShipperID
where su.CompanyName like 'Tokyo Traders'
and
sh.CompanyName = 'Federal Shipping'
order by ProductID desc

-- Laboratorio (AdventureWorks)
use AdventureWorks2019

1. Mostrar los diferentes productos vendidos.
Tablas: Sales.SalesOrderDetail
Campos: ProductID

select distinct * from Sales.SalesOrderDetail

1. Mostrar todos los productos vendidos y ordenados
Tablas: Sales.SalesOrderDetail, Production.WorkOrder
Campos: ProductID

select ProductID from Sales.SalesOrderDetail order by ProductID desc

2. Mostrar los diferentes productos vendidos y ordenados
Tablas: Sales.SalesOrderDetail, Production.WorkOrder
Campos: ProductID

select distinct ProductID from Sales.SalesOrderDetail order by ProductID desc

1. Obtener el id y una columna denominada sexo cuyo valores
disponibles sean “Masculino” y ”Femenino”.
Tablas: HumanResources.Employee
Campos: BusinessEntityID, Gender

select 
	hre.BusinessEntityID as id,
	Sexo = CASE Gender
		WHEN 'M' THEN 'Masculino'
		ELSE 'Femenino'
	END
from HumanResources.Employee as hre

2. Mostrar el id de los empleados, si tiene salario deberá
mostrarse descendente de lo contrario ascendente.
Tablas: HumanResources.Employee
Campos: BusinessEntityID, SalariedFlag

select
	*
from HumanResources.Employee as hre
order by case when SalariedFlag = '1'
then hre.BusinessEntityID end desc

-- LABORATORIO

1. Mostrar la fecha más reciente de venta.
Tablas: Sales.SalesOrderHeader
Campos: OrderDate

select max(OrderDate) as FechaReciente from Sales.SalesOrderHeader

2. Mostrar el precio más barato de todas
las bicicletas.
Tablas: Production.Product
Campos: ListPrice, Name

select min(pp.ListPrice) as PrecioMin from Production.Product as pp
where Name like '%bike%'

3. Mostrar la fecha de nacimiento del
empleado más joven.
Tablas: HumanResources.Employee
Campos: BirthDate

4. Mostrar el promedio del listado de
precios de productos.
Tablas: Production.Product
Campos: ListPrice

select max(hre.BirthDate) as FechaNcEmpleadoJoven from HumanResources.Employee as hre

5. Mostrar la cantidad de ventas y el
total vendido.
Tablas: Sales.SalesOrderDetail
Campos: LineTotal

select 
SalesOrderID,
count(SalesOrderDetailID) as CantidadDeVentas,
sum(UnitPrice) as TotalVendido
from Sales.SalesOrderDetail
group by SalesOrderID
order by TotalVendido desc

-- ROLL UP

SELECT ProductID, MAX(LineTotal) as Maximo
FROM Sales.SalesOrderDetail
WHERE ProductID > 995
group by ProductID WITH ROLLUP
HAVING MAX(LineTotal) > 3000;

-- ALL

SELECT ProductID, MAX(LineTotal) as Maximo
FROM Sales.SalesOrderDetail
WHERE ProductID <> 707
GROUP BY ALL ProductID;

-- Laboratorio Agrupación Group By

1. Mostrar el código de subcategoría y el
precio del producto más barato de cada
una de ellas.
Tablas: Production.Product
Campos: ProductSubcategoryID, ListPrice

select 
ProductSubcategoryID,
min(ListPrice) PrecioMasBarato
from Production.Product pp
group by ProductSubcategoryID

2. Mostrar los productos y la cantidad total
vendida de cada uno de ellos.
Tablas: Sales.SalesOrderDetail
Campos: ProductID, OrderQty

select 
ProductID,
sum(OrderQty) cantidadVendida
from Sales.SalesOrderDetail
group by ProductID
order by cantidadVendida desc

3. Mostrar los productos y el total vendido de
cada uno de ellos, ordenados por el total
vendido.
Tablas: Sales.SalesOrderDetail
Campos: ProductID, LineTotal

select 
ProductID,
sum(LineTotal) TotalVendido
from Sales.SalesOrderDetail
group by ProductID
order by TotalVendido desc

4. Mostrar el promedio vendido por factura.
Tablas: Sales.SalesOrderDetail
Campos: SalesOrderID, LineTotal

select 
SalesOrderID,
avg(LineTotal) PromedioVendido
from Sales.SalesOrderDetail
group by SalesOrderID
order by PromedioVendido desc

-- Laboratorio having

1. Mostrar todas las facturas realizadas y
el total facturado de cada una de ellas
ordenado por número de factura pero sólo
de aquellas órdenes superen un total de
$10.000.
Tablas: Sales.SalesOrderDetail
Campos: SalesOrderID, LineTotal

select 
SalesOrderID,
sum(LineTotal) TotalVendido
from Sales.SalesOrderDetail
group by SalesOrderID
having sum(LineTotal) > 10000
order by TotalVendido asc

2. Mostrar la cantidad de facturas que
vendieron más de 20 unidades.
Tablas: Sales.SalesOrderDetail
Campos: SalesOrderID, OrderQty

select 
SalesOrderID,
sum(OrderQty) QVendido
from Sales.SalesOrderDetail
group by SalesOrderID
having sum(OrderQty) > 20
order by QVendido desc

3. Mostrar las subcategorías de los productos
que tienen dos o más productos que cuestan
menos de $150.
Tablas: Production.Product
Campos: ProductSubcategoryID, ListPrice

select 
ProductSubcategoryID,
count(ProductSubcategoryID) as cantidadDeProductos
from Production.Product
where ListPrice < 150
group by ProductSubcategoryID
having count(ProductSubcategoryID) > 2

4. Mostrar todos los códigos de subcategorías
existentes junto con la cantidad para los
productos cuyo precio de lista sea mayor a $
70 y el precio promedio sea mayor a $ 300.
Tablas: Production.Product
Campos: ProductSubcategoryID, ListPrice

select 
pp.ProductSubcategoryID subcategoria,
count(pp.ProductSubcategoryID) cantidad,
avg(pp.ListPrice) promedio
from Production.Product pp
where pp.ListPrice > 70
group by ProductSubcategoryID
having avg(pp.ListPrice) > 300
order by promedio desc

-- Laboratorio Roll up
1. Mostrar el número de factura, el monto vendido, y al final,
totalizar la facturación.
Tablas: Sales.SalesOrderDetail
Campos: SalesOrderID, UnitPrice, OrderQty

select 
sso.SalesOrderID numeroFactura,
sum(sso.UnitPrice*OrderQty) montoVendido
from Sales.SalesOrderDetail sso
group by sso.SalesOrderID with rollup
order by montoVendido desc

-- DESAFÍOS

1. Informe todos los cargos (de los empleados) existentes,
ordenados alfabéticamente

select distinct 
JobTitle 
from [HumanResources].[Employee] order by JobTitle

2. Genere una lista completa y única de los códigos de moneda
(contemple [Sales].[Currency] y [Sales].[CountryRegionCurrency])

select CurrencyCode from [Sales].[Currency]
UNION
select CurrencyCode from [Sales].[CountryRegionCurrency]

3. Totalizar las ventas a la fecha (YTD) de US, por región

select 
Name,
sum(SalesYTD) Total
from sales.SalesTerritory
where CountryRegionCode = 'US'
group by Name

4. Recupere los productos sin órdenes

select ProductID
 from Production.Product
except
select ProductID
 from Production.WorkOrder
 
3. A las vtas. a la fecha de Estados Unidos (por región) del punto 1,
agréguele el total gral.

select Name, SUM(SalesYTD) TotSalesYTD
 from Sales.SalesTerritory
 where CountryRegionCode = 'US'
 group by Name with rollup

 -- EXAMEN
*/
