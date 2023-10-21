-- Funciones integradas de SQL
/*
select @@version

--de conversion
select convert(varchar(11), getdate(), 103)

select
OrderID,
OrderDate,
convert(varchar(11), OrderDate, 103) Fecha
from Orders

-- declarar una variable
declare @dato varchar(2),@dato2 int

set @dato='27'
select @dato+2 as variableAumentada

select @dato2 = cast(@dato as int)
select @dato2+2 as VariableCasteada

-- mostrar de los empleados el apellido y la primer letra del nombre

select
e.LastName,
substring(e.FirstName,1,1)+'.' InicialNombre
from Employees as e

-- con left/right

select
e.LastName,
left(e.FirstName,1)+'.' InicialNombre
from Employees as e


--length

select 
c.CustomerID,
lower(c.CompanyName) Nombre,
len(c.CompanyName) as LongitudNombre
from Customers c
order by len(c.CompanyName) desc

-- Normalizar el pais en la tabla de customers
select
c.Country PaisSinNormalizar
from Customers c

update Customers
set Country = upper(Country)

-- sacar espacios en blanco
select * from Employees
order by trim(LastName)

-- FUNCIONES DEFININDAS CREADAS POR EL PROG

-- ESCALARES (reciben parametros y retornan un valor)
--dado un id de cliente como parametro, retornan la cantidad de pedidos

create function fn_pedidos_idCliente 
(
	@idCliente nchar(5)
)
returns int
as -- cuerpo principal de la funcion
begin -- una buena practica es declarar la variable dentro del cuerpo
	declare @cantidadPedidos int
	set @cantidadPedidos = (select count(*) q from Orders where CustomerID = @idCliente)
	return @cantidadPedidos
end

--uso de la funcion
select
c.ContactName,
c.CompanyName,
dbo.fn_pedidos_idCliente(c.CustomerID) as CantidadPedidos
from Customers c

create function fn_pedidos_idCliente2 
(
	@idCliente nchar(5),
	@ano int
)
returns int
as -- cuerpo principal de la funcion
begin -- una buena practica es declarar la variable dentro del cuerpo
	declare @cantidadPedidos int
	set @cantidadPedidos = (select count(*) q from Orders where CustomerID = @idCliente and year(OrderDate)= @ano)
	return @cantidadPedidos
end

--uso de la funcion
select
c.ContactName,
c.CompanyName,
dbo.fn_pedidos_idCliente(c.CustomerID) as CantidadPedidos,
dbo.fn_pedidos_idCliente2(c.CustomerID, 1997) pedidosAño1997
from Customers c

alter function fn_pedidos_idCliente2 
(
	@idCliente nchar(5),
	@ano int
)
returns int
as -- cuerpo principal de la funcion
if @ano = 0
begin -- una buena practica es declarar la variable dentro del cuerpo
	declare @cantidadPedidos int
	set @cantidadPedidos = (select count(*) q from Orders where CustomerID = @idCliente)
end
else
begin -- una buena practica es declarar la variable dentro del cuerpo
	declare @cantidadPedidos int
	set @cantidadPedidos = (select count(*) q from Orders where CustomerID = @idCliente and year(OrderDate)= @ano)
	return @cantidadPedidos
end


-- Funciones matemáticas

-- abs / round / sign

-- ceiling: Devuelve el número entero más pequeño que sea mayor o igual que la expresión numérica especificada.
select ceiling(124.55)

-- floor: Devuelve el número entero más grande que sea menor o igual que la expresión numérica especificada.
select floor(123.45)

-- Funciones de fecha

-- datename / datepart / day / month / year / getdate / datediff / dateadd

SELECT DATENAME(YEAR, '2018-06-21'),
DATENAME(MONTH, '2018-06-21'), DATENAME(DAY,
'2018-06-21'), DATENAME(WEEKDAY, '2018-06-21');

SELECT DATEPART (YEAR, '2007-05-10'), DATEPART(MONTH, '2007-05-10'), DATEPART(DAY, '2007-05-10');

SELECT YEAR('1995-08-19'), MONTH('1995-08-19'), DAY('1995-08-19'); 

SELECT GETDATE(); 
SELECT DATEDIFF(YEAR, '2005-01-01', '2018-01-01');

SELECT DATEADD(MONTH, -1, '2006-08-01');
-- Funciones de Texto 
-- right / left / substring / charindex / replace / len / lower / upper

SELECT LastName, RIGHT(LastName,2)
FROM Person.Person
WHERE BusinessEntityID=1;SELECT SUBSTRING('AABBCC',3,2);SELECT CHARINDEX('B','ABC');SELECT REPLACE('AABB','B','Z');SELECT REPLACE('AABB');SELECT LOWER('AABB');-- Funciones definidas por el UsuarioSELECT definition, type
FROM sys.sql_modules AS m
JOIN sys.objects AS o ON m.object_id = o.object_id
AND type IN ('FN', 'IF', 'TF');
GO -- Funciones Escalares
	Devuelven un solo valor del tipo definido en la cláusula RETURNS.
	Este tipo de funciones es sintácticamente similar a las funciones del Sistema
	tales como COUNT() o MAX().
	EJEMPLO:
	
		IF OBJECT_ID ('Sales.fnTotalVentas', 'FN') IS NOT NULL
	 DROP FUNCTION Sales.fnTotalVentas;
	GO
	-- CREACIÓN DE FUNCIÓN ESCALAR
	CREATE FUNCTION Sales.fnTotalVentas(@ProductID INT)
	RETURNS INT
	AS
	BEGIN
	 DECLARE @ret int; -- declara la variable
	 SELECT @ret = SUM(OrderQty)
	 FROM Sales.SalesOrderDetail
	 WHERE ProductID = @ProductID;
	 RETURN @ret;
	END
	GO
	SELECT Sales.fnTotalVentas(712) AS Producto;

	
-- Funciones Tabulares En Línea
	Devuelven una tabla que es el resultado de una sola sentencia SELECT. Es
	similar a una Vista, pero ofrecen más flexibilidad que una Vista porque se le
	pueden suministrar parámetros a la Función.

		IF OBJECT_ID ('Sales.ifTotalVentas', 'IF') IS NOT NULL
	 DROP FUNCTION [Sales].[ifTotalVentas];
	GO
	-- CREACION DE FUNCIÓN TABULAR
	CREATE FUNCTION Sales.ifTotalVentas(@ProductID INT)
	RETURNS TABLE
	AS
	RETURN
	(SELECT * FROM Sales.SalesOrderDetail WHERE ProductID =@ProductID);
	GO
	SELECT * FROM [Sales].[ifTotalVentas](712);

-- Funciones Tabulares Multi-sentencia
	Devuelve una Tabla construida por una o más sentencias Transact-SQL. Es
	similar a un Procedimiento Almacenado, pero a diferencia de éste último, la
	Vista puede referenciarse en la cláusula FROM de una sentencia SELECT
	como si se tratase de una Tabla.	Características:
	● Las funciones de tabla de multi
	sentencias son similares a los
	procedimientos almacenados
	excepto que devuelven una tabla.
	● Este tipo de función se usa en
	situaciones donde se requiere
	más lógica y proceso.		IF OBJECT_ID ('SALES.tfTotalVentas', 'TF') IS NOT NULL
	 DROP FUNCTION SALES.tfTotalVentas;
	GO
	CREATE FUNCTION [Sales].tfTotalVentas(@format NVARCHAR(9))
	RETURNS @Empleados TABLE(EmpleadoID INT, Nombre NVARCHAR(100))
	AS
	BEGIN
	IF (@format = 'SHORTNAME')
	 BEGIN
	 INSERT @Empleados
	 SELECT BusinessEntityID, LastName
	 FROM HumanResources.vEmployee;
	 END
	ELSE
	 BEGIN
	 INSERT @Empleados
	 SELECT BusinessEntityID, (FirstName + ' ' +
	LastName)
	 FROM HumanResources.vEmployee;
	 END
	 RETURN
	 END
	GO
	SELECT * FROM Sales.tfTotalVentaS('SHORTNAME');-- Laboratorio 1 Funciones Escalares1. Crear una función que devuelva el promedio
de los productos.
Tablas: Production.Product
Campos: ListPriceGO
CREATE FUNCTION dbo.FN_Promedio()
RETURNS MONEY
AS
BEGIN
		DECLARE @promedio MONEY;

		SELECT 
				@promedio=AVG(ListPrice) 
		FROM 
				Production.Product
		
		RETURN @promedio
END
GO

SELECT dbo.FN_Promedio() as Promedio

2. Crear una función que dado un código de
producto devuelva el total de ventas para
dicho producto luego, mediante una
consulta, traer código y total de ventas.
Tablas: Sales.SalesOrderDetail
Campos: ProductID, LineTotal

IF OBJECT_ID ('dbo.FN_TotalVentas','FN') IS NOT NULL
	DROP FUNCTION dbo.FN_TotalVentas;
GO
CREATE FUNCTION dbo.FN_TotalVentas(@idProducto int)
RETURNS MONEY
AS
BEGIN
		DECLARE @totalVenta MONEY;
			SELECT @totalVenta = SUM(LineTotal)
			FROM Sales.SalesOrderDetail as ssod
			WHERE ProductID = @idProducto;
		RETURN @totalVenta
END
GO
SELECT
	sso.ProductID Producto,
	(SELECT dbo.FN_TotalVentas(925)) as TotalVentas
FROM Sales.SalesOrderDetail sso
where ProductID = 925
group by ProductID
GO

3. Crear una función que dado un código
devuelva la cantidad de productos vendidos
o cero si no se ha vendido.
Tablas: Sales.SalesOrderDetail
Campos: ProductID, OrderQty

IF OBJECT_ID('dbo.FN_CantidadVendida','FN') IS NOT NULL
	DROP FUNCTION dbo.FN_CantidadVendida;
GO
CREATE FUNCTION dbo.FN_CantidadVendida(@PRODUCTID INT)
RETURNS INT
AS
	BEGIN
		DECLARE @RESULT INT;
		SELECT 
		@RESULT = SUM(SSOD.OrderQty)
		FROM Sales.SalesOrderDetail AS SSOD
		WHERE ProductID = @PRODUCTID;
		IF (@RESULT IS NULL)
			SET @RESULT = 0
		RETURN @RESULT
	END
GO
SELECT dbo.FN_CantidadVendida(776) AS CANTIDADVENDIDA

4. Crear una función que devuelva el promedio
total de venta, luego obtener los productos
cuyo precio sea inferior al promedio.
Tablas: Sales.SalesOrderDetail,
Production.Product
Campos: ProductID, ListPrice

IF OBJECT_ID('dbo.FN_PromedioTotalDeVenta','FN') IS NOT NULL
	DROP FUNCTION dbo.FN_PromedioTotalDeVenta;
GO
CREATE FUNCTION dbo.FN_PromedioTotalDeVenta() 
RETURNS INT
AS
BEGIN
	DECLARE @PROMEDIO INT;
	SELECT @PROMEDIO = AVG(LineTotal)
	FROM Sales.SalesOrderDetail 
	RETURN @PROMEDIO;
END
GO

SELECT
	*
FROM Sales.SalesOrderDetail
WHERE UnitPrice < dbo.FN_PromedioTotalDeVenta()

-- LABORATORIO FUNCIONES DE TABLA EN LINEA

5. Crear una función que dado un año, devuelva nombre y
apellido de los empleados que ingresaron ese año.
Tablas: Person.Person, HumanResources.Employee
Campos: FirstName, LastName,HireDate, BusinessEntityIDIF OBJECT_ID ('dbo.IF_EmpleadosIngresadosPorAnio','IF') IS NOT NULL	DROP FUNCTION dbo.IF_EmpleadosIngresadosPorAnio;GO
CREATE FUNCTION dbo.IF_EmpleadosIngresadosPorAnio(@ANIO INT) 
RETURNS TABLE
AS
RETURN
	(SELECT
		pp.FirstName + ' ' + pp.LastName as NombreCompleto
	FROM Person.Person AS pp 
	JOIN HumanResources.Employee AS hre on pp.BusinessEntityID = hre.BusinessEntityID
	WHERE year(hre.HireDate) = @ANIO);
GO
SELECT * FROM dbo.IF_EmpleadosIngresadosPorAnio(2011)

6. Crear una función que reciba un parámetro
correspondiente a un precio y nos retorna una tabla con
código, nombre, color y precio de todos los productos
cuyo precio sea inferior al parámetro ingresado.
Tablas: Production.Product
Campos: ProductID, Name, Color, ListPrice

IF OBJECT_ID ('dbo.IF_PreciosDeProductos','IF') IS NOT NULL
	DROP FUNCTION dbo.IF_PreciosDeProductos; 
GO
CREATE FUNCTION dbo.IF_PreciosDeProductos(@PRECIO MONEY)
RETURNS TABLE
AS
RETURN
	(
	SELECT 
		pp.ProductID codigo,
		pp.Name nombre,
		pp.Color,
		pp.ListPrice precio
	FROM Production.Product AS pp
	WHERE ListPrice < @PRECIO
	);
GO
SELECT * FROM dbo.IF_PreciosDeProductos(44.54) WHERE precio <> 0.00

-- LABORATORIO FUNCIONES MULTISENTENCIA

7. Realizar el mismo pedido que en el punto anterior, pero
utilizando este tipo de función.
Tablas: Production.Product
Campos: ProductID, Name, Color, ListPrice

IF OBJECT_ID ('dbo.TF_PreciosDeProductos','TF') IS NOT NULL
	DROP FUNCTION dbo.TF_PreciosDeProductos; 
GO
CREATE FUNCTION dbo.TF_PreciosDeProductos( @minimo DECIMAL(6,2))
RETURNS @oferta 
TABLE
(
	Codigo		INT
	,Nombre		VARCHAR(40)
	,Color		VARCHAR(30)
	,Precio		DECIMAL(6,2)
)
AS
BEGIN
	INSERT @oferta
	SELECT	
		ProductID,
		Name,
		Color,
		ListPrice
	FROM Production.Product
	WHERE ListPrice<@minimo
	RETURN
END
GO
SELECT * FROM dbo.TF_PreciosDeProductos(44.50);

*/