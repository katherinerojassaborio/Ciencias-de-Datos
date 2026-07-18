--Creation of the database
CREATE DATABASE bdcentro_academico
GO

USE bdcentro_academico
GO

--Create tables following the relational logical order
--First, for the students we need to register their personal data
CREATE TABLE alumno (
	dni VARCHAR(11) PRIMARY KEY,
	nombre NVARCHAR(20) NOT NULL,
	apellido NVARCHAR(20) NOT NULL,
	domicilio NVARCHAR(50) NOT NULL,
	telefono SMALLINT NOT NULL
)
GO

--Create a table for the professors, to register their names and id
CREATE TABLE personal (
	id VARCHAR(11) PRIMARY KEY,
	nombre_prof NVARCHAR(60) NOT NULL
)
GO

--Create a table to register names and IDs for subjects
CREATE TABLE asignatura (
	codigo SMALLINT PRIMARY KEY IDENTITY(1,1),
	nombre NVARCHAR(40) NOT NULL
)
GO

--To apply normalization, the catedra table will create a relationship through the FKs of subjects and professors
CREATE TABLE catedra (
	id SMALLINT PRIMARY KEY IDENTITY(1,1),
	educador_id VARCHAR(11) NOT NULL,
	asignatura_codigo SMALLINT NOT NULL,
	CONSTRAINT FK_educador_catedra FOREIGN KEY (educador_id) REFERENCES personal(id) ON DELETE NO ACTION,
	CONSTRAINT FK_asignatura_catedra FOREIGN KEY (asignatura_codigo) REFERENCES asignatura(codigo) ON DELETE CASCADE
)
GO

--Finally, registro_academico table will gather the information of grades, through the relationship between students and subjects.
CREATE TABLE registro_academico (
	id_registro SMALLINT PRIMARY KEY IDENTITY(1,1),
	asignatura_codigo SMALLINT NOT NULL,
	dni_alumno VARCHAR(11) NOT NULL,
	resultado_evaluacion DECIMAL(10,2) NOT NULL,
	resultado_tarea1 DECIMAL(10,2) NOT NULL,
	resultado_tarea2 DECIMAL(10,2) NOT NULL,
	CONSTRAINT FK_asignatura_registro FOREIGN KEY (asignatura_codigo) REFERENCES asignatura(codigo) ON DELETE CASCADE,
	CONSTRAINT FK_dni_registro FOREIGN KEY (dni_alumno) REFERENCES alumno(dni) ON DELETE CASCADE
)
GO