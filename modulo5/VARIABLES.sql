/*
-- VARIABLES
-- DECLARACIONES TIPOS PRIMITIVOS
DECLARE @VARIABLE1 INT = 0;
DECLARE @VARIABLE2 INT;
SET @VARIABLE2 = 0;
SELECT @VARIABLE1 = 0;

-- DECLARACIONES TIPO TABLA
DECLARE @VARIABLE3 TABLE(
ID INT NOT NULL,
APELLIDO VARCHAR(50),
NOMBRE VARCHAR(50)
);

-- CONDICIONALES

DECLARE @valor int
SET @valor=55
IF @valor<10
PRINT 'EL PRECIO ES MUY BAJO'
ELSE
PRINT 'EL PRECIO ES MUY CARO'

-- GOTO / WAITFOR

DECLARE @indice INT;
SET @indice=0 ;
WHILE (@indice<=10)
BEGIN
IF @indice=7
BEGIN
SET @indice=@indice+1;
WAITFOR DELAY '00:00:20'
CONTINUE;
END
-- Dos formas de salir forzando el while
IF @indice=8 GOTO mensaje;
IF @indice=9 BREAK;
--
SET @indice=@indice+1;
END
mensaje:
PRINT 'SALI DEL WHILE POR EL GOTO'

--LABORATORIO

1. Obtener el total de ventas del año 2014
y guardarlo en una variable llamada
@TotalVentas, luego imprimir el resultado.
Tablas: Sales.SalesOrderDetail
Campos: LineTotal

DECLARE @TotalVentas int;
SET @TotalVentas = 
(SELECT 
	SUM(ssod.LineTotal) totalVentas
FROM Sales.SalesOrderDetail AS ssod
WHERE YEAR(ssod.ModifiedDate) = 2014)
PRINT @TotalVentas;

2. Obtener el promedio de precios y guardarlo
en una variable llamada @Promedio luego
hacer un reporte de todos los productos cuyo
precio de venta sea menor al Promedio.
Tablas: Production.Product
Campos: ListPrice, ProductID

DECLARE @Promedio MONEY;
SET @Promedio = 
(SELECT 
	AVG(pp.ListPrice) promedioPrecios
FROM Production.Product AS pp)
SELECT *
FROM Production.Product
WHERE ListPrice < @Promedio
AND ListPrice <> 0.00
ORDER BY ListPrice DESC

3. Utilizando la variable @Promedio
incrementar en un 10% el valor de los
productos sean inferior al promedio.
Tablas: Production.Product
Campos: ListPrice

DECLARE @Promedio MONEY;
SET @Promedio = 
(SELECT 
	AVG(pp.ListPrice) promedioPrecios
FROM Production.Product AS pp)
SELECT 
	ProductID,
	Name,
	ListPrice *1.1
FROM Production.Product
WHERE ListPrice < @Promedio
AND ListPrice <> 0.00
ORDER BY ListPrice DESC

4. Crear un variable de tipo tabla con las
categorías y subcategoría de productos y
reportar el resultado.
Tablas: Production.ProductSubcategory,
Production.ProductCategory
Campos: Name

DECLARE @Categories TABLE(
	categoria VARCHAR(50),
	subcategoria VARCHAR(50)
);
INSERT INTO @Categories
SELECT 
	pp.Name, 
	ps.Name
FROM Production.ProductSubcategory	 AS pp
inner join Production.ProductCategory as ps on pp.ProductSubcategoryID = ps.ProductCategoryID

SELECT * FROM @Categories;

5. Analizar el promedio de la lista de precios de productos, si
su valor es menor 500 imprimir el mensaje el PROMEDIO
BAJO de lo contrario imprimir el mensaje PROMEDIO ALTO.
Tablas: Production.Product
Campos: ListPrice

IF(SELECT AVG(ListPrice) FROM Production.Product)<500
PRINT 'PROMEDIO BAJO'
ELSE 
PRINT 'PROMEDIO ALTO'
*/
