DELIMITER $$
CREATE OR REPLACE PROCEDURE regiones()
-- seccion para llamar a las regiones
BEGIN 
	DECLARE vRegionId INT;
	DECLARE vRegionName VARCHAR(100);
	DECLARE doneRegion BOOLEAN DEFAULT FALSE;
	DECLARE cRegion CURSOR FOR SELECT r.region_id, r.region_name FROM regions AS r;
	DECLARE CONTINUE handler FOR NOT FOUND SET doneRegion = TRUE;
	
	OPEN cRegion;
	
	fetch cRegion INTO vRegionId , vRegionName;
	while (NOT doneRegion) DO 
		SELECT vRegionName;
		
		-- seccion para llamas los paises de las regiones
		BEGIN 
			DECLARE vPaisId CHAR(2);
			DECLARE vPaisName VARCHAR(100);
			DECLARE vPaisRId INT;
			DECLARE donePais BOOLEAN DEFAULT FALSE;
			DECLARE cPais CURSOR FOR SELECT c.country_id, country_name, c.region_id FROM countries AS c WHERE c.region_id = vRegionId;
			DECLARE CONTINUE handler FOR NOT FOUND SET donePais = TRUE;
			
			OPEN cPais;
				fetch cPais INTO vPaisId , vPaisName, vPaisRId;
				while (NOT donePais) DO 
					SELECT CONCAT('      ', vPaisName);
					-- seccion para llamar a las locaciones del pais
					BEGIN 
						DECLARE vLocationId INT;
						DECLARE vLocationAddress VARCHAR(100);
						DECLARE vLocationPostalCode VARCHAR(100);
						DECLARE vLocationCity VARCHAR(100);
						DECLARE vLocationProvince VARCHAR(100);
						DECLARE vLocationCId CHAR(2);
						DECLARE doneLocation BOOLEAN DEFAULT FALSE;
						DECLARE cLocation CURSOR FOR SELECT l.location_id, l.street_address, l.postal_code, l.city, l.state_province, l.country_id 
																FROM locations AS l 
																WHERE l.country_id = vPaisId;
						DECLARE CONTINUE handler FOR NOT FOUND SET doneLocation = TRUE;
						
						OPEN cLocation;
						fetch cLocation INTO vLocationId,vLocationAddress, vLocationPostalCode , vLocationCity, vLocationProvince, vLocationCId;
							while (NOT doneLocation) DO 
							
							SELECT CONCAT('   ','   ','   ', NVL(vLocationAddress,' '),' ',NVL(vLocationPostalCode,' '),' ',NVL(vLocationCity,' '),' ', NVL(vLocationProvince,''));
							
							fetch cLocation INTO vLocationId,vLocationAddress, vLocationPostalCode , vLocationCity, vLocationProvince, vLocationCId;
							END while;
						close cLocation;
								
					END;
					-- fin de seccion para llamar a las locaciones del pais
					fetch cPais INTO vPaisId , vPaisName, vPaisRId;
				END while;
			close cPais;
		END; 
		-- fin de seccion para llamas los paises de las regiones
		fetch cRegion INTO vRegionId , vRegionName;
	END while;
	close cRegion;
END 
-- fin de seccion para llamar las regiones
$$


-- CALL regiones();


/*
SELECT * FROM regions ;
SELECT * FROM countries;
SELECT * FROM locations;
*/

-- SELECT * FROM countries WHERE region_id = 1;




