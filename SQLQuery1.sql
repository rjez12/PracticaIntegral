--Módulo 1: Creación de la base de datos, esquemas y tablas para un sistema de gestión hospitalaria

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

--Módulo 2: Modificación de tablas para agregar restricciones y relaciones adicionales

ALTER TABLE Pacientes ADD CONSTRAINT PK_Pacientes PRIMARY KEY (id_paciente);

ALTER TABLE Medicos ADD CONSTRAINT PK_Medicos PRIMARY KEY (id_medico);

ALTER TABLE Pacientes MODIFY nombre VARCHAR(50) NOT NULL;

ALTER TABLE Medicos MODIFY nombre VARCHAR(50) NOT NULL;

ALTER TABLE Pacientes ADD CONSTRAINT UQ_Paciente_Correo UNIQUE (correo);

ALTER TABLE Medicos ADD CONSTRAINT UQ_Medico_Correo UNIQUE (correo);

ALTER TABLE Pacientes ADD CONSTRAINT CK_Paciente_Edad CHECK (edad >= 0);

ALTER TABLE Medicos ADD CONSTRAINT CK_Medico_Salario CHECK (salario > 0);

ALTER TABLE Pacientes MODIFY fecha_registro DATE DEFAULT (CURRENT_DATE);

ALTER TABLE Medicos ADD CONSTRAINT FK_Medicos_Especialidades 
FOREIGN KEY (id_especialidad) REFERENCES Especialidades(id_especialidad);

ALTER TABLE Citas ADD CONSTRAINT FK_Citas_Pacientes 
FOREIGN KEY (id_paciente) REFERENCES Pacientes(id_paciente);

ALTER TABLE Citas ADD CONSTRAINT FK_Citas_Medicos 
FOREIGN KEY (id_medico) REFERENCES Medicos(id_medico);

ALTER TABLE Tratamientos ADD CONSTRAINT FK_Tratamientos_Pacientes 
FOREIGN KEY (id_paciente) REFERENCES Pacientes(id_paciente);

ALTER TABLE Medicamentos ADD CONSTRAINT FK_Medicamentos_Tratamientos 
FOREIGN KEY (id_tratamiento) REFERENCES Tratamientos(id_treatment);

ALTER TABLE Habitaciones ADD CONSTRAINT FK_Habitaciones_Pacientes 
FOREIGN KEY (id_paciente) REFERENCES Pacientes(id_paciente);
