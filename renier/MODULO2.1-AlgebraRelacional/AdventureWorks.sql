-- Elimina la base de datos si ya existe.
DROP DATABASE IF EXISTS AdventureWorks;
-- Crea la base de datos.
CREATE DATABASE AdventureWorks;
-- Selecciona la base de datos para trabajar con ella.
USE AdventureWorks;
-- Tabla que almacena la información de los empleados.
CREATE TABLE Employee (
    -- Identificador único del empleado. Valores: enteros positivos únicos generados automáticamente.
    BusinessEntityID INT AUTO_INCREMENT PRIMARY KEY,
    -- Número nacional de identificación. Valores: cadena alfanumérica.
    NationalIDNumber VARCHAR(25) NOT NULL UNIQUE,
    -- Nombre de inicio de sesión. Valores: texto.
    LoginID VARCHAR(30) UNIQUE,
    -- Nodo organizativo. Valores: texto.
    OrganizationNode VARCHAR(30),
    -- Nivel jerárquico. Valores: Director, Manager, Supervisor, Employee.
    OrganizationLevel VARCHAR(25)
        CHECK (OrganizationLevel IN ('Director','Manager','Supervisor','Employee')),
    -- Puesto de trabajo. Valores: texto.
    JobTitle VARCHAR(30),
    -- Fecha de nacimiento. Valores: AAAA-MM-DD.
    BirthDate DATE,
    -- Estado civil. Valores: Single, Married, Divorced, Widowed.
    MaritalStatus VARCHAR(25)
        CHECK (MaritalStatus IN ('Soltero','Casado','Divorciado','Viudo')),
    -- Género. Valores: Male, Female, Non-binary, Other.
    Gender VARCHAR(15)
        CHECK (Gender IN ('Masculino','Femenino','Otros')),
    -- Fecha de contratación. Valores: AAAA-MM-DD.
    HireDate DATE,
    -- Empleado asalariado. Valores: TRUE o FALSE.
    SalariedFlag BOOLEAN NOT NULL DEFAULT TRUE,
    -- Horas de vacaciones. Valores: enteros mayores o iguales a 0.
    VacationHours INT NOT NULL DEFAULT 0 CHECK (VacationHours >= 0),
    -- Horas de baja médica. Valores: enteros mayores o iguales a 0.
    SickLeaveHours INT NOT NULL DEFAULT 0 CHECK (SickLeaveHours >= 0),
    -- Empleado activo. Valores: TRUE o FALSE.
    CurrentFlag BOOLEAN NOT NULL DEFAULT TRUE,
    -- Identificador único global. Valores: UUID generado automáticamente.
    ROWGUID INT NOT NULL,
    -- Fecha y hora de la última modificación. Valores: CURRENT_TIMESTAMP.
    ModifiedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Tabla que almacena el historial salarial de los empleados.
CREATE TABLE EmployeePayHistory (
    -- Identificador del empleado.
    -- Valores: identificadores existentes en la tabla Employee.
    BusinessEntityID INT  NOT NULL REFERENCES Employee(BusinessEntityID),
    -- Fecha en la que entra en vigor el salario.
    -- Valores: fecha válida (AAAA-MM-DD).
    RateChangeDate   DATE NOT NULL DEFAULT CURRENT_DATE,
    -- Salario del empleado.
    -- Valores: número decimal mayor que 0.
    Rate             INT  NOT NULL 
                     CHECK (Rate > 0),
    -- Frecuencia de pago.
    -- Valores:
    -- 1 = Mensual
    -- 2 = Quincenal
    PayFrequency     INT NOT NULL 
                     CHECK (PayFrequency IN (1,2)),
    -- Fecha y hora de la última modificación.
    -- Valores: CURRENT_TIMESTAMP.
    ModifiedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    -- Clave primaria compuesta para permitir varios cambios salariales por empleado.
    PRIMARY KEY (BusinessEntityID, RateChangeDate)      
);

-- Tabla que almacena la información de los candidatos a un puesto de trabajo.
CREATE TABLE JobCandidate (
    -- Identificador del candidato.
    -- Valores: enteros positivos generados automáticamente.
    JobCandidateID   INT AUTO_INCREMENT PRIMARY KEY,
    -- Identificador del empleado asociado al candidato.
    -- Valores: identificadores existentes en la tabla Employee.
    BusinessEntityID INT,
    -- Currículum del candidato en formato XML.
    -- Valores: documento XML almacenado como texto.
    Resume           XMLTYPE,
    -- Fecha y hora de la última modificación.
    -- Valores: CURRENT_TIMESTAMP.
    ModifiedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    -- Clave foránea que relaciona el candidato con un empleado.
    FOREIGN KEY (BusinessEntityID)
        REFERENCES Employee(BusinessEntityID)
);

-- Tabla que almacena los departamentos de la empresa.
CREATE TABLE Department (
    -- Identificador único del departamento.
    -- Valores: enteros positivos generados automáticamente.
    DepartmentID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    -- Nombre del departamento.
    -- Valores: texto único (ej.: Ventas, Ingeniería, Marketing).
    Name VARCHAR(50) NOT NULL UNIQUE,
    -- Grupo al que pertenece el departamento.
    -- Valores: texto (ej.: Executive General and Administration, Sales and Marketing, Manufacturing).
    GroupName VARCHAR(50) NOT NULL,
    -- Fecha y hora de la última modificación.
    -- Valores: CURRENT_TIMESTAMP.
    ModifiedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Tabla que almacena los turnos de trabajo.
CREATE TABLE Shift (
    -- Identificador único del turno.
    -- Valores: enteros positivos generados automáticamente.
    ShiftID   INT AUTO_INCREMENT PRIMARY KEY,
    -- Nombre del turno.
    -- Valores: Day, Evening o Night.
    Name      VARCHAR(20) NOT NULL
              CHECK (Name IN ('Mañana', 'Tarde', 'Noche')),
    -- Hora de inicio del turno.
    -- Valores: hora válida (HH:MM:SS).
    StartTime TIME NOT NULL,
    -- Hora de finalización del turno.
    -- Valores: hora válida (HH:MM:SS). Puede haber turnos nocturnos de 22:00 a 06:00
    EndTime   TIME NOT NULL,
    -- Fecha y hora de la última modificación.
    -- Valores: CURRENT_TIMESTAMP.
    ModifiedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Tabla que almacena el historial de departamentos y turnos de los empleados.
CREATE TABLE EmployeeDepartmentHistory (
    -- Identificador del empleado.
    -- Valores: identificadores existentes en la tabla Employee.
    BusinessEntityID INT REFERENCES Employee(BusinessEntityID),
    -- Identificador del departamento.
    -- Valores: identificadores existentes en la tabla Department.
    DepartmentID INT REFERENCES Department(DepartmentID),
    -- Identificador del turno.
    -- Valores: identificadores existentes en la tabla Shift.
    ShiftID INT REFERENCES Shift(ShiftID),
    -- Fecha de inicio de la asignación.
    -- Valores: fecha válida (AAAA-MM-DD).
    StartDate DATE ,
    -- Fecha de finalización de la asignación.
    -- Valores: fecha válida (AAAA-MM-DD) o NULL si la asignación sigue vigente.
    EndDate DATE
        CHECK (EndDate IS NULL OR StartDate <= EndDate),
    -- Fecha y hora de la última modificación.
    -- Valores: CURRENT_TIMESTAMP.
    ModifiedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    -- Clave primaria compuesta.
    PRIMARY KEY (BusinessEntityID, DepartmentID, ShiftID, StartDate)        
);

ALTER TABLE employee ADD COLUMN Nombre VARCHAR(64) NOT NULL;
ALTER TABLE employee ADD COLUMN Apellido1 VARCHAR(64) NOT NULL;
ALTER TABLE employee ADD COLUMN Apellido2 VARCHAR(64);