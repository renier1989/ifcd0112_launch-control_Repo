DELIMITER $$
CREATE OR REPLACE FUNCTION getCantEmpleados(
idTerr INT	
)
RETURNS INT
BEGIN

	DECLARE cantEmp INT;

		SELECT COUNT(e.EmployeeID) total_empleados
		FROM employees e 
		right JOIN employeeterritories et USING(EmployeeID)
		right  JOIN territories t USING(TerritoryID)
		right JOIN region r USING(RegionID)
		WHERE t.TerritoryID = idTerr
		GROUP BY t.TerritoryID
		INTO cantEmp;
	
	RETURN cantEmp;
END  
$$

SELECT getCantEmpleados(29202);



