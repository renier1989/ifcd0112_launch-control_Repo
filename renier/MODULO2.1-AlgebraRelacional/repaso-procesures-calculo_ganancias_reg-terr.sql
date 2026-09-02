DELIMITER $$
CREATE OR REPLACE PROCEDURE calculateIncomes(
in idReg INT,
IN idTerr INT,
OUT sumReg FLOAT(10,2),
OUT sumTerr FLOAT(10,2)
)
BEGIN 

	-- Ganancias por territorio 
	SELECT nvl(sum(os.Subtotal),0) AS total_ganancia FROM orders o 
	left JOIN  order_subtotals os ON o.OrderID = os.OrderID
	left JOIN employees e ON e.EmployeeID = o.EmployeeID
	left JOIN employeeterritories et ON et.EmployeeID = e.EmployeeID
	left JOIN territories t ON t.TerritoryID = et.TerritoryID
	WHERE t.TerritoryID = idTerr
	GROUP BY t.TerritoryID
	INTO sumTerr;
	
	-- ganancias por region
	SELECT nvl(sum(os.Subtotal),0) AS total_ganancia FROM orders o 
	left JOIN  order_subtotals os ON o.OrderID = os.OrderID
	left JOIN employees e ON e.EmployeeID = o.EmployeeID
	left JOIN employeeterritories et ON et.EmployeeID = e.EmployeeID
	left JOIN territories t ON t.TerritoryID = et.TerritoryID
	LEFT join region r ON r.RegionID = t.RegionID
	WHERE r.RegionID = idReg
	GROUP BY r.RegionID
	INTO sumReg;


END
$$

CALL calculateIncomes(7,03801,@sumR, @sumT);
SELECT @sumR, @sumT;


-- Ganancias por territorio 
SELECT t.TerritoryID,t.TerritoryDescription, sum(os.Subtotal) AS total_ganancia FROM orders o 
left JOIN  order_subtotals os ON o.OrderID = os.OrderID
left JOIN employees e ON e.EmployeeID = o.EmployeeID
left JOIN employeeterritories et ON et.EmployeeID = e.EmployeeID
left JOIN territories t ON t.TerritoryID = et.TerritoryID
-- WHERE t.TerritoryID = 03801
GROUP BY t.TerritoryID;

-- ganancias por region
SELECT r.RegionID, sum(os.Subtotal) AS total_ganancia FROM orders o 
left JOIN  order_subtotals os ON o.OrderID = os.OrderID
left JOIN employees e ON e.EmployeeID = o.EmployeeID
left JOIN employeeterritories et ON et.EmployeeID = e.EmployeeID
left JOIN territories t ON t.TerritoryID = et.TerritoryID
LEFT join region r ON r.RegionID = t.RegionID
-- WHERE r.RegionID = 2
GROUP BY r.RegionID;




