-- Creamos la tabla Prueba y CopiaPrueba para realizar los siguientes ejemplos

	IF OBJECT_ID (N'dbo.Prueba', N'U') IS NOT NULL
	DROP TABLE dbo.Prueba;
	GO
	CREATE TABLE dbo.Prueba(Codigo INT, Nombre VARCHAR(50));
	GO
	IF OBJECT_ID (N'dbo.CopiaPrueba', N'U') IS NOT NULL
	DROP TABLE dbo.CopiaPrueba;
	GO
	CREATE TABLE [dbo].[CopiaPrueba](Codigo INT, Nombre VARCHAR(50));
/*
# TRIGGER INSERT 

El siguiente ejemplo crea un trigger llamado
TR_Prueba sobre la taba Prueba, al dispararse
ante una operación INSERT guarda un
histórico en la tabla CopiaPrueba.
*/
	IF OBJECT_ID (N'dbo.TR_Prueba', N'TR') IS NOT NULL
	DROP TRIGGER dbo.TR_Prueba;
	GO
	CREATE TRIGGER dbo.TR_Prueba ON dbo.Prueba
	AFTER INSERT AS
	BEGIN
		INSERT INTO dbo.CopiaPrueba
		SELECT * FROM inserted;
	END
	GO
	INSERT INTO dbo.Prueba VALUES (1,'GABRIEL'),(2,'CARLOS'),(3,'JUAN');
	GO
	SELECT * FROM dbo.CopiaPrueba;

/*
# TRIGGER UPDATE 

El siguiente ejemplo crea un trigger llamado
TR_Prueba sobre la taba Prueba, al dispararse
ante una operación UPDATE modifica el
nombre en la tabla de históricos
CopiaPrueba.
*/
IF OBJECT_ID (N'dbo.TR_Prueba', N'TR') IS NOT NULL
DROP TRIGGER dbo.TR_Prueba;
GO
CREATE TRIGGER dbo.TR_Prueba ON dbo.Prueba
AFTER UPDATE AS
BEGIN
 UPDATE p SET Nombre=i.Nombre
 FROM dbo.CopiaPrueba p INNER JOIN Inserted i
 ON p.Codigo=i.Codigo;
END
GO
 UPDATE dbo.Prueba SET Nombre='PEDRO'
 WHERE codigo = 1;
SELECT Nombre, CODIGO FROM dbo.CopiaPrueba WHERE codigo = 1;

/*
# TRIGGER DELETE 

El siguiente ejemplo crea un trigger llamado
TR_Prueba sobre la taba Prueba,
al dispararse ante una operación DELETE
elimina el dato del histórico.
*/

IF OBJECT_ID (N'dbo.TR_Prueba', N'TR') IS NOT NULL
DROP TRIGGER dbo.TR_Prueba;
GO
CREATE TRIGGER dbo.TR_Prueba ON dbo.Prueba
AFTER DELETE AS
BEGIN
 DELETE FROM dbo.CopiaPrueba
 FROM dbo.CopiaPrueba p INNER JOIN deleted d
 ON p.Codigo=d.Codigo;
END
GO
DELETE FROM dbo.Prueba
WHERE Nombre LIKE '%PEDRO%';
SELECT * FROM dbo.CopiaPrueba;
/*
-- LABORATORIO ADVENTUREWORKS2019 - TRIGGERS
-- use AdventureWorks2019
1. Clonar estructura (ProductID, ListPrice) y datos de la
tabla Production.Product en una tabla llamada
Productos.
IF 
SELECT
	ProductID,
	ListPrice
INTO Productos
FROM Production.Product;

2. Crear un trigger sobre la tabla Productos llamado
TR_ActualizaPrecios dónde actualice la tabla
#HistoricoPrecios con los cambios de precio.
Tablas: Productos
Campos: ProductID, ListPrice

SELECT * INTO #HistoricoPrecios FROM dbo.Productos;

IF OBJECT_ID (N'dbo.TR_ActualizaPrecios', N'TR') IS NOT NULL
	DROP TRIGGER dbo.TR_ActualizaPrecios;
GO
CREATE TRIGGER dbo.TR_ActualizaPrecios ON dbo.Productos
AFTER UPDATE AS
BEGIN
	UPDATE p 
	SET p.ListPrice = i.ListPrice
	FROM #HistoricoPrecios p INNER JOIN Inserted i
	ON p.ProductID=i.ProductID;
END
GO
UPDATE dbo.Productos
SET ListPrice = 57
WHERE ProductID = 1

select * from #HistoricoPrecios p where p.ProductID = 1 
select * from dbo.Productos p where p.ProductID = 1 

3. Adaptar el trigger del punto anterior donde valide que
el precio no pueda ser negativo.

ALTER TRIGGER dbo.TR_ActualizaPrecios ON dbo.Productos
INSTEAD OF UPDATE AS
IF NOT EXISTS (SELECT 1 FROM inserted WHERE ListPrice > 0)
	BEGIN
		UPDATE p 
		SET p.ListPrice = i.ListPrice
		FROM #HistoricoPrecios p INNER JOIN Inserted i
		ON p.ProductID=i.ProductID;
	END
GO
UPDATE dbo.Productos
SET ListPrice = 157
WHERE ProductID = 1

select * from #HistoricoPrecios p where p.ProductID = 1 
select * from dbo.Productos p where p.ProductID = 1 
*/