-- solo ver el nombre de la region de la tabla regiones 
DELIMITER $$
CREATE OR REPLACE PROCEDURE show_regions()
BEGIN 
	DECLARE done INT DEFAULT FALSE;
	DECLARE regionId VARCHAR(50);
	DECLARE regionName VARCHAR(50);
	DECLARE result VARCHAR(10000) DEFAULT '';
	
	DECLARE cur_reg CURSOR FOR SELECT r.RegionId, r.regionDescription FROM region r;
	DECLARE CONTINUE handler FOR NOT FOUND SET done = TRUE;
	
	OPEN cur_reg;
		fetch cur_reg INTO regionId,regionName ;
		while (NOT done) DO 
			SET result = CONCAT(result ,'Region: ', regionName, CHAR(10));
			SET result = CONCAT(result , getTerritoryName(regionId),CHAR(10));
			fetch cur_reg INTO regionId,regionName ;
		END while;
		
	close cur_reg;
	
	SELECT result;

END 
$$


-- SELECT * FROM region
-- SELECT * FROM territories t WHERE t.RegionID = 3;
CALL show_regions();
