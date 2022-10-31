-- Curso Full Stack Developer - Silicion Misiones - 2022
-- Comisión B
-- TP6 - Ejercicio #1
-- Alumno: Juan Andrés Markovich 

DROP DATABASE IF EXISTS elsistema;
CREATE DATABASE IF NOT EXISTS elsistema CHARACTER SET utf8mb4;
USE elsistema;

CREATE TABLE departamentos (
iddepartamento INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
presupuesto DOUBLE UNSIGNED NOT NULL,
estado BOOLEAN NULL
);

CREATE TABLE empleados (
idemplaedo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
cuil_cuit VARCHAR(15) NOT NULL UNIQUE,
nombre VARCHAR(100) NOT NULL,
apellido VARCHAR(100) NOT NULL,
id_departamento INT UNSIGNED,
estado BOOLEAN,
FOREIGN KEY (id_departamento) REFERENCES departamentos(iddepartamento)
);
 
CREATE TABLE clientes (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(30) NOT NULL,
apellido VARCHAR(30) NOT NULL,
cuitcuil VARCHAR(20),
ciudad VARCHAR(100),
categoría INT UNSIGNED
);

CREATE TABLE vendedores (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(30) NOT NULL,
apellido VARCHAR(30) NOT NULL,
cuitcuil VARCHAR(20),
comisión FLOAT
);

CREATE TABLE pedidos (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
cantidad DOUBLE NOT NULL,
fecha DATE,
id_cliente INT UNSIGNED NOT NULL,
id_vendedor INT UNSIGNED NOT NULL,
FOREIGN KEY (id_cliente) REFERENCES clientes(id),
FOREIGN KEY (id_vendedor) REFERENCES vendedores(id)
);



-- 1. Agregar las entidades paises (id, nombre), provincias (id, nombre, id_pais) y localidades (id,nombre, cp, id_provincia).
-- Tener en cuenta que:
-- * En un país hay muchas provincias.
-- * En una provincia hay muchas localidades.

CREATE TABLE paises (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
estado BOOLEAN NULL
);

CREATE TABLE provincias (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
id_pais INT UNSIGNED NOT NULL,
	FOREIGN KEY (id_pais) 
	REFERENCES paises(id)
);


CREATE TABLE localidades (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
id_provincia INT UNSIGNED NOT NULL,
	FOREIGN KEY (id_provincia) 
	REFERENCES provincias(id)
);


-- 2. Modificar la tabla empleados usando ALTER TABLE y agregar los campos:
-- * direccion (varchar)
-- * id_localidad (pk localidad) – Esta es un relación con la tabla localidades
-- * email
-- * telefono
-- * fecha_ingreso
-- * tms (timestamp)
ALTER TABLE empleados 
ADD COLUMN direccion VARCHAR(45) NOT NULL AFTER apellido,
ADD COLUMN id_localidad INT UNSIGNED NOT NULL,
ADD COLUMN email VARCHAR(60) NOT NULL AFTER estado,
ADD COLUMN telefono VARCHAR(45) NOT NULL AFTER email,
ADD COLUMN fecha_ingreso DATE NULL AFTER telefono,
ADD COLUMN tms TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP AFTER fecha_ingreso,
ADD FOREIGN KEY (id_localidad) REFERENCES localidades(id);



-- 3 Modificar la tabla de departamentos usando ALTER TABLE y agregar los campos:
-- * gasto (double)
-- * tms (timestamp)
ALTER TABLE departamentos 
ADD COLUMN gasto DOUBLE NULL AFTER presupuesto,
ADD COLUMN tms TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP AFTER estado;



-- 4. Insertar 5 registros en cada tabla de: paises, provincias, localidades, departamentos, empleados.
-- Paises
INSERT INTO paises (nombre,estado) VALUES 
	('Argentina',1),
	('Brasil',1),
	('Paraguay',1),
	('Uruguay',1),
	('Mexico',1);

-- Presentación de la tabla
SELECT * FROM paises;

-- Provincias
INSERT INTO provincias (nombre,id_pais) VALUES 
	('Misiones',1),
	('Corrientes',1),
	('Entre Rios',1),
	('Santa Fé',1),
	('Misiones',3);

-- Presentación de la tabla
SELECT * FROM provincias;

-- Localidades
INSERT INTO localidades (nombre,id_provincia) VALUES 
	('Posadas',1),
	('Oberá',1),
	('Eldorado',1),
	('Corrientes',2),
	('Rosario',4),
	('San Lorenzo',5),
	('Lambaré',5),
	('Luque',5);

