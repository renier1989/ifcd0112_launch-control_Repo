DELIMITER $$
CREATE OR REPLACE PROCEDURE numero(
IN pnum INT  
)
BEGIN 

	if pnum < 0 then 
		SET @msg = 'Numero Negativo';
	ELSEIF pnum > 0 then 
		SET @msg ='Numero Posito';
	ELSE  
		SET @msg = 'Numero es Cero';
	END if;
	
	SELECT @msg AS "Mensaje";

END 
$$

CALL numero(0);

-- --------------------

DELIMITER $$
CREATE OR REPLACE PROCEDURE numeroOut(
IN pnum INT  ,
OUT msg VARCHAR(20)
)
BEGIN 

	if pnum < 0 then 
		SET msg = 'Numero Negativo';
	ELSEIF pnum > 0 then 
		SET msg ='Numero Posito';
	ELSE  
		SET msg = 'Numero es Cero';
	END if;

END 
$$

CALL numeroOut(-3,@res);
SELECT @res AS "Mensaje";

-- ----------------------


DELIMITER $$
CREATE OR REPLACE PROCEDURE valorNota(
IN pNota DECIMAL(4,2)
)
BEGIN 
	
	case 
		when pNota >= 0 AND pNota < 5 then SET @msg = 'Insuficiente';
		when pNota >= 5 AND pNota < 6  then SET @msg = 'Aprobado';
		when pNota >= 6 AND pNota < 7 then SET @msg = 'Bien';
		when pNota >= 7 AND pNota < 9 then SET @msg = 'Notable';
		when pNota >= 9 AND pNota < 10  then SET @msg = 'Sobresaliente';
		
		ELSE SET @msg = 'Nota no válida';
	END case;
	
	SELECT @msg AS 'Valoracion';

END 
$$

CALL valorNota(6.5);


-- ----------------------


DELIMITER $$
CREATE OR REPLACE PROCEDURE valorNotaOut(
IN pNota DECIMAL(4,2),
OUT msg VARCHAR(20)
)
BEGIN 
	
	case 
		when pNota >= 0 AND pNota < 5 then set msg = 'Insuficiente';
		when pNota >= 5 AND pNota < 6  then set msg = 'Aprobado';
		when pNota >= 6 AND pNota < 7 then set msg = 'Bien';
		when pNota >= 7 AND pNota < 9 then set msg = 'Notable';
		when pNota >= 9 AND pNota < 10  then set msg = 'Sobresaliente';
		
		ELSE SET msg = 'Nota no válida';
	END case;

END 
$$

CALL valorNotaOut(3.5, @res);
SELECT @res AS "Mensaje";


-- ----------------------


DELIMITER $$
CREATE OR REPLACE PROCEDURE diaSemana(
IN pDia INT 
)
BEGIN 
	
	if pDia = 1 then SET @txt = 'lunes';
	ELSEIF pDia = 2 then SET @txt = 'martes';
	ELSEIF pDia = 3 then SET @txt = 'miercoles';
	ELSEIF pDia = 4 then SET @txt = 'jueves';
	ELSEIF pDia = 5 then SET @txt = 'viernes';
	ELSEIF pDia = 6 then SET @txt = 'sabado';
	ELSEIF pDia = 7 then SET @txt = 'domingo';
	ELSE SET @txt = 'dia no valido';
	END if;

	SELECT @txt AS "Día de la semana";

END 
$$

CALL diaSemana(4);

-- --------- otra forma 

DELIMITER $$
CREATE OR REPLACE PROCEDURE diaSemanaELT(
IN pDia INT 
)
BEGIN 
	
	SELECT nvl(
		ELT(pDia,'Lunes', 'Martes', 'Miercoles', 'Jueves','Viernes', 'Sabado', 'Domingo')
		, 'Día no Valido'
	) AS 'Días de la semana';

END 
$$

CALL diaSemanaELT(3);



-- ----------------------


DELIMITER $$
CREATE OR REPLACE PROCEDURE diaSemanaCase(
IN pDia INT 
)
BEGIN 
	
	case
		when pDia = 1 then SET @txt = 'lunes';
		when pDia = 2 then SET @txt = 'martes';
		when pDia = 3 then SET @txt = 'miercoles';
		when pDia = 4 then SET @txt = 'jueves';
		when pDia = 5 then SET @txt = 'viernes';
		when pDia = 6 then SET @txt = 'sabado';
		when pDia = 7 then SET @txt = 'domingo';
		ELSE SET @txt = 'dia no valido';
	END case;
	
	SELECT @txt AS "Día de la semana";

END 
$$

CALL diaSemanaCase(4);



-- ----------------------

USE jardineria;
SELECT * FROM cliente;

DELIMITER &&
CREATE OR REPLACE PROCEDURE getClientesPais(
IN pNombrePais VARCHAR(20)
)
BEGIN 
	SELECT * FROM cliente c WHERE c.pais = pNombrePais;
END 
&&

CALL getClientesPais('USA');



-- ----------------------

USE jardineria;
SELECT * FROM pago;

DELIMITER &&
CREATE OR REPLACE PROCEDURE getFormaPago(
IN pFormaP VARCHAR(20)
)
BEGIN 
	SELECT MAX(p.total) FROM pago p WHERE p.forma_pago = pFormaP;
