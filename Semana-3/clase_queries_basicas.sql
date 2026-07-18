--CREATE DATABASE
CREATE DATABASE clase1
go

--ACTIVATION OF THE DATABASE FOR THE NEXT QUERIES
USE clase1
go

--CREATION OF THE TABLE
CREATE TABLE product (
	id INT NOT NULL,
	nombre VARCHAR(10) NOT NULL,
	clase VARCHAR(5) NOT NULL
)
go

--INSERT REGISTERS INTO THE PRODUCT TABLE
INSERT INTO product (id, nombre, clase)
VALUES
(1, 'Escritorio', 'X'),
(2, 'Silla', 'X'),
(3, 'Carpeta', 'Y'),
(4, 'Marcador', 'Z'),
(5, 'Lápiz', 'Z'),
(6, 'Teclado', 'E'),
(7, 'Lámpara', 'X'),
(8, 'Router', 'E'),
(9, 'Libreta', 'Z'),
(10, 'Calendario', 'Z')
go

SELECT * FROM product;

--EXAMPLE 2
--CREATION OF THE TABLE FOR A STATIONARY STORE CLIENTS
CREATE TABLE customer (
	cedula VARCHAR(10) PRIMARY KEY NOT NULL,
	nombre VARCHAR(15) NOT NULL,
	fecha_nacimiento DATE NOT NULL,
	direccion VARCHAR(50) NOT NULL,
	email VARCHAR(20) NOT NULL,
	telefono VARCHAR(11) NOT NULL,
)
go

INSERT INTO customer (cedula, nombre, fecha_nacimiento, direccion, email, telefono) 
VALUES
('108450672', 'Maria Rojas', '1995-03-14', 'San Jose, Curridabat', 'mrojas@mail.com', '88112233'),
('205670891', 'Carlos Solis', '1988-07-22', 'Alajuela Centro', 'csolis@mail.com', '87223344'),
('302340556', 'Ana Vargas', '1999-11-05', 'Heredia, Barreal', 'avargas@mail.com', '86334455'),
('403120778', 'Luis Mora', '1975-01-30', 'Cartago, Tres Rios', 'lmora@mail.com', '85445566'),
('117890234', 'Sofia Jimenez', '2001-05-18', 'San Jose, Escazu', 'sjimenez@mail.com', '84556677'),
('501230445', 'Diego Castro', '1992-09-09', 'Limon Centro', 'dcastro@mail.com', '83667788'),
('602340667', 'Paola Vega', '1985-12-25', 'Puntarenas Centro', 'pvega@mail.com', '82778899'),
('109560889', 'Jose Fernandez', '1998-04-02', 'San Jose, Desamparados', 'jfernandez@mail.com', '81889900'),
('701230112', 'Karla Chaves', '1990-06-17', 'Guanacaste, Liberia', 'kchaves@mail.com', '80990011'),
('204450334', 'Andres Salas', '1980-08-11', 'Alajuela, San Ramon', 'asalas@mail.com', '89001122');
GO