DELIMITER $$
CREATE OR REPLACE FUNCTION calcular_factorial_repeat
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
	   	bucle: REPEAT 
            SET resultado = resultado * contador;
            SET contador = contador - 1;
            UNTIL contador = 0
	      END REPEAT bucle;  
	      RETURN resultado;
    END CASE;
    
END $$

-- SELECT calcular_factorial_repeat(5) AS "factorial";