USE northwind2;

-- ################# parte 1 - creacion de tablas con procedimiento #################

DELIMITER $$
CREATE OR REPLACE PROCEDURE crearTablas()
BEGIN

DROP TABLE if EXISTS fact_resumen_territorio;
DROP TABLE if EXISTS dim_territorio;

CREATE TABLE dim_territorio(
	territorio_key INT AUTO_INCREMENT PRIMARY KEY,
	territoryID INT NOT NULL,
	territoryDecription VARCHAR(100) NOT NULL,
	regionID INT NOT NULL,
	regionDescription VARCHAR(100) NOT NULL
	);

CREATE TABLE fact_resumen_territorio(
	territorio_key INT NOT NULL, 
	num_empleados INT NOT NULL,
	num_pedidos INT NOT NULL,
	num_clientes INT NOT NULL,
	CONSTRAINT fk_fac_resumen_dim_terriorio FOREIGN KEY (territorio_key) REFERENCES dim_territorio(territorio_key)
);

END
$$



-- ################# parte 2 creacion de funciones #################

DELIMITER $$
CREATE OR REPLACE FUNCTION getEmpTerr(
	pTerrId INT
)
RETURNS INT
BEGIN
	
	DECLARE cantEmp INT DEFAULT 0;
	
	SELECT COUNT(et.EmployeeID) "Cant.Empleados x Territorio"
	FROM employeeterritories et 
	right JOIN territories t ON et.TerritoryID = t.TerritoryID
	WHERE t.TerritoryID = pTerrId
	GROUP BY et.TerritoryID
	INTO cantEmp;
	
	RETURN cantEmp;
	
END
$$


DELIMITER $$
CREATE OR REPLACE FUNCTION getPedidosEmp(
	pTerrId INT 
)
RETURNS INT
BEGIN 
	
	DECLARE cantPed INT DEFAULT 0;
	
	SELECT COUNT(o.OrderID) "Cant.Pedido Emp x Territorio"
	FROM orders o 
	RIGHT JOIN employees e ON o.EmployeeID = e.EmployeeID
	RIGHT JOIN employeeterritories et ON e.EmployeeID = et.EmployeeID
	RIGHT JOIN territories t ON et.TerritoryID = t.TerritoryID
	WHERE t.TerritoryID = pTerrId
	GROUP BY t.TerritoryID
	INTO cantPed;
	
	RETURN cantPed;

END 
$$


DELIMITER $$
CREATE OR REPLACE FUNCTION getClientePed(
	pTerrId INT
)
RETURNS INT
BEGIN 
	DECLARE cantCliPed INT DEFAULT 0;
	
	SELECT COUNT(DISTINCT c.CustomerID) 
	FROM customers c
	right JOIN orders o ON c.CustomerID = o.CustomerID
	right JOIN employees e ON e.EmployeeID = o.EmployeeID
	right JOIN employeeterritories et ON et.EmployeeID = e.EmployeeID
	WHERE et.TerritoryID = pTerrId
	INTO cantCliPed;
	
	RETURN cantCliPed;

END 
$$


-- ################# parte 3 cargar tabla dim_territorio #################

DELIMITER $$
CREATE OR REPLACE PROCEDURE cargarDim()
BEGIN 
	
	DECLARE vDone BOOLEAN DEFAULT FALSE;
	DECLARE vTerrId INT;
	DECLARE vTerrDesc VARCHAR(100);
	DECLARE vRegId INT;
	DECLARE vRegDesc VARCHAR(100);
	DECLARE cTerrReg CURSOR FOR 
										SELECT t.TerritoryID
										,t.TerritoryDescription
										,r.RegionID
										,r.RegionDescription
										from region r
										INNER JOIN territories t ON t.RegionID = r.RegionID;
	
	DECLARE CONTINUE handler FOR NOT FOUND SET vDone = TRUE;

	OPEN cTerrReg ;
		
   START TRANSACTION;
	fetch cTerrReg INTO vTerrId, vTerrDesc, vRegId, vRegDesc;
	while (NOT vDone) DO 
		INSERT INTO dim_territorio (territoryID,territoryDecription ,regionID ,regionDescription)
			VALUES (vTerrId, vTerrDesc, vRegId, vRegDesc);
		fetch cTerrReg INTO vTerrId, vTerrDesc, vRegId, vRegDesc;			
	END while;
 	COMMIT;
	close cTerrReg ;
END
$$

CALL cargarDim();

-- ################# parte 4 cargar la tabla fact #################

DELIMITER $$
CREATE OR REPLACE PROCEDURE cargarFact()
BEGIN
	DECLARE vDone BOOLEAN DEFAULT FALSE;
	DECLARE vTerrKey INT;
	DECLARE vTerrId INT;
	DECLARE vNumEmp INT;
	DECLARE vNumPed INT;
	DECLARE vNumCli INT;
	DECLARE cTerrFact CURSOR FOR SELECT dt.territorio_key, dt.territoryID FROM dim_territorio dt;
	DECLARE CONTINUE handler FOR NOT FOUND SET vDone = TRUE;
	
	OPEN cTerrFact;
	   START TRANSACTION;
		fetch cTerrFact INTO vTerrKey, vTerrId;
		while (NOT vDone) DO
			INSERT INTO fact_resumen_territorio 
				VALUES (vTerrKey, getEmpTerr(vTerrId),getPedidosEmp(vTerrId), getClientePed(vTerrId) );
				fetch cTerrFact INTO vTerrKey, vTerrId;
		END while;
		COMMIT;
	
	close cTerrFact;
END
$$


CALL cargarFact();
-- parte 5 añadir columna a empleados 

ALTER table employees 
ADD COLUMN orderManage INT;
























SELECT t.TerritoryID
,t.TerritoryDescription
,r.RegionID
,r.RegionDescription
from region r
INNER JOIN territories t ON t.RegionID = r.RegionID;

SELECT * FROM dim_territorio;




SELECT * FROM orders;
SELECT * FROM employees;
SELECT * FROM employeeterritories;
SELECT * FROM territories;

SELECT COUNT(et.EmployeeID) "Cant.Empleados x Territorio"
, t.TerritoryID 
, t.TerritoryDescription
FROM employeeterritories et 
right JOIN territories t ON et.TerritoryID = t.TerritoryID
 WHERE t.TerritoryID = 29202
GROUP BY et.TerritoryID;

SELECT COUNT(o.OrderID) "Cant.Pedido Emp x Territorio" 
, t.TerritoryDescription
, t.TerritoryID
FROM orders o 
RIGHT JOIN employees e ON o.EmployeeID = e.EmployeeID
RIGHT JOIN employeeterritories et ON e.EmployeeID = et.EmployeeID
RIGHT JOIN territories t ON et.TerritoryID = t.TerritoryID
WHERE t.TerritoryID = 29202
GROUP BY t.TerritoryID
ORDER BY 1;


	SELECT COUNT(DISTINCT c.CustomerID) 
	FROM customers c
	right JOIN orders o ON c.CustomerID = o.CustomerID
	right JOIN employees e ON e.EmployeeID = o.EmployeeID
	right JOIN employeeterritories et ON et.EmployeeID = e.EmployeeID
	WHERE et.TerritoryID = 02139