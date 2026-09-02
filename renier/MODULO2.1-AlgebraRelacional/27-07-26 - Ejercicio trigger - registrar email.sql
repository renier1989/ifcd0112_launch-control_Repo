DELIMITER $$
CREATE OR REPLACE TRIGGER trigger_crear_email_before_insert
BEFORE INSERT OR UPDATE 
ON alumnos FOR EACH ROW 
BEGIN 

	if NEW.email IS NULL then
		SET NEW.email = crear_email(new.nombre, new.apellido1, new.apellido2, new.dominio);
	END if;
	
END 
$$

SELECT * FROM alumnos;