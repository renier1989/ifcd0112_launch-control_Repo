DROP DATABASE if EXISTS datamartsalario;
CREATE DATABASE datamartsalario;
USE datamartsalario;

DELIMITER $$
CREATE OR REPLACE PROCEDURE crearBDdatamartsalario()
BEGIN

	DROP TABLE IF EXISTS empleado;
	DROP TABLE IF EXISTS departamento;
	DROP TABLE IF EXISTS localizacion;
	DROP TABLE IF EXISTS pais;
	DROP TABLE IF EXISTS region;
	
	CREATE TABLE region(
		id INT PRIMARY KEY,
		nombre VARCHAR(25) NOT NULL,
		salariototal DECIMAL(10,2) NOT NULL DEFAULT 0 CHECK(salariototal >= 0)
	);
	
	CREATE TABLE pais (
		id CHAR(2) PRIMARY KEY,
		nombre VARCHAR(40) NOT NULL,
		salariototal DECIMAL(10,2) NOT NULL DEFAULT 0 CHECK(salariototal >= 0),
		regionId INT NOT NULL,
		CONSTRAINT fk_pais_region FOREIGN KEY (regionId) REFERENCES region(id)
	);
	
	CREATE TABLE localizacion(
		id INT PRIMARY KEY,
		direccion VARCHAR(120) NOT NULL,
		salariototal DECIMAL(10,2) NOT NULL DEFAULT 0 CHECK(salariototal >= 0),
		paisId CHAR(2) NOT NULL,
		CONSTRAINT fk_localizacion_pais FOREIGN KEY (paisId) REFERENCES pais(id)
	);
	
	CREATE TABLE departamento(
		id INT PRIMARY KEY,
		nombre VARCHAR(120) NOT NULL,
		salariototal DECIMAL(10,2) NOT NULL DEFAULT 0 CHECK(salariototal >= 0),
		localizacionId INT NOT NULL,
		CONSTRAINT fk_departamento_localizacion FOREIGN KEY (localizacionId) REFERENCES localizacion(id)
	);
	
	CREATE TABLE empleado(
		id INT PRIMARY KEY,
		nombreCopmleto VARCHAR(120) NOT NULL,
		salariototal DECIMAL(8,2) NOT NULL DEFAULT 0 CHECK(salariototal >= 0) ,	
		departamentoId INT NOT NULL ,
		CONSTRAINT fk_empleado_departamento FOREIGN KEY (departamentoId) REFERENCES departamento(id)
	);
	
	ALTER TABLE empleado
	ADD COLUMN departamentoNombe VARCHAR(120);
	
	ALTER TABLE departamento
	ADD COLUMN cantEmpleados INT;

END
$$

CALL datamartsalario.crearBDdatamartsalario();

/*
use datamartsalario;
select * from datamartsalario.region;
select * from datamartsalario.pais;
select * from datamartsalario.localizacion;
select * from datamartsalario.departamento;
select * from datamartsalario.empleado;
*/