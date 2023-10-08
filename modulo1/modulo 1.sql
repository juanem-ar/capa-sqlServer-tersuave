-- use AdventureWorks2019;

-- LABORATORIO 2

/*
1. Mostrar el nombre, precio y color de los accesorios para
asientos las bicicletas cuyo precio sea mayor a 100 pesos.
Tablas: Production.Product
Campos: Name, ListPrice, Color


select
	pp.Name Name, pp.ListPrice Precio, Color = case pp.Color when 0 then 'Sin Color' else 'Test' end
from Production.Product pp
where pp.ListPrice > 100
and
pp.Name like '%Seat%'

2. Mostrar el nombre de los productos que tengan cualquier
combinación de ‘mountain bike’.
Tablas: Production.Product
Campos: Name

select
	*
from Production.Product pp
where pp.Name like '%mountain bike%'

3. Mostrar las personas cuyo nombre comience con la
letra “y”.
Tablas: Person.Person
Campos: FirstName

select
	*
from Person.Person perp
where perp.FirstName like 'y%'

4. Mostrar las personas que en la segunda
letra de su apellido tienen una ‘s’.
Tablas: Person.Person
Campos: LastName

select
	*
from Person.Person perp
where perp.LastName like '_s%'

5. Mostrar el nombre concatenado con el
apellido de las personas cuyo apellido
terminen en ‘ez’.
Tablas: Person.Person
Campos: FirstName, LastName

select
	perp.FirstName + ' '+ perp.LastName
from Person.Person perp
where perp.LastName like '%ez'

6. Mostrar los nombres de los productos
que terminen en un número.
Tablas: Production.Product
Campos: Name

select
	pp.Name Nombre
from Production.Product pp
where pp.Name like '%[0-9]'

7. Mostrar las personas cuyo nombre tenga
una ‘C’ o ‘c’ como primer carácter, cualquier
otro como segundo carácter, ni ‘d’ ni ‘e’ ni ‘f’
ni ‘g’ como tercer carácter, cualquiera entre
‘j’ y ‘r’ o entre ‘s’ y ‘w’ como cuarto carácter y
el resto sin restricciones.
Tablas: Person.Person
Campos: FirstName

select
	perp.FirstName Nombre
from Person.Person perp 
where perp.FirstName like '[C-c]_[^defg][j-w]%'

1. Mostrar todos los productos cuyo precio de lista esté entre 200 y 300.
Tablas: Production.Product
Campos: ListPrice

select
	pp.Name, pp.ListPrice
from Production.Product pp
where pp.ListPrice between 200 and 300

2. Mostrar todos los empleados que nacieron entre 1970 y 1985.
Tablas: HumanResources.Employee
Campos: BirthDate

select
	hre.BusinessEntityID ID, hre.BirthDate FechaNac
from HumanResources.Employee hre
where year(hre.BirthDate) between 1970 and 1985 
order by hre.BirthDate desc

3. Mostrar la fecha, número de cuenta y subtotal de las órdenes de venta
efectuadas en los años 2005 y 2006.
Tablas: Sales.SalesOrderHeader
Campos: OrderDate, AccountNumber, SubTotal

select
	ssoh.OrderDate Fecha, ssoh.AccountNumber NumeroCuenta, ssoh.SubTotal
from Sales.SalesOrderHeader ssoh
where year(ssoh.OrderDate) between 2005 and 2006

4. Mostrar todas las órdenes de venta cuyo Subtotal no esté entre 50 y 70
Tablas: Sales.SalesOrderHeader
Campos: OrderDate, AccountNumber, SubTotal

select
	*
from Sales.SalesOrderHeader ssoh
where SubTotal not between 50 and 70

1. Mostrar los códigos de orden de venta, código de producto,
cantidad vendida y precio unitario de los productos 750, 753 y 770.
Tablas: Sales.SalesOrderDetail
Campos: SalesOrderID, OrderQty, ProductID, UnitPrice

select
	ssod.SalesOrderID ID, ssod.ProductID CodigoProducto, ssod.OrderQty CantidadVendida, ssod.UnitPrice PrecioUnitario
from Sales.SalesOrderDetail ssod
where ssod.ProductID in (750, 753, 770)
order by ssod.ProductID desc

2. Mostrar todos los productos cuyo color sea verde, blanco y azul.
Tablas: Production.Product
Campos: Color

select
	*
from Production.Product prp
where prp.Color in ('Green','White','Blue')


-- LABORATORIO 3

1. Mostrar las personas ordenadas, primero por su
apellido y luego por su nombre.
Tablas: Person.Person
Campos: Firstname, Lastname

select
	*
from Person.Person perp
order by perp.LastName desc, perp.FirstName asc

2. Mostrar los cinco productos más caros y su nombre,
ordenados en forma alfabética.
Tablas: Production.Product
Campos: Name, ListPrice

select top 5
	prp.ListPrice Precio, 
	prp.Name Nombre
from Production.Product prp
order by Precio desc

-- DESAFIO 1

1. Recupere los diferentes tipos de contactos que son managers,
ordenados alfabéticamente por nombre de z ? a.

select
*
from Person.ContactType pct
where pct.Name like '%manager%'
order by pct.ContactTypeID desc

2. Recupere los datos indicados en el ejemplo de resultado anterior, de los
empleados con cargo de Gerente de Marketing o Senior Tool Designer.

select
	hre.BusinessEntityID, hre.Gender, hre.MaritalStatus, hre.JobTitle
from HumanResources.Employee hre
where hre.JobTitle in ('Marketing Manager', 'Senior Tool Designer')

1. Recuperar datos de los productos con color y tamaño
informado, según el ejemplo:

select
	pp.Name, pp.Size, pp.Color
from Production.Product pp
where pp.Size is not null and pp.Color is not null

1. Liste datos de la facturación de los meses de 06/2011 y
07/2011, respetando la salida de ejemplo

select
	sso.SalesOrderID '#factura', sso.OrderDate as 'fecha', sso.TotalDue 'total'
from sales.SalesOrderHeader sso 
where month(sso.OrderDate) between 6 and 7
and year(sso.OrderDate) = 2011 

2. A los datos de la facturación de los meses de 06/2011 y 07/2011, obtenidos
agréguele el cálculo de 21% de IVA.select
	sso.SalesOrderID '#factura', sso.OrderDate as 'fecha', sso.TotalDue 'total', sso.TotalDue * 0.21 'IVA'
from sales.SalesOrderHeader sso 
where month(sso.OrderDate) between 6 and 7
and year(sso.OrderDate) = 2011 */