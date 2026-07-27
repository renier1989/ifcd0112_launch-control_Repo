-- DROP TABLE if EXISTS log_alumnos_eliminados;

CREATE OR REPLACE TABLE log_alumnos_eliminados(
 id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 id_alumno INT UNSIGNED NOT NULL,
 fecha_hora DATETIME NOT NULL DEFAULT NOW(),
 nombre VARCHAR(50) NOT NULL ,
 apellido1 VARCHAR(50) NOT NULL,
 apellido2 VARCHAR(50),
 email VARCHAR(100) NOT NULL

);



DELIMITER $$
CREATE OR REPLACE TRIGGER trigger_guardar_alumnos_eliminados
AFTER DELETE 
ON alumnos FOR EACH ROW 
BEGIN 
	
	INSERT INTO log_alumnos_eliminados
		VALUES (
			NULL, OLD.id, NOW(), OLD.nombre, OLD.apellido1, OLD.apellido2, OLD.email
		);

END 
$$

DELETE FROM alumnos WHERE id = 3;
SELECT * FROM alumnos;
SELECT * FROM log_cambios_email;
SELECT * FROM log_alumnos_eliminados;