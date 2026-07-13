

-- ###################################################################################
USE northwind;
SELECT * FROM employees e
INNER JOIN orders o ON e.id = o.employee_id
INNER JOIN purchase_orders po ON po.approved_by = e.id;


-- ###################################################################################
USE northwind2;
SELECT c.CategoryName, c.`Description` FROM categories c ORDER BY c.CategoryName; -- 1
SELECT c.ContactName, c.CompanyName, c.ContactTitle, c.Phone FROM customers c ORDER BY c.Phone;-- 2
SELECT UPPER(e.FirstName) FirstName, UPPER(e.LastName) LastName, e.HireDate FROM employees e ORDER BY e.HireDate DESC; -- 3
SELECT o.OrderID, o.OrderDate, o.ShippedDate, o.CustomerID, o.Freight FROM orders o ORDER BY o.Freight DESC LIMIT 10; -- 4
SELECT LOWER(c.CustomerID) ID FROM customers c ; -- 5
SELECT s.CompanyName, s.Fax, s.Phone, s.Country, s.HomePage FROM suppliers s ORDER BY s.Country DESC ,  s.CompanyName ASC; -- 6
SELECT c.CompanyName, c.ContactName FROM customers c WHERE c.City = 'Buenos Aires'; -- 7
SELECT p.ProductName, p.UnitPrice, p.QuantityPerUnit FROM products p WHERE p.UnitsInStock = 0; -- 8
SELECT c.ContactName, c.Address, c.City FROM customers c WHERE c.Country NOT IN ('Germany', 'Mexico','Spain'); -- 9
SELECT o.OrderDate, o.ShippedDate, o.CustomerID FROM orders o WHERE DATE_FORMAT(o.OrderDate, '%Y-%m-%d') = '1996-05-21'; -- 10
SELECT o.OrderDate, o.ShippedDate, o.CustomerID FROM orders o WHERE DATE_FORMAT(o.OrderDate, '%d %M %Y') = '04 July 1996'; -- 10
SELECT e.FirstName, e.LastName, e.Country FROM employees e WHERE e.Country <> 'USA'; -- 11
SELECT o.EmployeeID, o.OrderID, o.CustomerID,o.RequiredDate, o.ShippedDate FROM orders o WHERE o.ShippedDate > o.RequiredDate; -- 12
SELECT c.City, c.CompanyName, c.ContactName FROM customers c WHERE c.City LIKE 'A%' OR c.City LIKE 'B%' ORDER BY c.City; -- 13
SELECT o.OrderID FROM orders o WHERE o.OrderID % 2 = 0 ORDER BY 1; -- 14
SELECT * FROM orders o WHERE o.Freight > 500; -- 15
SELECT p.ProductName, p.UnitsInStock, p.UnitsOnOrder, p.ReorderLevel FROM products p WHERE p.UnitsInStock + p.UnitsOnOrder <=  p.ReorderLevel; -- 16
SELECT c.CompanyName, c.ContactName FROM customers c WHERE c.Fax IS NULL; -- 17
SELECT e.FirstName, e.LastName FROM employees e WHERE e.ReportsTo IS NULL; -- 18
SELECT o.OrderID FROM orders o WHERE o.OrderID % 2 != 0 ORDER BY 1; -- 19
SELECT c.CompanyName, c.ContactName, c.Fax FROM customers c WHERE c.Fax IS NULL ORDER BY c.ContactName; -- 20
SELECT c.City, c.CompanyName, c.ContactName FROM customers c WHERE c.City LIKE '%L%' ORDER BY c.ContactName; -- 21
SELECT e.FirstName, e.LastName , e.BirthDate FROM employees e WHERE YEAR(e.BirthDate) = '1950'; -- 22
SELECT e.FirstName, e.LastName , YEAR(e.BirthDate) AS "Birth Year" FROM employees e; -- 23
SELECT od.OrderID, COUNT(od.OrderID) AS "NumberofOrders" FROM orderdetails od GROUP BY od.OrderID ORDER BY NumberofOrders; -- 24
SELECT p.SupplierID,p.ProductName, s.CompanyName  FROM products p INNER JOIN suppliers s ON s.SupplierID = p.SupplierID 
WHERE s.CompanyName IN ('Exotic Liquids', 'Specialty Biscuits, Ltd.','Escargots Nouveaux') ORDER BY p.SupplierID; -- 25
SELECT o.ShipPostalCode,o.OrderID, o.RequiredDate, o.ShippedDate FROM orders o WHERE o.ShipPostalCode LIKE '98124%'; -- 26
SELECT c.ContactName, c.ContactTitle, c.CompanyName FROM customers c WHERE c.ContactTitle LIKE '%Sales%'; -- 27
SELECT e.FirstName, e.LastName, e.City FROM employees e WHERE e.City <> 'Seattle'; -- 28
SELECT c.CompanyName, c.ContactTitle, c.City, c.Country FROM customers c 
WHERE c.Country = 'Mexico' OR (c.Country = 'Spain' AND c.City !='Madrid'); -- 29
SELECT CONCAT(e.FirstName,' ', e.LastName, ' can be reached at x',e.Extension) AS ContactInfo FROM employees e ; -- 30



