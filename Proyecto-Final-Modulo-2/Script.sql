-- Creation of the database for the University, with the purpose of registering enrollment
CREATE DATABASE db_universidad;
GO

-- Select the database for further queries
USE db_universidad;
GO

-- Creation of the tables according to the Entity Relationship Diagram
-- carrera will store the name and id of each career
CREATE TABLE carrera (
	id_carrera SMALLINT PRIMARY KEY,
	nombre VARCHAR(30) NOT NULL
)

-- estudiante stores each student's personal and contact info, identified by their identification, which may have different formats if the student is international
CREATE TABLE estudiante (
	identificacion VARCHAR(20) PRIMARY KEY,
	nombres NVARCHAR(50) NOT NULL,
	primer_apellido NVARCHAR(15) NOT NULL,
	segundo_apellido NVARCHAR(15),
	fecha_nacimiento DATE NOT NULL,
	email VARCHAR(50) UNIQUE NOT NULL,
	direccion VARCHAR(200) NOT NULL,
	numero_telefono VARCHAR(20) UNIQUE NOT NULL,
	id_carrera1 SMALLINT NOT NULL,
	id_carrera2 SMALLINT,
	CONSTRAINT FK_carrera1 FOREIGN KEY (id_carrera1) REFERENCES carrera(id_carrera),
	CONSTRAINT FK_carrera2 FOREIGN KEY (id_carrera2) REFERENCES carrera(id_carrera)
)

-- Profesores stores each professor's basic information, identified by id_profesor, will be used later to connect the catedra
CREATE TABLE profesores (
	id_profesor VARCHAR(20) PRIMARY KEY,
	nombres NVARCHAR(50) NOT NULL,
	primer_apellido NVARCHAR (15) NOT NULL,
	segundo_apellido NVARCHAR(15),
	email_profesor VARCHAR(50) NOT NULL
)

-- Stores the name and id of each suject offered in the university
CREATE TABLE asignaturas (
	cod_asignatura SMALLINT PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL
)

-- Stores available time blocks (day, start and end time) that can be reused across different groups
CREATE TABLE horarios (
	id_registro_horario SMALLINT IDENTITY(1,1) PRIMARY KEY,
	dia VARCHAR(15) NOT NULL,
	hora_inicio TIME NOT NULL,
	hora_fin TIME NOT NULL
)

-- Stores each academic period, which will be used later to tie enrollment, teaching and payments to a specific term
CREATE TABLE periodo (
	id_periodo VARCHAR(10) PRIMARY KEY,
	año SMALLINT NOT NULL,
	nombre_periodo VARCHAR(25) NOT NULL
)

-- Registers the enrollments of the students according to the period, connected to estudiante and periodo through FK
CREATE TABLE matricula (
	id_matricula SMALLINT IDENTITY(1,1) PRIMARY KEY,
	fecha_matricula DATE NOT NULL,
	id_estudiante VARCHAR(20) NOT NULL,
	id_periodo VARCHAR(10) NOT NULL,
	CONSTRAINT FK_estudiante_matricula FOREIGN KEY (id_estudiante) REFERENCES estudiante(identificacion),
	CONSTRAINT FK_periodo_matricula FOREIGN KEY (id_periodo) REFERENCES periodo(id_periodo)
)

-- Registers the payments of the students according to their total to pay during a period, connected to estudiante and periodo through FK
CREATE TABLE finanzas (
	id_registro SMALLINT IDENTITY(1,1) PRIMARY KEY,
	id_estudiante VARCHAR(20) NOT NULL,
	id_periodo VARCHAR(10) NOT NULL,
	pago_completo BIT NOT NULL DEFAULT 0,
	fecha_ultimo_pago DATE,
	monto_total_periodo DECIMAL(10,2) NOT NULL,
	CONSTRAINT FK_estudiante_finanzas FOREIGN KEY (id_estudiante) REFERENCES estudiante(identificacion),
	CONSTRAINT FK_periodo_finanzas FOREIGN KEY (id_periodo) REFERENCES periodo(id_periodo)
)

-- Creation of intermediate tables to mantain normalization and coherent connection of each register
-- Connects a professor to a subject within a specific period, defining who teaches what and when, through FK to profesores, asignaturas and periodo
CREATE TABLE catedra (
	id_registro_catedra SMALLINT IDENTITY(1,1) PRIMARY KEY,
	id_profesor VARCHAR(20) NOT NULL,
	cod_asignatura SMALLINT NOT NULL,
	id_periodo VARCHAR(10) NOT NULL,
	CONSTRAINT FK_profesor_catedra FOREIGN KEY (id_profesor) REFERENCES profesores(id_profesor),
	CONSTRAINT FK_asignatura_catedra FOREIGN KEY (cod_asignatura) REFERENCES asignaturas(cod_asignatura),
	CONSTRAINT FK_periodo_catedra FOREIGN KEY (id_periodo) REFERENCES periodo(id_periodo)
)

-- Represents a specific group of a catedra subject, assigning it a time block, connected to catedra and horarios through FK
CREATE TABLE grupos (   
	id_grupo SMALLINT IDENTITY(1,1) PRIMARY KEY,
	nombre VARCHAR(15) NOT NULL,
	id_registro_horario SMALLINT NOT NULL,
	id_registro_catedra SMALLINT NOT NULL,
	CONSTRAINT FK_horario_grupo FOREIGN KEY (id_registro_horario) REFERENCES horarios(id_registro_horario),
	CONSTRAINT FK_catedra_grupo FOREIGN KEY (id_registro_catedra) REFERENCES catedra(id_registro_catedra) ON DELETE CASCADE
)

-- Connects a matricula to the specific groups the student enrolled in, since one enrollment can include several groups, through FK to matricula and grupos
CREATE TABLE detalle_matricula (
	id_detalle_matricula SMALLINT IDENTITY(1,1) PRIMARY KEY,
	id_matricula SMALLINT NOT NULL,
	id_grupo SMALLINT NOT NULL,
	CONSTRAINT FK_matricula_detalle FOREIGN KEY (id_matricula) REFERENCES matricula(id_matricula) ON DELETE CASCADE,
	CONSTRAINT FK_grupo_detalle FOREIGN KEY (id_grupo) REFERENCES grupos(id_grupo) ON DELETE CASCADE
)








