DELIMITER $$
CREATE OR REPLACE FUNCTION listar_empleados(
idDep  INT
)
RETURNS VARCHAR(10000)
BEGIN 
	DECLARE done int DEFAULT FALSE;
	DECLARE idEmp INT ;
	DECLARE nameEmp, apellEmp VARCHAR (100);
	DECLARE salida VARCHAR(1000) DEFAULT '';	
	DECLARE cur_emp CURSOR FOR SELECT e.employee_id, e.first_name, e.last_name FROM employees e WHERE e.department_id = idDep;
	DECLARE CONTINUE handler FOR NOT FOUND SET done = TRUE;
	
	OPEN cur_emp;
	fetch	cur_emp INTO idEmp, nameEmp, apellEmp;
	while (NOT done) DO 
	SET salida = CONCAT(salida,CHAR(9) ,idEmp, ' - ', nameEmp , ' ' ,apellEmp, CHAR(10));
	fetch	cur_emp INTO idEmp, nameEmp, apellEmp;	
	END while;
	close cur_emp;
	if salida = '' 
		then SET salida = CONCAT(CHAR(9), 'SIN EMPLEADOS',CHAR(10)); 
		ELSE SET salida = CONCAT(salida,CHAR(9),'Salario Total : ', salario_total(idDep),CHAR(10));
	end if;
	RETURN salida;
	
END 
$$

/*
SELECT listar_empleados(10);
SELECT * FROM employees d WHERE d.department_id = 10;
SELECT * FROM departments 
*/