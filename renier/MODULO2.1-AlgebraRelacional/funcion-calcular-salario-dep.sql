DELIMITER $$
CREATE OR REPLACE FUNCTION salario_total(
idDep  INT
)
RETURNS VARCHAR(100)
BEGIN 
	DECLARE salida VARCHAR(1000) DEFAULT '';	
	SELECT 
			CONCAT(LPAD(FORMAT(SUM(nvl(e.salary*(1+commission_pct),salary)),2),15,'.'),'$') AS "Salario Total"
			FROM employees e
			WHERE e.department_id = idDep
			INTO salida;
	RETURN salida;	
END 
$$

/*
SELECT listar_empleados(10);
SELECT * FROM employees d WHERE d.department_id = 10;
SELECT * FROM departments 
SELECT * FROM departments ;
SELECT * FROM employees;

SELECT SUM(e.salary) AS "TotalSalario"
			,nvl(SUM(e.salary) * e.commission_pct,0) AS totalcomision 
			, SUM(e.salary) + nvl((SUM(e.salary) * e.commission_pct),0) AS total
FROM employees e
WHERE e.department_id = 80;
*/

SELECT salario_total(10);
