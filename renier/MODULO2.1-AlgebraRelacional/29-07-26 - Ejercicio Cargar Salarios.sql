USE hr;

DELIMITER $$

CREATE OR REPLACE PROCEDURE regionesCursoSalarios()
BEGIN
   DECLARE vFIN        BOOLEAN DEFAULT FALSE;
   DECLARE vRegionID   INT(11);
   DECLARE vRegionName VARCHAR(25);
   DECLARE vRegionSalario VARCHAR(25);
   DECLARE cRegiones CURSOR FOR /* SELECT * FROM hr.regions ORDER BY 2;*/
											SELECT  r.region_id
													,r.region_name
													,NVL(SUM(e.salary+(e.salary*NVL(e.commission_pct,0))),0) AS salariototal
											FROM hr.regions r
											LEFT join countries c ON r.region_id = c.region_id
											left JOIN hr.locations l ON c.country_id = l.country_id
											left JOIN  hr.departments d ON d.location_id = l.location_id
											left JOIN hr.employees e ON d.department_id = e.department_id
											GROUP BY r.region_id;

   DECLARE CONTINUE HANDLER FOR NOT FOUND SET vFin = TRUE;
   
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
		BEGIN
			GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, 
			 @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;
			SET @full_error = CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text);
			SELECT @full_error;
		END;
	CALL datamartsalario.crearBDdatamartsalario();
   OPEN cRegiones;
   FETCH cRegiones INTO vRegionID, vRegionName,vRegionSalario;
   WHILE (NOT vFin) DO
		SELECT CONCAT(vRegionName, ' -Salario Region:- ',vRegionSalario);
      INSERT INTO datamartsalario.region VALUES(vRegionID, vRegionName,vRegionSalario);
      -- Procesar los países
      BEGIN
         DECLARE vFinPais  BOOLEAN DEFAULT FALSE;
         DECLARE vPaisID   CHAR(2);
         DECLARE vPaisName VARCHAR(40);
         DECLARE vPaisSalario DOUBLE(10,2);
         DECLARE cPais CURSOR FOR 
												/*
												SELECT country_id, country_name
												FROM hr.countries
												WHERE region_id=vRegionID
												ORDER BY 2;
												*/                       
												SELECT c.country_id
												, c.country_name
												, nvl(SUM(e.salary+(e.salary*NVL(e.commission_pct,0))),0) AS salariototal
												FROM hr.countries c
												left JOIN hr.locations l ON c.country_id = l.country_id
												left JOIN  hr.departments d ON d.location_id = l.location_id
												left JOIN hr.employees e ON d.department_id = e.department_id
												WHERE region_id=vRegionID
												GROUP BY c.country_id;
                                  
         DECLARE CONTINUE HANDLER FOR NOT FOUND SET vFinPais = TRUE;
         OPEN cPais;
         FETCH cPais INTO vPaisID, vPaisName,vPaisSalario;
         WHILE (NOT vFinPais) DO
            SELECT CONCAT('   ',vPaisName,' -Salario Pais:- ',vPaisSalario);
            INSERT INTO datamartsalario.pais VALUES(vPaisID, vPaisName,vPaisSalario,vRegionID);
            -- Procesar las localizaciones
            BEGIN
               DECLARE vFinLoca  BOOLEAN DEFAULT FALSE;
               DECLARE vLocaID   INT(11);
               DECLARE vLocaName VARCHAR(120);
               DECLARE vLocaSalario DOUBLE(10,2);
               DECLARE cLoca CURSOR FOR 
													/*
													SELECT location_id
                                             , CONCAT(street_address           ,', '
                                                     ,NVL(postal_code,'--')    ,', '
                                                     ,city                     ,', '
                                                     ,NVL(state_province,'--'))
                                        FROM hr.locations
                                        WHERE country_id=vPaisID
                                        ORDER BY 2;
                                        */
                                        
                                        SELECT l.location_id
															, CONCAT(street_address           ,', '
															        ,NVL(postal_code,'--')    ,', '
															        ,city                     ,', '
															        ,NVL(state_province,'--')) AS localizacion_name
															        ,NVL(SUM(e.salary+(e.salary*NVL(e.commission_pct,0))),0) AS salariototal
															FROM hr.locations l
															LEFT JOIN  hr.departments d ON d.location_id = l.location_id
															LEFT JOIN hr.employees e ON d.department_id = e.department_id
															WHERE country_id=vPaisID
															GROUP BY l.location_id;
               DECLARE CONTINUE HANDLER FOR NOT FOUND SET vFinLoca = TRUE;
               OPEN cLoca;
               FETCH cLoca INTO vLocaID, vLocaName,vLocaSalario;
               WHILE (NOT vFinLoca) DO
                 	SELECT CONCAT('   ','   ',vLocaName,' -Salario Loc:- ', vLocaSalario);
                  INSERT INTO datamartsalario.localizacion VALUES(vLocaID, vLocaName,vLocaSalario,vPaisID);
                  -- Procesar los departamentos
                  BEGIN
                     DECLARE vFinDept  BOOLEAN DEFAULT FALSE;
                     DECLARE vDeptID   INT(11);
                     DECLARE vDeptName VARCHAR(120);
                     DECLARE vDetpSalario DOUBLE(10,2);
                     DECLARE vDetpCantEmp INT;
                     DECLARE cDept CURSOR FOR 
															/*
															SELECT department_id
                                                   , department_name
                                              FROM hr.departments
                                              WHERE location_id=vLocaID
                                              ORDER BY 2;
                                              */
                                             SELECT department_id
															, department_name
															,NVL(SUM(e.salary+(e.salary*NVL(e.commission_pct,0))),0) AS salariototal 
															,COUNT(e.employee_id) AS cantEmpleado
															from hr.departments 
															LEFT join hr.employees e USING (department_id)
															WHERE location_id=vLocaID
															GROUP BY department_id
                                             ORDER BY 2;
                     DECLARE CONTINUE HANDLER FOR NOT FOUND SET vFinDept = TRUE;
                     OPEN cDept;
                     FETCH cDept INTO vDeptID, vDeptName,vDetpSalario,vDetpCantEmp;
                     WHILE (NOT vFinDept) DO
                        SELECT CONCAT('   ','   ','   ',vDeptName,' -Salario Dept: - ',vDetpSalario, ' - Cant Emp: -',vDetpCantEmp);
		                  INSERT INTO datamartsalario.departamento VALUES(vDeptID, vDeptName,vDetpSalario,vLocaID,vDetpCantEmp);
                        -- Procesar los empleados
                        BEGIN
                           DECLARE vFinEmp  BOOLEAN DEFAULT FALSE;
                           DECLARE vEmpID   INT(11);
                           DECLARE vEmpName VARCHAR(120);
                           DECLARE vSalario DOUBLE(8,2);
                           DECLARE vEmpDeptName VARCHAR(120);
                           DECLARE cEmp CURSOR FOR SELECT employee_id
																	, CONCAT(last_name,', ',first_name)
																	, nvl(e.salary+(e.salary*NVL(e.commission_pct,0)),e.salary)
																	, d.department_name
																	FROM hr.employees e
																	LEFT JOIN hr.departments d ON e.department_id = d.department_id
																	WHERE d.department_id=vDeptID
																	ORDER BY 2;
                           DECLARE CONTINUE HANDLER FOR NOT FOUND SET vFinEmp = TRUE;
                           OPEN cEmp;
                           FETCH cEmp INTO vEmpID, vEmpName,vSalario,vEmpDeptName;
                           WHILE (NOT vFinEmp) DO
                              SELECT CONCAT('   ','   ','   ','   ',vEmpName,' -Salario: - ',vSalario);
                              INSERT INTO datamartsalario.empleado VALUES(vEmpID, vEmpName,vSalario,vDeptID,vEmpDeptName);
                              -- Fin
                              FETCH cEmp INTO vEmpID, vEmpName,vSalario,vEmpDeptName;
                           END WHILE;
                           CLOSE cEmp;                        
                        END;
                        FETCH cDept INTO vDeptID, vDeptName,vDetpSalario,vDetpCantEmp;
                     END WHILE;
                     CLOSE cDept;        
                  END;
                  FETCH cLoca INTO vLocaID, vLocaName,vLocaSalario;
               END WHILE;
               CLOSE cLoca;
            END;
            FETCH cPais INTO vPaisID, vPaisName,vPaisSalario;
         END WHILE;
         CLOSE cPais;
      END;
      FETCH cRegiones INTO vRegionID, vRegionName,vRegionSalario;
   END WHILE;
   CLOSE cRegiones;
