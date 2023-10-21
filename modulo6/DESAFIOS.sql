-- DESAF�OS
/*
1. Escriba una funci�n llamada fn_FormatPhone que reciba
un n�mero de 10 d�gitos y lo format�e seg�n la m�scara
siguiente (###) ###-####

IF OBJECT_ID ('dbo.fn_FormatPhone', 'FN') IS NOT NULL
	DROP FUNCTION dbo.fn_FormatPhone;
GO
CREATE FUNCTION dbo.fn_FormatPhone (@NUMERO VARCHAR(10))
RETURNS VARCHAR(14)
AS
BEGIN
	DECLARE @RESULT VARCHAR(14);
	SET @RESULT = '(' + SUBSTRING(@NUMERO,1,3) + ') '
	SET @RESULT = @RESULT + SUBSTRING(@NUMERO,4,3) + '-'
	SET @RESULT = @RESULT + SUBSTRING(@NUMERO,7,4)
	RETURN @RESULT;
END
GO
SELECT dbo.fn_FormatPhone('1234567891');

1. Cree una funci�n llamada fn_RemueveNumeros, que elimine d�gitos
num�ricos en un string de 250 caracteres.
SELECT dbo.fn_RemueveNumeros('abc 123 probando 456 la 7 funci�n')
abc probando la funci�n

IF OBJECT_ID ('dbo.fn_RemueveNumeros','FN') IS NOT NULL
	DROP FUNCTION dbo.fn_RemueveNumeros;
GO
CREATE FUNCTION dbo.fn_RemueveNumeros (@Expression VARCHAR(250))
 RETURNS VARCHAR(250) AS
BEGIN
 DECLARE @NewExpression VARCHAR(250) = ''
 DECLARE @Count INT = 1
 DECLARE @Char CHAR(1)
 WHILE @Count <= LEN(@Expression)
BEGIN
 SET @Char = SUBSTRING(@Expression, @Count, 1)
 IF ISNUMERIC(@Char) = 0
 SET @NewExpression += @Char
 SET @Count += 1
END
RETURN @NewExpression
END
GO
SELECT dbo.fn_RemueveNumeros('ASDASDASD 1234567891');

-- EJERCICIO 3

1. Defina un trigger llamado tr_Person_AddressINS que sustituya cualquier
intento de ingresar una direcci�n abreviada de Avda. por Avenida.
INSERT INTO Person.Address (AddressLine1, City, StateProvinceID, PostalCode)
 VALUES ('Avda. San Mart�n', 'CABA', 79, '1140')
INSERT INTO Person.Address (AddressLine1, City, StateProvinceID, PostalCode)
 VALUES ('Bulnes', 'CABA', 79, '1140')
SELECT AddressLine1 FROM Person.Address
 WHERE PostalCode = '1140'
CREATE TRIGGER tr_Person_AddressINS
 ON Person.Address
 INSTEAD OF INSERT AS
BEGIN
 INSERT INTO Person.Address (AddressLine1, City, StateProvinceID, PostalCode)
 SELECT REPLACE(AddressLine1, 'Avda.', 'Avenida'), City,
 StateProvinceID, PostalCode
 FROM Inserted
END

2. Deshabilite todos los triggers de la tabla usada en el paso
anterior y elimine el trigger creado.
DISABLE TRIGGER ALL ON Person.Address
DROP TRIGGER Person.tr_Person_AddressINS

3. Explique brevemente, qu� hace el trigger siguiente y si funciona.
CREATE TRIGGER trPODetailINS
 ON Purchasing.PurchaseOrderDetail
 FOR INSERT AS
BEGIN
 UPDATE Purchasing.PurchaseOrderHeader
 SET SubTotal=SubTotal +
 (SELECT SUM(LineTotal) FROM inserted
 WHERE
PurchaseOrderHeader.PurchaseOrderID=inserted.PurchaseOrderID)
 WHERE PurchaseOrderHeader.PurchaseOrderID IN (SELECT PurchaseOrderID FROM
inserted)
END

El trigger dado funciona y su objetivo es ir actualizando el
total de las �rdenes de compra, a partir de los �tems que
se van dando de alta.