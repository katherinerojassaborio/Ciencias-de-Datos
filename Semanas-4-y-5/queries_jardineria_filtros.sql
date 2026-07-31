USE db_jardineria
go

-- Clientes que tienen un nombre de región nulo
SELECT nombre_cliente, ciudad, region
FROM cliente
WHERE region IS NULL;
GO

-- Empleados que no tenga un jefe asignado
SELECT nombre, apellido1, codigo_jefe
FROM empleado
WHERE codigo_jefe IS NULL;
GO

--Pedidos que aún no han sido entregados
SELECT codigo_pedido, fecha_pedido, fecha_entrega
FROM pedido
WHERE fecha_entrega IS NULL;
GO

--Clientes que no tienen límite de crédito
SELECT nombre_cliente
FROM cliente
WHERE limite_credito IS NOT NULL
GO

--Oficinas que tienen segunda dirección
SELECT ciudad, linea_direccion2
FROM oficina
WHERE linea_direccion2 IS NOT NULL;
GO

-- Usa una string personalizada en todas las regiones nulas
SELECT nombre_cliente,
	COALESCE(region, 'Sin región')
	AS region
FROM cliente;
GO

-- Mostrar 'no tiene jefe' cuando el empleado no tiene jefe
SELECT nombre,
	apellido1,
	COALESCE(CAST(codigo_jefe AS VARCHAR), 'No tiene jefe') AS jefe
FROM empleado

-- Mostrar comentarios de pedidos
-- Si el pedido no tiene comentarios, aparece 'Sin comentarios'
SELECT codigo_pedido,
	COALESCE(comentarios, 'No tiene comentarios') AS comentarios
FROM pedido;
GO

-- Clientes que tienen región y límite de crédito
-- Que el límite de crédito no sea null

SELECT nombre_cliente,
	region,
	limite_credito
FROM cliente
WHERE limite_credito IS NOT NULL AND region IS NOT NULL