END $$

DELIMITER ;

CALL hr.regionesCursoSalarios();

/*
SELECT COUNT(*) FROM employees e WHERE e.department_id = 50;

SELECT * FROM hr.departments;

SELECT employee_id
, CONCAT(last_name,', ',first_name)
, nvl(e.salary+(e.salary*NVL(e.commission_pct,0)),e.salary)
, d.department_name
FROM hr.employees e
LEFT JOIN hr.departments d ON e.department_id = d.department_id
-- WHERE department_id=vDeptID
ORDER BY 2;


SELECT department_id
, department_name
,NVL(SUM(e.salary+(e.salary*NVL(e.commission_pct,0))),0) AS salariototal 
,COUNT(e.employee_id) AS cantEmpleado
from hr.departments 
LEFT join hr.employees e USING (department_id)
-- WHERE location_id=vLocaID
GROUP BY department_id
ORDER BY 2;

*/
/*
SELECT department_id
, department_name
,NVL(SUM(e.salary+(e.salary * NVL(e.commission_pct,0))),0) AS salariototal 
from hr.departments 
LEFT join hr.employees e USING (department_id)
-- WHERE location_id=vLocaID
GROUP BY department_id
ORDER BY 2;
*/
/*

use hr;

SELECT * from countries;
SELECT * FROM locations;
SELECT * FROM departments;
select * from hr.employees;


SELECT  r.region_id
			,r.region_name
			,SUM(e.salary) AS salariototal
FROM hr.regions r
LEFT join countries c ON r.region_id = c.region_id
left JOIN hr.locations l ON c.country_id = l.country_id
left JOIN  hr.departments d ON d.location_id = l.location_id
left JOIN hr.employees e ON d.department_id = e.department_id

GROUP BY r.region_id;
ORDER BY 2;


SELECT c.country_id
, c.country_name
, nvl(e.salary,0) AS salariototal
FROM hr.countries c
left JOIN hr.locations l ON c.country_id = l.country_id
left JOIN  hr.departments d ON d.location_id = l.location_id
left JOIN hr.employees e ON d.department_id = e.department_id

GROUP BY c.country_id
-- WHERE region_id=vRegionID
ORDER BY 2;

SELECT l.location_id
, CONCAT(street_address           ,', '
        ,NVL(postal_code,'--')    ,', '
        ,city                     ,', '
        ,NVL(state_province,'--')) AS localizacion_name
        ,SUM(e.salary) AS salariototal
FROM hr.locations l
INNER JOIN  hr.departments d ON d.location_id = l.location_id
INNER JOIN hr.employees e ON d.department_id = e.department_id
GROUP BY l.location_id

;

*/

/*
select * from employees;

select department_id, department_name, location_id,SUM(employees.salary) AS salariototal  
from departments inner join employees USING (department_id) GROUP BY department_id;

SELECT e.salary,
		nvl(e.salary+(salary*e.commission_pct),e.salary) AS total 
FROM employees e;
*/