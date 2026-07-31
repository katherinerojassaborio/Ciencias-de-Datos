--Sintaxis básica de VIEW

--Ejemplo 1: vista de clientes
CREATE VIEW vista_cliente
AS
SELECT nombre_cliente, ciudad, pais
FROM cliente;
go

SELECT * FROM vista_cliente
GO

--Ejemplo 2: vista de productos caros
CREATE VIEW vista_productos_caros
AS
SELECT
	nombre, precio_venta
FROM producto
WHERE precio_venta >= 100;
GO

SELECT * FROM vista_productos_caros


-- Ejemplo 3: Vista con INNER JOIN cod, nombre, fec
CREATE VIEW vista_pedidos
AS
	SELECT 
		p.codigo_cliente,
		c.nombre_cliente,
		p.fecha_pedido
	FROM pedido p
	INNER JOIN cliente c ON p.codigo_cliente=c.codigo_cliente

GO

SELECT * FROM detalle_pedido


-- Ejemplo 4: Vista con funciones de agregación GROUP BY
CREATE VIEW vista_total_clientes
AS
	SELECT 
		p.codigo_pedido,
		p.codigo_cliente,
		SUM(d.cantidad * d.precio_unidad) AS total
	FROM detalle_pedido d
	INNER JOIN pedido p ON d.codigo_pedido=p.codigo_pedido
	GROUP BY p.codigo_cliente, p.codigo_pedido;
GO

-- Otra forma de verlo directo desde pagos
CREATE VIEW total_pagos_cliente
AS
	SELECT codigo_cliente,
		SUM(total) AS total_pagado
	FROM pago
	GROUP BY codigo_cliente;
	GO

--Vista con el monto máximo pagado por los clientes
CREATE VIEW total_pagos_cliente_max
AS
	SELECT codigo_cliente,
		MAX(total) AS total_pagado
	FROM pago
	GROUP BY codigo_cliente;
	GO

SELECT * FROM total_pagos_cliente_max

-- Consulta recursiva
WITH promedio AS (
	SELECT AVG(precio_venta) AS precio_promedio
	FROM producto
)
SELECT nombre, precio_venta
FROM producto, promedio
WHERE precio_venta > promedio.precio_promedio;