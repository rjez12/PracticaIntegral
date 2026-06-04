if not exists (select * from sys.databases where name =  'HospitalDB')
begin
	create database HospitalDB;
end
go

select name from sys.databases where name = 'HospitalDB';
go

use HospitalDB;
go

create schema Catalogos;
go

create schema Clinico;
go

create schema Operaciones;
go

CREATE TABLE Catalogos.Especialidades (
    EspecialidadID INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Descripcion VARCHAR(255)
);

CREATE TABLE Catalogos.Habitaciones (
    HabitacionID INT IDENTITY(1,1) PRIMARY KEY,
    NumeroHabitacion VARCHAR(10) NOT NULL UNIQUE,
    Tipo VARCHAR(50) NOT NULL,
    Estado VARCHAR(20) DEFAULT 'Disponible'
);

CREATE TABLE Catalogos.Medicamentos (
    MedicamentoID INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Formula VARCHAR(150),
    Precio DECIMAL(10,2) NOT NULL,
    Stock INT NOT NULL DEFAULT 0
);
GO


CREATE TABLE Clinico.Pacientes (
    PacienteID INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Apellido VARCHAR(100) NOT NULL,
    FechaNacimiento DATE NOT NULL,
    Genero CHAR(1) CHECK (Genero IN ('M', 'F')), 
    Telefono VARCHAR(20),
    Direccion VARCHAR(255)
);

CREATE TABLE Clinico.Medicos (
    MedicoID INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Apellido VARCHAR(100) NOT NULL,
    EspecialidadID INT,
    Telefono VARCHAR(20),
    Email VARCHAR(100),
    CONSTRAINT FK_Medicos_Especialidades FOREIGN KEY (EspecialidadID) 
        REFERENCES Catalogos.Especialidades(EspecialidadID) ON DELETE SET NULL
);
GO

CREATE TABLE Operaciones.Citas (
    CitaID INT IDENTITY(1,1) PRIMARY KEY,
    PacienteID INT NOT NULL,
    MedicoID INT NOT NULL,
    HabitacionID INT,
    FechaHora DATETIME NOT NULL,
    Motivo VARCHAR(255),
    Estado VARCHAR(20) DEFAULT 'Programada',
    CONSTRAINT FK_Citas_Pacientes FOREIGN KEY (PacienteID) 
        REFERENCES Clinico.Pacientes(PacienteID) ON DELETE CASCADE,
    CONSTRAINT FK_Citas_Medicos FOREIGN KEY (MedicoID) 
        REFERENCES Clinico.Medicos(MedicoID) ON DELETE NO ACTION,
    CONSTRAINT FK_Citas_Habitaciones FOREIGN KEY (HabitacionID) 
        REFERENCES Catalogos.Habitaciones(HabitacionID) ON DELETE SET NULL
);

CREATE TABLE Operaciones.Tratamientos (
    TratamientoID INT IDENTITY(1,1) PRIMARY KEY,
    PacienteID INT NOT NULL,
    MedicoID INT NOT NULL,
    Descripcion TEXT NOT NULL,
    FechaInicio DATE NOT NULL,
    FechaFin DATE,
    CONSTRAINT FK_Tratamientos_Pacientes FOREIGN KEY (PacienteID) 
        REFERENCES Clinico.Pacientes(PacienteID) ON DELETE CASCADE,
    CONSTRAINT FK_Tratamientos_Medicos FOREIGN KEY (MedicoID) 
        REFERENCES Clinico.Medicos(MedicoID) ON DELETE NO ACTION
);
GO
