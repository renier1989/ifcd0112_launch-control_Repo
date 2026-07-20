DELIMITER $$
CREATE OR REPLACE FUNCTION calcular_factorial_while
(
    valor INT  
)
RETURNS INT  
DETERMINISTIC
BEGIN
    DECLARE contador INT DEFAULT valor;
    DECLARE resultado INT DEFAULT 1;
    
    CASE valor
    	WHEN valor < 0 THEN RETURN -1;
    	WHEN valor = 0 THEN RETURN  1;
    	ELSE 
   	bucle: WHILE contador > 1 do
            SET resultado = resultado * contador;
            SET contador = contador - 1;
        END WHILE bucle;
        RETURN resultado;
    END CASE; 
END $$


SELECT calcular_factorial_while(13) AS "factorial";
