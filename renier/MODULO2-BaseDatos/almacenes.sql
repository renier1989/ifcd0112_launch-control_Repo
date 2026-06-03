CREATE TABLE ALMACEN
(
   Numero      NUMBER PRIMARY KEY,
   Direccion   TEXT        NOT NULL,
   Telefono    FLOAT        NOT NULL
);

CREATE TABLE TIENDA
(
   Nombre      TEXT PRIMARY KEY,
   Direccion   TEXT        NOT NULL,
   Telefono    NUMBER        NOT NULL
);

CREATE TABLE CAMION
(
   Matricula       TEXT PRIMARY KEY,
   LimitePeso      FLOAT        NOT NULL,
   LimiteVolumen   FLOAT        NOT NULL
);

CREATE TABLE VIAJE
(
   Numero              NUMBER PRIMARY KEY,
   FechaUso            DATE        NOT NULL,
   CAMION_Matricula   TEXT        NOT NULL,
   FOREIGN KEY (CAMION_Matricula) REFERENCES CAMION(Matricula)
);

CREATE TABLE PEDIDO
(
   Numero           NUMBER PRIMARY KEY,
   Volumen          FLOAT        NOT NULL,
   Peso             FLOAT        NOT NULL,
   Entregado        BOOLEAN        NOT NULL,
   TIENDA_Nombre    TEXT        NOT NULL,
   ALMACEN_Numero   NUMBER        NOT NULL,
   FOREIGN KEY (TIENDA_Nombre) REFERENCES TIENDA(Nombre),
   FOREIGN KEY (ALMACEN_Numero) REFERENCES ALMACEN(Numero)
);

CREATE TABLE TRANSPORTAR
(
   VIAJE_Numero    NUMBER,
   PEDIDO_Numero   NUMBER,
   PRIMARY KEY (VIAJE_Numero,PEDIDO_Numero),
   FOREIGN KEY (VIAJE_Numero) REFERENCES VIAJE(Numero),
   FOREIGN KEY (PEDIDO_Numero) REFERENCES PEDIDO(Numero)
); 


-- DATOS DE INSERCION.

INSERT INTO ALMACEN (Numero, Direccion , Telefono) VALUES (1, 'Calle Arcos de Jalon 15', '987654325'), (2, 'Av. de Guadalajara', '978576456');
		
INSERT INTO TIENDA (Nombre, Direccion, Telefono) VALUES ('Tienda 1', 'Av. España', '951847623'), ('Tienda 2', 'Calle del Retiro', '958954963'), ('Tienda 3', 'Av, Principe Pio', '963854123');

INSERT INTO CAMION (Matricula, LimitePeso, LimiteVolumen) VALUES ('000444','600','555'), ('676G5G','670','444'),('TYT67R','800','554');

INSERT INTO PEDIDO VALUES (1, 3, 100, FALSE, 'Tienda 1', 1), (2, 10, 300, FALSE, 'Tienda 1', 1), (3, 13, 500, FALSE, 'Tienda 2', 2);

INSERT INTO VIAJE VALUES (1, '2026-06-03', '000444');

INSERT INTO TRANSPORTAR  VALUES (1,1), (1,2);


/* -- CONSULTAR QUE CAMIONES LLEVAN LOS PEDIDOS DE QUE TIENDA.
SELECT DISTINCT  c.Matricula AS CAMION , p.TIENDA_Nombre AS TIENDA,P.Numero AS NUMERO_PEDIDO    
FROM PEDIDO p
INNER JOIN TRANSPORTAR t ON  p.Numero   = t.PEDIDO_Numero 
inner join VIAJE v on t.VIAJE_Numero = v.Numero 
inner JOIN CAMION c on v.CAMION_Matricula  = c.Matricula ;
*/