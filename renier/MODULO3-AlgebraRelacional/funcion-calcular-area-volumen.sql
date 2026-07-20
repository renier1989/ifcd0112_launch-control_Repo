DELIMITER $$
CREATE OR REPLACE FUNCTION calcular_area_circulo(
	IN radio DOUBLE
)
RETURNS DOUBLE 
DETERMINISTIC
BEGIN
	if radio > 0
		then RETURN PI() * POW(radio , 2);
		else
			RETURN -1;
        -- SIGNAL SQLSTATE '45000' 
        -- SET MESSAGE_TEXT = 'Error: EL RADIO DEBE SER MAYOR A 0';
	END if;
END
$$

CREATE OR REPLACE FUNCTION calcular_volumen_cilindro(
IN	radio DOUBLE ,
IN altura DOUBLE 
)
RETURNS DOUBLE 
BEGIN
	
	if radio > 0 AND altura > 0 
	then RETURN calcular_area_circulo(radio) * altura;
	ELSE 
	RETURN -1;
	--   SIGNAL SQLSTATE '45000' 
     -- SET MESSAGE_TEXT = 'Error: AMBOS PARAMETROS DEBEN SER POSITIVOS';		   
   END if;

END
$$

/*
SELECT calcular_area_circulo(-2) AS "Area_Circulo";
SELECT calcular_volumen_cilindro(2,2) AS "Volumen_cilindro";
*/