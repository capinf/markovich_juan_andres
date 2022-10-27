-- Curso Full Stack Developer - Silicion Misiones - 2022
-- Comisión B
-- TP5 - Ejercicio 2
-- Alumno: Juan Andrés Markovich


-- 1. 	Devuelve un listado con todos los pedidos que se han realizado. 
-- 		Los pedidos deben estar ordenados por la fecha de realización, mostrando en primer lugar los pedidos más recientes.
SELECT * 
			FROM ventas.pedidos AS p 
				ORDER BY p.fecha DESC;

			
-- 2.	Devuelve todos los datos de los dos pedidos de mayor valor.
SELECT * 
			FROM ventas.pedidos AS p 
				ORDER BY p.cantidad 
				DESC LIMIT 2;

			
-- 3. 	Devuelve un listado con los identificadores de los clientes que han realizado algún pedido.
-- 		Tenga en cuenta que no debe mostrar identificadores que estén repetidos.
SELECT DISTINCT id_cliente 
			FROM ventas.clientes AS c 
				JOIN ventas.pedidos AS p ON c.id = p.id_cliente;

			
-- 4.	Devuelve un listado de todos los pedidos que se realizaron durante el año 2022, cuya cantidad total sea superior a $500.
SELECT * 
			FROM ventas.pedidos AS p 
				WHERE p.fecha 
				BETWEEN '2022-01-01' AND '2022-12-31' AND p.cantidad >500;

			
-- 5. 	Devuelve un listado con el nombre y apellido de los vendedores que tienen una comisión entre 0.05 y 0.11.
SELECT CONCAT_WS(' ', v.nombre, v.apellido) AS 'Nombre y Apellido', v.comisión  
			FROM ventas.vendedores AS v WHERE v.comisión 
				BETWEEN 0.05 AND 0.11;

			
-- 6.	Devuelve el valor de la comisión de mayor valor que existe en la tabla vendedores.
SELECT v.comisión  
			FROM ventas.vendedores AS v 
				ORDER BY v.comisión DESC 
				LIMIT 1;

			
-- 7.	Devuelve el identificador, nombre y primer apellido de aquellos clientes cuyo cuitcuil no es NULL. 
-- 		El listado deberá estar ordenado alfabéticamente por apellido y nombre.
SELECT c.id, c.apellido, c.nombre,  c.cuitcuil 
			FROM ventas.clientes AS c 
				WHERE c.cuitcuil IS NOT NULL 
				ORDER BY c.apellido, c.nombre;

			
-- 8.	Devuelve un listado de los nombres de los clientes que empiezan por “A” y terminan por “n” y
-- 		también los nombres que empiezan por “P”. El listado deberá estar ordenado alfabéticamente.
SELECT c.apellido , c.nombre 
			FROM ventas.clientes AS c 
				WHERE c.nombre 
				LIKE 'a%n';

			
-- 9. 	Devuelve un listado de los nombres de los clientes que no empiezan por “A”. El listado deberá
-- 		estar ordenado alfabéticamente.
SELECT c.apellido , c.nombre 
			FROM ventas.clientes AS c 
				WHERE c.nombre 
				NOT LIKE 'a%';

			
-- 10.	Devuelve un listado con los nombres de los vendedores que terminan por “el” o “o”. Tenga en
-- 		cuenta que se deberán eliminar los nombres repetidos
SELECT * 
			FROM ventas.vendedores AS v 
				WHERE v.nombre 
				LIKE '%el' OR v.nombre LIKE '%o';

			
-- 11.	vuelve un listado con el identificador, nombre y apellido de todos los clientes que han realizado algún pedido.
--  	El listado debe estar ordenado alfabéticamente y se deben eliminar los elementos repetidos.
SELECT DISTINCT c.id, c.apellido, c.nombre 
			FROM ventas.clientes AS c 
				JOIN ventas.pedidos AS p ON c.id = p.id_cliente 
				ORDER BY c.apellido, c.nombre;

			
