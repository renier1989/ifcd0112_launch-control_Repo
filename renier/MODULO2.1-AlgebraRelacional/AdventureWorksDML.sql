-- Iniciar la transacción.
START TRANSACTION;

-- Vaciar las tablas;
DELETE FROM EmployeeDepartmentHistory;
DELETE FROM Employee;
DELETE FROM Shift;
DELETE FROM Department;

-- Insertar tres departamentos.
INSERT INTO Department (Name, GroupName)
VALUES
('Ventas', 'Comercial'),
('Producción', 'Fabricación'),
('Informática', 'Tecnología');

-- Insertar tres turnos.
INSERT INTO Shift (Name, StartTime, EndTime)
VALUES
('Mañana', '06:00:00', '14:00:00'),
('Tarde',  '14:00:00', '22:00:00'),
('Noche',  '22:00:00', '06:00:00');

-- Insertar tres empleados.
INSERT INTO Employee (Nombre, Apellido1,Apellido2,NationalIDNumber, ROWGUID)
VALUES
('Angel','Martinez',NULL,'11111111A', 1),
('Maria','Andrade','Colmenares','22222222B', 2),
('Pedro','Uzcategui',NULL,'33333333C', 3);

/*
UPDATE employee
SET Nombre=CONCAT('Nombre',BusinessEntityID)
, SET Apellido1=CONCAT('Apellido',BusinessEntityID);
*/

-- Asignar un departamento y un turno a cada empleado.
INSERT INTO EmployeeDepartmentHistory
(BusinessEntityID, DepartmentID, ShiftID, StartDate)
VALUES
(1, 1, 1, CURRENT_DATE),
(2, 2, 2, CURRENT_DATE),
(3, 3, 3, CURRENT_DATE);

-- Confirmar la transacción.
COMMIT;