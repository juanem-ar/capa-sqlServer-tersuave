-- crear una lista de precios con la siguiente información
-- codigo-proveedor(nombre) - categoria(nombre) - precio - dto 15% precio mayorista - aumento 20%

-- use Northwind
/*
create view VistaPrecios
as
select
	p.ProductID codigo,
	s.CompanyName proveedor,
	c.CategoryID categoria,
	p.UnitPrice precioPublico,
	p.UnitPrice * 0.85 preciodMayorista,
	p.UnitPrice * 1.2 precioConAumento
from Products as p -- las tablas usadas aca se llaman tablas base
join Suppliers as s on s.SupplierID = p.SupplierID
join Categories as c on c.CategoryID = p.CategoryID

update Products
set UnitPrice=18.50
where ProductID=1

--actualizar un registro a travez de una vista
update VistaPrecios
set precioPublico=18.50
where codigo=1
*/

/*
select * from VistaPrecios

-- obtener codigo de la vista
sp_helptext VistaPrecios;

-- ahora modifico la vista para encriptarla
alter view VistaPrecios
with encryption
as
select
	p.ProductID codigo,
	s.CompanyName proveedor,
	c.CategoryID categoria,
	p.UnitPrice precioPublico,
	p.UnitPrice * 0.85 preciodMayorista,
	p.UnitPrice * 1.2 precioConAumento
from Products as p -- las tablas usadas aca se llaman tablas base
join Suppliers as s on s.SupplierID = p.SupplierID
join Categories as c on c.CategoryID = p.CategoryID

create view PedidosAlfki
as
select
*
from Orders as o
where CustomerID = 'Alfki'

--crear una vista con los importes totales de los pedidos del cliente alfki
--nombre, pedidosalfi

create view PedidosAlfki2
as
select
	o.OrderID as IdPedido,
	SUM(od.quantity*od.UnitPrice) as TotalPedido
from Orders as o
join [dbo].[Order Details] as od on o.OrderID = od.OrderID
where CustomerID = 'Alfki'
group by o.OrderID

select * from PedidosAlfki2

-- totales de fletes por empleados de los pedidos de alfki
select 
	p.EmployeeID,
	SUM(Freight) TotalFlete
from PedidosAlfki as p
group by p.EmployeeID

-- dar permisos sobre las vistas
GRANT SELECT ON VistaNombre
TO user_name/rol

GRANT SELECT ON PedidosAlfki
TO 'Vendedores'

-- Practica de clase
-- Crear una vista con los clientes de brasil, lo pagado en flete

create view FletesBrazil2
as
select
	c.CompanyName Cliente,
	sum(o.Freight) as Flete
from Orders o
join Customers c on c.CustomerID = o.CustomerID
where c.Country = 'Brazil'
group by c.CompanyName

select * from FletesBrazil2
*/
