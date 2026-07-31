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
-- Filters students whose primary or secondary major is Medicine, using OR to cover both fields.
SELECT * FROM estudiante
WHERE id_carrera1 = 2 OR id_carrera2 = 2;
GO

-- Which enrollments (matricula) were made in the IC-2026 period?
-- Filters enrollments whose period is exactly IC-2026, using WHERE.
SELECT * FROM matricula
WHERE id_periodo = 'IC-2026';


-- =========================================================
-- ORDER BY
-- =========================================================

-- What is the list of students ordered alphabetically by primer_apellido?
-- Shows student names ordered alphabetically A to Z by their first last name (primer_apellido)
SELECT nombres, primer_apellido, segundo_apellido FROM estudiante
ORDER BY primer_apellido 

-- What are the finanzas payments ordered from highest to lowest monto_total_periodo?
-- Shows finanzas payments ordered from highest to lowest amount using ORDER BY ... DESC.
SELECT id_periodo, monto_total_periodo FROM finanzas
ORDER BY monto_total_periodo DESC;
GO

-- =========================================================
-- DISTINCT
-- =========================================================

-- What are the distinct primary majors associated with enrolled students?
-- Returns major names without repeats, removing duplicates with DISTINCT, based on students who already have an enrollment on record.
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
-- Returns only the top 10 results with the highest amount to pay, combining TOP with ORDER BY DESC.
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
-- Searches for subjects whose name contains the word "Derecho" anywhere in the text, using the % from LIKE.
SELECT * FROM asignaturas
WHERE nombre LIKE '%Derecho%';

-- What students have an email ending in "@estudiantes.ac.cr"?
-- Searches for students whose email ends exactly in "@estudiantes.ac.cr", using the %.
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
-- Filters finanzas records whose amount falls between the 300000 to 500000 range using BETWEEN.
SELECT * FROM finanzas  
WHERE monto_total_periodo BETWEEN 300000 AND 500000
ORDER BY monto_total_periodo

-- What classes start between 13:00 and 18:00?
-- Filters classes whose start time falls within 13:00 to 18:00, using BETWEEN on a TIME data.
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
-- Filters students whose major (primary or secondary) is within a specific list of three majors, using IN.
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
-- Filters subjects whose code matches 101, 201 or 301, using IN.
SELECT * FROM asignaturas
WHERE cod_asignatura IN(101, 201, 301);
GO

-- =========================================================
-- NOT
-- =========================================================

-- What students do NOT belong to the Law major?
-- Shows students whose major is not Derecho, using NOT.
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
-- Shows finanzas records whose payment is NOT marked as 1.
SELECT * FROM finanzas
WHERE NOT pago_completo = 1;
GO

-- =========================================================
-- IS NULL / IS NOT NULL
-- =========================================================

-- What students do NOT have a secondary major?
-- Filters students who do not have a second major on record, using IS NULL.
SELECT * FROM estudiante
WHERE id_carrera2 IS NULL;
GO

-- What students DO have a segundo_apellido registered?
-- Filters students who do have a second last name on record, using IS NOT NULL.
SELECT * FROM estudiante 
WHERE segundo_apellido IS NOT NULL;
GO

-- =========================================================
-- AND / OR
-- =========================================================

-- What students are from San Jose province AND belong to the Psychology major?
-- Filters students who live in San Jose AND belong to the Psychology major, using AND.
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
-- Filters finanzas records that meet payment not complete OR null last payment date.
SELECT * FROM finanzas
WHERE pago_completo = 0 OR fecha_ultimo_pago IS NULL;
GO

-- =========================================================
-- GROUP BY
-- =========================================================

-- How many students are there grouped by id_carrera1?
-- Counts how many students there are per primary major, grouping results with GROUP BY.
SELECT 
    COUNT(*) AS total_estudiantes,
    id_carrera1
FROM estudiante
GROUP BY id_carrera1;
GO

