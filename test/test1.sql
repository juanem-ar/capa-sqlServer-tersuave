/*
TABLAS:

- Inquilino
	- DNI
	- Nombre
	- Apellido
- Contrato
	- Id (PK)
	- DNI_INQUILINO
	- FECHA_ALQUILER
	- ID_CASA
	- DEUDA
	- MONTO_ALQUILER
- Due�o
	- DNI
	- NOMBRE
	- APELLIDO
- Casa
	- ID
	- DNI_DUE�O
	- BARRIO
	- CALLE
	- CANT_HABITACIONES
	- CANT_PATIOS

1. Mostrar los datos de los due�os de la casa ubicada en Colon 714 en el barrio Centro

SELECT
	d.DNI,
	d.NOMBRE,
	d.APELLIDO
FROM Due�o d
JOIN Casa c on d.DNI =	c.DNI_DUE�O
WHERE c.CALLE = 'Colon 714'
AND c.BARRIO = 'Centro'

2. �Cuanta plata en total le deben a cada due�o del barrio alberdi?

SELECT
	d.DNI AS DNI_DUE�O, 
	d.NOMBRE, 
	d.APELLIDO,
	SUM(co.DEUDA) as TotalDeuda
FROM Contrato as co
INNER JOIN Casa ca on co.ID_CASA = ca.ID
INNER JOIN Due�o d on ca.ID = d.DNI
WHERE ca.Barrio = 'Alberdi'
GROUP BY d.DNI, d.NOMBRE, d.APELLIDO;

3. �Cu�l es la deuda total de cada inquilino, mostrar los datos de los inquilinos?

SELECT
	i.DNI,
	i.Nombre,
	i.Apellido,
	SUM(co.DEUDA) as TotalDeuda
FROM Inquilino as i
INNER JOIN Contrato co on i.DNI = co.DNI_INQUILINO
GROUP BY i.DNI,i.Nombre,i.Apellido,;

4. Mostrar la cantidad de personas de la Base de datos, e indicar si es inquilino o due�o.SELECT	'Inquilinos' as Tipo,	COUNT(*) as CantidadFROM Contrato as coUNIONSELECT	'Due�os' as Tipo,	COUNT(*) as CantidadFROM Casa as ca5. Mostrar los datos de las personas que poseen m�s de 3 casas, con apellido �Gomez�.SELECT*FROM Due�o dJOIN Casa c on d.DNI = c.DNI_DUE�OWHERE d.APELLIDO = 'Gomez'GROUP BY d.DNIHAVING COUNT(c.DNI_DUE�O) > 36. Mostrar los datos de las personas que poseen m�s de 2 casas con m�s de 2 habitaciones.SELECT*FROM Due�o dJOIN Casa c on d.DNI = c.DNI_DUE�OWHERE c.CANT_HABITACIONES > 2GROUP BY d.DNIHAVING COUNT(c.DNI_DUE�O) > 27. Mostrar los datos de las inquilinos que alquilen m�s de 1 casa que con m�s de 1 habitaci�n y sin patio.SELECT*FROM Inquilino iJOIN Contrato c ON i.DNI = c.DNI_INQUILINOJOIN Casa ca ON c.ID_CASA = ca.IDWHERE ca.CANT_HABITACIONES > 1AND ca.CANT_PATIOS = 0GROUP BY i.DNIHAVING COUNT(c.ID_CASA) > 18. Mostrar los datos de los due�os que tengan deudores en todas sus casas.SELECT	d.DNI,	d.NOMBRE,	d.APELLIDOFROM Due�o dWHERE NOT EXISTS (	SELECT		c.ID	FROM Casa c	LEFT JOIN Contrato co on c.ID = co.ID_CASA	WHERE c.DNI_DUE�O = d.DNI	AND co.DEUDA > 0.00)9. Mostrar los datos y la cantidad de veces que se alquil� cada casa por a�o en los �ltimos 20 a�os.SELECT	c.ID CasaId,	year(con.FECHA_ALQUILER) A�o,	COUNT(con.ID) CantidadAlquiladaFROM Contrato conINNER JOIN Casa c ON con.ID_CASA = c.IDWHERE year(con.FECHA_ALQUILER) BETWEEN YEAR(GETDATE()) >= YEAR(GETDATE())-20GROUP BY con.ID_CASA10. Calcular las siguientes estad�sticas:a.    Cantidad de casas de cada due�o.SELECT 	d.NOMBRE + ' ' + d.APELLIDO Due�o	COUNT(c.ID) CantidadCasasFROM Due�o dINNER JOIN Casa c ON d.DNI = c.DNI_DUE�OGROUP BY d.NOMBREb.   Due�o/s con m�s casas.SELECT 
	d.DNI, 
	d.Nombre,
	d.Apellido, 
	COUNT(CAS.ID) AS CantidadCasas
FROM Due�o AS d
LEFT JOIN Casa AS c ON d.DNI = c.DNI_DUE�O
GROUP BY d.DNI, d.Nombre, d.Apellido
HAVING COUNT(c.ID) = (
    SELECT MAX(CantidadCasas)
    FROM (
        SELECT d.DNI, COUNT(c.ID) AS CantidadCasas
        FROM Due�o AS d
        LEFT JOIN Casa AS c ON d.DNI = c.DNI_DUE�O
        GROUP BY d.DNI
    ) AS MaxCasas
)