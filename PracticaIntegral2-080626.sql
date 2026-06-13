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

-- Paso 6
ALTER TABLE TEmpleado ADD CONSTRAINT CK_Salario CHECK (nSalario > 300);
GO

-- Paso 7
ALTER TABLE TEmpleado ADD CONSTRAINT DF_Fecha DEFAULT GETDATE() FOR dFechaContratacion;
GO

-- Paso 8
ALTER TABLE TEmpleado ADD CONSTRAINT FK_Emp_Depto FOREIGN KEY (nDepartamentoID) REFERENCES TDepartamento(nDepartamentoID);
GO

-- Paso 9
ALTER TABLE TEmpleado ADD CONSTRAINT FK_Emp_Cargo FOREIGN KEY (nCargoID) REFERENCES TCargo(nCargoID);
GO

-- Paso 10 y 11: (SQL Server exige que el autoincremental IDENTITY se defina al crear el campo)
CREATE TABLE TProyecto (
    nProyectoID INT IDENTITY(1,1) PRIMARY KEY
);
GO

-- Paso 12
ALTER TABLE TProyecto ADD cNombreProyecto VARCHAR(150) NOT NULL;
GO

-- Paso 13
ALTER TABLE TProyecto ADD dFechaInicio DATE NOT NULL;
GO

-- Paso 14
ALTER TABLE TProyecto ADD dFechaFinalizacion DATE;
GO      

-- paso 15
create table templeado_proyecto (
    nempleadoid int, 
    nproyectoid int, 
    primary key (nempleadoid, nproyectoid),
    constraint fk_ep_emp foreign key (nempleadoid) references templeado(nempleadoid),
    constraint fk_ep_proy foreign key (nproyectoid) references tproyecto(nproyectoid)
);
go

-- paso 16
alter table templeado add cemail varchar(150);
go

-- paso 17
alter table templeado add ctelefono varchar(15);
go

-- paso 18
alter table templeado alter column cnombre varchar(100);
go

-- paso 19
alter table templeado alter column capellido varchar(100);
go

-- paso 20
alter table templeado add cdireccion varchar(200);
go

-- paso 21
alter table templeado add nedad int;
go

-- paso 22
alter table templeado add constraint ck_edad check (nedad between 18 and 65);
go

-- paso 23
alter table templeado add constraint uq_email unique (cemail);
go

-- paso 24
alter table templeado add bactivo bit default 1;
go

-- paso 25
alter table templeado drop column cdireccion;
go

-- paso 26
alter table templeado alter column ctelefono varchar(20);
go

-- paso 27
alter table templeado add cgenero char(1);
go

-- paso 28
alter table templeado add constraint ck_genero check (cgenero in ('m', 'f'));
go

-- paso 29
alter table templeado add dfechanacimiento date;
go

-- paso 30
create table tsucursal (
    nsucursalid int identity(1,1) primary key, 
    cnombresucursal varchar(100) not null
);
go