-- 12.	Devuelve un listado que muestre todos los pedidos que ha realizado cada cliente. 
-- 		El resultado debe mostrar todos los datos de los pedidos y del cliente.
-- 		El listado debe mostrar los datos de los clientes ordenados alfabéticamente.
SELECT 	c.id AS 'id cliente', c.apellido , c.nombre , c.cuitcuil , c.ciudad , c.categoría,  
		p.id AS 'id pedido', p.id_vendedor AS 'id vendedor', p.fecha , p.cantidad AS 'Importe' 
			FROM ventas.clientes AS c 
				JOIN ventas.pedidos AS p ON c.id = p.id_cliente 
				ORDER BY c.apellido, c.nombre;

			
-- 13.	Devuelve un listado que muestre todos los pedidos en los que ha participado un vendedor.
-- 		El resultado debe mostrar todos los datos de los pedidos y de los vendedores. 
-- 		El listado debe mostrar los datos de los vendedores ordenados alfabéticamente.
SELECT * 
			FROM ventas.vendedores AS v 
				JOIN ventas.pedidos AS p ON p.id_vendedor = v.id 
				ORDER BY v.nombre , v.apellido ;

			
-- 14.	Devuelve un listado que muestre todos los clientes, con todos los pedidos que han realizado y con los datos de los vendedores asociados a cada pedido.
SELECT 	c.id AS 'Id. Cliente', CONCAT_WS(' ', c.apellido , c.nombre) AS 'Cliente', c.cuitcuil AS 'CUIT/L - Cliente', 
		p.id AS 'id Pedido', p.fecha ,p.cantidad AS 'Importe',
		v.id AS 'Id Vendedor', CONCAT_WS(' ', v.apellido, v.nombre) AS 'Vendedor', v.cuitcuil AS 'CUIT/L - Vendedor', v.comisión 
			FROM ventas.pedidos AS p
				JOIN ventas.clientes AS c ON p.id_cliente = c.id
				JOIN ventas.vendedores AS v ON v.id  = p.id_vendedor ORDER BY c.apellido , c.nombre, v.apellido , v.nombre ;

			
-- 15.	Devuelve un listado de todos los clientes que realizaron un pedido durante el año 2022, cuyo monto esté entre $300 y $1000.
SELECT * 
			FROM ventas.pedidos AS p 
				JOIN ventas.clientes AS c ON p.id_cliente = c.id 
				WHERE p.cantidad >300 AND p.cantidad <1000 AND p.fecha BETWEEN '2022-01-01' AND '2022-12-31';

			
-- 16.	Devuelve el nombre y apellido de todos los vendedores que han participado en algún pedido realizado por María Santana.
SELECT DISTINCT  CONCAT_WS(' ',v.nombre, v.apellido) AS 'Vendedor', CONCAT_WS(' ',c.apellido, c.nombre) AS 'CLiente'  
			FROM ventas.pedidos AS p 
				JOIN ventas.clientes AS c ON p.id_cliente = c.id
				JOIN ventas.vendedores AS v ON p.id_vendedor = v.id
				WHERE c.nombre ='Maria' AND c.apellido ='Santana';

			
-- 17.	Devuelve el nombre de todos los clientes que han realizado algún pedido con el vendedor Daniel Sáez.
SELECT DISTINCT CONCAT_WS(' ', c.nombre, c.apellido) AS 'Clientes', CONCAT_WS(' ', v.nombre, v.apellido) AS "Vendedor"  
			FROM ventas.pedidos AS p 
				JOIN ventas.clientes AS c ON p.id_cliente = c.id
				JOIN ventas.vendedores AS v ON p.id_vendedor = v.id
				WHERE v.nombre ='Daniel' AND v.apellido ='Sáez';
			
			
