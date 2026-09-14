CREATE DATABASE base_banco

USE base_banco
GO

-- Creation of the tables
CREATE TABLE sucursales (
	id_sucursal SMALLINT PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL,
	provincia VARCHAR(20) NOT NULL,
	ciudad VARCHAR(30) NOT NULL,
	direccion NVARCHAR(200) NOT NULL,
	telefono VARCHAR (15) NOT NULL,
	fecha_apertura DATE NOT NULL,
	gerente VARCHAR (70) NOT NULL
)

CREATE TABLE usuarios (
	id_usuario SMALLINT PRIMARY KEY,
	nombre VARCHAR(20) NOT NULL,
	apellido1 VARCHAR(20) NOT NULL,
	apellido2 VARCHAR(20),
	cedula NVARCHAR(11) NOT NULL UNIQUE,
	email NVARCHAR(100) NOT NULL UNIQUE,
	telefono NVARCHAR(15) NOT NULL,
	fecha_nacimiento DATE NOT NULL,
	fecha_registro DATE NOT NULL,
	id_sucursal SMALLINT NOT NULL REFERENCES sucursales(id_sucursal),
	típo_cuenta VARCHAR(15) NOT NULL,
	saldo_cuenta DECIMAL(10,2) NOT NULL
)
CREATE TABLE transacciones (
	id_transaccion INT PRIMARY KEY,
	id_usuario SMALLINT NOT NULL REFERENCES usuarios(id_usuario),
	id_sucursal SMALLINT NOT NULL REFERENCES sucursales(id_sucursal),
	fecha DATE NOT NULL,
	tipo_transaccion VARCHAR(30) NOT NULL,
	canal NVARCHAR(20) NOT NULL,
	monto DECIMAL(10,2) NOT NULL,
	estado VARCHAR(15) NOT NULL,
)

-- Local configuration in case of inserting data via OPENROWSET	
/*
EXEC sp_enum_oledb_providers;

EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;

EXEC sp_configure 'Ad Hoc Distributed Queries', 1;
RECONFIGURE;

EXEC master.dbo.sp_MSset_oledb_prop N'Microsoft.ACE.OLEDB.12.0', N'AllowInProcess', 1;
EXEC master.dbo.sp_MSset_oledb_prop N'Microsoft.ACE.OLEDB.12.0', N'DynamicParameters', 1;
*/


-- Sucursales Table
SET DATEFORMAT dmy;

BULK INSERT sucursales
FROM 'C:\Data\base_datos_banco_sucursales.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ';',
    ROWTERMINATOR = '0x0d0a',
    DATAFILETYPE = 'char',
    CODEPAGE = '65001'
);

SELECT * FROM sucursales

-- Usuarios Table
SET DATEFORMAT dmy;

BULK INSERT usuarios
FROM 'C:\Data\base_datos_banco_usuarios.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ';',
    ROWTERMINATOR = '0x0d0a',
    DATAFILETYPE = 'char',
    CODEPAGE = '65001'
);

SELECT * FROM usuarios

-- Transacciones Table
SET DATEFORMAT dmy;

BULK INSERT transacciones
FROM 'C:\Data\base_datos_banco_transacciones.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ';',
    ROWTERMINATOR = '0x0d0a',
    DATAFILETYPE = 'char',
    CODEPAGE = '65001'
);

SELECT * FROM transacciones
