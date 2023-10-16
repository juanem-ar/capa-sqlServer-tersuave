/* Laboratorio

-- use AdventureWorks2019

1. Mostrar los empleados que tambi�n son vendedores.
Tablas: HumanResources.Employee, Sales.SalesPerson
Campos: BusinessEntityID
apellido y por nombre.
Tablas: HumanResources.Employee, Person.Person
Campos: BusinessEntityID, LastName, FirstName
b�sico de los vendedores.
Tablas: HumanResources.Employee, Sales.SalesPerson
Campos: LoginID, TerritoryID, Bonus, BusinessEntityID
Tablas: Production.Product, Production.ProductSubcategory
Campos: Name, ProductSubcategoryID
Tablas:Production.Product, Production.ProductSubcategory
Campos: Name, ProductSubcategoryID
el precio de venta sea inferior al precio de lista recomendado
para ese producto ordenados por nombre de producto.
Tablas: Sales.SalesOrderDetail, Production.Product
Campos: ProductID, Name, ListPrice, UnitPrice
deben mostrar de a pares, c�digo y nombre de cada uno de
los dos productos y el precio de ambos. Ordenar por precio
en forma descendente.
Tablas:Production.Product
Campos: ProductID, ListPrice, Name
cuya subcategor�a es 15 ordenados por nombre de
proveedor.
Tablas: Production.Product, Purchasing.ProductVendor,
Purchasing.Vendor
Campos: Name ,ProductID, BusinessEntityID,
ProductSubcategoryID
que sean empleados mostrar tambi�n el login id, sino mostrar
null.
Tablas: Person.Person, HumanResources.Employee
Campos: FirstName, LastName, LoginID, BusinessEntityID

select 
	pp.FirstName + ' ' + pp.LastName as NombreCompleto,
	hre.LoginID
from Person.Person pp
left join HumanResources.Employee hre on pp.BusinessEntityID = hre.BusinessEntityID
*/