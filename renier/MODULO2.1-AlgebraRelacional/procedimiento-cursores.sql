DELIMITER $$
CREATE OR REPLACE PROCEDURE listar_departamentos()
BEGIN 
	DECLARE done INT DEFAULT FALSE;
	-- departamento -- 
	DECLARE idDep INT;
	DECLARE nameDep VARCHAR(50); 
	-- salida --
	DECLARE resultado LONGTEXT
	DEFAULT CHAR(10);
	-- cursores -- 
	DECLARE cur_dep CURSOR FOR SELECT d.department_id, d.department_name FROM departments d;
	-- manejador -- 
	DECLARE CONTINUE handler FOR NOT FOUND SET done = TRUE;
	OPEN cur_dep;
		exe_loop : LOOP
			fetch cur_dep INTO idDep,nameDep;
			if done then
				leave exe_loop ;
			END if;
			SET resultado = CONCAT(resultado, 'Dep: ', CHAR(9), nameDep, CHAR(9),' ID: ',idDep,CHAR(10));
			SET resultado = CONCAT(resultado, listar_empleados(idDep) , CHAR(10));
		END LOOP;
	CLOSE cur_dep;	
	SELECT resultado;

END 
$$


/*
CALL listar_departamentos();
SELECT * from dep_temp;

SELECT d.department_id AS "idDep", d.department_name AS "nameDep", 
FROM employees e
INNER JOIN departments d USING (d.department_id);
;


*/