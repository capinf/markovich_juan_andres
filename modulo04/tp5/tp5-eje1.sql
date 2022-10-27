-- Curso Full Stack Developer - Silicion Misiones - 2022
-- Comisión B
-- TP5 - Ejercicio 2
-- Alumno: Juan Andrés Markovich

-- 1. Lista el apellido de todos los empleados.
SELECT apellido 
		FROM sistema.empleados;

	
-- 2. Lista el apellido de los empleados eliminando los apellidos que estén repetidos.
SELECT DISTINCT apellido 
		FROM sistema.empleados;
	
-- 3. Lista todas las columnas de la tabla empleados.
SELECT * 
		FROM sistema.empleados;

-- 4. Lista el nombre y apellido de todos los empleados.
SELECT nombre, apellido 
		FROM sistema.empleados;


-- 5. Lista el cuit/cuil de los departamentos de los empleados que aparecen en la tabla empleados.
SELECT cuil_cuit 
		FROM sistema.empleados;

-- 6. Lista el nombre y apellido de los empleados en una única columna.
SELECT CONCAT_WS(' ', nombre, apellido) AS 'Nombre y Apellido' 
		FROM sistema.empleados;

-- 7. Lista el nombre y apellido de los empleados en una única columna, convirtiendo todos los caracteres en mayúscula.
SELECT UPPER(CONCAT_WS(' ', nombre, apellido)) AS 'Nombre y Apellido' 
		FROM sistema.empleados;

-- 8. Lista el nombre y apellido de los empleados en una única columna, convirtiendo todos los caracteres en minúscula.
SELECT LOWER(CONCAT_WS(' ', nombre, apellido)) AS 'Nombre y Apellido' 
		FROM sistema.empleados;

-- 9. Lista el nombre de los departamentos y el valor del presupuesto actual ordenado de forma ascendente.
SELECT nombre, presupuesto 
		FROM sistema.departamentos 
		ORDER BY presupuesto ASC;


-- 10. Lista el nombre de todos los departamentos ordenados de forma ascendente.
SELECT nombre 
		FROM sistema.departamentos 
		ORDER BY nombre ASC;


-- 11. Lista el nombre de todos los departamentos ordenados de forma descendente.
SELECT nombre 
		FROM sistema.departamentos 
		ORDER BY nombre DESC;
	
	
-- 12. Lista el apellido y el nombre de todos los empleados, ordenados de forma alfabética tendiendo en cuenta en primer lugar su apellido y luego su nombre.	
SELECT apellido, nombre 
		FROM sistema.empleados 
		ORDER BY apellido, nombre;

-- 13. Devuelve una lista con el nombre y el presupuesto, de los 3 departamentos que tienen mayor presupuesto.
SELECT nombre AS departamento, presupuesto 
		FROM sistema.departamentos 
		ORDER BY presupuesto DESC LIMIT 3;


-- 14. Devuelve una lista con el nombre y el presupuesto, de los 3 departamentos que tienen menor presupuesto.
SELECT nombre AS departamento, presupuesto 
		FROM sistema.departamentos 
		WHERE presupuesto>0  
		ORDER BY presupuesto ASC LIMIT 3;


-- 15.	Devuelve una lista con el nombre de los departamentos y el presupuesto, de aquellos que tienen un presupuesto mayor o igual a $150000.
SELECT nombre AS departamento, presupuesto 
		FROM sistema.departamentos 
		WHERE presupuesto>=150000  
		ORDER BY presupuesto ASC;


-- 16.	Devuelve una lista con el nombre de los departamentos y el presupuesto, de aquellos que tienen un presupuesto entre $100000 y $200000. 
-- 		Sin utilizar el operador BETWEEN.
SELECT nombre AS departamento, presupuesto 
		FROM sistema.departamentos
		WHERE presupuesto=0;


-- 17.	Devuelve una lista con el nombre de los departamentos que no tienen un presupuesto entre $100000 y $200000. Sin utilizar el operador BETWEEN.
SELECT nombre AS departamento, presupuesto 
		FROM sistema.departamentos 
		WHERE presupuesto>0 AND (presupuesto<=100000 OR presupuesto>=200000);


