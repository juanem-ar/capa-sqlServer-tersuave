-- PROCEDIMIENTOS ALMACENADOS
/*
Tipos de procedimientos almacenados
	● Definidos por el usuario
	Un procedimiento definido por el usuario se puede
	crear en una base de datos definida por el usuario o
	en todas las bases de datos del sistema excepto en la
	base de datos Resource. El procedimiento se puede
	desarrollar en Transact-SQL o como una referencia a
	un método de Common Runtime Language (CLR) de
	Microsoft .NET Framework .
	● Temporales
	Los procedimientos temporales son una forma
	de procedimientos definidos por el usuario. Los
	procedimientos temporales son iguales que los
	procedimientos permanentes salvo porque se
	almacenan en tempdb.
	Hay dos tipos de procedimientos temporales:
	locales y globales. Se diferencian entre sí por los
	nombres, la visibilidad y la disponibilidad. Los
	procedimientos temporales locales tienen como
	primer carácter de sus nombres un solo signo
	de número (#); solo son visibles en la conexión
	actual del usuario y se eliminan cuando se cierra
	la conexión.
	Los procedimientos temporales globales
	presentan dos signos de número (##)
	antes del nombre; son visibles para
	cualquier usuario después de su creación
	y se eliminan al final de la última sesión
	en la que se usa el procedimiento.
	Sistema
	Los procedimientos del sistema se incluyen con
	SQL Server. Están almacenados físicamente en
	la base de datos interna y oculta Resource y se
	muestran de forma lógica en el esquema sys de
	cada base de datos definida por el sistema y por
	el usuario. Además, la base de datos msdb
	también contiene procedimientos almacenados
	del sistema en el esquema dbo que se usan
	para programar alertas y trabajos.
	Dado que los procedimientos del sistema
	empiezan con el prefijo sp_, recomendamos
	que no use este prefijo cuando asigne un
	nombre a los procedimientos definidos por
	el usuario. Para obtener una lista completa
	de los procedimientos del sistema.
	sp_tables
	sp_columns
	sp_databases
	sp_execute

-- CREAR UN PROCEDIMIENTO ALMACENADO

CREATE PROCEDURE dbo.PA_Empleados
AS
 SELECT 
	 LastName, 
	 FirstName, 
	 Department
 FROM HumanResources.vEmployeeDepartmentHistory;
GO
-- LLAMADO O INVOCACIÓN
EXEC dbo.PA_Empleados;
GO

--CREAR PROCEDIMIENTO CON PARAMETROS DE ENTRADA

El ejemplo crea un procedimiento almacenado llamado PA_Empleados que obtiene un listado con el
Apellido, Nombre y Departamento de los empleados filtrando por Apellido y Nombre.
IF OBJECT_ID ('dbo.PA_Empleados', 'P') IS NOT NULL
 DROP PROCEDURE dbo.PA_Empleados;
GO
CREATE PROCEDURE dbo.PA_Empleados @LastName VARCHAR(50),
@FirstName VARCHAR(50)
AS
 SELECT LastName, FirstName, Department
 FROM HumanResources.vEmployeeDepartmentHistory
 WHERE FirstName = @FirstName AND LastName = @LastName;
GO
-- Invocación al SP pasando los parámetros teniendo en cuenta el orden
EXEC dbo.PA_Empleados 'Ackerman', 'Pilar';
-- Invocación al SP pasando los parámetros sin tener en cuenta el orden
EXEC dbo.PA_Empleados @FirstName = 'Pilar', @LastName = 'Ackerman';

-- CREAR PROCEDIMIENTO CON PARAMETROS DE ENTRADA DETERMINADOS

El ejemplo crea un procedimiento
almacenado llamado PA_Empleados que
obtiene un listado con datos del empleado
cuyo Apellido y Nombre son pasados
como valores de parámetros, por otro
lado, el procedimiento no recibe valores
en sus parámetros mostrará los datos de
Arifin Zainal.

IF OBJECT_ID ('dbo.PA_Empleados', 'P') IS NOT NULL
 DROP PROCEDURE dbo.PA_Empleados;
GO
CREATE PROCEDURE dbo.PA_Empleados @LastName VARCHAR(50)='Arifin', @FirstName VARCHAR(50)='Zainal'
AS
 SELECT LastName, FirstName,Department
 FROM HumanResources.vEmployeeDepartmentHistory
 WHERE FirstName = @FirstName AND LastName = @LastName;
GO
-- Invocación al SP pasando nombre y apellido del empleado
EXEC dbo.PA_Empleados 'Ackerman', 'Pilar';
-- Invocación al SP usando los valores predeterminados
EXEC dbo.PA_Empleados;

-- CREAR UN PROCEDIMIENTO CON PARAMETROS DE ENTRADA Y SALIDA

El siguiente ejemplo crea un
procedimiento almacenado llamado
PA_Empleados que recibe Nombre y
Apellido del empleado y guarda en el
parámetro de salida el nombre del
departamento.IF OBJECT_ID ('dbo.PA_Empleados', 'P') IS NOT NULL
 DROP PROCEDURE dbo.PA_Empleados;
GO
CREATE PROCEDURE dbo.PA_Empleados @LastName VARCHAR(50)='Arifin', @FirstName VARCHAR(50)='Zainal', @Department VARCHAR(50) OUTPUT
AS
 SELECT @Department=[Department]
 FROM HumanResources.vEmployeeDepartmentHistory
 WHERE FirstName = @FirstName AND LastName = @LastName;
GO
-- Declaro la variable donde se guardará el departamento del
empleado
DECLARE @Departamento VARCHAR(50);
-- Obtengo el departamento de Akerman
EXEC dbo.PA_Empleados 'Ackerman', 'Pilar', @Departamento OUTPUT;
-- Verifica el departamento obtenido
SELECT @Departamento AS [Valor obtenido desde un OUTPUT];
GO-- CREAR UN PROCEDIMIENTO CON VALOR DE RETORNOEl siguiente ejemplo crea un
procedimiento almacenado llamado
PA_Empleados que recibe Nombre y
Apellido del empleado y retorna cero
si no tiene departamento o uno en
caso contrario.IF OBJECT_ID ('dbo.PA_Empleados', 'P') IS NOT NULL
 DROP PROCEDURE dbo.PA_Empleados;
GO
CREATE PROCEDURE dbo.PA_Empleados @LastName VARCHAR(50)='Arifin', @FirstName VARCHAR(50)='Zainal'
AS
 DECLARE @Department VARCHAR(50);
 SELECT @Department=[Department]
 FROM HumanResources.vEmployeeDepartmentHistory
 WHERE FirstName = @FirstName AND LastName = @LastName;
 IF @Department IS NULL
 RETURN 0;
 ELSE
 RETURN 1;
GO
DECLARE @Resultado TINYINT;
-- Guardo el valor de retorno en la variable resultado
EXEC @Resultado=dbo.PA_Empleados 'Ackerman', 'Pilar';
-- Verifico si tiene o no departamento
SELECT @Resultado AS [Valor obtenido desde un RETURN]-- CREAR UN PROCEDIMIENTO COMBINANDO PARAMETROS Y VALOR DE RETORNOEl ejemplo crea un procedimiento
almacenado llamado PA_Empleados que
recibe Nombre y Apellido del empleado
y retorna cero si no tiene departamento
almacenando Desconocido en el
parámetro de salida o uno en caso
contrario y el nombre del departamentoIF OBJECT_ID ('dbo.PA_Empleados', 'P') IS NOT NULL
 DROP PROCEDURE dbo.PA_Empleados;
GO
CREATE PROCEDURE dbo.PA_Empleados @LastName VARCHAR(50)='Arifin',
@FirstName VARCHAR(50)='Zainal', @Department VARCHAR(50) OUTPUT
AS
 SELECT @Department=Department
 FROM HumanResources. vEmployeeDepartmentHistory
 WHERE FirstName = @FirstName AND LastName = @LastName;
 -- Si el empleado no tiene departamento
 IF @Department IS NULL
 BEGIN
 SET @Department='Departamento Desconocido';
 RETURN 0;
 END
 RETURN 1;
GO
DECLARE @Resultado TINYINT;
DECLARE @Departamento VARCHAR(50);
EXEC @Resultado=dbo.PA_Empleados 'Ackerman', 'Pilar', @Departamento OUTPUT;
-- Verifica los datos del empleado
SELECT @Resultado AS [Valor obtenido desde un RETURN],
 @Departamento AS [Valor obtenido desde un OUTPUT];-- INSERTAR REGISTROS MEDIANTE UN PROCEDIMIENTO ALMACENADOIF OBJECT_ID ( 'dbo.PA_Empleados', 'P') IS NOT NULL
 DROP PROCEDURE dbo.PA_Empleados;
GO
CREATE PROCEDURE dbo.PA_Empleados
AS
 SELECT LastName, FirstName, Department
 FROM HumanResources.vEmployeeDepartmentHistory;
GO
IF OBJECT_ID ( 'dbo.Empleados', 'U' ) IS NOT NULL
 DROP TABLE dbo.Empleados;
GO
CREATE TABLE dbo.Empleados(
Nombre varchar(50),
Apellido varchar(50),
Departamento varchar(50)
);
GO
INSERT INTO dbo.Empleados
EXEC dbo.PA_Empleados;
GO
SELECT * FROM dbo.Empleados;
*/