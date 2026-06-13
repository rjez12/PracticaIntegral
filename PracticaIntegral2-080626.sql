--Paso 1
if not exists(select * from sys.databases where name = 'EmpresaSQL')
begin
	create database EmpresaSQL
end

-- Paso 2
go
use EmpresaSQL
go

-- paso 3
create table tdepartamento (
    ndepartamentoid int identity(1,1) primary key, 
    cnombredepartamento varchar(100) unique not null
);
go

-- paso 4
create table tcargo (
    ncargoid int identity(1,1) primary key, 
    cnombrecargo varchar(100) unique not null
);
go

-- paso 5
create table templeado (
    nempleadoid int identity(1,1) primary key,
    cnif varchar(20) unique,
    cnombre varchar(50),
    capellido varchar(50),
    ndepartamentoid int,
    ncargoid int,
    dfechacontratacion date,
    nsalario decimal(12,2)
);
go

-- paso 6
alter table templeado add constraint ck_salario check (nsalario > 300);
go

-- paso 7
alter table templeado add constraint df_fecha default getdate() for dfechacontratacion;
go

-- paso 8
alter table templeado add constraint fk_emp_depto foreign key (ndepartamentoid) references tdepartamento(ndepartamentoid);
go

-- paso 9
alter table templeado add constraint fk_emp_cargo foreign key (ncargoid) references tcargo(ncargoid);
go

-- paso 10 y 11
create table tproyecto (
    nproyectoid int identity(1,1) primary key
);
go

-- paso 12
alter table tproyecto add cnombreproyecto varchar(150) not null;
go

-- paso 13
alter table tproyecto add dfechainicio date not null;
go

-- paso 14
alter table tproyecto add dfechafinalizacion date;
go

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
insert into tdepartamento (cnombredepartamento) values 
('ingenieria de sistemas'), 
('recursos humanos'), 
('soporte tecnico dti'), 
('operaciones y ventas'), 
('departamento inactivo');
go

-- paso 32
insert into tcargo (cnombrecargo) values 
('desarrollador de software'), 
('administrador de base de datos'), 
('analista de calidad qa'), 
('gerente de proyectos it'), 
('especialista de soporte');
go

-- paso 33
insert into templeado (cnif, cnombre, capellido, ndepartamentoid, ncargoid, nsalario, cemail, nedad, bactivo, cgenero) values 
('001-151100-1000a', 'jesser', 'rodriguez', 1, 1, 1500.00, 'jrodriguez@uam.edu', 25, 1, 'm'),
('001-120501-1001b', 'maria', 'perez', 1, 2, 1600.00, 'mperez@uam.edu', 22, 1, 'f'),
('001-220802-1002c', 'kellys', 'lopez', 2, 4, 1800.00, 'klopez@uam.edu', 23, 1, 'f'),
('001-100301-1003d', 'samuel', 'gomez', 1, 1, 1400.00, 'sgomez@uam.edu', 24, 1, 'm'),
('001-050403-1004e', 'anyeli', 'martinez', 3, 5, 900.00, 'amartinez@uam.edu', 21, 1, 'f'),
('001-301000-1005f', 'jimmy', 'hernandez', 3, 5, 450.00, 'jhernandez@uam.edu', 26, 1, 'm'), -- salario bajo intencional para el paso 46
('001-140299-1006g', 'carlos', 'sanchez', 4, 3, 1300.00, 'csanchez@uam.edu', 28, 1, 'm'),
('001-180998-1007h', 'ana', 'ruiz', 4, 3, 1350.00, 'aruiz@uam.edu', 27, 1, 'f'),
('001-251295-1008i', 'luis', 'diaz', 2, 4, 1750.00, 'ldiaz@uam.edu', 29, 1, 'm'),
('001-080797-1009j', 'sofia', 'ramirez', 1, 2, 1550.00, 'sramirez@uam.edu', 25, 1, 'f');
go

-- paso 34
insert into tproyecto (cnombreproyecto, dfechainicio) values 
('sistema techzone s.a. core', '2025-08-15'), 
('plataforma jino gym', '2026-02-10'), 
('tienda kjmr backend', '2026-04-01');
go