SELECT DISTINCT e.LastName , e.LastName, r.RegionDescription 
			FROM employees e 
			Right JOIN  employeeterritories et ON e.EmployeeID = et.EmployeeID
			Right JOIN  territories t ON et.TerritoryID = t.TerritoryID
			Right JOIN region r ON t.RegionID = r.RegionID;

SELECT DISTINCT 
r.RegionDescription , COUNT(e.EmployeeID) AS totalR
			FROM employees e 
			right outer JOIN  employeeterritories et ON e.EmployeeID = et.EmployeeID
			right outer join  territories t ON et.TerritoryID = t.TerritoryID
			right outer join region r ON t.RegionID = r.RegionID
			GROUP BY r.RegionID
			union
SELECT  DISTINCT 
r.RegionDescription , COUNT(e.EmployeeID) AS totalR
			FROM employees e
			left outer JOIN  employeeterritories et ON e.EmployeeID = et.EmployeeID
			left outer join  territories t ON et.TerritoryID = t.TerritoryID
			left outer join region r ON t.RegionID = r.RegionID
			GROUP BY r.RegionID
			ORDER BY RegionDescription;
			
			
-- empleado que mas gana
SELECT e.FirstName , e.Salary
FROM employees e 
WHERE salary = (	
	SELECT MAX(e.Salary) AS salary  FROM employees e
	);			
	
-- fecha del pedido con mayor cuantia economica
SELECT o.ShippedDate FROM orders o WHERE o.OrderID IN 
	(SELECT od.OrderID FROM orderdetails od WHERE od.UnitPrice * od.Quantity * (1-od.Discount) =
		(SELECT MAX(od.UnitPrice * od.Quantity * (1-od.Discount)) "maximo" FROM orderdetails od)
	);

-- empleados que ganan un salario mayor que el salario medio que se paga en cualquier region

SELECT e.FirstName, e.Salary FROM employees e WHERE salary > all 
(
SELECT AVG(e.Salary) media_salario
			FROM employees e 
			inner JOIN  employeeterritories et ON e.EmployeeID = et.EmployeeID
			inner JOIN  territories t ON et.TerritoryID = t.TerritoryID
			inner JOIN region r ON t.RegionID = r.RegionID
			GROUP BY r.RegionID
) ORDER BY e.Salary DESC;


SELECT * FROM employees e;
SELECT * FROM employeeterritories;
SELECT * FROM territories t ORDER BY t.RegionID;
SELECT * FROM region r;
			
SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM orderdetails;
SELECT * FROM products;

SELECT o.OrderDate, DATE_FORMAT(o.OrderDate, '%d %M %Y') FROM orders o 


