-- Habilitar claves foráneas
PRAGMA foreign_keys = ON;

-- Vaciado previo por seguridad (simulación de truncado en orden jerárquico inverso)
DELETE FROM PARTICIPACION;
DELETE FROM CORREDOR;
DELETE FROM subir_puerto;
DELETE FROM TIPO_PUERTO;
DELETE FROM PARTICIPACION_PUERTO;
DELETE FROM PUERTOS;
DELETE FROM ETAPA;
DELETE FROM EQUIPO;
DELETE FROM TIPO_ETAPA;
DELETE FROM PATROCINADOR;
DELETE FROM PAIS;
DELETE FROM DIRECTOR;
DELETE FROM COMPETICION;
DELETE FROM CIUDAD;

-- 1. DATOS MAESTROS INDEPENDIENTES

INSERT INTO CIUDAD (id_ciudad, nombre_ciudad) VALUES
(1, 'Málaga'),
(2, 'Marbella'),
(3, 'Granada'),
(4, 'Sierra Nevada'),
(5, 'Sevilla');

INSERT INTO COMPETICION (id_competicion, fecha_competicion) VALUES
(100, '2026-08-20');

INSERT INTO DIRECTOR (nombre_directo) VALUES
( 'Eusebio Unzué'),
( 'Matxin Fernández'),
( 'Richard Plugge');

INSERT INTO PAIS (id_pais, nombre_pais) VALUES
(1, 'España'),
(2, 'Colombia'),
(3, 'Eslovenia'),
(4, 'Bélgica');

INSERT INTO PATROCINADOR (nombre_patrocinador) VALUES
('Movistar'),
('UAE Emirates'),
('Visma-Lease a Bike');

INSERT INTO TIPO_ETAPA (id_tipo_etapa, nombre_tipo_etapa) VALUES
(1, 'Llana'),
(2, 'Montaña'),
(3, 'Contrarreloj Individual'),
(4, 'Cronoescalada');

INSERT INTO PUERTOS (id_puerto, nombre_puerto, puntuacion) VALUES
(10, 'Puerto de Ojén', 10),     -- Categoría Segunda (Reparte 10 puntos en total)
(11, 'Alto de Monachil', 30);  -- Categoría Especial (Reparte 30 puntos en total)

-- 2. EQUIPOS (Nivel 1)
INSERT INTO EQUIPO (id_equipo, DIRECTOR_nombre_directo, PATROCINADOR_nombre_patrocinador, PAIS_id_pais) VALUES
(1, 'Eusebio Unzué', 'Movistar', 1),
(2, 'Matxin Fernández', 'UAE Emirates', 1), -- Licencia o sede en España para el ejemplo
(3, 'Richard Plugge', 'Visma-Lease a Bike', 4);

-- 3. ETAPAS (Nivel 1 - Relaciona Ciudades, Competición y Tipo)
INSERT INTO ETAPA (numero_etapa, fecha, longitud_kilometros, tiempo_maximo, CIUDAD_id_ciudad, CIUDAD_id_ciudad2, COMPETICION_id_competicion, TIPO_ETAPA_id_tipo_etapa) VALUES
-- Etapa 1: Málaga -> Marbella (Llana)
(1, '2026-08-20', 140, '04:30:00', 1, 2, 100, 1), 
-- Etapa 2: Granada -> Sierra Nevada (Montaña)
(2, '2026-08-21', 165, '05:45:00', 3, 4, 100, 2),
-- Etapa 3: Sevilla -> Sevilla (Circuito cerrado llano: Origen y Destino igual)
(3, '2026-08-22', 120, '03:15:00', 5, 5, 100, 1);

-- 4. RELACIÓN ETAPA - PUERTOS (subir_puerto)
INSERT INTO subir_puerto (ETAPA_numero_etapa, PUERTOS_id_puerto) VALUES
(1, 10), -- En la Etapa 1 se sube el Puerto de Ojén
(2, 11); -- En la Etapa 2 se sube el Alto de Monachil

-- 5. CORREDORES (Nivel 2)
INSERT INTO CORREDOR (numero_dorsal, EQUIPO_id_equipo, nombre_corredor, puntos_totales, PAIS_id_pais) VALUES
(1, 1, 'Enric Mas', 0, 1),
(2, 1, 'Nairo Quintana', 0, 2),
(11, 2, 'Tadej Pogačar', 0, 3),
(12, 2, 'Juan Ayuso', 0, 1),
(21, 3, 'Wout van Aert', 0, 4);

-- 6. PARTICIPACIÓN EN ETAPAS (Tiempos de llegada y Casos Especiales)
INSERT INTO PARTICIPACION (tiempo_empleado, CORREDOR_numero_dorsal, ETAPA_numero_etapa) VALUES
-- Resultados Etapa 1 (Todos llegan bien)
('03:45:12', 1, 1),
('03:45:15', 2, 1),
('03:44:50', 11, 1), -- Pogačar gana la etapa 1
('03:45:00', 12, 1),
('03:44:55', 21, 1),

-- Resultados Etapa 2 (Montaña - Caso de Abandono/Fuera de tiempo)
('05:10:20', 11, 2), -- Pogačar gana en montaña
('05:12:00', 1, 2),
('05:15:35', 2, 2),
('05:13:10', 12, 2),
('00:00:00', 21, 2); -- Wout van Aert ABANDONA o llega FUERA DE TIEMPO (Valor por defecto)

-- 7. PARTICIPACIÓN EN PUERTOS (Paso y reparto manual de puntos de montaña)
-- El enunciado dice: "se reparten los puntos asociados al puerto entre los tres primeros corredores"
-- Puerto 11 (Alto de Monachil) vale 30 puntos en total. Reparto: 1º=15pts, 2º=10pts, 3º=5pts. Total = 30.
INSERT INTO PARTICIPACION_PUERTO (tiempo_empleado, numero_dorsal, orden, PUERTOS_id_puerto) VALUES
('04:30:15', 11, 1, 11), -- Pogačar corona 1º (Suma 15 pts manualmente en la lógica de negocio)
('04:31:00', 2, 2, 11),  -- Nairo Quintana corona 2º (Suma 10 pts)
('04:31:45', 1, 3, 11);  -- Enric Mas corona 3º (Suma 5 pts)