-- Presentación de la tabla
SELECT * FROM localidades;

-- Departamentos ----> Lo inserto aquí porque sino en el proximo insert da error.
INSERT INTO departamentos (nombre,presupuesto,gasto,estado) 	VALUES 
	('Administracion',150000,32000,1),
	('Tesoreria',85000,65000,1),
	('Suministros',60000,23000,0),
	('Logística',123000,84000,1);

-- Presentación de la tabla
SELECT * FROM departamentos;


-- Empleados
INSERT INTO elsistema.empleados (cuil_cuit,nombre,apellido,direccion,id_departamento,id_localidad,estado,email,telefono,fecha_ingreso,tms) VALUES
	('27-29045142-5','Juan Andres','Markovich','Barrio Sur Argentino',1,1,1,'capinf@gmail.com','376-4256580','2022-01-01','2022-10-29 10:04:04'),
	('27-35256854-8','Rodrigo','Larreta','Calle 178 s/n',2,1,0,'rodrigo@gmail.com','376-4332502','2010-05-10','2022-10-29 10:04:04'),
	('23-05425472-3','Alma Rosario','Bárbaro','José Hernandez 2552',3,2,1,'almarosario@gmail.com','375-5426205','2005-02-25','2022-10-29 10:04:04'),
	('23-21587436-6','Josefa','Ramírez','Acosta s/n',4,3,1,'lajosefa@gmail.com','351-2531547','2002-10-17','2022-10-29 10:04:04'),
	('27-39456253-2','Matias','Rojas','Barrio San Isidro',1,1,1,'elcolorojas@gmail.com','376-2566789','2007-11-25','2022-10-29 10:04:04');

-- Presentación de la tabla
SELECT * FROM empleados;



-- 5. Modificar el nombre de la tabla “pedidos” por “movimientos”. RENAME TABLE
ALTER TABLE pedidos
RENAME TO movimientos;

-- Presentación de la tabla
SELECT * FROM movimientos;


-- 6. Agregar las entidades Marcas, Productos, Proveedores y Cajas:
-- Notas: Muchos productos tienen una sola marca, o una marca tiene uno o muchos productos. Un proveedor está en una localidad.

