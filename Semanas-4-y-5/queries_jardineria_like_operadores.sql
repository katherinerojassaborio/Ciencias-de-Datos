-- Usar la base de datos de jardinería
USE db_jardineria
GO

-- Seleccionar la base de datos
SELECT * FROM cliente
GO
-- Comando para buscar un nombre que sea igual a x
SELECT nombre_contacto FROM cliente 
WHERE nombre_contacto = 'Jose';

-- Comando para buscar un nombre diferente <> a x --
SELECT * FROM CLIENTE 
WHERE nombre_contacto <> 'Jose';

-- Comando para buscar un nombre de contacto = igual a x nombre de cliente
SELECT nombre_contacto
FROM cliente
WHERE nombre_cliente = 'Lasas S.A.';

-- % Parecido que empiece con x --
SELECT nombre_contacto
FROM cliente
WHERE nombre_contacto LIKE 'luis%';
GO

-- % Parecido que termine con x --
SELECT nombre_contacto
FROM cliente
WHERE nombre_contacto LIKE '%an';
GO

-- Buscar nombre contacto, apellido y teléfono de los que empiezan con 'Ju'
SELECT nombre_contacto, apellido_contacto, telefono
FROM cliente
WHERE nombre_contacto LIKE 'Ju%';
GO

-- Buscar nombre contacto, apellido y teléfono de los que empiezan con 'Ju'
SELECT nombre_contacto, apellido_contacto, telefono
FROM cliente
WHERE nombre_contacto LIKE 'A%';
GO

-- Buscar nombre contacto, apellido y teléfono de los que terminan con ina --
SELECT nombre_contacto, apellido_contacto, telefono
FROM cliente
WHERE nombre_contacto LIKE '%ina';
GO

-- Buscar nombre contacto, apellido y teléfono de los que empiezan con J --
SELECT nombre_contacto, apellido_contacto, telefono
FROM cliente
WHERE nombre_contacto LIKE 'J%';
GO

-- Buscar nombre contacto, apellido y teléfono de los que tengan 'an' en algún lugar --
SELECT nombre_contacto, apellido_contacto, telefono
FROM cliente
WHERE nombre_contacto LIKE '%an%';
GO


-- > límite menor o mayor

-- Ver clientes con límite de crédito mayor a 3000
SELECT * FROM cliente
WHERE limite_credito > 3000;

-- Ver clientes con límite de crédito mayor a 3000
SELECT * FROM cliente
WHERE limite_credito > 3000;

--Nombre de contacto sea = XXX y (AND) crédito menor a y
SELECT * FROM cliente
WHERE nombre_contacto = 'Luis' 
AND limite_credito < 5000;
GO


--Uso de operador lógico AND
SELECT * FROM cliente
WHERE limite_credito > 3000
AND ciudad = 'Miami';
GO

--Ciudad termina con 'i'
SELECT * FROM cliente
WHERE limite_credito > 3000
AND ciudad LIKE '%in';
GO

--Ciudad tiene la letra 'o'
SELECT * FROM cliente
WHERE limite_credito > 1000
AND ciudad LIKE '%lo%';
GO

-- Uso de operador OR
-- Seleccionar toda la tabla clientes donde el límite de créditos sea menor o igual a 3000 o ciudad a Miami
SELECT * FROM cliente
WHERE limite_credito >= 3000 
OR ciudad = 'Miami';
GO


-- Seleccionar solo los que son nulos
SELECT * FROM cliente
WHERE linea_direccion2 IS NULL;
GO

--Seleccionar con lineas de direccion nulas
SELECT nombre_cliente
FROM cliente
WHERE linea_direccion1 IS NULL OR linea_direccion2 IS NULL ;
GO

-- Seleccionar clientes cuya ciudad no es San Francisco
SELECT * FROM cliente
WHERE NOT ciudad = 'San Francisco';
GO

-- Seleccionar cliente en ciudad Miami o Madrid, y código de empleado de ventas entre 5 y 8, y nombre de cliente empieza con una 'D'
SELECT * FROM cliente
WHERE ciudad IN ('Miami','Madrid')
AND codigo_empleado_rep_ventas BETWEEN 5 AND 8
AND nombre_cliente LIKE 'D%';
GO



