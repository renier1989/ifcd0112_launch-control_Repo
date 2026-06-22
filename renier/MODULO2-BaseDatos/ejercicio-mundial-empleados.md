## Empresa Multinacional

Una empresa multinacional requiere diseñar una base de datos relacional para gestionar la estructura de sus oficinas a nivel global, sus departamentos, los puestos de trabajo disponibles y el historial laboral de todos sus empleados.

La empresa opera en distintas Regiones del mundo. De cada región se necesita almacenar un identificador único numérico y su nombre oficial.
Cada región contiene uno o varios Países. De cada país se registra su identificador único (código de letras) y su nombre.
Dentro de los países se encuentran diferentes Ubicaciones físicas (oficinas o sedes). De cada ubicación se debe guardar un identificador único, la dirección de la calle, el código postal, la ciudad y el estado o provincia donde se localiza.

La empresa se organiza en Departamentos (por ejemplo: Ventas, Finanzas, IT). De cada departamento se almacena un identificador único y el nombre del departamento.

Existen diferentes tipos de Trabajos o roles definidos en la compañía. Cada trabajo tiene un identificador único (código de texto), un título del puesto (nombre del rol), así como un salario mínimo y un salario máximo permitido para ese puesto.

Se requiere registrar a todos los Empleados de la organización. De cada uno se guarda un identificador único numérico, su nombre, apellido, correo electrónico (el cual debe ser único), número de teléfono, la fecha en que fue contratado, su salario actual y el porcentaje de comisión que le corresponde (si aplica).

Para mantener un registro de la evolución de los empleados, se debe almacenar el Historial de Trabajos. Se registrará de forma obligatoria la fecha de inicio y la fecha de finalización en la que un empleado ocupó un puesto específico dentro de un departamento determinado.

Una región puede albergar múltiples países, pero un país pertenece a una única región. Del mismo modo, un país puede tener muchas ubicaciones físicas, pero una ubicación pertenece a un solo país. Cada ubicación física corresponde exactamente a un país, y en una ubicación se pueden establecer uno o varios departamentos. Sin embargo, un departamento solo puede estar físicamente en una única ubicación.

* Un empleado trabaja obligatoriamente en un único departamento, pero un departamento puede tener asignados a muchos empleados.

* Un empleado desempeña un único trabajo o rol actual en la empresa, pero un mismo tipo de trabajo puede ser ejercido por muchos empleados.

* Un empleado puede dirigir (ser el gerente de) un departamento. Un departamento es dirigido exactamente por un empleado, el cual ejerce como su mánager.

* Un empleado puede supervisar o dirigir a otros empleados (relación de subordinación). Un empleado operativo es dirigido por un único mánager o supervisor.

* Un empleado puede pasar por varios puestos o departamentos a lo largo del tiempo, generando múltiples registros en su historial laboral. Cada registro de historial pertenece obligatoriamente a un único empleado, hace referencia al trabajo que desempeñó y al departamento en el que estuvo asignado durante ese periodo de tiempo.