-- ###################################################################################
USE hr;
SELECT * FROM employees e WHERE e.department_id IS NULL;

SELECT d.department_name AS "Nombre del Departamento", COUNT(e.department_id) AS "Total por departamento"
FROM employees e 
INNER JOIN departments d ON e.department_id = d.department_id
GROUP BY e.department_id 
ORDER BY d.department_name ASC;


SELECT  NVL(d.department_name,'pendiente por asignar') AS "Nombre del Departamento", COUNT(e.employee_id) AS "Total por departamento"
FROM employees e 
LEFT JOIN departments d ON e.department_id = d.department_id
GROUP BY e.department_id 
ORDER BY d.department_name ASC;


SELECT 
CASE
	when d.department_name IS NULL then 'Pendiente por asignar'
	ELSE d.department_name
END  AS "Nombre del Departamento" 
-- d.department_name AS "Nombre del Departamento"
, COUNT(e.employee_id) AS "Empleados por Asignar"
FROM employees e 
left JOIN departments d ON e.department_id = d.department_id
GROUP BY e.department_id
ORDER BY d.department_name ASC;

-- empleados que ganan mas que sus jefes.
SELECT e.first_name AS empleado, e.salary AS salario_empleado , ee.first_name AS jefe, ee.salary
FROM employees e
INNER JOIN employees AS ee ON e.manager_id = ee.employee_id
WHERE e.salary > ee.salary;

-- cuantos empleados por region
SELECT CONCAT(e.first_name, ' ',e.last_name) AS "Empleado"
, NVL(r.region_name, 'Sin region Asignada') AS "Region Asignada" 
FROM employees e
inner JOIN departments d ON d.department_id = e.employee_id
inner JOIN locations l ON l.location_id = d.location_id
inner JOIN countries c ON c.country_id = l.country_id
inner JOIN regions r ON r.region_id = c.region_id;


SELECT r.region_name AS "Region"
, COUNT(e.employee_id) as "Total Asignados"
FROM employees e
inner JOIN departments d ON d.department_id = e.department_id
inner JOIN locations l ON l.location_id = d.location_id
inner JOIN countries c ON c.country_id = l.country_id
right JOIN regions r ON r.region_id = c.region_id
GROUP by r.region_name
UNION 
SELECT NVL(r.region_name,'Sin Region') AS "Region"
, COUNT(e.employee_id) as "Total Asignados"
FROM employees e
left JOIN departments d ON d.department_id = e.department_id
left JOIN locations l ON l.location_id = d.location_id
left JOIN countries c ON c.country_id = l.country_id
left JOIN regions r ON r.region_id = c.region_id
GROUP BY r.region_id,r.region_name
;


SELECT coalesce(r.region_name,'Sin Region') AS "Region"
, COUNT(e.employee_id) as "Total Asignados"
FROM employees e
left JOIN departments d ON d.department_id = e.department_id
left JOIN locations l ON l.location_id = d.location_id
left JOIN countries c ON c.country_id = l.country_id
left JOIN regions r ON r.region_id = c.region_id
GROUP BY r.region_id,r.region_name
UNION 
SELECT "Sin Region",
COUNT(*) 
FROM employees e
WHERE e.department_id IS NULL
ORDER BY 1;


SELECT d.department_name, l.* FROM departments d  
INNER JOIN locations l USING(location_id);
SELECT * FROM departments;

SELECT * FROM employees;
SELECT * FROM locations;
SELECT * FROM countries;
SELECT * FROM regions;
SELECT * FROM job_history;


-- ##################### uso de funciones ###########################
USE northwind2;
SELECT e.HireDate, e.HireDate+INTERVAL '1:30:30' HOUR_SECOND FROM employees e;
SELECT e.HireDate, e.HireDate+INTERVAL '1' YEAR FROM employees e;
SELECT e.HireDate, date(e.HireDate) FROM employees e;

SELECT e.HireDate 
		,ADD_MONTHS(e.HireDate,12*CEIL(MONTHS_BETWEEN
       (NOW(),
        e.HireDate 
       )/12)) AS "Proximo Aniversario"
		 FROM employees e;
		 
