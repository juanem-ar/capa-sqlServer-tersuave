-- use Northwind
-- Creando una tabla temporal local
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
