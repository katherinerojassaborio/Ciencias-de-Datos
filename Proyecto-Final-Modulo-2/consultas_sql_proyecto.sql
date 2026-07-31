USE db_universidad;
GO

-- Validation of source tables
SELECT * FROM carrera;
SELECT * FROM estudiante;
SELECT * FROM profesores;
SELECT * FROM asignaturas;
SELECT * FROM horarios;
SELECT * FROM periodo;
 

SELECT * FROM matricula;
SELECT * FROM finanzas;
 

SELECT * FROM catedra;
SELECT * FROM grupos;
SELECT * FROM detalle_matricula;




-- =========================================================
-- SELECT / WHERE
-- =========================================================

-- What are the full records of students who belong to the Medicine major (id_carrera1 = 2)?
SELECT * FROM estudiante
WHERE id_carrera1 = 2 OR id_carrera2 = 2;
GO

-- Which enrollments (matricula) were made in the IC-2026 period?
SELECT * FROM matricula
WHERE id_periodo = 'IC-2026';


-- =========================================================
-- ORDER BY
-- =========================================================

-- What is the list of students ordered alphabetically by primer_apellido?
SELECT nombres, primer_apellido, segundo_apellido FROM estudiante
ORDER BY primer_apellido 

-- What are the finanzas payments ordered from highest to lowest monto_total_periodo?
SELECT id_periodo, monto_total_periodo FROM finanzas
ORDER BY monto_total_periodo DESC;
GO

-- =========================================================
-- DISTINCT
-- =========================================================

-- What are the distinct primary majors associated with enrolled students?
SELECT DISTINCT 
    c.nombre AS nombre_carrera
FROM estudiante e
INNER JOIN matricula m ON e.identificacion = m.id_estudiante
INNER JOIN carrera c ON c.id_carrera = e.id_carrera1;
GO

-- =========================================================
-- TOP
-- =========================================================

-- Who are the top 10 students with the highest monto_total_periodo to pay?
SELECT TOP 10 
    e.identificacion,
    e.nombres,
    e.primer_apellido,
    e.segundo_apellido,
    f.monto_total_periodo
FROM estudiante e
INNER JOIN finanzas f ON  e.identificacion = f.id_estudiante
ORDER BY monto_total_periodo DESC;
GO

-- =========================================================
-- LIKE
-- =========================================================

-- What subjects contain the word "Derecho" in their name?
SELECT * FROM asignaturas
WHERE nombre LIKE '%Derecho%';

-- What students have an email ending in "@estudiantes.ac.cr"?
SELECT 
    identificacion,
    nombres,
    primer_apellido,
    segundo_apellido,
    email
FROM estudiante
WHERE email LIKE '%estudiantes.ac.cr';
GO


-- =========================================================
-- BETWEEN
-- =========================================================

-- What finanzas records have a monto_total_periodo between 300000 and 500000?
SELECT * FROM finanzas  
WHERE monto_total_periodo BETWEEN 300000 AND 500000
ORDER BY monto_total_periodo

-- What classes start between 13:00 and 18:00?
SELECT 
    c.id_periodo,
    c.cod_asignatura,
    a.nombre,
    g.nombre AS nombre_grupo,
    h.hora_inicio,
    h.hora_fin
FROM grupos g
INNER JOIN catedra c ON g.id_registro_catedra = c.id_registro_catedra
INNER JOIN asignaturas a ON a.cod_asignatura=c.cod_asignatura
INNER JOIN horarios h ON g.id_registro_horario = h.id_registro_horario
WHERE h.hora_inicio BETWEEN '13:00:00' AND '18:00:00';
GO

-- =========================================================
-- IN
-- =========================================================

-- What students belong to Computer Engineering, Civil Engineering or Graphic Design?
SELECT DISTINCT
    e.identificacion,
    e.nombres,
    e.primer_apellido,
    c.nombre AS nombre_carrera
FROM estudiante e
INNER JOIN carrera c 
    ON c.id_carrera = e.id_carrera1 
    OR c.id_carrera = e.id_carrera2
WHERE c.nombre IN ('Ingenieria en Computacion', 'Ingenieria Civil', 'Diseno Grafico');
GO

-- What subjects have the codes 101, 201 or 301?
SELECT * FROM asignaturas
WHERE cod_asignatura IN(101, 201, 301);
GO

-- =========================================================
-- NOT
-- =========================================================

-- What students do NOT belong to the Law major?
SELECT DISTINCT
    e.identificacion,
    e.nombres,
    e.primer_apellido,
    e.segundo_apellido,
    c.nombre