-- 18.	Devuelve una lista con el nombre de los departamentos que tienen un presupuesto entre $100000 y $200000. Utilizando el operador BETWEEN.
SELECT nombre AS departamento, presupuesto 
		FROM sistema.departamentos 
		WHERE presupuesto BETWEEN 100000 AND 200000;


-- 19. 	Devuelve una lista con el nombre de los departamentos que no tienen un presupuesto entre $100000 y $200000. 
-- 		Utilizando el operador BETWEEN.
SELECT nombre AS departamento, presupuesto 
		FROM sistema.departamentos 
		WHERE presupuesto NOT BETWEEN 100000 AND 200000;



-- 20. 	Devuelve un listado con los empleados y los datos de los departamentos donde trabaja cada uno.
SELECT CONCAT_WS(' ',e.nombre, e.apellido) AS 'Nombre y Apellido' , d.nombre AS 'Departamento' 
		FROM sistema.empleados AS e 
		JOIN sistema.departamentos AS d
		WHERE e.id_departamento = d.iddepartamento;


-- 21. 	Devuelve un listado con los empleados y los datos de los departamentos donde trabaja cada uno. 
-- 		Ordena el resultado, en primer lugar por el nombre del departamento (en orden alfabético) y en segundo lugar por apellido y el nombre de los empleados.
SELECT d.nombre AS 'Departamento', CONCAT_WS(' ',e.nombre, e.apellido) AS 'Nombre y Apellido'  
		FROM sistema.empleados AS e 
		JOIN sistema.departamentos AS d 
		WHERE e.id_departamento = d.iddepartamento ORDER BY d.nombre, e.nombre;


-- 22. Devuelve un listado con el código y el nombre del departamento, solamente de aquellos departamentos que tienen empleados.
SELECT DISTINCT d.iddepartamento AS 'Código', d.nombre 
		FROM sistema.empleados AS e 	
		JOIN sistema.departamentos AS d ON e.id_departamento = d.iddepartamento;


-- 23. Devuelve el nombre del departamento donde trabaja el empleado que tiene el cuit 27-38382980-3.
SELECT d.nombre 
		FROM sistema.departamentos AS d 
		JOIN sistema.empleados AS e ON e.id_departamento = d.iddepartamento 
		WHERE e.cuil_cuit = '27-38382980-3';


-- 24. Devuelve el nombre del departamento donde trabaja el empleado Pepe Ruiz.
SELECT d.nombre 
		FROM sistema.departamentos AS d 
		JOIN sistema.empleados AS e ON e.id_departamento = d.iddepartamento 
		WHERE e.nombre  = 'Pepe' AND e.apellido = 'Ruiz';


-- 25.  Devuelve un listado con los datos de los empleados que trabajan en el departamento de I+D. Ordena el resultado alfabéticamente.
SELECT CONCAT_WS(' ',e.nombre, e.apellido) AS 'Nombre y Apellido' , e.cuil_cuit,  d.nombre AS 'Departamento' 
		FROM sistema.empleados AS e 
		JOIN sistema.departamentos AS d ON e.id_departamento = d.iddepartamento
		WHERE d.nombre = 'I+D';


-- 26. Devuelve un listado con los datos de los empleados que trabajan en el departamento de Sistemas, Contabilidad o I+D. Ordena el resultado alfabéticamente.
SELECT CONCAT_WS(' ',e.nombre, e.apellido) AS 'Nombre y Apellido' , e.cuil_cuit,  d.nombre AS 'Departamento' 
		FROM sistema.empleados AS e 
		JOIN sistema.departamentos AS d ON e.id_departamento = d.iddepartamento 
		WHERE d.nombre = 'I+D' OR d.nombre = 'Contabilidad' OR d.nombre = 'Sistemas' 
		ORDER BY e.nombre;


-- 27 Devuelve una lista con el nombre de los empleados que tienen los departamentos que no tienen un presupuesto entre $100000 y $200000.
SELECT CONCAT_WS(' ',e.nombre, e.apellido) AS 'Nombre y Apellido' , d.nombre AS 'Departamento' , d.presupuesto 
		FROM sistema.empleados AS e JOIN sistema.departamentos AS d ON e.id_departamento = d.iddepartamento 
		WHERE d.presupuesto<100000 OR d.presupuesto>200000
		ORDER BY d.presupuesto ASC;