-- 18.	Devuelve un listado con todos los clientes junto con los datos de los pedidos que han realizado. 
-- 		Este listado también debe incluir los clientes que no han realizado ningún pedido.
-- 		El listado debe estar ordenado alfabéticamente por el apellido y nombre de los clientes.			
SELECT 	CONCAT_WS(' ', c.apellido, c.nombre) AS 'Cliente', p.id AS 'Id Pedido', p.cantidad AS 'Importe', 
		CONCAT_WS(' ', v.nombre, v.apellido) AS 'Vendedor'  
			FROM ventas.clientes AS c
				LEFT JOIN ventas.pedidos AS p ON c.id = p.id_cliente
				JOIN ventas.vendedores AS v
				ORDER BY c.apellido , c.nombre ; 

			
-- 19.	Devuelve un listado con todos los vendedores junto con los datos de los pedidos que han realizado.
-- 		Este listado también debe incluir los vendedores que no han realizado ningún pedido.
-- 		El listado debe estar ordenado alfabéticamente por el apellido y nombre de losvendedores.
SELECT *
			FROM ventas.vendedores As v
				LEFT JOIN ventas.pedidos AS p ON v.id=p.id_vendedor
				ORDER BY v.apellido, v.nombre;
			
			
-- 20.	Devuelve un listado que solamente muestre los clientes que no han realizado ningún pedido.
SELECT * 
			FROM ventas.clientes AS c
				LEFT JOIN ventas.pedidos AS p ON c.id = p.id_cliente
				WHERE p.id IS NULL
				ORDER BY c.apellido , c.nombre ; 
			
			
-- 21.	Devuelve un listado que solamente muestre los vendedores que no han realizado ningún pedido.
SELECT *
			FROM ventas.vendedores AS v
				LEFT JOIN ventas.pedidos AS p ON v.id = p.id_vendedor
				WHERE p.id IS NULL 
				ORDER BY v.apellido , v.nombre ;
			
			
-- 22.	Devuelve un listado con los clientes que no han realizado ningún pedido y de los vendedores que no han participado en ningún pedido. 
-- 		Ordene el listado alfabéticamente por el apellido y el nombre. 
-- 		En el listado deberá diferenciar de algún modo los clientes y los vendedores. 
SELECT CONCAT_WS(' ', c.apellido, c.nombre) AS Nombre, 'Cliente' AS Tipo   
			FROM ventas.clientes AS c
				LEFT  JOIN ventas.pedidos AS p ON c.id = p.id_cliente
				WHERE p.id IS NULL
UNION
SELECT CONCAT_WS(' ', v.apellido, v.nombre) AS Nombre, 'Vendedor' AS Tipo 
			FROM ventas.vendedores AS v
				LEFT JOIN ventas.pedidos AS p ON v.id = p.id_vendedor
				WHERE p.id IS NULL
				ORDER BY Nombre ASC;
		
			
-- 23.	Calcula la cantidad total que suman todos los pedidos que aparecen en la tabla pedido.
SELECT SUM(p.cantidad) AS Total 
			FROM pedidos AS p;

		
-- 24.	Calcula la cantidad media de todos los pedidos que aparecen en la tabla pedido.
SELECT AVG(p.cantidad) AS Total 
			FROM pedidos AS p;

		
-- 25.	Calcula el número total de vendedores distintos que aparecen en la tabla pedido.
SELECT COUNT(DISTINCT p.id_vendedor) AS Vendedores 
			FROM ventas.pedidos AS p;

		
-- 26.	Calcula el número total de clientes que aparecen en la tabla cliente.
SELECT COUNT(DISTINCT c.id) 
			FROM ventas.clientes AS c;

		
-- 27.	Calcula cuál es la mayor cantidad que aparece en la tabla pedido.
SELECT MAX(p.cantidad) 
			FROM ventas.pedidos AS p;

		
-- 28.	Calcula cuál es la menor cantidad que aparece en la tabla pedido.
SELECT MIN(p.cantidad) 
			FROM ventas.pedidos AS p;

		
