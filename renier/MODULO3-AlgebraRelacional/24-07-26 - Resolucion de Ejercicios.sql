
-- ############################### 1.8.3 - 1

DELIMITER $$
CREATE OR REPLACE FUNCTION numero_par_impar(
pNum INT UNSIGNED 
)
RETURNS BOOLEAN
BEGIN
	
	if pNum % 2 = 0 then
		RETURN TRUE;
	else
		RETURN FALSE;
	END if;
	
END 
$$

SET @numero = 3;
SELECT @numero AS "Numero" 
, numero_par_impar(@numero) AS "Es Par?"
, (case
		when numero_par_impar(@numero) = 1 then 'TRUE'
		ELSE 'FALSE'
	END)  AS "Texto"
;


-- ############################### 1.8.3 - 2


DELIMITER $$
CREATE OR REPLACE FUNCTION calcular_hipotenusa(
	ladoA DOUBLE,
	ladoB DOUBLE
)
RETURNS DOUBLE
BEGIN 
	
 RETURN  SQRT(POW(ladoA, 2) + POW(ladoB,2) );
	
END 
$$

SET @lado_a = 4;
SET @lado_b = 4;
SELECT @lado_a AS "Lado A", @lado_b AS "Lado B", calcular_hipotenusa(@lado_a,@lado_b) AS HIPOTENUSA;




-- ############################### 1.8.3 - 3


DELIMITER $$
CREATE OR REPLACE FUNCTION dia_semana(
pDia INT UNSIGNED 
)
RETURNS VARCHAR(10)
BEGIN

/*
	-- solucion elegante
	return nvl(
		ELT(pDia,'Lunes', 'Martes', 'Miercoles', 'Jueves','Viernes', 'Sabado', 'Domingo')
		, 'Día no Valido'
	);
*/	
	--	solucion con CASE
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
	
	RETURN @txt;
	
END 
$$

SELECT dia_semana(4);


-- ############################### 1.8.3 - 4

DELIMITER $$
CREATE OR REPLACE FUNCTION numero_maximo(
pNum1 INT,
pNum2 INT,
pNum3 INT 
)
RETURNS INT 
BEGIN

	return GREATEST(pNum1, pNum2, pNum3);
	
END
$$

SELECT numero_maximo(2,5,30) "N° Maximo";


-- ############################### 1.8.3 - 5


DELIMITER $$
CREATE OR REPLACE FUNCTION calcular_area_circulo(
	pRadio DOUBLE 
)
RETURNS DOUBLE
BEGIN

	RETURN PI() * POW(pRadio, 2);
	 
END 
$$

SET @radio = 45;
SELECT @radio AS "Radio", calcular_area_circulo(@radio) AS "Area del Circulo";


-- ############################### 1.8.3 - 6

DELIMITER $$
CREATE OR REPLACE FUNCTION calcular_anios(
	pFec1 DATE,
	pFec2 DATE
)
RETURNS VARCHAR(10)
BEGIN 
	
	RETURN TRUNCATE(DATEDIFF(pFec1, pFec2)/365, 0);

END 
$$

SELECT calcular_anios('2028-01-01' , '2018-01-01') AS "Años Transcurridos";



-- ############################### 1.8.3 - 7

DELIMITER $$
CREATE OR REPLACE FUNCTION limpiar_acentos(
	pPalabra VARCHAR(50)
)
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN 
	DECLARE vIndex INT DEFAULT 1;
	DECLARE vLetra CHAR(1) DEFAULT '';
	DECLARE vPalabra VARCHAR(50) DEFAULT '';
	DECLARE vComparar VARCHAR(50) DEFAULT 'áéíóúÁÉÍÓÚ';
	DECLARE cReemplazo VARCHAR(50) DEFAULT 'aeiouAEIOU';
	FOR vIndex IN  1..CHAR_LENGTH(pPalabra) do
		SET vLetra = SUBSTR(pPalabra,vIndex,1);
		SET @indiceLetra = LOCATE(vLetra COLLATE UTF8MB4_BIN, vComparar);
		CASE 
			WHEN @indiceLetra > 0 then 
				SET vLetra = SUBSTR(cReemplazo, @indiceLetra ,1);
			ELSE 
				SET vLetra = vLetra;
		END CASE;
		SET vPalabra = CONCAT(vPalabra, vLetra);
	END FOR ;
	RETURN vPalabra;
END $$

SELECT limpiar_acentos('MáriÁ');



-- ############################### 1.8.4 - 1

DELIMITER $$
CREATE OR REPLACE FUNCTION 
$$



SELECT 		LOCATE('c','aeiou');
SUBSTRING_INDEX(str,delim,count)