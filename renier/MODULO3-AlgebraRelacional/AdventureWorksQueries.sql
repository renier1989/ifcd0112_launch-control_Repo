SELECT * from employee;
SELECT * FROM department;
SELECT * FROM employeedepartmenthistory;
SELECT * from shift ;

SET @searchTime := '23:00:00';

SELECT e.BusinessEntityID AS "ID Emp."
, e.Nombre AS "Nombre"
, e.Apellido1 AS "Ape. Paterno"
, e.Apellido2 AS "Ape. Materno"
, s.StartTime AS "Hora Inicio"
, s.EndTime AS "Hora Final"
, edh.StartDate AS "Fecha inicio"
, edh.EndDate AS "Fecha fin"
FROM employeedepartmenthistory edh
INNER JOIN employee e USING(BusinessEntityID)
INNER JOIN shift s USING(ShiftID)

WHERE (
		NOW() BETWEEN edh.StartDate AND edh.EndDate
		OR (edh.EndDate IS NULL AND edh.StartDate <= NOW())
)
AND   
	IF(s.StartTime <= s.EndTime, 
        @searchTime BETWEEN s.StartTime AND s.EndTime, 
        @searchTime >= s.StartTime OR @searchTime <= s.EndTime
    )
;

SELECT COUNT(e.BusinessEntityID) AS "Cant. Empleados", d.`Name` AS "Nombre Departamento"
FROM department d
LEFT JOIN employeedepartmenthistory edh USING(DepartmentID)
LEFT JOIN employee e USING(BusinessEntityID)
GROUP BY d.DepartmentID;

SELECT COUNT(e.BusinessEntityID) AS "Cant. Empleados", d.`Name` AS "Nombre Departamento"
FROM department d
LEFT JOIN employeedepartmenthistory edh USING(DepartmentID)
LEFT JOIN employee e USING(BusinessEntityID)
GROUP BY d.DepartmentID
HAVING COUNT(e.BusinessEntityID) > 1;

START TRANSACTION; 
UPDATE employeedepartmenthistory edh SET edh.DepartmentID = 1;

-- ROLLBACK;

SELECT CONCAT(e.Apellido1, ' ' , nvl(e.Apellido2,'') , ' , ', e.Nombre) AS "Nombre Empleado"
FROM department d
INNER  JOIN employeedepartmenthistory edh USING(DepartmentID)
inner JOIN employee e USING(BusinessEntityID)
WHERE d.`Name` LIKE '%a%';