-- 29.	Calcula cuál es el valor máximo de categoría para cada una de las ciudades que aparece en la tabla cliente.
SELECT c.ciudad, MAX(c.categoría) AS 'Max Categoría' 
			FROM ventas.clientes c
				GROUP BY c.ciudad
				ORDER BY c.ciudad ASC;

-- 30.	Calcula cuál es el máximo valor de los pedidos realizados durante el mismo día para cada uno de los clientes. 
-- 		Es decir, el mismo cliente puede haber realizado varios pedidos de diferentes cantidades el mismo día.
-- 		Se pide que se calcule cuál es el pedido de máximo valor para cada uno de los días en los que un cliente ha realizado un pedido.
-- 		Muestra el identificador del cliente, nombre, apellido, la fecha y el valor de la cantidad.	
SELECT c.id AS "Cliente Id", CONCAT_WS(' ', c.apellido , c.nombre) AS Cliente, p.fecha , MAX(p.cantidad) AS 'Pedido Máximo'
			FROM ventas.pedidos AS p
				JOIN ventas.clientes AS c ON c.id = p.id_cliente
				GROUP BY p.id_cliente, p.fecha
				ORDER BY Cliente, p.fecha DESC; 

			
-- 31.	Calcula cuál es el máximo valor de los pedidos realizados durante el mismo día para cada uno de los clientes,
-- 		teniendo en cuenta que sólo queremos mostrar aquellos pedidos que superen la cantidad de $2000 .
SELECT c.id AS "Cliente Id", CONCAT_WS(' ', c.apellido , c.nombre) AS 'Cliente', p.fecha , MAX(p.cantidad) AS 'Pedido Máximo'
			FROM ventas.pedidos AS p
				JOIN ventas.clientes AS c ON c.id = p.id_cliente
				WHERE p.cantidad >2000
				GROUP BY p.id_cliente, p.fecha
				ORDER BY Cliente, p.fecha DESC;

			
-- 32.	Calcula el máximo valor de los pedidos realizados para cada uno de los vendedores durante la fecha 2021-08-17.
-- 		Muestra el identificador del vendedor, nombre, apellido y total.
SELECT v.id AS 'Vendedor Id', CONCAT_WS(' ', v.apellido, v.nombre) AS Vendedor, p.fecha, MAX(p.cantidad) AS 'Pedido Máximo'
			FROM ventas.pedidos AS p
				JOIN ventas.vendedores AS v ON v.id = p.id_vendedor
				WHERE p.fecha = '2021-08-17'
				GROUP BY v.id
				ORDER BY Vendedor; 

			
-- 33.	Devuelve un listado con el identificador de cliente, nombre y apellido y el número total de pedidos que ha realizado cada uno de los clientes.
-- 		Tenga en cuenta que pueden existir clientes que no han realizado ningún pedido.
-- 		Estos clientes también deben aparecer en el listado indicando que el número de pedidos realizados es 0.
SELECT c.id AS 'Cliente Id', CONCAT_WS(' ', c.apellido, c.nombre) AS Cliente, COUNT(p.id) AS Pedidos 
			FROM ventas.clientes AS c
				LEFT JOIN ventas.pedidos AS p ON c.id = p.id_cliente 
				GROUP BY c.id
				ORDER BY Cliente;

			
-- 34.	Devuelve un listado con el identificador de cliente, nombre, apellido y el número total de pedidos que ha realizado cada uno de clientes durante el año 2020.
SELECT c.id AS 'Cliente Id', CONCAT_WS(' ', c.apellido, c.nombre) AS Cliente, COUNT(p.id) AS Pedidos 
			FROM ventas.clientes AS c
				LEFT JOIN ventas.pedidos AS p ON c.id = p.id_cliente 
				WHERE p.fecha BETWEEN '2022-01-01' AND '2022-12-31'			
				GROUP BY c.id
				ORDER BY Cliente;

			
