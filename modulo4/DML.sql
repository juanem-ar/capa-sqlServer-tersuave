-- DML

-- INSERT

CREATE TABLE dbo.Sectores(
SectorID TINYINT NOT NULL IDENTITY(1,1),
Gerencia VARCHAR(50),
Sector VARCHAR(50) DEFAULT 'Sin Sector'
);

-- insertar defaults
INSERT INTO dbo.Sectores DEFAULT VALUES;

INSERT INTO dbo.Sectores VALUES ('Finanzas',
'Contaduria');-- varias filasINSERT INTO dbo.Sectores VALUES
('Finanzas','Cobranzas'), ('Finanzas','Ventas');SELECT * FROM dbo.Sectores;-- insertar indicando idINSERT INTO dbo.Sectores (Gerencia, Sector) VALUES ('Finanzas', 'Ventas');
SET IDENTITY_INSERT dbo.Sectores ON;
INSERT INTO dbo.Sectores (SectorID, Gerencia, Sector) VALUES
(100, 'Recursos Humanos', DEFAULT);
SELECT * FROM dbo.Sectores;
SET IDENTITY_INSERT dbo.Sectores OFF; INSERT INTO dbo.Sectores (Gerencia, Sector)-- UPDATE-- use AdventureWorks2019UPDATE Person.Address
SET ModifiedDate = GETDATE();select ModifiedDate from Person.Address-- valor calculadoUPDATE Production.Product
SET ListPrice = ListPrice * 2;-- actualizar varias columnasUPDATE Sales.SalesPerson
SET Bonus = 6000, CommissionPct = 1.10, SalesQuota = NULL; -- con clausula whereUPDATE Production.Product
SET Color = 'Metallic Red'
WHERE Name LIKE N'Road-250%' AND Color = 'Red';

-- actualizar filas con valores default
UPDATE Production.Location
SET CostRate = DEFAULT
WHERE CostRate > 20.00;-- indicando la cantidad de filas a alterarUPDATE TOP (10) HumanResources.Employee
SET VacationHours = VacationHours * 1.25;

-- igual que el anterior pero teniendo en cuenta algun orden
UPDATE HumanResources.Employee
SET VacationHours = VacationHours + 8
FROM (SELECT TOP 10 BusinessEntityID FROM
HumanResources.Employee
 ORDER BY HireDate ASC) AS th
WHERE HumanResources.Employee.BusinessEntityID =
th.BusinessEntityID;-- actualizar filas con valores de otras tablasUPDATE s
SET Sector=sn.SectorNuevo
FROM
Sectores s
INNER JOIN SectoresNuevo sn
ON S.Sector=sn.Sector
SELECT * FROM dbo.Sectores;

-- DELETE

-- usar TRUNCATE TABLE para mayor rendimiento
-- @@ROWCOUNT devuelve la cantidad de filas eliminadas
-- DELETE FROM Sales.SalesPersonQuotaHistory;

DELETE Production.ProductCostHistory
WHERE StandardCost BETWEEN 12.00 AND 14.00 AND
EndDate IS NULL;

--usando JOIN
DELETE s
FROM dbo.Sectores s
INNER JOIN dbo.SectoresNuevo sn
ON S.Sector=sn.Sector;
SELECT * FROM dbo.Sectores;

-- TRUNCATE

TRUNCATE TABLE dbo.Sectores;
GO
SELECT COUNT(*) AS CantidadRegistros
FROM dbo.Sectores;