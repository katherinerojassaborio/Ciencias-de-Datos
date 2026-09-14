CREATE DATABASE farmacia_examen

USE farmacia_examen
GO

-- Creation of the tables
CREATE TABLE clientes (
    Cliente_ID INT PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    Telefono VARCHAR(20) NOT NULL,
    Provincia NVARCHAR(50) NOT NULL,
    Tipo_Seguro VARCHAR(50) NOT NULL
);

CREATE TABLE medicamentos (
    Medicamento_ID INT PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    Categoria NVARCHAR(70) NOT NULL,
    Precio_Unitario DECIMAL(10,2) NOT NULL,
    Requiere_Receta VARCHAR(5) NOT NULL
);


CREATE TABLE sucursales (
    Sucursal_ID INT PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    Provincia NVARCHAR(50) NOT NULL,
    Encargado NVARCHAR(100) NOT NULL
);

CREATE TABLE ventas (
    Venta_ID INT PRIMARY KEY,
    Fecha DATE NOT NULL,
    Sucursal_ID INT NOT NULL REFERENCES sucursales(Sucursal_ID),
    Cliente_ID INT NOT NULL REFERENCES clientes(Cliente_ID),
    Medicamento_ID INT NOT NULL REFERENCES medicamentos(Medicamento_ID),
    Cantidad INT NOT NULL,
    Precio_Unitario DECIMAL(10,2) NOT NULL,
    Total DECIMAL(10,2) NOT NULL
);




-- Clientes Table

BULK INSERT clientes
FROM 'C:\Data\examen_farmacia\clientes.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ';',
    ROWTERMINATOR = '\n',
    CODEPAGE = '65001'
);

SELECT * FROM clientes

-- Medicamentos Table
BULK INSERT medicamentos
FROM 'C:\Data\examen_farmacia\medicamentos.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ';',
    ROWTERMINATOR = '\n',
    CODEPAGE = '65001'
);

SELECT * FROM medicamentos

-- Sucursales Table

BULK INSERT sucursales
FROM 'C:\Data\examen_farmacia\sucursales.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ';',
    ROWTERMINATOR = '\n',
    CODEPAGE = '65001'
);

SELECT * FROM sucursales

-- Ventas Table
SET DATEFORMAT dmy;
BULK INSERT ventas
FROM 'C:\Data\examen_farmacia\ventas.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ';',
    ROWTERMINATOR = '\n',
    CODEPAGE = '65001'
);

SELECT * FROM ventas



