/* Laboratorio

-- use AdventureWorks2019

1. Mostrar los empleados que también son vendedores.
Tablas: HumanResources.Employee, Sales.SalesPerson
Campos: BusinessEntityIDselect	hre.BusinessEntityID EmpleadoID,	ssp.BusinessEntityID VendedorIdfrom HumanResources.Employee hreinner join Sales.SalesPerson ssp on hre.BusinessEntityID = ssp.BusinessEntityID2. Mostrar los empleados ordenados alfabéticamente por
apellido y por nombre.
Tablas: HumanResources.Employee, Person.Person
Campos: BusinessEntityID, LastName, FirstNameselect*from HumanResources.Employee hrejoin Person.Person pp on hre.BusinessEntityID = pp.BusinessEntityIDorder by pp.LastName, pp.FirstName3. Mostrar el código de logueo, código de territorio y sueldo
básico de los vendedores.
Tablas: HumanResources.Employee, Sales.SalesPerson
Campos: LoginID, TerritoryID, Bonus, BusinessEntityIDselect	hre.BusinessEntityID VendedorId,	hre.LoginID codigoLogeo,	ssp.TerritoryID,	ssp.Bonusfrom HumanResources.Employee hreinner join Sales.SalesPerson ssp on hre.BusinessEntityID = ssp.BusinessEntityID4. Mostrar los productos que sean ruedas.
Tablas: Production.Product, Production.ProductSubcategory
Campos: Name, ProductSubcategoryIDselect*from Production.Product ppinner join Production.ProductSubcategory pps on pp.ProductSubcategoryID = pps.ProductSubcategoryIDwhere pps.name = 'Wheels'5. Mostrar los nombres de los productos que no son bicicletas.
Tablas:Production.Product, Production.ProductSubcategory
Campos: Name, ProductSubcategoryIDselect*from Production.Product ppinner join Production.ProductSubcategory pps on pp.ProductSubcategoryID = pps.ProductSubcategoryIDwhere pps.name not like '%Bike%'6. Mostrar los precios de venta de aquellos productos donde
el precio de venta sea inferior al precio de lista recomendado
para ese producto ordenados por nombre de producto.
Tablas: Sales.SalesOrderDetail, Production.Product
Campos: ProductID, Name, ListPrice, UnitPriceselect distinct	pp.ProductID,	pp.Name NombreProducto,	ssod.UnitPrice PrecioVendido,	pp.ListPrice PrecioSugeridofrom Sales.SalesOrderDetail ssodinner join Production.Product pp on ssod.ProductID = pp.ProductIDwhere ssod.UnitPrice < pp.ListPriceorder by NombreProducto7. Mostrar todos los productos que tengan igual precio. Se
deben mostrar de a pares, código y nombre de cada uno de
los dos productos y el precio de ambos. Ordenar por precio
en forma descendente.
Tablas:Production.Product
Campos: ProductID, ListPrice, Nameselect	pp1.ProductID Id1,	pp1.Name nombre1,	pp1.ListPrice precio1,	pp2.ProductID Id2,	pp2.Name nombre2,	pp2.ListPrice precio2from Production.Product pp1inner join Production.Product pp2 on pp1.ListPrice = pp2.ListPricewhere pp1.ProductID > pp2.ProductIDorder by pp1.ListPrice desc8. Mostrar el nombre de los productos y de los proveedores
cuya subcategoría es 15 ordenados por nombre de
proveedor.
Tablas: Production.Product, Purchasing.ProductVendor,
Purchasing.Vendor
Campos: Name ,ProductID, BusinessEntityID,
ProductSubcategoryIDselect 	pp.Name Nombre,	pv.Name Proveedorfrom Production.Product ppinner join Purchasing.ProductVendor ppv on pp.ProductID = ppv.ProductIDinner join Purchasing.Vendor pv on ppv.BusinessEntityID = pv.BusinessEntityIDwhere pp.ProductSubcategoryID = 15order by Proveedor9. Mostrar todas las personas (nombre y apellido) y en el caso
que sean empleados mostrar también el login id, sino mostrar
null.
Tablas: Person.Person, HumanResources.Employee
Campos: FirstName, LastName, LoginID, BusinessEntityID

select 
	pp.FirstName + ' ' + pp.LastName as NombreCompleto,
	hre.LoginID
from Person.Person pp
left join HumanResources.Employee hre on pp.BusinessEntityID = hre.BusinessEntityID
*/
