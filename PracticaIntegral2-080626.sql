--Paso 1
if not exists(select * from sys.databases where name = 'EmpresaSQL')
begin
	create database EmpresaSQL
end

-- Paso 2
go
use EmpresaSQL
go

-- Paso 3
CREATE TABLE TDepartamento (
    nDepartamentoID INT IDENTITY(1,1) PRIMARY KEY, 
    cNombreDepartamento VARCHAR(100) UNIQUE NOT NULL
);
GO

-- Paso 4
CREATE TABLE TCargo (
    nCargoID INT IDENTITY(1,1) PRIMARY KEY, 
    cNombreCargo VARCHAR(100) UNIQUE NOT NULL
);
GO

-- Paso 5
CREATE TABLE TEmpleado (
    nEmpleadoID INT IDENTITY(1,1) PRIMARY KEY,
    cNIF VARCHAR(20) UNIQUE,
    cNombre VARCHAR(50),
    cApellido VARCHAR(50),
    nDepartamentoID INT,
    nCargoID INT,
    dFechaContratacion DATE,
    nSalario DECIMAL(12,2)
);
GO