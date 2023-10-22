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

4. Mostrar la cantidad de personas de la Base de datos, e indicar si es inquilino o due�o.
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