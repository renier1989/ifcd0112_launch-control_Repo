-- Adaptado para SQLite el 2026-06-16
PRAGMA foreign_keys = ON;

-- 1. TABLAS MAESTRAS / INDEPENDIENTES

CREATE TABLE Especialidad (
    cod_especialidad INTEGER NOT NULL,
    descripcion      TEXT NOT NULL,
    CONSTRAINT Especialidad_PK PRIMARY KEY (cod_especialidad)
);

CREATE TABLE Grua (
    id_grua INTEGER NOT NULL,
    altura  REAL NOT NULL,
    base    INTEGER NOT NULL,
    CONSTRAINT Grua_PK PRIMARY KEY (id_grua)
);

CREATE TABLE Tipo_documento (
    codigo      INTEGER NOT NULL,
    descripcion TEXT,
    CONSTRAINT Tipo_documento_PK PRIMARY KEY (codigo)
);

CREATE TABLE Tipo_via (
    codigo_via  INTEGER NOT NULL,
    descripcion TEXT,
    CONSTRAINT Tipo_via_PK PRIMARY KEY (codigo_via)
);

CREATE TABLE Servicio (
    Servicio_ID       INTEGER PRIMARY KEY AUTOINCREMENT, -- Autoincremental en SQLite
    precio_hora       REAL NOT NULL,
    nombre_transporte TEXT
);

CREATE TABLE Provincia (
    id_provincia     INTEGER NOT NULL,
    nombre_provincia INTEGER NOT NULL,
    CONSTRAINT Provincia_PK PRIMARY KEY (id_provincia)
);

-- 2. TABLAS DEPENDIENTES (NIVEL 1)

CREATE TABLE Poblacion (
    id_poblacion           INTEGER NOT NULL,
    nombre_poblacion       TEXT NOT NULL,
    Provincia_id_provincia INTEGER,
    CONSTRAINT Poblacion_PK PRIMARY KEY (id_poblacion),
    CONSTRAINT Poblacion_Provincia_FK FOREIGN KEY (Provincia_id_provincia) 
        REFERENCES Provincia (id_provincia)
);

CREATE TABLE Regulacion (
    peso_minimo          INTEGER NOT NULL,
    peso_maximo          INTEGER NOT NULL,
    porcentaje           REAL,
    Servicio_Servicio_ID INTEGER NOT NULL,
    CONSTRAINT Regulacion_PK PRIMARY KEY (peso_minimo),
    CONSTRAINT Regulacion_Servicio_FK FOREIGN KEY (Servicio_Servicio_ID) 
        REFERENCES Servicio (Servicio_ID)
);

-- 3. TABLAS DEPENDIENTES (NIVEL 2)

CREATE TABLE Persona (
    numero                        INTEGER NOT NULL,
    direccion                     TEXT NOT NULL,
    codigo_postal                 INTEGER NOT NULL,
    Tipo_via_codigo_via           INTEGER NOT NULL,
    Tipo_documento_codigo         INTEGER NOT NULL,
    Poblacion_id_poblacion        INTEGER NOT NULL,
    nombre_empresa                TEXT,
    nombre                        TEXT,
    apellido_pat                  TEXT,
    apellido_mat                  TEXT,
    cod_empleado                  INTEGER,
    Especialidad_cod_especialidad INTEGER,
    cod_cliente                   INTEGER,
    CONSTRAINT Persona_PK PRIMARY KEY (numero, Tipo_documento_codigo),
    CONSTRAINT Persona_cod_cliente_UN UNIQUE (cod_cliente),
    CONSTRAINT Persona_cod_empleado_UN UNIQUE (cod_empleado),
    CONSTRAINT Persona_nombre_empresa_UN UNIQUE (nombre_empresa),
    CONSTRAINT Persona_Especialidad_FK FOREIGN KEY (Especialidad_cod_especialidad) 
        REFERENCES Especialidad (cod_especialidad),
    CONSTRAINT Persona_Poblacion_FK FOREIGN KEY (Poblacion_id_poblacion) 
        REFERENCES Poblacion (id_poblacion),
    CONSTRAINT Persona_Tipo_documento_FK FOREIGN KEY (Tipo_documento_codigo) 
        REFERENCES Tipo_documento (codigo),
    CONSTRAINT Persona_Tipo_via_FK FOREIGN KEY (Tipo_via_codigo_via) 
        REFERENCES Tipo_via (codigo_via)
);

-- 4. TABLAS DEPENDIENTES (NIVEL 3)

CREATE TABLE Contratacion (
    fec_inicio                     TEXT NOT NULL, -- Las fechas se almacenan como TEXT en SQLite
    fec_fin                        TEXT,
    Persona_numero2                INTEGER NOT NULL,
    Persona_numero                 INTEGER NOT NULL,
    Persona_Tipo_documento_codigo  INTEGER NOT NULL,
    Persona_Tipo_documento_codigo2 INTEGER NOT NULL,
    CONSTRAINT Contratacion_Persona_FK FOREIGN KEY (Persona_numero, Persona_Tipo_documento_codigo2) 
        REFERENCES Persona (numero, Tipo_documento_codigo),
    CONSTRAINT Contratacion_Persona_FKv2 FOREIGN KEY (Persona_numero2, Persona_Tipo_documento_codigo) 
        REFERENCES Persona (numero, Tipo_documento_codigo)
);