FROM 
estudiante e
INNER JOIN carrera c 
    ON c.id_carrera = e.id_carrera1 
    OR c.id_carrera = e.id_carrera2
WHERE NOT c.nombre = 'Derecho';
GO

-- What finanzas records do NOT have pago_completo = 1?
SELECT * FROM finanzas
WHERE NOT pago_completo = 1;
GO

-- =========================================================
-- IS NULL / IS NOT NULL
-- =========================================================

-- What students do NOT have a secondary major?
SELECT * FROM estudiante
WHERE id_carrera2 IS NULL;
GO

-- What students DO have a segundo_apellido registered?
SELECT * FROM estudiante 
WHERE segundo_apellido IS NOT NULL;
GO

-- =========================================================
-- AND / OR
-- =========================================================

-- What students are from San Jose province AND belong to the Psychology major?
SELECT DISTINCT
    e.identificacion,
    e.nombres,
    e.primer_apellido,
    e.segundo_apellido,
    e.direccion,
    c.nombre AS nombre_carrera
FROM estudiante e
INNER JOIN carrera c 
    ON c.id_carrera = e.id_carrera1
    OR c.id_carrera = e.id_carrera2
WHERE e.direccion LIKE '%San Jose%' AND c.nombre = 'Psicologia';
GO

-- What finanzas records have pago_completo = 0 OR fecha_ultimo_pago IS NULL?
SELECT * FROM finanzas
WHERE pago_completo = 0 OR fecha_ultimo_pago IS NULL;
GO

-- =========================================================
-- GROUP BY
-- =========================================================

-- How many students are there grouped by id_carrera1?
SELECT 
    COUNT(*) AS total_estudiantes,
    id_carrera1
FROM estudiante
GROUP BY id_carrera1;
GO

-- How many subjects does each professor teach, grouped by id_profesor?
SELECT 
    p.id_profesor,
    p.nombres,
    COUNT(a.nombre) AS asignaturas_imparturas
FROM profesores p 
INNER JOIN catedra c ON p.id_profesor = c.id_profesor
INNER JOIN asignaturas a ON a.cod_asignatura = c.cod_asignatura
GROUP BY p.id_profesor, p.nombres;
GO


-- =========================================================
-- HAVING
-- =========================================================

-- What majors have more than 10 enrolled students?
SELECT 
    c.nombre AS nombre_carrera,
    COUNT(e.id_carrera1) AS est_matriculados
FROM carrera c
    INNER JOIN estudiante e ON e.id_carrera1 = c.id_carrera 
    INNER JOIN matricula m ON m.id_estudiante = e.identificacion
GROUP BY m.id_periodo, c.nombre
HAVING COUNT(e.id_carrera1) > 10;
GO


-- What professors teach more than 3 subjects?
SELECT 
    p.nombres,
    p.primer_apellido,
    p.segundo_apellido,
    COUNT(c.cod_asignatura) AS cantidad_asignaturas_impartidas
FROM profesores p 
INNER JOIN catedra c ON p.id_profesor=c.id_profesor
INNER JOIN asignaturas a ON a.cod_asignatura = c.cod_asignatura
GROUP BY p.nombres, p.primer_apellido, p.segundo_apellido
HAVING COUNT(c.cod_asignatura) > 3;
GO


-- =========================================================
-- COUNT
-- =========================================================
-- How many groups exist per subject?
SELECT 
    a.nombre AS nombre_asignatura,
    COUNT(g.id_grupo) AS numero_grupos
FROM asignaturas a 
INNER JOIN catedra c ON a.cod_asignatura = c.cod_asignatura
INNER JOIN grupos g ON g.id_registro_catedra = c.id_registro_catedra
GROUP BY a.nombre;
GO

-- =========================================================
-- SUM
-- =========================================================
-- What is the total amount to collect from all students in the IC-2026 period?
SELECT 
    SUM(monto_total_periodo) AS total_recaudado_IC2026
FROM finanzas 
WHERE id_periodo = 'IC-2026';
GO           

-- What is the count of paid (pago_completo = 1) vs pending amounts per major?
SELECT DISTINCT
    c.nombre AS nombre_carrera,
    SUM(CASE WHEN f.pago_completo = 1 THEN 1 END) AS pagos_completos,
    SUM(CASE WHEN f.pago_completo = 0 THEN 1 END) AS pagos_pendientes
