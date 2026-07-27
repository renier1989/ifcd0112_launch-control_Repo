ALTER TABLE alumnos
ADD COLUMN email VARCHAR(100),
add column dominio VARCHAR(100);


DELIMITER $$
CREATE OR REPLACE FUNCTION crear_email(
pNombre 	VARCHAR(50),
pApe1		VARCHAR(50),
pApe2 	VARCHAR(50),
pDominio	VARCHAR(50)
)
RETURNS VARCHAR(100)
BEGIN 
	DECLARE vEmail VARCHAR(100);
			
		SET vEmail = CONCAT(SUBSTRING(pNombre,1,1));
		SET vEmail = CONCAT(vEmail, SUBSTRING(pApe1,1,3));
		SET vEmail = CONCAT(vEmail, NVL(SUBSTRING(pApe2,1,3),''));
		SET vEmail = CONCAT(vEmail, '@',pDominio);

	RETURN LCASE(limpiar_acentos(vEmail));
END 
$$

UPDATE alumnos AS a SET email = crear_email(a.nombre, a.apellido1, a.apellido2, a.dominio);
SELECT * FROM alumnos;

SELECT crear_email('Renier','VÁrgas','Mejias','gamil.com');
