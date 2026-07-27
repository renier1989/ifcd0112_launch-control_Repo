DROP DATABASE if EXISTS test ;

CREATE DATABASE test;
USE test;

DROP TABLE if EXISTS alumnos;

CREATE OR REPLACE TABLE alumnos (
	id 	 				INT UNSIGNED PRIMARY KEY ,
	nombre 				VARCHAR(50) NOT null,
	apellido1			VARCHAR(50) NOT NULL ,
	apellido2			VARCHAR(50),
	fecha_nacimiento 	DATE NOT NULL 
);

DELETE from alumnos;

INSERT INTO alumnos
VALUES 
(1,'nombre 1','apellido 1',NULL,'1989-01-01'),
(2,'nombre 2','apellido 2','apellido22','1989-01-02'),
(3,'nombre 3','apellido 3',NULL,'1989-01-03'),
(4,'nombre 4','apellido 4',NULL,'1989-01-04');

ALTER TABLE alumnos 
ADD COLUMN edad INT GENERATED ALWAYS AS (TIMESTAMPDIFF(YEAR, fecha_nacimiento, CURDATE())) VIRTUAL;

SELECT  * FROM alumnos;


-- funcion 

DELIMITER $$
CREATE OR REPLACE FUNCTION calcular_edad(
 pFecNac DATE 
)
RETURNS INT
BEGIN
	
		RETURN TIMESTAMPDIFF(YEAR, pFecNac, NOW());

END
$$

-- procedimiento
DELIMITER $$
CREATE OR REPLACE PROCEDURE actualizar_columna_edad ()
BEGIN
		
	UPDATE alumnos SET edad = calcular_edad(fecha_nacimiento); 
	
END 
$$


CALL actualizar_columna_edad();
SELECT * FROM alumnos ;