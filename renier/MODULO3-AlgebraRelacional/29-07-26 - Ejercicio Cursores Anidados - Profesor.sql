DELIMITER $$

CREATE OR REPLACE PROCEDURE regionesCurso()
BEGIN
   DECLARE vFIN        BOOLEAN DEFAULT FALSE;
   DECLARE vRegionID   INT(11);
   DECLARE vRegionName VARCHAR(25);
   DECLARE cRegiones CURSOR FOR SELECT * FROM regions ORDER BY 2;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET vFin = TRUE;
   OPEN cRegiones;
   FETCH cRegiones INTO vRegionID, vRegionName;
   WHILE (NOT vFin) DO
      SELECT vRegionName;
      -- Procesar los países
      BEGIN
         DECLARE vFinPais  BOOLEAN DEFAULT FALSE;
         DECLARE vPaisID   CHAR(2);
         DECLARE vPaisName VARCHAR(40);
         DECLARE cPais CURSOR FOR SELECT country_id, country_name
                                  FROM countries
                                  WHERE region_id=vRegionID
                                  ORDER BY 2;
         DECLARE CONTINUE HANDLER FOR NOT FOUND SET vFinPais = TRUE;
         OPEN cPais;
         FETCH cPais INTO vPaisID, vPaisName;
         WHILE (NOT vFinPais) DO
            SELECT CONCAT('   ',vPaisName);
            -- Procesar las localizaciones
            BEGIN
               DECLARE vFinLoca  BOOLEAN DEFAULT FALSE;
               DECLARE vLocaID   INT(11);
               DECLARE vLocaName VARCHAR(120);
               DECLARE cLoca CURSOR FOR SELECT location_id
                                             , CONCAT(street_address           ,', '
                                                     ,NVL(postal_code,'--')    ,', '
                                                     ,city                     ,', '
                                                     ,NVL(state_province,'--'))
                                        FROM Locations
                                        WHERE country_id=vPaisID
                                        ORDER BY 2;
               DECLARE CONTINUE HANDLER FOR NOT FOUND SET vFinLoca = TRUE;
               OPEN cLoca;
               FETCH cLoca INTO vLocaID, vLocaName;
               WHILE (NOT vFinLoca) DO
                  SELECT CONCAT('   ','   ',vLocaName);
                  -- Procesar los departamentos
                  BEGIN
                     DECLARE vFinDept  BOOLEAN DEFAULT FALSE;
                     DECLARE vDeptID   INT(11);
                     DECLARE vDeptName VARCHAR(120);
                     DECLARE cDept CURSOR FOR SELECT department_id
                                                   , department_name
                                              FROM departments
                                              WHERE location_id=vLocaID
                                              ORDER BY 2;
                     DECLARE CONTINUE HANDLER FOR NOT FOUND SET vFinDept = TRUE;
                     OPEN cDept;
                     FETCH cDept INTO vDeptID, vDeptName;
                     WHILE (NOT vFinDept) DO
                        SELECT CONCAT('   ','   ','   ',vDeptName);
                        -- Procesar los empleados
                        BEGIN
                           DECLARE vFinEmp  BOOLEAN DEFAULT FALSE;
                           DECLARE vEmpID   INT(11);
                           DECLARE vEmpName VARCHAR(120);
                           DECLARE cEmp CURSOR FOR SELECT employee_id
                                                        , CONCAT(last_name,', ',first_name)
                                                   FROM employees
                                                   WHERE department_id=vDeptID
                                                   ORDER BY 2;
                           DECLARE CONTINUE HANDLER FOR NOT FOUND SET vFinEmp = TRUE;
                           OPEN cEmp;
                           FETCH cEmp INTO vEmpID, vEmpName;
                           WHILE (NOT vFinEmp) DO
                              SELECT CONCAT('   ','   ','   ','   ',vEmpName);
                              -- Fin
                              FETCH cEmp INTO vEmpID, vEmpName;
                           END WHILE;
                           CLOSE cEmp;                        
                        END;
                        FETCH cDept INTO vDeptID, vDeptName;
                     END WHILE;
                     CLOSE cDept;        
                  END;
                  FETCH cLoca INTO vLocaID, vLocaName;
               END WHILE;
               CLOSE cLoca;
            END;
            FETCH cPais INTO vPaisID, vPaisName;
         END WHILE;
         CLOSE cPais;
      END;
      FETCH cRegiones INTO vRegionID, vRegionName;
   END WHILE;
   CLOSE cRegiones;
END $$

DELIMITER ;

CALL regionesCurso();