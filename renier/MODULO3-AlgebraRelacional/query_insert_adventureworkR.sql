START TRANSACTION;

INSERT INTO `adventureworks`.`department` (`Name`, `GroupName`) 
VALUES 
('IT', 'Tecnologia')
,('Contabilidad', 'Finanzas')
,('Gestion Humana', 'RRHH');

INSERT INTO `adventureworks`.`shift` (`Name`, `StartTime`, `EndTime`) 
VALUES 
('Mañana', '07:30:00', '12:30:00')
,('Tarde', '12:30:00', '16:30:00')
,('Noche', '16:30:00', '21:30:00');


INSERT INTO `adventureworks`.`employee` 
(`NationalIDNumber`, `LoginID`, `OrganizationNode`, `OrganizationLevel`, `JobTitle`, `BirthDate`, `MaritalStatus`, `Gender`, `HireDate`, `ROWGUID`) 
VALUES 
('123ABC', '5555', 'Industria especializada', 'Employee', 'Analista', '1989-07-13', 'Casado', 'Masculino', '2023-07-13', 1001)
,('234ABC', '4444', 'Cargador de Cajas', 'Employee', 'Soporte', '1980-02-11', 'Casado', 'Masculino', '2020-05-22', 1002)
,('345ABC', '3333', 'Observador del trabajo', 'Supervisor', 'Observador', '1990-02-11', 'Divorciado', 'Femenino', '2010-03-25', 1003);

INSERT INTO `adventureworks`.`employeedepartmenthistory` 
(`BusinessEntityID`, `DepartmentID`, `ShiftID`, `StartDate`) 
VALUES (1, 1, 1, '2021-07-13')
,(2, 2, 2, '2020-08-14')
,(3, 3, 3, '2019-09-15');

COMMIT;