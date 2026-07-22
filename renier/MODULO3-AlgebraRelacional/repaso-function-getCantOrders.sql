DELIMITER $$
CREATE OR REPLACE FUNCTION getCantOrders(
idTerr INT 
)
RETURNS INT 
BEGIN 
	DECLARE cantOrder INT;
	SELECT count(*) FROM orders o 
	left JOIN employees e ON e.EmployeeID = o.EmployeeID
	left JOIN employeeterritories et ON et.EmployeeID = e.EmployeeID
	WHERE et.TerritoryID = idTerr
	INTO cantOrder
	;	
	
	RETURN cantOrder;
END 
$$


SELECT getCantOrders(06897);
/*
	SELECT et.TerritoryID,COUNT(*) FROM orders o 
	left JOIN employees e ON e.EmployeeID = o.EmployeeID
	left JOIN employeeterritories et ON et.EmployeeID = e.EmployeeID
	GROUP BY et.TerritoryID;
*/