END 
&&

CALL getFormaPago('paypal');

-- ----------------------

USE jardineria;
SELECT * FROM pago;

DELIMITER &&
CREATE OR REPLACE PROCEDURE getFormaPagoFull(
IN pFormaP VARCHAR(20)
)
BEGIN 
	SELECT 
		MAX(p.total) AS "Pago Maximo" 
		, MIN(p.total) AS "Pago Minimo"
		, AVG(p.total) AS "Pago Medio"
		, SUM(p.total) AS "Sumatoria pagos"
		, COUNT(*) AS "Cantidad pagos"
	FROM pago p WHERE p.forma_pago = pFormaP;
END 
&&

CALL getFormaPagoFull('paypal');



-- ----------------------
DROP DATABASE if EXISTS procedimientos;

CREATE DATABASE procedimientos;
USE procedimientos;

DROP TABLE if EXISTS cuadrado;

CREATE TABLE cuadrado(
	numero INT UNSIGNED ,
	cuadrardo INT UNSIGNED
);

DELIMITER $$
CREATE OR REPLACE PROCEDURE calcular_cuadrados(
IN tope INT UNSIGNED 
)
BEGIN 
	
	DECLARE init INT DEFAULT 1;
	DECLARE multiplicador INT DEFAULT 2;
	DELETE FROM cuadrado;


	/*
	--	Solucion con WHILE
	while init <= tope DO
		INSERT INTO cuadrado
		SELECT init, POW(init , multiplicador);
		set init = init + 1;
	END while;	
	*/
	
	/*
	-- Solucion con REPEAT
	repeat
		INSERT INTO cuadrado
		SELECT init, POW(init , multiplicador);
		set init = init + 1;
	until tope = init
	END repeat;
	*/
	
	-- Solucion con LOOP
	read_loop: loop 
		if init > tope then
			leave read_loop;
		END if;
		INSERT INTO cuadrado
		SELECT init, POW(init , multiplicador);
		set init = init + 1;
		
	END loop;
	
	
	
END 
$$


CALL calcular_cuadrados(4);
SELECT * FROM cuadrado;

-- ----------------------

USE procedimientos;

DROP TABLE if EXISTS ejercicio;

CREATE TABLE ejercicio(
	numero INT UNSIGNED
);

DELIMITER $$
CREATE OR REPLACE PROCEDURE calcular_numeros(
IN valor_inicial INT UNSIGNED
)
BEGIN 
	
	
	DECLARE vValor INT;
	SET vValor = valor_inicial;
	DELETE FROM ejercicio;
	
	FOR vValorIndex IN REVERSE 1..vValor DO        
			INSERT INTO ejercicio VALUES (vValorIndex);
	END FOR; 
	
	
	/*
	--	solucion con WHILE
	while vValor >= 1 DO 
		INSERT INTO ejercicio VALUES (vValor);
		SET vValor = vValor - 1;
	END while;
	*/
	/*
	-- Solucion con REPEAT
	repeat
		INSERT INTO ejercicio VALUES (vValor);
		SET vValor = vValor - 1;		
	until vValor <= 0
	END repeat;
	*/
	
	/*
	-- Solucion con LOOP
	read_loop : loop
		if vValor = 0 then
			leave read_loop;
		END if;
		INSERT INTO ejercicio VALUES (vValor);
		SET vValor = vValor - 1;		
	END loop;
	*/
	
END 
$$

CALL calcular_numeros(10);
SELECT * FROM ejercicio;


-- ----------------------

USE procedimientos;

DROP TABLE if EXISTS pares ;
DROP TABLE if EXISTS impares ;

CREATE TABLE pares(
	numero INT UNSIGNED
);

CREATE TABLE impares(
	numero INT UNSIGNED
);

DELIMITER $$
CREATE OR REPLACE PROCEDURE calcular_pares_impares(
IN tope INT UNSIGNED
)
BEGIN 
		
	/*
	SELECT 3%2 ;
	-- si es 0 es par
	-- si es 1 es impar
	*/

	DECLARE vTope INT;
	SET vTope = tope;
	DELETE FROM pares;
	DELETE FROM impares;
	
	
	/*
	--	solucion con WHILE
	while vTope >= 1 DO 
		if vTope%2 = 0 then
			INSERT INTO pares VALUES (vTope);
		ELSE
			INSERT INTO impares VALUES (vTope);
		END if;

		SET vTope = vTope - 1;
	END while;
	*/
	
	/*
	-- Solucion con REPEAT
	repeat
	
		if vTope%2 = 0 then
			INSERT INTO pares VALUES (vTope);
		ELSE
			INSERT INTO impares VALUES (vTope);
		END if;

		SET vTope = vTope - 1;
		
	until vTope = 0
	END repeat;
	
	*/

	
	-- Solucion con LOOP
	read_loop : loop
		if vTope = 0 then
			leave read_loop;
		END if;
		
		if vTope%2 = 0 then
			INSERT INTO pares VALUES (vTope);
		ELSE
			INSERT INTO impares VALUES (vTope);
		END if;

		SET vTope = vTope - 1;

	END loop;
	
END 
$$

CALL calcular_pares_impares(10);
SELECT p.numero AS "Numeros Pares" FROM pares p;
SELECT i.numero AS "Numeros Impares" FROM impares i;



