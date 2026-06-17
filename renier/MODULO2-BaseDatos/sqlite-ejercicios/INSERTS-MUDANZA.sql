-- Especialidad

INSERT INTO Especialidad VALUES 
(1,'Chofer'),(2,'Ayudante'),(3,'Limpieza');


-- Grua
INSERT INTO Grua VALUES
(1, '1.5','10'),(2, '2.2','8'),(3, '2.5','13');


--Provincia
INSERT INTO Provincia (id_provincia, nombre_provincia) VALUES
(1, 'Araba/Álava'),
(2, 'Albacete'),
(3, 'Alicante/Alacant'),
(4, 'Almería'),
(5, 'Ávila'),
(6, 'Badajoz'),
(7, 'Illes Balears'),
(8, 'Barcelona'),
(9, 'Burgos'),
(10, 'Cáceres'),
(11, 'Cádiz'),
(12, 'Castellón/Castelló'),
(13, 'Ciudad Real'),
(14, 'Córdoba'),
(15, 'A Coruña'),
(16, 'Cuenca'),
(17, 'Girona'),
(18, 'Granada'),
(19, 'Guadalajara'),
(20, 'Gipuzkoa'),
(21, 'Huelva'),
(22, 'Huesca'),
(23, 'Jaén'),
(24, 'León'),
(25, 'Lleida'),
(26, 'La Rioja'),
(27, 'Lugo'),
(28, 'Madrid'),
(29, 'Málaga'),
(30, 'Murcia'),
(31, 'Navarra'),
(32, 'Ourense'),
(33, 'Asturias'),
(34, 'Palencia'),
(35, 'Las Palmas'),
(36, 'Pontevedra'),
(37, 'Salamanca'),
(38, 'Santa Cruz de Tenerife'),
(39, 'Cantabria'),
(40, 'Segovia'),
(41, 'Sevilla'),
(42, 'Soria'),
(43, 'Tarragona'),
(44, 'Teruel'),
(45, 'Toledo'),
(46, 'Valencia/València'),
(47, 'Valladolid'),
(48, 'Bizkaia'),
(49, 'Zamora'),
(50, 'Zaragoza'),
(51, 'Ceuta'),
(52, 'Melilla');


-- Poblacion
INSERT INTO Poblacion VALUES 
(1, 'Madrid', 28),(2, 'Malaga', 29),(3,'Soria',42);


-- Tipo_documento
INSERT INTO Tipo_documento VALUES 
('1','NIF'),('2','NIE'),('3','Pasaporte'),('4','CIF');

-- Tipo_via 
INSERT INTO Tipo_via VALUES 
(1,'Calle'), (2, 'Avenida'), (3,'Travesia');

--  Servicio
INSERT INTO Servicio VALUES
(1,'33.3','Embalado'),(2,'44.2','Desembalado'),(3,'56.3','Montaje'),(4,'69.3','Grua'),(5,'22.1','Desmontaje');


-- Regulacion
INSERT INTO Regulacion VALUES 
(100,200,'12.0',1),(102,300,'35.0',2),(120,220,'20.0',3),(125,225,'25.0',1),(500,320,'20.0',2),(520,520,'50.0',4) ;


-- PERSONA, PARA EMPRESAS
INSERT INTO Persona (Tipo_documento_codigo,numero,nombre_empresa,direccion,codigo_postal,Tipo_via_codigo_via,Poblacion_id_poblacion) 
VALUES 
(4,'B-54545632','EMPRESA DE TRASNPORTE S.A.C','MADRID 123', '27816',1,1),
(4,'B-54734523','MOVILIDAD ANONIMA PLUG','MALAGA 13', '28543',2,2);

-- PERSONA, PARA EMPLEADOS
INSERT INTO Persona (Tipo_documento_codigo,numero,direccion,codigo_postal,Tipo_via_codigo_via,Poblacion_id_poblacion,
						nombre, apellido_pat,apellido_mat,cod_empleado,Especialidad_cod_especialidad)
		VALUES (1,'F-123123123','Calle principal de Moncloa','27615',2,1 , 'Paquito','Perez','Martinez',1,1),
				(1,'F-675948234','Avenida de las americas 123','28761',1,1 , 'Alejandro','Gonzales','Casas',2,2),
				(2,'Z-12312312-C','Calle de alcala 4A','28765',3,1 , 'MARIA','Fernandez','Olgin',3,3);
				

-- PERSONA, PARA CLIENTES
INSERT INTO Persona (Tipo_documento_codigo,numero,direccion,codigo_postal,Tipo_via_codigo_via,Poblacion_id_poblacion,
						nombre, apellido_pat,apellido_mat,cod_cliente)
		VALUES (1,'C-43223123','Nuñez de balboa 1,1A','27611',2,1 , 'Fernando','Gutierrez','Maldonado',1),
				(1,'H-57849233','Calle alacla de Henares 8B','28763',1,1 , 'Ana','Valera',NULL,2),
				(2,'Z-4948594-C','Avenida Principal de Soria','30765',3,3 , 'Alejandra','de Arco','Soza',3);


-- Contratacion
INSERT INTO Contratacion 
VALUES ('2026-01-01 00:00:00',NULL,'B-54545632','F-123123123',4,1),
		('2026-03-01 00:00:00','2026-08-01 00:00:00','B-54545632','F-675948234',4,1),
		('2026-06-01 00:00:00',NULL,'B-54734523','Z-12312312-C',4,2);
		

-- Telefono
INSERT INTO Telefono VALUES 
		(636456123, 1,'C-43223123',1),
		(698745123, 2,'H-57849233',1),
		(652632852, 2,'Z-4948594-C',2),
		(963852741, 1,'F-123123123',1),
		(951753159, 1,'F-675948234',1),
		(684123852, 1,'Z-12312312-C',2),
		(985963236, 1,'B-54545632',4),
		(984752125, 1,'B-54734523',4);
			

-- Solicitud
INSERT INTO Solicitud VALUES 
		(1,'2026-01-02 12:20:25',NULL,NULL,1,'C-43223123',1,'Nuñez de balboa 1,1A','27611',1),
		(2,'2026-03-11 08:44:32','2026-03-15 15:43:20','ENTREGADO EN LA TIENDA DE RECOJO ASIGNADA',3,'Z-4948594-C',2,'Avenida Principal de Soria','30765',3);


-- PrestacionServicio
INSERT INTO PrestacionServicio (Solicitud_cod_solicitud, Persona_Tipo_documento_codigo,Persona_numero,Servicio_Servicio_ID)
VALUES 
		(1,4,'B-54545632',1);