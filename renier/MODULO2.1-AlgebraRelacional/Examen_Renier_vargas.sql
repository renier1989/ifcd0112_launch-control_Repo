/*
Fecha 14/07/2026
Autor: Renier Josué Vargas Mejias
*/

-- Eliminacion de la BD si existe 
DROP DATABASE IF EXISTS Jardineria;

-- Crea la base de datos.
CREATE DATABASE Jardineria;

-- usamos la BD
USE Jardineria;

-- Eliminacion de tablas si existen
DROP TABLE if EXISTS empleados;
DROP TABLE if EXISTS oficinas;

-- creacion de tablas
CREATE TABLE oficinas 
( 
	codigooficina 		VARCHAR(10) 	PRIMARY KEY
	, ciudad 			VARCHAR(30)		NOT NULL 
	, pais 				VARCHAR(50)		NOT NULL
	, region 			VARCHAR(50)		
	, codigopostal 	VARCHAR(10)		NOT NULL
	, telefono 			VARCHAR(20)		NOT NULL CHECK(REGEXP_SUBSTR(telefono, '[0-9]+'))
	, lineadireccion1 VARCHAR(50)		NOT NULL
	, lineadireccion2 VARCHAR(50)		
);


CREATE TABLE empleados 
( 
	codigoempleado 		NUMERIC(5,0)	PRIMARY KEY 
	, nombre 				VARCHAR(50) 	NOT NULL 
	, apellido1 			VARCHAR(50)		NOT NULL
	, apellido2 			VARCHAR(50)		
	, extension 			VARCHAR(10)		NOT NULL CHECK(REGEXP_SUBSTR(extension, '[0-9]+'))
	, email 					VARCHAR(100)	NOT NULL
	, codigooficina 		VARCHAR(10)		NOT NULL
	, codigojefe 			NUMERIC(5,0)		
	, puesto 				VARCHAR(50)		
	, CONSTRAINT fk_empleados_oficina 
		FOREIGN KEY (codigooficina) 
		REFERENCES  oficinas (codigooficina) 
		ON DELETE CASCADE 
 	, CONSTRAINT fk_empleados_empleados
		FOREIGN KEY (codigojefe) 
		REFERENCES  empleados (codigoempleado) 
		ON DELETE RESTRICT 
);

-- Limipieza e insercion de datos
START TRANSACTION;

DELETE FROM empleados;
DELETE FROM oficinas;

INSERT INTO oficinas (codigooficina,ciudad ,pais,codigopostal,telefono,lineadireccion1)
VALUES 
('Oficina1','Madrid','España','27018','963852741','Avenida de la Americas 2B'),
('Oficina2','Alicante','España','30512','987654321','Benidorm Levante 23 3 C');

INSERT INTO empleados (codigoempleado,nombre ,apellido1,extension,email,codigooficina,codigojefe)
VALUES 
(1000, 'nombre1','apellido1','111','persona1@correo.com','Oficina1',NULL),
(2000, 'nombre2','apellido2','222','persona2@correo.com','Oficina1',1000),
(3000, 'nombre3','apellido3','333','persona3@correo.com','Oficina2',1000),
(4000, 'nombre4','apellido4','444','persona4@correo.com','Oficina2',3000);


-- consulta de la informacion
SELECT 
	e.codigoempleado AS "ID Empleado" 
	, CONCAT(
			UPPER( SUBSTRING(e.nombre,1,1))
			,LCASE(SUBSTRING(e.nombre,2))
			,' '
			,UCASE( SUBSTRING(e.apellido1,1,1))
			,LCASE(SUBSTRING(e.apellido1,2))
			,' '
			, NVL(
					CONCAT(
							UCASE( SUBSTRING(e.apellido2,1,1))
							,LCASE(SUBSTRING(e.apellido2,2))
					)
				,' '
				)
	) AS "Nombre Completo"
	, codigooficina AS "Codigo oficina"	
	, NVL(codigojefe, ' ') AS "Codigo Jefe"
FROM empleados e
WHERE e.codigooficina = 'Oficina1';

-- actualizacion de la informacion 
UPDATE empleados 
SET codigooficina = 'Oficina1' , codigojefe = 2000
WHERE codigoempleado IN (3000,4000);



 COMMIT;
 
 ROLLBACK;



