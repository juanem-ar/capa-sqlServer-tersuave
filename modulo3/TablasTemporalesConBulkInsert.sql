-- use Northwind
-- Creando una tabla temporal local
/*
select
p.ProductID id,
s.CompanyName proveedor,
p.ProductName producto,
p.UnitPrice precio,
p.UnitPrice*0.21 IVA,
p.UnitPrice + p.UnitPrice*0.21 PrecioIVAIncluido
into #Precios
from Products p join Suppliers s on p.SupplierID = s.SupplierID

-- Creando una tabla temporal global
select
p.ProductID id,
s.CompanyName proveedor,
p.ProductName producto,
p.UnitPrice precio,
p.UnitPrice*0.21 IVA,
p.UnitPrice + p.UnitPrice*0.21 PrecioIVAIncluido
into ##Precios
from Products p join Suppliers s on p.SupplierID = s.SupplierID

-- Creando una tabla Permanente
select
p.ProductID id,
s.CompanyName proveedor,
p.ProductName producto,
p.UnitPrice precio,
p.UnitPrice*0.21 IVA,
p.UnitPrice + p.UnitPrice*0.21 PrecioIVAIncluido
into Precios
from Products p join Suppliers s on p.SupplierID = s.SupplierID

-- Laboratorio
-- use AdventureWorks2019
1. Clonar estructura y datos de los campos nombre,
color y precio de lista de la tabla Production.Product
en una tabla llamada #Productos.
Tablas: Production.Product
Campos: Name, ListPrice, Colorselect	pp.name nombre,	pp.color,	pp.ListPrice precioLista	into #Productosfrom Production.Product ppselect * from #Productos2. Clonar solo estructura de los campos identificador,
nombre y apellido de la tabla Person.Person en una
tabla llamada #Personas
Tablas: Person.Person
Campos: BusinessEntityID, FirstName, LastNameselect	pp.BusinessEntityID,	pp.FirstName,	pp.LastName	into #Personasfrom Person.Person ppselect * from #Personas3. Eliminar si existe la tabla #Productos
Tablas: #Productosdrop table if exists #Productosselect * from #Productos*/