FROM finanzas f
INNER JOIN estudiante e ON e.identificacion = f.id_estudiante
INNER JOIN carrera c 
    ON c.id_carrera = e.id_carrera1
    OR c.id_carrera = e.id_carrera2
GROUP BY c.nombre;
GO


-- =========================================================
-- AVG
-- =========================================================

-- What is the average monto_total_periodo students pay per period?
SELECT 
    id_periodo,
    AVG(monto_total_periodo) AS promedio_por_periodo
FROM finanzas
GROUP BY id_periodo;
GO
       

-- =========================================================
-- MIN / MAX
-- =========================================================

-- What is the minimum and maximum amount paid in finanzas?
SELECT DISTINCT
    MIN(monto_total_periodo) AS minimo_pago,
    MAX(monto_total_periodo) AS maximo_pago
FROM finanzas;
GO

-- What is the oldest and most recent payment registered?
SELECT DISTINCT
    MIN(fecha_ultimo_pago) AS pago_mas_antiguo,
    MAX(fecha_ultimo_pago) AS pago_mas_reciente
FROM finanzas

-- =========================================================
-- INNER JOIN
-- =========================================================

-- Which student is enrolled in which group, showing student name and group name?
SELECT DISTINCT 
    e.identificacion,
    e.nombres,
    e.primer_apellido,
    e.segundo_apellido,
    g.nombre AS nombre_grupo
FROM estudiante e
INNER JOIN matricula m ON e.identificacion = m.id_estudiante
INNER JOIN detalle_matricula d ON m.id_matricula = d.id_matricula
INNER JOIN grupos g ON g.id_grupo = d.id_grupo

-- Which professor teaches which subject, showing professor name and subject name?
SELECT DISTINCT 
    p.id_profesor,
    p.nombres,
    p.primer_apellido,
    p.segundo_apellido,
    a.nombre AS nombre_asignatura
FROM profesores p
INNER JOIN catedra c ON p.id_profesor = c.id_profesor
INNER JOIN asignaturas a ON a.cod_asignatura = c.cod_asignatura


-- =========================================================
-- LEFT JOIN
-- =========================================================

-- What are all students and their finanzas records, including those who don't have a payment record yet?
SELECT 
    e.identificacion,
    e.nombres,
    e.primer_apellido,
    e.segundo_apellido,
    e.email,
    e.fecha_nacimiento,
    e.direccion, 
    e.id_carrera1,
    e.id_carrera2,
    f.fecha_ultimo_pago,
    f.pago_completo,
    f.monto_total_periodo
FROM estudiante e 
LEFT JOIN finanzas f ON e.identificacion=f.id_estudiante


-- What are all subjects and their groups, including subjects that don't have a group assigned yet?
SELECT DISTINCT
    a.nombre,
    g.nombre AS nombre_grupo
FROM asignaturas a 
LEFT JOIN catedra c ON a.cod_asignatura = c.cod_asignatura
LEFT JOIN grupos g ON g.id_registro_catedra = c.id_registro_catedra;
GO


-- =========================================================
-- RIGHT JOIN
-- =========================================================

-- What are all groups and their schedule, even if a schedule had no group associated?
SELECT DISTINCT
    g.nombre AS nombre_grupo,
    h.id_registro_horario,
    h.dia,
    h.hora_inicio,
    h.hora_fin
FROM grupos g
RIGHT JOIN horarios h ON g.id_registro_horario = h.id_registro_horario;
GO

-- What are all majors and the students they have, even if a major had no students?
SELECT DISTINCT
    c.id_carrera,
    c.nombre AS nombre_carrera,
    e.identificacion AS id_estudiante,
    e.nombres AS nombre_estudiante,
    e.primer_apellido
FROM estudiante e 
RIGHT JOIN carrera c
    ON e.id_carrera1 = c.id_carrera
    OR e.id_carrera2 = c.id_carrera


-- =========================================================
-- SUBQUERIES
-- =========================================================
-- What are the provinces of the students?
WITH estudiante_provincia AS (
    SELECT
        LEFT(direccion, CHARINDEX(',', direccion)-1) AS provincia
    FROM estudiante
)
SELECT 
    provincia, 
    COUNT(*) AS total_estudiantes
FROM estudiante_provincia
GROUP BY provincia
ORDER BY provincia;
GO

-- What students have a monto_total_periodo higher than the general average?
SELECT 
    e.identificacion,
    e.nombres,
    e.primer_apellido,
    e.segundo_apellido,
    f.monto_total_periodo
