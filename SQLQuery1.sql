--Módulo 1: Creación de la base de datos, esquemas y tablas para un sistema de gestión hospitalaria


-- 1. Crear una base de datos llamada HospitalDB.
CREATE DATABASE HospitalDB;
GO

-- 2. Mostrar todas las bases de datos existentes (Sintaxis oficial del sistema en SQL Server).
SELECT name FROM sys.databases;
GO

-- 3. Seleccionar HospitalDB para trabajar.
USE HospitalDB;
GO

-- 4. Crear la tabla Pacientes (Estructura base inicial).
CREATE TABLE Pacientes (
    id_paciente INT,
    nombre VARCHAR(50),
    correo VARCHAR(100),
    edad INT,
    fecha_registro DATE
);

-- 5. Crear la tabla Medicos (Estructura base inicial).
CREATE TABLE Medicos (
    id_medico INT,
    nombre VARCHAR(50),
    correo VARCHAR(100),
    salario DECIMAL(10,2),
    id_especialidad INT
);

-- 6. Crear la tabla Especialidades.
CREATE TABLE Especialidades (
    id_especialidad INT
);

-- 7. Crear la tabla Citas.
CREATE TABLE Citas (
    id_cita INT,
    id_paciente INT,
    id_medico INT,
    fecha DATETIME
);

-- 8. Crear la tabla Habitaciones.
CREATE TABLE Habitaciones (
    id_habitacion INT,
    numero VARCHAR(10),
    id_paciente INT
);

-- 9. Crear la tabla Tratamientos.
CREATE TABLE Tratamientos (
    id_tratamiento INT,
    descripcion VARCHAR(255),
    id_paciente INT
);

-- 10. Crear la tabla Medicamentos.
CREATE TABLE Medicamentos (
    id_medicamento INT,
    nombre VARCHAR(100),
    id_tratamiento INT,
    fecha_vencimiento DATE
);

--Módulo 2: Modificación de tablas para agregar restricciones y relaciones adicionales

-- 11. Definir PRIMARY KEY en Pacientes.
ALTER TABLE Pacientes ADD CONSTRAINT PK_Pacientes PRIMARY KEY (id_paciente);

-- 12. Definir PRIMARY KEY en Médicos.
ALTER TABLE Medicos ADD CONSTRAINT PK_Medicos PRIMARY KEY (id_medico);

-- Completar PK faltante en Especialidades para poder referenciarla más adelante
ALTER TABLE Especialidades ADD CONSTRAINT PK_Especialidades PRIMARY KEY (id_especialidad);

-- 13. Agregar NOT NULL al nombre del paciente (Se redefine la columna manteniendo el tipo).
ALTER TABLE Pacientes ALTER COLUMN nombre VARCHAR(50) NOT NULL;

-- 14. Agregar NOT NULL al nombre del médico.
ALTER TABLE Medicos ALTER COLUMN nombre VARCHAR(50) NOT NULL;

-- 15. Crear una restricción UNIQUE para el correo del paciente.
ALTER TABLE Pacientes ADD CONSTRAINT UQ_Paciente_Correo UNIQUE (correo);

-- 16. Crear una restricción UNIQUE para el correo del médico.
ALTER TABLE Medicos ADD CONSTRAINT UQ_Medico_Correo UNIQUE (correo);

-- 17. Agregar CHECK para edad mayor o igual a 0.
ALTER TABLE Pacientes ADD CONSTRAINT CK_Paciente_Edad CHECK (edad >= 0);

-- 18. Agregar CHECK para salario del médico mayor que 0.
ALTER TABLE Medicos ADD CONSTRAINT CK_Medico_Salario CHECK (salario > 0);

-- 19. Agregar DEFAULT para fecha de registro (Uso de GETDATE() optimizado para SQL Server).
ALTER TABLE Pacientes ADD CONSTRAINT DF_Paciente_FechaReg DEFAULT GETDATE() FOR fecha_registro;

-- 20. Crear FOREIGN KEY entre Médicos y Especialidades.
ALTER TABLE Medicos ADD CONSTRAINT FK_Medicos_Especialidades 
FOREIGN KEY (id_especialidad) REFERENCES Especialidades(id_especialidad);

-- 21. Crear FOREIGN KEY entre Citas y Pacientes.
ALTER TABLE Citas ADD CONSTRAINT FK_Citas_Pacientes 
FOREIGN KEY (id_paciente) REFERENCES Pacientes(id_paciente);

-- 22. Crear FOREIGN KEY entre Citas y Médicos.
ALTER TABLE Citas ADD CONSTRAINT FK_Citas_Medicos 
FOREIGN KEY (id_medico) REFERENCES Medicos(id_medico);

