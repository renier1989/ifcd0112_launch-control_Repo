DELIMITER $$
CREATE OR REPLACE FUNCTION getTerritoryName(
idReg INT 
)
RETURNS VARCHAR(10000)
BEGIN 
		
	-- CONSTANTES --
	DECLARE titleTerr VARCHAR(16) DEFAULT 'TERRITORIO';
	DECLARE titleEmp  VARCHAR(16) DEFAULT 'N° EMPLEADOS';
	DECLARE widthNEmp INT DEFAULT LENGTH(titleEmp)-1;
	DECLARE titleOrd  VARCHAR(16) DEFAULT 'N° ORDENES';
	DECLARE widthNOrd INT DEFAULT LENGTH(titleOrd)-1;
	DECLARE titleCus  VARCHAR(16) DEFAULT 'N° CLIENTES';
	DECLARE widthNCus INT DEFAULT LENGTH(titleCus)-1;
	DECLARE done      INT DEFAULT FALSE;
	
	DECLARE terrId    INT ;
	DECLARE terrName  VARCHAR(150);
	DECLARE widthTerr INT;
	
	DECLARE result    VARCHAR (3000) DEFAULT '';
	DECLARE cur_ter   CURSOR FOR 
			SELECT t.TerritoryID, t.TerritoryDescription FROM territories t WHERE t.RegionID = idReg;
	DECLARE CONTINUE handler FOR NOT FOUND SET done = TRUE;
	
	--	asigno el valor del ancho mas largo de la descripcion de territorios a una variable
	SELECT MAX(LENGTH(TRIM(t.TerritoryDescription))) FROM territories t INTO widthTerr;
	
	OPEN cur_ter;
		fetch cur_ter INTO terrId, terrName;

		SET result = CONCAT(result,CHAR(9), RPAD(titleTerr,widthTerr),' '
													 , RPAD(titleEmp,widthNEmp),' '
 													 , RPAD(titleOrd,widthNOrd),' '
 													 , RPAD(titleCus,widthNCus)
													 , CHAR(10));
		SET result = CONCAT(result,CHAR(9), LPAD('',widthTerr,'-'),' '
													 , LPAD('',widthNEmp,'-'),' '
 													 , LPAD('',widthNOrd,'-'),' '
													 , LPAD('',widthNCus,'-')
													 ,CHAR(10));
		
		while (NOT done) DO 
			
			SET result = CONCAT(result,CHAR(9), RPAD(terrName,widthTerr),' '
														 , LPAD(getCantEmpleados(terrId),widthNEmp)
 														 , LPAD(getCantOrders(terrId),widthNOrd)
 														 , LPAD(getNCustomers(terrId),widthNCus)
														 , CHAR(10));		
			fetch cur_ter INTO terrId, terrName;
			
			
		END while;
	close cur_ter;
	RETURN result;
END 
$$

SELECT getTerritoryName(4);