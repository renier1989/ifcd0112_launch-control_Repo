DELIMITER $$

CREATE OR REPLACE FUNCTION numeros_romanos
(
    numero INT  
)
RETURNS VARCHAR(50)  
DETERMINISTIC
BEGIN
    DECLARE resultado VARCHAR(50) DEFAULT '';
    
    IF numero <= 0 OR numero >= 4000 THEN
        RETURN 'Fuera de Rango';
    END IF;

    WHILE numero > 0 DO
        IF numero >= 1000 THEN SET resultado = CONCAT(resultado, 'M'); SET numero = numero - 1000;
        ELSEIF numero >= 900 THEN SET resultado = CONCAT(resultado, 'CM'); SET numero = numero - 900;
        ELSEIF numero >= 500 THEN SET resultado = CONCAT(resultado, 'D');  SET numero = numero - 500;
        ELSEIF numero >= 400 THEN SET resultado = CONCAT(resultado, 'CD'); SET numero = numero - 400;
        ELSEIF numero >= 100 THEN SET resultado = CONCAT(resultado, 'C');  SET numero = numero - 100;
        ELSEIF numero >= 90  THEN SET resultado = CONCAT(resultado, 'XC'); SET numero = numero - 90;
        ELSEIF numero >= 50  THEN SET resultado = CONCAT(resultado, 'L');  SET numero = numero - 50;
        ELSEIF numero >= 40  THEN SET resultado = CONCAT(resultado, 'XL'); SET numero = numero - 40;
        ELSEIF numero >= 10  THEN SET resultado = CONCAT(resultado, 'X');  SET numero = numero - 10;
        ELSEIF numero >= 9   THEN SET resultado = CONCAT(resultado, 'IX'); SET numero = numero - 9;
        ELSEIF numero >= 5   THEN SET resultado = CONCAT(resultado, 'V');  SET numero = numero - 5;
        ELSEIF numero >= 4   THEN SET resultado = CONCAT(resultado, 'IV'); SET numero = numero - 4;
        ELSEIF numero >= 1   THEN SET resultado = CONCAT(resultado, 'I');  SET numero = numero - 1;
        END IF;
    END WHILE;

    RETURN resultado;
END $$

SELECT numeros_romanos(50); 