CREATE TABLE Solicitud (
    cod_solicitud                 INTEGER NOT NULL,
    fec_solicitud                 TEXT NOT NULL,
    fec_resolucion                TEXT,
    resolucion                    TEXT,
    Tipo_via_codigo_via           INTEGER,
    Persona_numero                INTEGER NOT NULL,
    Persona_Tipo_documento_codigo INTEGER NOT NULL,
    calle                         TEXT,
    cod_postal                    INTEGER,
    Poblacion_id_poblacion        INTEGER,
    CONSTRAINT Solicitud_PK PRIMARY KEY (cod_solicitud),
    CONSTRAINT Solicitud_Persona_FK FOREIGN KEY (Persona_numero, Persona_Tipo_documento_codigo) 
        REFERENCES Persona (numero, Tipo_documento_codigo),
    CONSTRAINT Solicitud_Poblacion_FK FOREIGN KEY (Poblacion_id_poblacion) 
        REFERENCES Poblacion (id_poblacion),
    CONSTRAINT Solicitud_Tipo_via_FK FOREIGN KEY (Tipo_via_codigo_via) 
        REFERENCES Tipo_via (codigo_via)
);

CREATE TABLE Telefono (
    numero                        TEXT,
    id_telefono                   INTEGER NOT NULL,
    Persona_numero                INTEGER NOT NULL,
    Persona_Tipo_documento_codigo INTEGER NOT NULL,
    CONSTRAINT Telefono_PK PRIMARY KEY (id_telefono, Persona_numero, Persona_Tipo_documento_codigo),
    CONSTRAINT Telefono_Persona_FK FOREIGN KEY (Persona_numero, Persona_Tipo_documento_codigo) 
        REFERENCES Persona (numero, Tipo_documento_codigo)
);

-- 5. TABLAS DEPENDIENTES (NIVEL 4)

CREATE TABLE PrestacionServicio (
    nombre_servicio               TEXT,
    Grua_id_grua                  INTEGER,
    Solicitud_cod_solicitud       INTEGER NOT NULL,
    duracion                      TEXT,
    coste_total                   REAL,
    Persona_numero                INTEGER NOT NULL,
    Persona_Tipo_documento_codigo INTEGER NOT NULL,
    umbral                        INTEGER,
    porcentaje                    INTEGER,
    Servicio_Servicio_ID          INTEGER NOT NULL,
    CONSTRAINT PrestacionServicio_PK PRIMARY KEY (Solicitud_cod_solicitud, Persona_numero, Persona_Tipo_documento_codigo),
    CONSTRAINT PrestacionServicio_Grua_FK FOREIGN KEY (Grua_id_grua) 
        REFERENCES Grua (id_grua),
    CONSTRAINT PrestacionServicio_Persona_FK FOREIGN KEY (Persona_numero, Persona_Tipo_documento_codigo) 
        REFERENCES Persona (numero, Tipo_documento_codigo),
    CONSTRAINT PrestacionServicio_Servicio_FK FOREIGN KEY (Servicio_Servicio_ID) 
        REFERENCES Servicio (Servicio_ID),
    CONSTRAINT PrestacionServicio_Solicitud_FK FOREIGN KEY (Solicitud_cod_solicitud) 
        REFERENCES Solicitud (cod_solicitud)
);

-- 6. TABLAS DEPENDIENTES (NIVEL 5)

CREATE TABLE Participacion (
    Persona_numero                                   INTEGER NOT NULL,
    PrestacionServicio_Solicitud_cod_solicitud       INTEGER NOT NULL,
    Persona_Tipo_documento_codigo                    INTEGER NOT NULL,
    PrestacionServicio_Persona_numero                INTEGER NOT NULL,
    PrestacionServicio_Persona_Tipo_documento_codigo INTEGER NOT NULL,
    Especialidad_cod_especialidad                    INTEGER,
    CONSTRAINT Participacion_PK PRIMARY KEY (Persona_numero, Persona_Tipo_documento_codigo, PrestacionServicio_Solicitud_cod_solicitud, PrestacionServicio_Persona_numero, PrestacionServicio_Persona_Tipo_documento_codigo),
    CONSTRAINT Participacion_Especialidad_FK FOREIGN KEY (Especialidad_cod_especialidad) 
        REFERENCES Especialidad (cod_especialidad),
    CONSTRAINT Participacion_Persona_FK FOREIGN KEY (Persona_numero, Persona_Tipo_documento_codigo) 
        REFERENCES Persona (numero, Tipo_documento_codigo),
    CONSTRAINT Participacion_PrestacionServicio_FK FOREIGN KEY (PrestacionServicio_Solicitud_cod_solicitud, PrestacionServicio_Persona_numero, PrestacionServicio_Persona_Tipo_documento_codigo) 
        REFERENCES PrestacionServicio (Solicitud_cod_solicitud, Persona_numero, Persona_Tipo_documento_codigo)
);