-- 35.	Devuelve cuál ha sido el pedido de máximo valor que se ha realizado cada año.
SELECT YEAR(p.fecha) AS Año,  MAX(p.cantidad) 'Pedido Máximo'
			FROM ventas.pedidos AS p
				GROUP BY YEAR(p.fecha)
				ORDER BY Año DESC;

			
-- 36.	Devuelve el número total de pedidos que se han realizado cada año.
SELECT YEAR(p.fecha) AS Año,  COUNT(p.id) AS Pedidos
			FROM ventas.pedidos AS p
				GROUP BY YEAR(p.fecha)
				ORDER BY Año DESC;

			
-- 37.	Devuelve un listado con todos los pedidos que ha realizado Adela Salas. (Sin utilizar INNER JOIN).
SELECT p.id AS 'Pedido Id', CONCAT_WS(' ', c.apellido, c.nombre) AS Cliente, p.fecha, p.cantidad
			FROM ventas.clientes AS c
				CROSS JOIN ventas.pedidos AS p ON c.id = p.id_cliente 
				WHERE c.apellido = 'Salas' AND c.nombre = 'Adela'
				ORDER BY p.fecha DESC;  

			
-- 38.	Devuelve el número de pedidos en los que ha participado el vendedor Daniel Sáe. (Sin utilizar INNER JOIN).
SELECT v.id AS 'Vendedor ID', CONCAT_WS(' ', v.apellido, v.nombre) AS Vendedor, count(p.id) AS Pedidos 
			FROM ventas.vendedores AS v
				CROSS JOIN ventas.pedidos AS p ON v.id = p.id_vendedor 
				WHERE v.apellido = 'Sáez' AND v.nombre = 'Daniel'
				GROUP BY v.id;

			
-- 39.	Devuelve los datos del cliente que realizó el pedido más caro en el año 2020. (Sin utilizar INNER JOIN).
SELECT c.id AS 'Cliente Id', CONCAT_WS(' ',c.apellido, c.nombre) AS 'Cliente', p.cantidad AS 'Maximo'
			FROM ventas.clientes AS c
				LEFT JOIN ventas.pedidos AS p ON c.id = p.id_cliente
				WHERE YEAR(p.fecha) = '2020'
				GROUP BY c.id, p.cantidad
				ORDER BY p.cantidad DESC
				LIMIT 1;
	
			
-- 40.	Devuelve la fecha y la cantidad del pedido de menor valor realizado por el cliente Pepe Ruiz Santana.
SELECT c.id, CONCAT_WS(' ',c.apellido, c.nombre) AS 'Cliente', ANY_VALUE(p.fecha) AS 'Fecha', MIN(p.cantidad) AS 'Pedido Mínimo'
			FROM ventas.clientes AS c
				JOIN ventas.pedidos AS p ON c.id = p.id_cliente
				WHERE c.apellido = 'Ruiz' AND c.nombre = 'Pepe'
				GROUP BY c.id; 

			
-- 41.	Devuelve un listado de los clientes que no han realizado ningún pedido. (Utilizando IN o NOT IN).
SELECT * 
			FROM ventas.clientes AS c
				WHERE c.id NOT IN (SELECT id_cliente FROM pedidos);

			
-- 42.	Devuelve un listado de los vendedores que no han realizado ningún pedido. (Utilizando IN o NOT IN).
SELECT *
			FROM ventas.vendedores AS v
				WHERE v.id NOT IN (SELECT id_vendedor FROM pedidos);

			
-- 43.	Devuelve un listado de los clientes que no han realizado ningún pedido. (Utilizando EXISTS o NOT EXISTS).
SELECT *
			FROM clientes AS c
				WHERE NOT EXISTS (SELECT p.id_cliente  FROM pedidos AS p WHERE c.id = p.id_cliente);

			
-- 44.Devuelve un listado de los vendedores que no han realizado ningún pedido. (Utilizando EXISTS o NOT EXISTS).
SELECT *
			FROM vendedores AS v 
				WHERE NOT EXISTS (SELECT p.id_vendedor FROM pedidos AS p WHERE v.id = p.id_vendedor);