-- How many subjects does each professor teach, grouped by id_profesor?
-- Counts how many subjects each professor teaches, grouping by their ID with GROUP BY.
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
-- Counts enrolled students per major and filters only majors that exceed 10 students using HAVING after GROUP BY.
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
-- Counts the subjects each professor teaches and filters only those who teach more than 3 using HAVING.
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
-- Counts how many groups exist for each subject, combining JOIN with COUNT and GROUP BY.
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
-- Sums the total amount to collect from all students enrolled in the IC-2026 period using SUM.
SELECT 
    SUM(monto_total_periodo) AS total_recaudado_IC2026
FROM finanzas 
WHERE id_periodo = 'IC-2026';
GO           

-- What is the count of paid (pago_completo = 1) vs pending amounts per major?
-- Sums how many payments are complete versus pending per major, using SUM together with CASE to show a descriptive data.
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
-- Calculates the average amount students pay, grouped by period, using AVG.
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
-- Gets the minimum and maximum amount paid across all finanzas records, using MIN and MAX.
SELECT DISTINCT
    MIN(monto_total_periodo) AS minimo_pago,
    MAX(monto_total_periodo) AS maximo_pago
FROM finanzas;
GO

-- What is the oldest and most recent payment registered?
-- Gets the oldest and most recent payment date registered in finanzas, using MIN and MAX on a date field.
SELECT DISTINCT
    MIN(fecha_ultimo_pago) AS pago_mas_antiguo,
    MAX(fecha_ultimo_pago) AS pago_mas_reciente
FROM finanzas

-- =========================================================
-- INNER JOIN
-- =========================================================

-- Which student is enrolled in which group, showing student name and group name?
-- Used INNER JOIN on matricula because we needed id_matricula to link the student to their enrollment.
-- Used INNER JOIN on detalle_matricula because we needed id_grupo to know which group belongs to that enrollment.
-- Used INNER JOIN on grupos because we needed nombre (the group name) to display
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
-- Used INNER JOIN on catedra because we needed cod_asignatura to link the professor to the subject they teach.
-- Used INNER JOIN on asignaturas because we needed the subject name.
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
-- Used LEFT JOIN on finanzas because we needed pago_completo, monto_total_periodo, fecha_ultimo_pago, while still keeping students who don't have a finanzas record at all.
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
-- Used LEFT JOIN on catedra because we needed id_registro_catedra to link the subject to a possible group.
-- Used LEFT JOIN on grupos because we needed the group name to display, while still keeping subjects with no group.
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
-- Used RIGHT JOIN on horarios because we wanted to keep every schedule, even the ones with no group linked to them, and we needed dia, hora_inicio and hora_fin to display.
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
-- Used RIGHT JOIN on carrera because we wanted to keep every major, even the ones with no students, and we needed id_carrera and nombre to display.
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
-- Used a CTE because we needed to extract only the province part of the direccion field before grouping it.
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
-- Used INNER JOIN on finanzas because we needed monto_total_periodo to compare it against the average.
-- Used a subquery with AVG inside the WHERE because we needed to calculate the general average first, before comparing each student's amount to it.
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
-- Used FULL OUTER JOIN on finanzas because we wanted to keep students with no payment record and payment records that might not match a student.
-- Used LEFT JOIN on carrera (primary and secondary) because we needed the major name for both id_carrera1 and id_carrera2, while still keeping students without a second major.
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
-- Used LEFT JOIN on catedra because we needed id_profesor and id_registro_catedra to link the subject to who teaches it and when, while still keeping subjects with no catedra register in that period.
-- Used LEFT JOIN on profesores because we needed the professor's name to display.
-- Used FULL OUTER JOIN on grupos because we wanted to keep catedras with no group and groups that might not match a catedra.
-- Used LEFT JOIN on horarios because we needed dia, hora_inicio and hora_fin to display, while still keeping groups with no schedule assigned.
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
-- Used INNER JOIN on catedra because we needed id_registro_catedra to link the subject to its groups.
-- Used INNER JOIN on grupos because we needed id_grupo to link the catedra to its groups.
-- Used LEFT JOIN on detalle_matricula because we needed to count enrolled students per group, while still keeping groups with zero enrollments.
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
-- The major is inferred directly from cod_asignatura using CASE and BETWEEN, since asignaturas is not connected to carrera by any foreign key.

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
