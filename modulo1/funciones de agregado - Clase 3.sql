use Northwind;

-- SWITCH

select
	p.ProductID as Codigo,
	p.ProductName as Nombre,
	UnitPrice as Precio,
	UnitsInStock as Stock,
	Estado = case p.Discontinued
		when 0 then 'ACTIVO'
		when 1 then 'INACTIVO'
		else 'SIN CLASIFICAR'
		end
from Products as p

-- equivalente a usar el if inmediato y el if como bloque

-- if inmediato
select
	p.ProductID as Codigo,
	p.ProductName as Nombre,
	UnitPrice as Precio,
	UnitsInStock as Stock,
	iif(p.Discontinued = 0, 'ACTIVO', 'INACTIVO') as Estado
from Products as p

-- case con order by
-- si el cliente es de brasil, ordenamos por ciudad ascendente

select
	c.CompanyName, c.ContactName, c.City, c.Country
from Customers c
order by case when c.Country = 'brazil' then c.City end asc,
	case when c.Country <> 'brazil' then c.City end desc;

-- creando una vista
create view VistaEstadosArt as
select
	p.ProductID as Codigo,
	p.ProductName as Nombre,
	UnitPrice as Precio,
	UnitsInStock as Stock,
	iif(p.Discontinued = 0, 'ACTIVO', 'INACTIVO') as Estado
from Products as p;

-- ver una vista como una tabla
select * from VistaEstadosArt
where Precio > 20;

-- LABORATORIO 3

-- mostrar los diferentes producto vendidos

--	Mostrar todos los productos vendidos y ordenados (UNION ALL)

-- Mostrar los diferentes productos vendidos y ordenados (UNION)

-- obtener el id y una columna denominada sexo cuyo valroes disponibles sean masculino y femenino
use AdventureWorks2019;
select 
	hre.BusinessEntityID as 'ID',
	case when hre.Gender = 'F' then 'Femenino'
	else 'Masculino'
	end as 'Sexo'
from HumanResources.Employee as hre;

-- mostrar el id de los empleados, si tiene salario debera mostrarse descendente de lo contrario asc

select
	hre.BusinessEntityID as 'ID',
	hre.SalariedFlag as 'Salario'
from HumanResources.Employee as hre
order by case when hre.SalariedFlag = 0 then hre.BusinessEntityID end,
	case when hre.SalariedFlag = 1 then hre.BusinessEntityID end desc

-- Funciones de Agregado
-- tienen un nombre para invocarlas, argumentos que va dentro del nombre y retornan un valor

-- count, retorna cantidad de filas donde el argumento NO es nulo
-- sintaxis: SELECT COUNT (CAMPO) FROM TABLA
-- ejemplo: retornar cantidad de clientes 
use Northwind;
select distinct count(
	c.CustomerID) as 'Cuenta de clientes'
from Customers as c;

-- sum

select 
COUNT(*) as CantModelos,
sum(UnitsInStock) as 'Suma stock cat 2'
from Products as p
where p.CategoryID =2;

-- min y max y avg

select 
min(p.unitPrice) as 'Precio Menor',
max(p.unitPrice) as 'Precio Mayor',
avg(p.UnitPrice) as 'Valor promedio'
from Products as p;

-- si fuera para el proveedor 4

select 
min(p.unitPrice) as 'Precio Menor',
max(p.unitPrice) as 'Precio Mayor',
avg(p.UnitPrice) as 'Valor promedio'
from Products as p
where p.SupplierID=4;

-- mostrar lo siguietnte
-- idproveedor --cant modelos -- precio menor, precio mayor, promedio

select 
	p.SupplierID as 'Proveedor',
	COUNT(*) as CantModelos,
	min(p.unitPrice) as 'Precio Menor',
	max(p.unitPrice) as 'Precio Mayor',
	avg(p.UnitPrice) as 'Valor promedio'
from Products as p
group by p.SupplierID

-- agrupar por mas de 1 campo
-- cantidad de pedidos por año

select
	count(*) as TotalPedidos,
	year(o.OrderDate) Año,
	month(o.OrderDate) Mes
from Orders as o
group by year(o.OrderDate), MONTH(o.OrderDate)
order by year(o.OrderDate)

-- cantidad de clientes por pais y ordeno por cantidad de clientes
-- pais -- cant clientes

select
	c.Country as Pais,
	c.City as Ciudad,
	Count(*) as Cantidad
from Customers as c
group by c.Country, c.City
order by Cantidad desc

-- quiero lanzar un producto en los paises q tengo mas de 10 clientes
-- para filtrar por funciones de agregado, usar la clausula HAVING que "es a las funciones de agregado lo que es where a los campos de la tabla"

select
	c.Country as Pais,
	Count(*) as Cantidad
from Customers as c
group by c.Country
having Count(*) > 10
order by Cantidad desc