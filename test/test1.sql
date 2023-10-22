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
- Dueño
	- DNI
	- NOMBRE
	- APELLIDO
- Casa
	- ID
	- DNI_DUEÑO
	- BARRIO
	- CALLE
	- CANT_HABITACIONES
	- CANT_PATIOS

1. Mostrar los datos de los dueños de la casa ubicada en Colon 714 en el barrio Centro

SELECT
	d.DNI,
	d.NOMBRE,
	d.APELLIDO
FROM Dueño d
JOIN Casa c on d.DNI =	c.DNI_DUEÑO
WHERE c.CALLE = 'Colon 714'
AND c.BARRIO = 'Centro'

2. ¿Cuanta plata en total le deben a cada dueño del barrio alberdi?

SELECT
	d.DNI AS DNI_DUEÑO, 
	d.NOMBRE, 
	d.APELLIDO,
	SUM(co.DEUDA) as TotalDeuda
FROM Contrato as co
INNER JOIN Casa ca on co.ID_CASA = ca.ID
INNER JOIN Dueño d on ca.ID = d.DNI
WHERE ca.Barrio = 'Alberdi'
GROUP BY d.DNI, d.NOMBRE, d.APELLIDO;

3. ¿Cuál es la deuda total de cada inquilino, mostrar los datos de los inquilinos?

SELECT
	i.DNI,
	i.Nombre,
	i.Apellido,
	SUM(co.DEUDA) as TotalDeuda
FROM Inquilino as i
INNER JOIN Contrato co on i.DNI = co.DNI_INQUILINO
GROUP BY i.DNI,i.Nombre,i.Apellido,;

4. Mostrar la cantidad de personas de la Base de datos, e indicar si es inquilino o dueño.SELECT	'Inquilinos' as Tipo,	COUNT(*) as CantidadFROM Contrato as coUNIONSELECT	'Dueños' as Tipo,	COUNT(*) as CantidadFROM Casa as ca5. Mostrar los datos de las personas que poseen más de 3 casas, con apellido “Gomez”.SELECT*FROM Dueño dJOIN Casa c on d.DNI = c.DNI_DUEÑOWHERE d.APELLIDO = 'Gomez'GROUP BY d.DNIHAVING COUNT(c.DNI_DUEÑO) > 36. Mostrar los datos de las personas que poseen más de 2 casas con más de 2 habitaciones.SELECT*FROM Dueño dJOIN Casa c on d.DNI = c.DNI_DUEÑOWHERE c.CANT_HABITACIONES > 2GROUP BY d.DNIHAVING COUNT(c.DNI_DUEÑO) > 27. Mostrar los datos de las inquilinos que alquilen más de 1 casa que con más de 1 habitación y sin patio.SELECT*FROM Inquilino iJOIN Contrato c ON i.DNI = c.DNI_INQUILINOJOIN Casa ca ON c.ID_CASA = ca.IDWHERE ca.CANT_HABITACIONES > 1AND ca.CANT_PATIOS = 0GROUP BY i.DNIHAVING COUNT(c.ID_CASA) > 18. Mostrar los datos de los dueños que tengan deudores en todas sus casas.SELECT	d.DNI,	d.NOMBRE,	d.APELLIDOFROM Dueño dWHERE NOT EXISTS (	SELECT		c.ID	FROM Casa c	LEFT JOIN Contrato co on c.ID = co.ID_CASA	WHERE c.DNI_DUEÑO = d.DNI	AND co.DEUDA > 0.00)9. Mostrar los datos y la cantidad de veces que se alquiló cada casa por año en los últimos 20 años.SELECT	c.ID CasaId,	year(con.FECHA_ALQUILER) Año,	COUNT(con.ID) CantidadAlquiladaFROM Contrato conINNER JOIN Casa c ON con.ID_CASA = c.IDWHERE year(con.FECHA_ALQUILER) BETWEEN YEAR(GETDATE()) >= YEAR(GETDATE())-20GROUP BY con.ID_CASA10. Calcular las siguientes estadísticas:a.    Cantidad de casas de cada dueño.SELECT 	d.NOMBRE + ' ' + d.APELLIDO Dueño	COUNT(c.ID) CantidadCasasFROM Dueño dINNER JOIN Casa c ON d.DNI = c.DNI_DUEÑOGROUP BY d.NOMBREb.   Dueño/s con más casas.SELECT 
	d.DNI, 
	d.Nombre,
	d.Apellido, 
	COUNT(CAS.ID) AS CantidadCasas
FROM Dueño AS d
LEFT JOIN Casa AS c ON d.DNI = c.DNI_DUEÑO
GROUP BY d.DNI, d.Nombre, d.Apellido
HAVING COUNT(c.ID) = (
    SELECT MAX(CantidadCasas)
    FROM (
        SELECT d.DNI, COUNT(c.ID) AS CantidadCasas
        FROM Dueño AS d
        LEFT JOIN Casa AS c ON d.DNI = c.DNI_DUEÑO
        GROUP BY d.DNI
    ) AS MaxCasas
)