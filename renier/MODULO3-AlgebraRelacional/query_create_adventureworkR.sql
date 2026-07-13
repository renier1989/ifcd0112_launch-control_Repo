-- creacion de BD
CREATE DATABASE if NOT EXISTS adventureworksR;

-- usamos la BD
USE adventureworksR;

-- Eliminacion de tablas si existen
DROP TABLE if EXISTS EmployeePayHistory;
DROP TABLE if EXISTS JobCandidate;
DROP TABLE if EXISTS EmployeeDepartmentHistory;
DROP TABLE if EXISTS Shift;
DROP TABLE if EXISTS Department;
DROP TABLE if EXISTS Employee;

-- creacion de tablas
CREATE TABLE Department 
( 
	DepartmentId 	INT 				AUTO_INCREMENT	PRIMARY KEY
	,`Name` 			VARCHAR(30)		NOT NULL UNIQUE 
	, GroupName 	VARCHAR(30)		NOT NULL
	, ModifiedDate TIMESTAMP		DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE Shift
(
	ShiftId 			INT 				AUTO_INCREMENT	PRIMARY KEY
	, `Name`			VARCHAR(50)		NOT NULL
	, StartTime		DATE 				NOT NULL 
	, EndTime		DATE 				NOT NULL 
	, ModifiedDate TIMESTAMP		DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE Employee
(
	BusinessEntityId 		INT 			AUTO_INCREMENT	PRIMARY KEY
	, NationalIdNumber	VARCHAR(25)	NOT NULL UNIQUE  
	, LoginId				VARCHAR(30) UNIQUE 
	, OrganizationNode	VARCHAR(30)  
	, OrganizationLevel	VARCHAR(25) NOT NULL 
	, JotTitle				VARCHAR(30) NOT NULL
	, BirthDate				DATE 			NOT NULL
	, MaritalStatus		VARCHAR(25) NOT NULL CHECK (Gender IN ('Soltero', 'Soltera', 'Casado', 'Casada', 'Viudo', 'Viuda', 'Divorciado', 'Divorciada'))
	, Gender					VARCHAR(15) NOT NULL CHECK (Gender IN ('M', 'F'))
	, HireDate				DATE  		NOT NULL 
	, SalariedFlag			BOOLEAN 		NOT NULL DEFAULT TRUE  
	, VacationHours		INT 			NOT NULL DEFAULT 0 
	, SickLeaveHours		INT 			NOT NULL DEFAULT 0 
	, CurrentFlag			BOOLEAN 		NOT NULL DEFAULT TRUE 
	, rowguid				INT			NOT NULL 
	, ModifiedDate 		TIMESTAMP	DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP	
);

CREATE TABLE JobCandidate
(
	JobCandidateId 		INT AUTO_INCREMENT PRIMARY KEY 
	, BusinessEntityId	INT
	, `Resume`				LONGTEXT NOT NULL 
	, ModifiedDate 		TIMESTAMP	DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP	
	, CONSTRAINT fk_jobcandidate_employee FOREIGN KEY (BusinessEntityId) REFERENCES Employee(BusinessEntityId) ON DELETE CASCADE
);

CREATE TABLE EmployeePayHistory
(
	BusinessEntityId 		INT			 
	, RateChangeDate		DATE			NOT NULL
	, Rate 					INT			NOT NULL CHECK(Rate > 0 )
	, PayFrequency 		INT			NOT NULL DEFAULT 0 COMMENT '0 - Mensual , 1 - Quincenal , 2 - Semanal' 
	, ModifiedDate 		TIMESTAMP	DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP	
	, PRIMARY KEY (BusinessEntityId, RateChangeDate	)
	, CONSTRAINT fk_employee_pay_history_employee FOREIGN KEY (BusinessEntityId) REFERENCES Employee(BusinessEntityId) ON DELETE CASCADE
);

CREATE TABLE EmployeeDepartmentHistory
(
	BusinessEntityId	INT			 
	, DepartmentId		INT 			 
	, ShiftId 			INT			 
	, StartDate 		DATE 			 
	, EndDate			DATE	
	, ModifiedDate 	TIMESTAMP	DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP	
	, PRIMARY KEY (BusinessEntityId, DepartmentId, ShiftId, StartDate )
	, CONSTRAINT fk_edh_employee FOREIGN KEY (BusinessEntityId) REFERENCES Employee(BusinessEntityId) ON DELETE CASCADE
	, CONSTRAINT fk_edh_department FOREIGN KEY (DepartmentId) REFERENCES Department (DepartmentId) ON DELETE CASCADE 
	, CONSTRAINT fk_edh_shift FOREIGN KEY (ShiftId) REFERENCES Shift (ShiftId) ON DELETE CASCADE
);

-- creacion de indices 
CREATE INDEX idx_employee_organization ON Employee(OrganizationLevel);
CREATE INDEX idx_employee_hiredate ON Employee(HireDate);
CREATE INDEX idx_employee_status_job ON Employee(CurrentFlag, JotTitle);
CREATE INDEX idx_edh_dates ON EmployeeDepartmentHistory(StartDate, EndDate);
CREATE INDEX idx_eph_rate_change_date ON EmployeePayHistory(RateChangeDate);
CREATE INDEX idx_eph_rate_analysis ON EmployeePayHistory(Rate, BusinessEntityId);


-- creacion de los trigers
-- -- valor auto generado para el campo rowguid
DELIMITER //
CREATE TRIGGER trg_employee_rowguid
BEFORE INSERT ON employee
FOR EACH ROW 
BEGIN
	SET NEW.rowguid = FLOOR(RAND() * 900000000) + 100000000;
END//

CREATE TRIGGER trg_shift_st
BEFORE INSERT ON Shift
FOR EACH ROW 
BEGIN
	IF NEW.StartTime <= CURDATE() then 
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'La fecha de inicio no puede ser posterior a la fecha actual' ;
	END IF;		
END//

CREATE TRIGGER trg_edh_sd
BEFORE INSERT ON EmployeeDepartmentHistory
FOR EACH ROW 
BEGIN
	IF NEW.StartDate <= CURDATE() then 
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'La fecha de inicio no puede ser posterior a la fecha actual' ;
	END IF;		
END//
DELIMITER ;