-- paso 35
insert into templeado_proyecto (nempleadoid, nproyectoid) values (1, 1), (2, 1), (3, 2), (4, 2), (5, 3);
go

-- paso 36
insert into templeado (cnif, cnombre, capellido, nsalario) 
values ('001-111111-1010k', 'roberto', 'castillo', 1150.00);
go

-- paso 37
insert into templeado (cnif, cnombre, capellido, nsalario, cemail) 
values ('001-222222-1011l', 'patricia', 'mendoza', 1250.00, 'pmendoza@uam.edu');
go

-- paso 38
insert into templeado (cnif, cnombre, capellido, nsalario) 
values ('001-333333-1012m', 'fernando', 'vargas', 1050.00);
go

-- paso 39
insert into templeado (cnif, cnombre, capellido, nsalario) values 
('001-444444-1013n', 'gabriela', 'silva', 1450.00), 
('001-555555-1014o', 'hector', 'navarro', 1380.00);
go

-- paso 40
begin try 
    insert into templeado (cnif, cnombre, nsalario) values ('error-salario', 'invalido', -500.00); 
end try 
begin catch 
    print 'paso 40 evaluado: no se permiten salarios negativos.';
end catch;
go

-- paso 41
update templeado set nsalario = nsalario * 1.10;
go

-- paso 42
update templeado set nsalario = nsalario * 1.20 where ndepartamentoid = 1;
go

-- paso 43
update templeado set cemail = 'jrodriguez.admin@uam.edu' where nempleadoid = 1;
go

-- paso 44
update templeado set ncargoid = 4 where nempleadoid = 3;
go

-- paso 45
update templeado set ndepartamentoid = 1 where nempleadoid in (4, 5);
go

-- paso 46
update templeado set bactivo = 0 where nsalario < 500;
go

-- paso 47
update tproyecto set dfechafinalizacion = '2026-12-15' where nproyectoid = 1;
go

-- paso 48
insert into templeado_proyecto (nempleadoid, nproyectoid) values (3, 3);
go

-- paso 49
delete from templeado where cnif = '001-555555-1014o';
go

-- paso 50
delete from templeado where bactivo = 0;
go

-- paso 51
delete from tproyecto where nproyectoid = 3;
go

-- paso 52
delete from templeado_proyecto where nempleadoid = 5;
go

-- paso 53
delete from tdepartamento where ndepartamentoid = 5;
go

-- paso 54
select * from templeado order by capellido asc;
go

-- paso 55
select * from templeado where nsalario > 1000;
go

-- paso 56
select * from templeado where bactivo = 1;
go

-- paso 57
select * from templeado where year(dfechacontratacion) = year(getdate());
go

-- paso 58
select e.cnombre, e.capellido, d.cnombredepartamento 
from templeado e join tdepartamento d on e.ndepartamentoid = d.ndepartamentoid;
go

-- paso 59
select e.cnombre, e.capellido, c.cnombrecargo 
from templeado e join tcargo c on e.ncargoid = c.ncargoid;
go

-- paso 60
select e.cnombre, e.capellido, p.cnombreproyecto 
from templeado e 
join templeado_proyecto ep on e.nempleadoid = ep.nempleadoid 
join tproyecto p on ep.nproyectoid = p.nproyectoid;
go

-- paso 61
select ndepartamentoid, count(*) as cantidad_empleados from templeado group by ndepartamentoid;
go

-- paso 62
select ndepartamentoid, avg(nsalario) as salario_promedio from templeado group by ndepartamentoid;
go

-- paso 63
select ndepartamentoid, max(nsalario) as maximo, min(nsalario) as minimo from templeado group by ndepartamentoid;
go

-- paso 64
select nproyectoid from templeado_proyecto group by nproyectoid having count(nempleadoid) > 2;
go

-- paso 65
select * from templeado where capellido like 'g%';
go

-- paso 66
select * from templeado order by nsalario desc;
go

-- paso 67
select top 3 * from templeado order by nsalario desc;
go

-- paso 68
select * from templeado where nedad between 25 and 40;
go

-- paso 69
select count(*) as total_activos from templeado where bactivo = 1;
go

-- paso 70
select count(*) as total_proyectos from tproyecto;
go