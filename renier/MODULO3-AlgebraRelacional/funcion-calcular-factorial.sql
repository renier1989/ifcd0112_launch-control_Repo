DELIMITER $$
CREATE OR REPLACE FUNCTION calcular_factorial
(
    valor INT 
)
RETURNS INT 
DETERMINISTIC
BEGIN
    DECLARE contador INT DEFAULT valor;
    DECLARE resultado INT DEFAULT 1;

    IF valor < 0 THEN RETURN -1;
    ELSEIF valor = 0 THEN RETURN 1;
    ELSE
        bucle: LOOP
            IF contador <= 1 THEN 
                LEAVE bucle;
            END IF;
            SET resultado = resultado * contador;
            SET contador = contador - 1;
        END LOOP bucle;
        RETURN resultado;
    END IF;
END $$


SELECT calcular_factorial(5) AS "factorial";