-- Marcas (id, nombre, descripción, imagen, id_proveedor, estado, tms)
CREATE TABLE marcas (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
descripcion VARCHAR(100) NULL,
imagen VARCHAR(150) NULL,
id_proveedor INT UNSIGNED NOT NULL,
estado BOOLEAN NULL,
tms TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Productos (id, nombre, descripcion, imagen, stock, precio, estado, tms, id_marca fk)
CREATE TABLE productos (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
descripcion VARCHAR(100) NULL,
imagen VARCHAR(150) NULL,
stock INT NULL,
precio INT UNSIGNED NULL,
estado BOOLEAN NULL,
tms TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
id_marca INT UNSIGNED NOT NULL,
	FOREIGN KEY (id_marca) 
	REFERENCES marcas(id)
);

-- Proveedores (id, naturaleza (fisica o juridica), razon_social, nombre, apellido,  cuit, estado,tms, id_localidad fk)
CREATE TABLE proveedores (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
naturaleza ENUM('física','jurídica') NOT NULL,
razon_social VARCHAR(150) NULL,
nombre VARCHAR(100) NULL,
apellido VARCHAR(50) NULL,
cuit VARCHAR(13) NULL,
estado BOOLEAN NULL,
tms TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
id_localidad INT UNSIGNED NOT NULL,
	FOREIGN KEY (id_localidad) 
	REFERENCES localidades(id)
);

-- Cajas (id,horainicio(datatime),horacierre(datatime), estado, tms)
CREATE TABLE cajas (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
horar_incio DATETIME NOT NULL,
horar_cierre DATETIME NOT NULL,
estado BOOLEAN NULL,
tms TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- 7. Insertar 5 registros en cada tabla del punto 6. Tener en cuenta que el script debe ejecutarse secuencialmente y no fallar.
INSERT INTO proveedores (naturaleza,razon_social,nombre,apellido,cuit,estado,id_localidad) VALUES 
	('física','El Proveedor','Ramón Alberto','Markovich','20-29842677-4',1,2),
	('física','La Casa de las Golosinas','José Alberto','Romero','20-27256842-4',1,1),
	('jurídica','ARCOR SAIC','NULL','NULL','30-65597770-4',1,4),
	('física','Ilolay','Pedro ','Perez','20-05935741-2',1,1),
	('jurídica','Oblita SA','NULL','NULL','30-26514298-6',1,4);

-- Presentación de la tabla
SELECT * FROM proveedores;


INSERT INTO marcas (nombre,descripcion,imagen,id_proveedor,estado,tms) VALUES
	('ARCOR','SAIC',NULL,1,1,'2022-10-28 15:31:18'),
	('POZO','GALLETITAS',NULL,1,1,'2022-10-28 15:31:18'),
	('LHERITIER','CHOCOLATES Y DULCES',NULL,1,1,'2022-10-28 15:31:18'),
	('JULICROC','SNACKS',NULL,2,1,'2022-10-28 15:31:18'),
	('HOJALMAR','GALLETITAS Y CRACKERS',NULL,3,1,'2022-10-28 15:31:18');

-- Presentación de la tabla
SELECT * FROM marcas;


INSERT INTO productos (nombre,descripcion,stock,precio,estado,id_marca) VALUES 
	('Chocolate Misky Blanco','30x25g ',10,1445.2,1,1),
	('Dulce de Batata Noel','Lata x5kg',10,1263.2,1,1),
	('Chupetin Picol Dulce','Pote x48u',10,723.5,1,3),
	('Papas Fritas PAI Julicroc','24x100g',10,114.5,1,4),
	('Minibudines Vainilla','x210g',10,132.5,1,5);

-- Presentación de la tabla
SELECT * FROM productos;


INSERT INTO cajas (horar_incio,horar_cierre,estado) VALUES 
	('2022-10-10 15:31:18','2022-10-10 20:31:18',1),
	('2022-10-12 15:31:18','2022-10-12 20:31:18',1),
	('2022-10-17 15:31:18','2022-10-17 20:31:18',1),
	('2022-10-20 15:31:18','2022-10-20 20:31:18',1),
	('2022-10-28 15:31:18','2022-10-28 21:31:18',1);

-- Presentación de la tabla
SELECT * FROM cajas;



-- No pide clientes, pero no se puede hacer más abajo la tarea si no hay clientes ....
INSERT INTO clientes (nombre,apellido,cuitcuil,ciudad,categoría)	VALUES 
	('Joselo','Lopez','20-293542142-7','Posadas',1),
	('Ramón','Ramirez','20-093254142-5','Oberá',1);

-- Presentación de la clientes
SELECT * FROM clientes;



-- 8. Listar el nombre, presupuesto, gastos y diferencia(presupuesto-gasto) de todos los departamentos con estado activo o 1.
SELECT d.nombre AS Departamento, d.presupuesto AS Presupuesto, d.gasto AS Gasto, (d.presupuesto-d.gasto) AS Saldo
		FROM departamentos AS d
		WHERE d.estado = 1;
	
-- 9. Listar todas todas las localidades agrupadas por pais. En la vista se deberia ver el nombre del pais y el nombre de la localidad
SELECT p.nombre AS 'País', l.nombre AS 'Localidad'  
		FROM provincias AS pro
		JOIN paises AS p ON p.id = pro.id_pais
		JOIN localidades AS l ON l.id_provincia = pro.id
		GROUP BY p.nombre, l.nombre; 
	
	
-- 10. Modificar (UPADTE):
-- * el telefono de un empleado cuando el id es igual a uno que hayan declarado.
-- * el fecha_ingreso y la localidad de otro empleado.

UPDATE empleados AS e 
SET e.telefono  = '376-4328260'
WHERE e.idemplaedo  = 1;

-- Presentación del resultado
SELECT e.telefono  FROM empleados AS e WHERE e.idemplaedo = 1;

-- 11. Insertar 5 vendedores.
--  Auto-generated SQL script #202210291019
INSERT INTO vendedores (nombre,apellido,cuitcuil,comisión) VALUES 
	('Rodrigo ','Osorio','27-35325482-9',0.15),
	('Paula','Moreira','23-32658412-7',0.13),
	('Aldana','Brignole','23-42524789-9',0.11),
	('Axel','Felis','27-45236985-7',0.15),
	('Mariano','Bustos','27-31524862-5',0.16);
	

-- Presentación de la tabla
SELECT * FROM vendedores;

-- 12. Modificar la tabla movimientos y agregar los campos: id_producto fk, estado, tms(timestamp), tipo_movimiento (ingreso, egreso, pedido)

ALTER TABLE movimientos 
ADD COLUMN tipo_movimiento ENUM('Ingreso', 'Egreso', 'Pedido') NOT NULL AFTER id,
ADD COLUMN id_producto INT UNSIGNED NOT NULL AFTER id_vendedor,
ADD COLUMN estado TINYINT NULL AFTER id_producto,
ADD COLUMN tms TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP AFTER estado,
ADD	FOREIGN KEY (id_producto) REFERENCES productos(id);
	
-- 13. Insertar 5 movimientos distintos.
--  Auto-generated SQL script #202210291039
INSERT INTO movimientos (tipo_movimiento,cantidad,fecha,id_cliente,id_vendedor,id_producto,estado) VALUES 
	('Ingreso',100,'2022-10-10',1,1,1,1),
	('Egreso',5,'2022-10-11',1,1,2,1),
	('Egreso',5,'2022-10-11',2,3,3,1),
	('Ingreso',10,'2022-10-12',1,2,3,0),
	('Ingreso',30,'2022-10-12',2,4,5,1);

-- Presentación de la tabla
SELECT * FROM movimientos;
	
-- 14. Borrar lógicamente (UPDATE de la columna estado):

-- * 2 movimientos que fueron cargados mal
UPDATE paises AS p
SET p.estado = 0
WHERE p.id = 4 OR p.id = 5;

-- * un pais que tenga al menos 3 localidades

	
DELETE
		FROM localidades 
		WHERE id_provincia = 5;
DELETE 
		FROM provincias 
		WHERE id_pais = 3;
DELETE
		FROM paises 
		WHERE id = 3;

-- // Presentación de resultados  ..
SELECT *
		FROM provincias AS pro
		JOIN paises AS p ON pro.id_pais = p.id;
SELECT * 	
		FROM paises p;

	
-- 15. Modificar el campo stock de la tabla productos teniendo en cuenta la cantidad de la tabla de movimientos. 
-- sumar el stock si es un ingreso, restar si es un egreso. Esto hacerlo de manera manual en base los 5 movimientos insertados en el punto 13. 
-- Es decir deben haber 5 updates de la tabla producto.select * from movimientos as m ;

	SELECT id, nombre,  descripcion, stock FROM productos;

SELECT p.id, p.nombre , m.tipo_movimiento, m.cantidad 
	FROM movimientos AS  	m
	JOIN productos AS p ON m.id_producto = p.id ;
	
UPDATE productos AS prod
	JOIN
	(
		SELECT	mov.id_producto, sum(cantidad) AS suma 
		FROM movimientos AS mov
		WHERE mov.tipo_movimiento = 'Ingreso'
		GROUP BY mov.id_producto
	) AS m ON prod.id = m.id_producto
		SET prod.stock = (prod.stock+m.suma);

UPDATE productos AS prod
	JOIN
	(
		SELECT	mov.id_producto, sum(cantidad) AS suma 
		FROM movimientos AS mov
		WHERE mov.tipo_movimiento = 'Egreso'
		GROUP BY mov.id_producto
	) AS m ON prod.id = m.id_producto
		SET prod.stock = (prod.stock-m.suma);

SELECT id, nombre,  descripcion, stock FROM productos;



-- 16. Cear la tabla parametros (id, tms,cosas(json), id_usuario)

CREATE TABLE parametros (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
tms TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
cosas JSON NULL,
id_usuario INT UNSIGNED
);

-- Insertar en la tabla parametros teniendo en cuenta la columna cosas:
-- Nota: Rellenar a criterio los campos id, tms,id_usuario
INSERT INTO parametros (id_usuario, cosas) VALUES
 	(1,'{"idDeLaCosa": 101, "permisos": "PUT, GET"}'),
 	(2,'{"vistasPermitidas": "menuPrincipal,menuSecundario,ventas,estadisticaVentas,listaCliente", "grupo": "ventas"}'),
 	(2,'{"zonaHoraria": "America/Argentina/BuenosAires"}'),
 	(3,'{"fechaInicioActividades":"01/01/2019", "mesAperturaCaja":"Enero", "mesCierreCaja":"Diciembre"}'),
 	(1,'{"balancesAniosAnteriores": {"2019": {"ingreso": "7374901,93", "egreso": "3732538,75"}, "2020": {"ingreso": "27442665,12", "egreso": "8522331,82"}, "2021": {"ingreso": "31634912,57", "egreso": "9757142,66"}}}');
 
 -- Presentación de la Tabla
 SELECT * FROM parametros;


