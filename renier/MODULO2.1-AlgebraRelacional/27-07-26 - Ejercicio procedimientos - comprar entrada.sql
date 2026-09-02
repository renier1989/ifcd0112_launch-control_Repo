DELIMITER $$
CREATE OR REPLACE PROCEDURE comprar_entrada(
IN pNif VARCHAR(9),
IN pIdCuenta INT,
IN pIdButaca INT,
OUT `pError` BOOLEAN 
)
BEGIN
	DECLARE vEntradaPrecio DOUBLE DEFAULT 5;
	DECLARE vPrecio DOUBLE DEFAULT NULL;
	DECLARE exit handler FOR 1264, 1062 
		BEGIN 
			SET pError = 1;
			ROLLBACK;
		END ;
	

	DECLARE EXIT HANDLER FOR SQLEXCEPTION
		BEGIN
			GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, 
			 @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;
			SET @full_error = CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text);
			SELECT @full_error;
		END;
		
	SET pError = 0;
		
	START TRANSACTION;
		
		SELECT saldo - vEntradaPrecio FROM cuentas WHERE id_cuenta = pIdCuenta INTO vPrecio;
	
		if vPrecio IS NULL then
			SET pError = 1;
			SIGNAL SQLSTATE '45000'
		   SET MESSAGE_TEXT = 'Esta cuenta no Existe.';
		ELSEIF vPrecio <= 0 then
			SET pError = 1;
			SIGNAL SQLSTATE '45000'
		   SET MESSAGE_TEXT = 'Te has quedado sin saldo. Recarga tu cuenta, para comprar una entrada.';
		END if;
		
		UPDATE cuentas
			SET saldo = saldo - vEntradaPrecio
			WHERE id_cuenta = pIdCuenta;
			
		INSERT INTO entradas VALUES 
		 (pIdButaca, pNif);
	
	COMMIT;
	
	SELECT 'Compra finalizado.';
END 
$$


SELECT * FROM cuentas;
SELECT * FROM entradas;
CALL comprar_entrada('12345678X',11,1, @flg_error);
CALL comprar_entrada('12345678X',22,1, @flg_error);
SELECT @flg_error;
CALL comprar_entrada('12345678X',11,1, @flg_error); -- butaca no disponible
CALL comprar_entrada('12345678X',33,2, @flg_error);
CALL comprar_entrada('12345678X',31,2, @flg_error);
SELECT @flg_error;

CALL comprar_entrada('12345678Z',11,3, @flg_error);
SELECT @flg_error;