SELECT DATE_ADD(
 			e.HireDate, 
			INTERVAL CEIL(MONTHS_BETWEEN (NOW(),e.HireDate )/12)
			YEAR) AS "Proximo Aniversario"
FROM employees e;

SELECT 
    e.HireDate,
    DATE_ADD(
        e.HireDate, 
        INTERVAL CEIL(TIMESTAMPDIFF(MONTH, e.HireDate, NOW()) / 12) YEAR
    ) AS "Proximo Aniversario",
    CONCAT(
        TIMESTAMPDIFF(YEAR, e.HireDate, NOW()), ' Año(s) ',
        TIMESTAMPDIFF(MONTH, DATE_ADD(e.HireDate, INTERVAL TIMESTAMPDIFF(YEAR, e.HireDate, NOW()) YEAR), NOW()), ' mes(es) ',
        DATEDIFF(
            NOW(), 
            DATE_ADD(
                DATE_ADD(e.HireDate, INTERVAL TIMESTAMPDIFF(YEAR, e.HireDate, NOW()) YEAR), 
                INTERVAL TIMESTAMPDIFF(MONTH, DATE_ADD(e.HireDate, INTERVAL TIMESTAMPDIFF(YEAR, e.HireDate, NOW()) YEAR), NOW()) MONTH
            )
        ), ' dia(s)'
    ) AS "Antigüedad"
FROM employees e;

-- ####################################################################################
USE hr;

SELECT 
	CONCAT( 
			LPAD(FORMAT(e.salary,2),LENGTH('##,###,###.##')) 
			,' '
			, CHAR(14844588 USING utf8mb4)
		)AS "Salario Fijo"
	, NVL( CONCAT(LPAD(FORMAT(e.salary * e.commission_pct,2 ),LENGTH('##,###,###.##'))
			,' '
			, CHAR(14844588 USING utf8mb4)
		),'') AS "Comision Variable" 
	, CONCAT(
			LPAD( NVL(FORMAT(e.salary * (1+e.commission_pct), 2),e.salary),LENGTH('##,###,###.##') )
			, ' '
			, CHAR(14844588 USING utf8mb4)
		) "Total" 
FROM employees e;

SELECT 
CONCAT(
	LPAD(e.employee_id,6,' ')
	, LPAD(CONCAT(
					UCASE( SUBSTRING(e.first_name,1,1))
					,LCASE(SUBSTRING(e.first_name,2))
					,' '
					,UCASE(SUBSTRING(e.last_name,1,1))
					,LCASE(SUBSTRING(e.last_name,2))
				),34,'.' 
			) 
) AS "Indice"
FROM employees e
ORDER BY e.employee_id asc;

/*
CREATE TABLE listado 
SELECT 
CONCAT(
	LPAD(e.employee_id,6,' ')
	, LPAD(CONCAT(
					UCASE( SUBSTRING(e.first_name,1,1))
					,LCASE(SUBSTRING(e.first_name,2))
					,' '
					,UCASE(SUBSTRING(e.last_name,1,1))
					,LCASE(SUBSTRING(e.last_name,2))
				),34,'.' 
			) 
) AS "Indice"
FROM employees e
ORDER BY e.employee_id asc;
*/

SELECT 
	l.indice
,  REGEXP_SUBSTR(l.indice, '[0-9]+') AS "ID"
,  REGEXP_SUBSTR(l.indice, '[a-zA-Z ]+$') AS "Nombre Completo" 
,  REGEXP_SUBSTR(REGEXP_SUBSTR(l.indice, '[a-zA-Z ]+$'), '^[^ ]+') AS Nombre,
	TRIM(REGEXP_SUBSTR(REGEXP_SUBSTR(l.indice, '[a-zA-Z ]+$'), ' +.*$')) AS Apellido
FROM listado l
ORDER BY Apellido;
