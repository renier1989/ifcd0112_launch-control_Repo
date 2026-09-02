DELIMITER $$

CREATE OR REPLACE FUNCTION numeros_romanos_millones
(
    numero BIGINT  
)
RETURNS VARCHAR(255) CHARACTER SET utf8mb4
DETERMINISTIC
BEGIN
    DECLARE resultado VARCHAR(255) DEFAULT '';
    
    IF numero <= 0 OR numero >= 4000000000 THEN
        RETURN 'Fuera de Rango';
    END IF;

    WHILE numero > 0 DO
        -- =======================================================
        -- MILLONES (Doble Barra: ) -> x 1.000.000
        -- =======================================================
        IF numero >= 1000000000 THEN SET resultado = CONCAT(resultado, 'M̄̄'); SET numero = numero - 1000000000;
        ELSEIF numero >= 900000000 THEN SET resultado = CONCAT(resultado, 'C̄̄M̄̄'); SET numero = numero - 900000000;
        ELSEIF numero >= 500000000 THEN SET resultado = CONCAT(resultado, 'D̄̄');  SET numero = numero - 500000000;
        ELSEIF numero >= 400000000 THEN SET resultado = CONCAT(resultado, 'C̄̄D̄̄'); SET numero = numero - 400000000;
        ELSEIF numero >= 100000000 THEN SET resultado = CONCAT(resultado, 'C̄̄');  SET numero = numero - 100000000;
        ELSEIF numero >= 90000000  THEN SET resultado = CONCAT(resultado, 'X̄̄C̄̄'); SET numero = numero - 90000000;
        ELSEIF numero >= 50000000  THEN SET resultado = CONCAT(resultado, 'L̄̄');  SET numero = numero - 50000000;
        ELSEIF numero >= 40000000  THEN SET resultado = CONCAT(resultado, 'X̄̄L̄̄'); SET numero = numero - 40000000;
        ELSEIF numero >= 10000000  THEN SET resultado = CONCAT(resultado, 'X̄̄');  SET numero = numero - 10000000;
        ELSEIF numero >= 9000000   THEN SET resultado = CONCAT(resultado, 'Ī̄X̄̄'); SET numero = numero - 9000000;
        ELSEIF numero >= 5000000   THEN SET resultado = CONCAT(resultado, 'V̄̄');  SET numero = numero - 5000000;
        ELSEIF numero >= 4000000   THEN SET resultado = CONCAT(resultado, 'Ī̄V̄̄'); SET numero = numero - 4000000;

        -- =======================================================
        -- MILES / MILLÓN 
        -- =======================================================
        ELSEIF numero >= 1000000 THEN SET resultado = CONCAT(resultado, 'M̄'); SET numero = numero - 1000000;
        ELSEIF numero >= 900000  THEN SET resultado = CONCAT(resultado, 'C̄M̄'); SET numero = numero - 900000;
        ELSEIF numero >= 500000  THEN SET resultado = CONCAT(resultado, 'D̄');  SET numero = numero - 500000;
        ELSEIF numero >= 400000  THEN SET resultado = CONCAT(resultado, 'C̄D̄'); SET numero = numero - 400000;
        ELSEIF numero >= 100000  THEN SET resultado = CONCAT(resultado, 'C̄');  SET numero = numero - 100000;
        ELSEIF numero >= 90000   THEN SET resultado = CONCAT(resultado, 'X̄C̄'); SET numero = numero - 90000;
        ELSEIF numero >= 50000   THEN SET resultado = CONCAT(resultado, 'L̄');  SET numero = numero - 50000;
        ELSEIF numero >= 40000   THEN SET resultado = CONCAT(resultado, 'X̄L̄'); SET numero = numero - 40000;
        ELSEIF numero >= 10000   THEN SET resultado = CONCAT(resultado, 'X̄');  SET numero = numero - 10000;
        ELSEIF numero >= 9000    THEN SET resultado = CONCAT(resultado, 'ĪX̄'); SET numero = numero - 9000;
        ELSEIF numero >= 5000    THEN SET resultado = CONCAT(resultado, 'V̄');  SET numero = numero - 5000;
        ELSEIF numero >= 4000    THEN SET resultado = CONCAT(resultado, 'ĪV̄'); SET numero = numero - 4000;

        -- =======================================================
        -- UNIDADES ESTÁNDAR
        -- =======================================================
        ELSEIF numero >= 1000 THEN SET resultado = CONCAT(resultado, 'M'); SET numero = numero - 1000;
        ELSEIF numero >= 900  THEN SET resultado = CONCAT(resultado, 'CM'); SET numero = numero - 900;
        ELSEIF numero >= 500  THEN SET resultado = CONCAT(resultado, 'D');  SET numero = numero - 500;
        ELSEIF numero >= 400  THEN SET resultado = CONCAT(resultado, 'CD'); SET numero = numero - 400;
        ELSEIF numero >= 100  THEN SET resultado = CONCAT(resultado, 'C');  SET numero = numero - 100;
        ELSEIF numero >= 90   THEN SET resultado = CONCAT(resultado, 'XC'); SET numero = numero - 90;
        ELSEIF numero >= 50   THEN SET resultado = CONCAT(resultado, 'L');  SET numero = numero - 50;
        ELSEIF numero >= 40   THEN SET resultado = CONCAT(resultado, 'XL'); SET numero = numero - 40;
        ELSEIF numero >= 10   THEN SET resultado = CONCAT(resultado, 'X');  SET numero = numero - 10;
        ELSEIF numero >= 9    THEN SET resultado = CONCAT(resultado, 'IX'); SET numero = numero - 9;
        ELSEIF numero >= 5    THEN SET resultado = CONCAT(resultado, 'V');  SET numero = numero - 5;
        ELSEIF numero >= 4    THEN SET resultado = CONCAT(resultado, 'IV'); SET numero = numero - 4;
        ELSEIF numero >= 1    THEN SET resultado = CONCAT(resultado, 'I');  SET numero = numero - 1;
        END IF;
    END WHILE;

    RETURN resultado;
END $$




SELECT numeros_romanos_millones(1000000000);