-- 23. Crear FOREIGN KEY entre Tratamientos y Pacientes.
ALTER TABLE Tratamientos ADD CONSTRAINT FK_Tratamientos_Pacientes 
FOREIGN KEY (id_paciente) REFERENCES Pacientes(id_paciente);

-- 24. Crear FOREIGN KEY entre Medicamentos y Tratamientos.
ALTER TABLE Medicamentos ADD CONSTRAINT FK_Medicamentos_Tratamientos 
FOREIGN KEY (id_tratamiento) REFERENCES Tratamientos(id_tratamiento);

-- 25. Crear FOREIGN KEY entre Habitaciones y Pacientes.
ALTER TABLE Habitaciones ADD CONSTRAINT FK_Habitaciones_Pacientes 
FOREIGN KEY (id_paciente) REFERENCES Pacientes(id_paciente);

--Módulo 3: Modificación de estructuras mediante alter

-- 26. Agregar columna teléfono a Pacientes.
ALTER TABLE Pacientes ADD telefono VARCHAR(20);

-- 27. Agregar columna dirección a Pacientes.
ALTER TABLE Pacientes ADD direccion VARCHAR(100);

-- 28. Agregar columna género.
ALTER TABLE Pacientes ADD genero VARCHAR(10);

-- 29. Agregar columna tipo_sangre.
ALTER TABLE Pacientes ADD tipo_sangre VARCHAR(5);

-- 30. Agregar columna fecha_nacimiento.
ALTER TABLE Pacientes ADD fecha_nacimiento DATE;

-- 31. Modificar tamaño del campo nombre (Ampliación de capacidad).
ALTER TABLE Pacientes ALTER COLUMN nombre VARCHAR(150) NOT NULL;

-- 32. Modificar tamaño del campo dirección.
ALTER TABLE Pacientes ALTER COLUMN direccion VARCHAR(255);

-- 33. Agregar columna experiencia a Médicos.
ALTER TABLE Medicos ADD experiencia INT;

-- 34. Agregar columna turno.
ALTER TABLE Medicos ADD turno VARCHAR(20);

-- 35. Agregar columna observaciones a Citas.
ALTER TABLE Citas ADD observaciones VARCHAR(255);

-- 36. Eliminar columna observaciones.
ALTER TABLE Citas DROP COLUMN observaciones;

-- 37. Agregar columna estado a Citas.
ALTER TABLE Citas ADD estado VARCHAR(20);

-- 38. Agregar columna costo_consulta.
ALTER TABLE Citas ADD costo_consulta DECIMAL(10,2);

-- 39. Modificar tipo de dato del costo (Cambio controlado de requerimiento a INT).
ALTER TABLE Citas ALTER COLUMN costo_consulta INT;

-- 40. Agregar columna disponibilidad a Habitaciones.
ALTER TABLE Habitaciones ADD disponibilidad VARCHAR(20);

-- Columnas y restricciones dummy creadas exclusivamente para ser el objetivo lógico del Módulo IV sin romper la integridad del core
ALTER TABLE Medicos ADD columna_dummy VARCHAR(10);
ALTER TABLE Medicos ADD CONSTRAINT CK_Medico_Dummy CHECK (experiencia >= 0);
ALTER TABLE Medicos ADD CONSTRAINT UQ_Medico_Dummy UNIQUE (columna_dummy);

--Módulo 4: Eliminación de Objetos

-- 41. Eliminar una tabla temporal.
CREATE TABLE #TempPacientes (id INT);
DROP TABLE #TempPacientes;

-- 42. Eliminar una restricción CHECK.
ALTER TABLE Medicos DROP CONSTRAINT CK_Medico_Dummy;

-- 43. Eliminar una restricción UNIQUE.
ALTER TABLE Medicos DROP CONSTRAINT UQ_Medico_Dummy;

-- 44. Eliminar una columna.
ALTER TABLE Medicos DROP COLUMN columna_dummy;

-- 45. Eliminar una tabla de pruebas.
CREATE TABLE TablaPruebas (id INT);
DROP TABLE TablaPruebas;

-- 46. Crear y eliminar una tabla Auditoria.
CREATE TABLE Auditoria (id INT);
DROP TABLE Auditoria;

-- 47. Crear y eliminar una tabla Logs.
CREATE TABLE Logs (id INT);
DROP TABLE Logs;

-- 48. Eliminar una FOREIGN KEY (Se elimina la relación de habitaciones para flexibilizar el diseño según requerimiento).
ALTER TABLE Habitaciones DROP CONSTRAINT FK_Habitaciones_Pacientes;

-- 49. Eliminar una tabla MedicamentosPrueba.
CREATE TABLE MedicamentosPrueba (id INT);
DROP TABLE MedicamentosPrueba;

-- 50. Eliminar una base de datos de pruebas.
CREATE DATABASE PruebaDB;
GO
DROP DATABASE PruebaDB;
GO