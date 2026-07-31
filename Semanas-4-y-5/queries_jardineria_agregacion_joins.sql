
USE db_jardineria
GO

SELECT * FROM cliente;
GO

-- Devuelve la cantidad de registros de una tabla
SELECT COUNT(*) AS total_clientes
FROM cliente;


-- Devuelve los registros con datos dentro de una columna
SELECT COUNT(limite_credito)
AS clientes_con_credito
FROM cliente;

-- Devuelve el total de la suma de los límites de crédito de la tabla
SELECT SUM(limite_credito)
AS total_credito
FROM cliente;

-- Devuelve el total de la suma de los números de código de empleado de ventas
SELECT SUM(codigo_empleado_rep_ventas)
AS total_credito
FROM cliente;


-- Devuelve el promedio de los límites de crédito
SELECT AVG(limite_credito)
AS promedio_credito
FROM cliente;

-- Devuelve el valor mínimo existente en el límite de crédito
SELECT MIN(limite_credito)
AS minimo_credito
FROM cliente;

-- Devuelve el valor máximo existente en el límite de crédito
SELECT MAX(limite_credito)
AS maximo_credito
FROM cliente;

-- Devuelve el total de clientes, mínimo y máximo de crédito, suma de todos los créditos, promedio de todos los créditos
SELECT 
	COUNT(*) AS total_clientes, 
	MIN(limite_credito) AS minimo_credito, 
	MAX(limite_credito) AS maximo_credito, 
	AVG(limite_credito) AS promedio_credito,
	SUM(limite_credito) AS total_credito
FROM cliente;


-- Devuelve el mínimo y máximo de fecha de pedido
SELECT 
	MIN(fecha_pedido) AS primer_pedido,
	MAX(fecha_pedido) AS ultimo_pedido
FROM pedido


-- Devuelve el total de pedidos por cliente (sólo los que tienen más de 5 pedidos)
SELECT 
    codigo_cliente,
    COUNT(*) AS total_pedidos
FROM pedido
GROUP BY codigo_cliente
HAVING COUNT(*) > 5;
go

select * from pago

-- Promedio de precio de productos por gama
SELECT 
	gama,
	AVG(precio_venta) AS promedio_precio
FROM producto
GROUP BY gama
HAVING AVG(precio_venta) > 10;
GO

-- Total pagado por cada cliente (solo los que han pagado mucho)
SELECT 
	codigo_cliente,
	SUM(total)
FROM pago
GROUP BY codigo_cliente
HAVING SUM(total) > 10000;

-- Devuelve la cantidad de empleados por oficina (solo oficinas grandes
SELECT * FROM empleado
SELECT 
	COUNT(codigo_empleado) AS cantidad_empleados,
	codigo_oficina
FROM empleado
GROUP BY codigo_oficina
HAVING COUNT(*) > 5;
GO

-- Total de productos vendidos por pedido (solo pedidos grandes)
SELECT 
	codigo_pedido,
	SUM(cantidad) AS total_productos
FROM detalle_pedido
GROUP BY codigo_pedido
HAVING SUM(cantidad) > 100;


-- Total de clientes por país, solo en pedidos con muchos clientes
SELECT 
	pais,
	COUNT(*) AS total_clientes
FROM cliente
GROUP BY pais
HAVING COUNT(*) > 5

-- INNER JOIN
SELECT 
	c.nombre_cliente,
	p.codigo_pedido,
	p.fecha_pedido
FROM cliente c
INNER JOIN pedido p
ON c.codigo_cliente = p.codigo_cliente

-- INNER JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
SELECT 
	c.nombre_cliente,
	p.codigo_pedido,
	pr.nombre AS producto,
	dp.cantidad
FROM cliente c
INNER JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
INNER JOIN detalle_pedido dp ON p.codigo_pedido = dp.codigo_pedido
INNER JOIN  producto pr ON dp.codigo_producto = pr.codigo_producto


-- LEFT JOIN
SELECT 
	c.nombre_cliente,
	p.codigo_pedido
FROM cliente c 
LEFT JOIN pedido p 
ON c.codigo_cliente = p.codigo_cliente

-- RIGHT JOIN
SELECT 
	c.nombre_cliente,
	p.codigo_pedido
FROM cliente c 
RIGHT JOIN pedido p 
ON c.codigo_cliente = p.codigo_cliente




	