FROM estudiante e
INNER JOIN finanzas f ON e.identificacion = f.id_estudiante
WHERE f.monto_total_periodo > (SELECT AVG(monto_total_periodo) FROM finanzas);
GO

-- =========================================================
-- VIEWS
-- =========================================================

-- A view showing student id, full name, majors and payment status
CREATE VIEW estudiantes_pago
AS
    SELECT 
        e.identificacion,
        CONCAT(e.nombres, ' ', e.primer_apellido, ' ', ISNULL(e.segundo_apellido, '')) AS nombre_completo,
        c1.nombre AS carrera_primaria,
        ISNULL(c2.nombre, 'Sin carrera secundaria') AS carrera_secundaria,
        CASE f.pago_completo
            WHEN 0 THEN 'Pago pendiente'
            WHEN 1 THEN 'Pago completo'
        END AS estado_pago,
        f.monto_total_periodo
    FROM estudiante e
    FULL OUTER JOIN finanzas f ON e.identificacion = f.id_estudiante 
    LEFT JOIN carrera c1 ON c1.id_carrera = e.id_carrera1
    LEFT JOIN carrera c2 ON c2.id_carrera = e.id_carrera2;
GO


SELECT * FROM estudiantes_pago
WHERE estado_pago = 'Pago pendiente';
GO


-- A view of the schedule of all the classes across the IC-2026
CREATE VIEW horario_clases
AS
    SELECT DISTINCT
        c.cod_asignatura,
        a.nombre AS nombre_asignatura,
        g.nombre AS nombre_grupo,
        CONCAT(p.nombres, ' ', p.primer_apellido, ' ', ISNULL(p.segundo_apellido, ' ')) AS nombre_profesor,
        h.dia,
        h.hora_inicio,
        h.hora_fin

    FROM asignaturas a 
    LEFT JOIN catedra c 
        ON a.cod_asignatura = c.cod_asignatura 
        AND c.id_periodo = 'IC-2026'
    LEFT JOIN profesores p ON p.id_profesor = c.id_profesor
    FULL OUTER JOIN grupos g ON g.id_registro_catedra = c.id_registro_catedra
    LEFT JOIN horarios h ON h.id_registro_horario = g.id_registro_horario
GO

SELECT * FROM horario_clases 
WHERE dia = 'Viernes';
GO



-- A view summarizing total student enrollment per group and subject across the IC-2026
CREATE VIEW cant_estudiantes_cursos 
AS
SELECT 
    a.cod_asignatura,
    a.nombre AS nombre_asignatura,
    COUNT(d.id_detalle_matricula) AS estudiantes_matriculados
FROM asignaturas a
INNER JOIN catedra c ON a.cod_asignatura = c.cod_asignatura
INNER JOIN grupos g ON g.id_registro_catedra = c.id_registro_catedra
LEFT JOIN detalle_matricula d ON d.id_grupo = g.id_grupo
WHERE id_periodo = 'IC-2026'
GROUP BY 
    a.cod_asignatura, 
    a.nombre; 
GO

SELECT * FROM cant_estudiantes_cursos 
ORDER BY estudiantes_matriculados DESC;
GO

-- A view showing categories of subjects according to the career
SELECT * FROM asignaturas;
GO

SELECT * FROM carrera;
GO

CREATE VIEW asignatura_por_carrera
AS
    SELECT 
        cod_asignatura,
        nombre,
        CASE 
            WHEN cod_asignatura BETWEEN 100 AND 199 THEN 'Derecho'
            WHEN cod_asignatura BETWEEN 200 AND 299 THEN 'Medicina'
            WHEN cod_asignatura BETWEEN 300 AND 399 THEN 'Ingenieria en Computacion'
            WHEN cod_asignatura BETWEEN 400 AND 499 THEN 'Administracion de Empresas'
            WHEN cod_asignatura BETWEEN 500 AND 599 THEN 'Arquitectura'
            WHEN cod_asignatura BETWEEN 600 AND 699 THEN 'Psicologia'
            WHEN cod_asignatura BETWEEN 700 AND 799 THEN 'Enfermeria'
            WHEN cod_asignatura BETWEEN 800 AND 899 THEN 'Contaduria Publica'
            WHEN cod_asignatura BETWEEN 900 AND 999 THEN 'Ingenieria Civil'
            WHEN cod_asignatura BETWEEN 1000 AND 1099 THEN 'Diseno Grafico'
        END AS carrera_correspondiente
    FROM asignaturas;
GO

SELECT * FROM asignatura_por_carrera 
WHERE carrera_correspondiente = 'Enfermeria';
GO
