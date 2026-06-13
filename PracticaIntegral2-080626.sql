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
    cCIF VARCHAR(20) UNIQUE,
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
-- paso 31
insert into tdepartamento (cnombredepartamento) values ('sistemas'), ('rrhh'), ('soporte'), ('ventas'), ('vacio');
go

-- paso 32
insert into tcargo (cnombrecargo) values ('desarrollador'), ('dba'), ('qa'), ('gerente'), ('soporte técnico');
go

-- paso 33
insert into templeado (cCIF, cnombre, capellido, ndepartamentoid, ncargoid, nsalario, cemail, nedad, bactivo, cgenero) values 
('25011185', 'Jesser', 'Rodriguez', 1, 1, 1000, 'jesserjrch@uamv.edu.ni', 18, 1, 'm'),
('n02', 'b', 'b', 1, 2, 1100, 'b@uam.edu', 21, 1, 'f'),
('n03', 'c', 'c', 2, 3, 1200, 'c@uam.edu', 22, 1, 'm'),
('n04', 'd', 'd', 2,     4, 1300, 'd@uam.edu', 23, 1, 'f'),
('n05', 'e', 'e', 3, 5, 1400, 'e@uam.edu', 24, 1, 'm'),
('n06', 'f', 'f', 3, 1, 400,  'f@uam.edu', 25, 1, 'f'), 
('n07', 'g', 'g', 4, 2, 1600, 'g@uam.edu', 26, 1, 'm'),
('n08', 'h', 'h', 4, 3, 1700, 'h@uam.edu', 27, 1, 'f'),
('n09', 'i', 'i', 1, 4, 1800, 'i@uam.edu', 28, 1, 'm'),
('n10', 'j', 'j', 2, 5, 1900, 'j@uam.edu', 29, 1, 'f');
go

-- paso 34
insert into tproyecto (cnombreproyecto, dfechainicio) values ('p1', getdate()), ('p2', getdate()), ('p3', getdate());
go

-- paso 35
insert into templeado_proyecto (nempleadoid, nproyectoid) values (1, 1), (2, 2);
go

-- paso 36
insert into templeado (cCIF, cnombre, nsalario) values ('n11', 'def', 1000);
go

-- paso 37
insert into templeado (cCIF, cnombre, nsalario, cemail) values ('n12', 'mail', 1000, 'mail@uam.edu');
go

-- paso 38
insert into templeado (cCIF, cnombre, nsalario) values ('n13', 'activo', 1000);
go

-- paso 39
insert into templeado (cCIF, cnombre, nsalario) values ('n14', 'multi1', 1000), ('n15', 'multi2', 1000);
go

-- paso 40
begin try insert into templeado (cCIF, nsalario) values ('err', -100); end try begin catch end catch;
go