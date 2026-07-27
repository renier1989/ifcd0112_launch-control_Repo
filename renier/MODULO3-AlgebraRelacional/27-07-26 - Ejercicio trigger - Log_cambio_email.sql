
CREATE OR REPLACE TABLE log_cambios_email(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY  ,
	id_alumno INT UNSIGNED NOT NULL,
	fecha_hora DATETIME NOT NULL,
	old_email VARCHAR(100) NOT NULL,
	new_email VARCHAR(100) NOT NULL
);

DELIMITER $$
CREATE OR REPLACE TRIGGER trigger_guardar_email_after_update
BEFORE UPDATE
ON alumnos FOR EACH ROW 
BEGIN 
	
	INSERT INTO log_cambios_email VALUES (NULL, OLD.id, NOW(), OLD.email, NEW.email);
	
END 
$$



SELECT * FROM alumnos;
SELECT * FROM log_cambios_email;