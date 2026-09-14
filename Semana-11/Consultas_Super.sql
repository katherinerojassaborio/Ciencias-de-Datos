USE super_San_Pascual

-- Total por sucursal
SELECT 
	s.nombre,
	SUM(v.total) AS total
FROM Dim_Sucursal s
INNER JOIN Hechos_Ventas v ON s.sucursal_id=v.sucursal_id
GROUP BY s.nombre
ORDER BY total DESC

-- 5 productos más vendidos
SELECT TOP 5
	p.nombre_producto,
	SUM(v.cantidad) AS unidades
FROM Dim_Producto p 
INNER JOIN Hechos_Ventas v ON p.producto_id=v.producto_id
GROUP BY nombre_producto
ORDER BY unidades DESC;

-- Ticket promedio según tipo de cliente
SELECT 
	CASE
		WHEN c.es_frecuente = 0 THEN 'no_frecuente'

		ELSE 'frecuente'
	END AS tipo_cliente,
	AVG(v.total) AS ticket_promedio
FROM Dim_Cliente c 
INNER JOIN Hechos_Ventas v ON c.cliente_id = v.cliente_id
GROUP BY c.es_frecuente

select
case
when h.cliente_id is null then 'Sin identificar (walk-in)'
when c.es_frecuente = 1 then 'Cliente frecuente'
else 'Cliente no frecuente'
end as segmento,
round(avg(h.total), 0) as ticket_promedio,
count(*) as num_ventas
from hechos_ventas h
left join dim_cliente c
on h.cliente_id = c.cliente_id
group by
case
when h.cliente_id is null then 'Sin identificar (walk-in)'
when c.es_frecuente = 1 then 'Cliente frecuente'
else 'Cliente no frecuente'
end
order by ticket_promedio desc;

-- Variación de ventas según el día de la semana
SELECT 
	t.dia_semana,
	SUM(v.total) AS total_dia
FROM Dim_Tiempo t
INNER JOIN Hechos_Ventas v ON v.fecha_id=t.fecha_id
GROUP BY dia_semana
ORDER BY total_dia DESC

-- Categoría de producto que genera más ingresos
SELECT TOP 1
	p.categoria_id,
	c.nombre AS nombre_categoria,
	SUM(v.total) AS total_ingresos
FROM Dim_Producto p 
INNER JOIN Hechos_Ventas v ON p.producto_id=v.producto_id
INNER JOIN Dim_Categoria c ON c.categoria_id = p.categoria_id
GROUP BY p.categoria_id, c.nombre
ORDER BY total_ingresos DESC

-- Ventas de mostrador sin cliente por sucursal
SELECT 
	s.nombre,
	SUM(v.total) AS total_ventas,
	COUNT (*) AS numero_ventas
FROM Hechos_Ventas v 
INNER JOIN Dim_Sucursal s ON v.sucursal_id=s.sucursal_id
WHERE v.cliente_id IS NULL
GROUP BY s.nombre
ORDER BY total_ventas DESC

-- Top 3 clientes frecuentes que más han gastado
SELECT TOP 3
	c.nombre AS nombre_cliente,
	SUM(v.total) AS total_gastado
FROM Dim_Cliente c 
INNER JOIN Hechos_Ventas v ON c.cliente_id = v.cliente_id
WHERE c.es_frecuente = 1
GROUP BY c.nombre
ORDER BY total_gastado DESC

