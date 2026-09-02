DELIMITER $$
CREATE OR REPLACE FUNCTION getNCustomers(
idTerr INT 
)
RETURNS INT
BEGIN

	DECLARE cantCus INT;
	SELECT COUNT(DISTINCT c.CustomerID) 
	FROM customers c
	right JOIN orders o ON c.CustomerID = o.CustomerID
	right JOIN employees e ON e.EmployeeID = o.EmployeeID
	right JOIN employeeterritories et ON et.EmployeeID = e.EmployeeID
	WHERE et.TerritoryID = idTerr
 	INTO cantCus;
 	
 	RETURN cantCus;
		
END 
$$

SELECT getNCustomers(02139);

/*
SELECT et.TerritoryID,count(DISTINCT c.CustomerID) 
FROM customers c
right JOIN orders o ON c.CustomerID = o.CustomerID
right JOIN employees e ON e.EmployeeID = o.EmployeeID
right JOIN employeeterritories et ON et.EmployeeID = e.EmployeeID
GROUP BY et.TerritoryID;
*/
