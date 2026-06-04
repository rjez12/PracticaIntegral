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

--Módulo 5: implementar carga de datos de prueba para Módulo V(Insert)
-- 51. Insertar 5 especialidades médicas.
ALTER TABLE Especialidades ADD nombre VARCHAR(100); -- Aseguramos columna destino
INSERT INTO Especialidades (id_especialidad, nombre) VALUES
(1, 'Cardiología'), (2, 'Pediatría'), (3, 'Dermatología'), (4, 'Ginecología'), (5, 'Neurología');

-- 52. Insertar 10 médicos.
INSERT INTO Medicos (id_medico, nombre, correo, salario, id_especialidad, experiencia, turno) VALUES
(1, 'Dr. Carlos Mendoza', 'carlos@hospital.com', 5000.00, 1, 10, 'Mañana'),
(2, 'Dra. Ana Gómez', 'ana@hospital.com', 4500.00, 2, 8, 'Tarde'),
(3, 'Dr. Luis Peralta', 'luis@hospital.com', 4800.00, 3, 5, 'Mañana'),
(4, 'Dra. Elena Rostova', 'elena@hospital.com', 5200.00, 4, 12, 'Noche'),
(5, 'Dr. Jorge Silva', 'jorge@hospital.com', 6000.00, 5, 15, 'Tarde'),
(6, 'Dr. Miguel Ángel', 'miguel@hospital.com', 4200.00, 1, 4, 'Mañana'),
(7, 'Dra. Sofia Casillas', 'sofia@hospital.com', 4700.00, 2, 6, 'Tarde'),
(8, 'Dr. Andrés Marín', 'andres@hospital.com', 5100.00, 3, 9, 'Noche'),
(9, 'Dra. Lucía Méndez', 'lucia@hospital.com', 5300.00, 4, 11, 'Mañana'),
(10, 'Dr. Ricardo Tovar', 'ricardo@hospital.com', 5800.00, 5, 14, 'Noche');

-- 53. Insertar 20 pacientes.
-- Nota: Dejamos los IDs 19 y 20 sin citas asignadas deliberadamente para cumplir limpiamente con el paso 87.
INSERT INTO Pacientes (id_paciente, nombre, correo, edad, fecha_registro, telefono, direccion, genero, tipo_sangre, fecha_nacimiento) VALUES
(1, 'Juan Pérez', 'juan@mail.com', 30, '2026-01-10', '555-1234', 'Calle 1', 'M', 'O+', '1996-05-12'),
(2, 'María López', 'maria@mail.com', 25, '2026-01-11', '555-5678', 'Calle 2', 'F', 'A+', '2001-08-22'),
(3, 'Pedro Gómez', 'pedro@mail.com', 40, '2026-01-12', '555-9012', 'Calle 3', 'M', 'B+', '1986-03-05'),
(4, 'Laura Martínez', 'laura@mail.com', 18, '2026-01-13', '555-3456', 'Calle 4', 'F', 'O-', '2008-11-15'),
(5, 'Carlos Sánchez', 'carlos_p@mail.com', 65, '2026-01-14', '555-7890', 'Calle 5', 'M', 'AB+', '1961-07-30'),
(6, 'Ana Ramírez', 'ana_r@mail.com', 12, '2026-01-15', '555-2345', 'Calle 6', 'F', 'A-', '2014-01-25'),
(7, 'Luis Hernández', 'luis_h@mail.com', 50, '2026-01-16', '555-6789', 'Calle 7', 'M', 'O+', '1976-09-18'),
(8, 'Elena Jiménez', 'elena_j@mail.com', 28, '2026-01-17', '555-0123', 'Calle 8', 'F', 'B-', '1998-04-02'),
(9, 'Jorge Díaz', 'jorge_d@mail.com', 35, '2026-01-18', '555-4567', 'Calle 9', 'M', 'O+', '1991-12-10'),
(10, 'Sofía Torres', 'sofia_t@mail.com', 22, '2026-01-19', '555-8901', 'Calle 10', 'F', 'A+', '2004-06-14'),
(11, 'Miguel Castro', 'miguel_c@mail.com', 45, '2026-01-20', '555-3210', 'Calle 11', 'M', 'AB-', '1981-02-27'),
(12, 'Lucía Fernández', 'lucia_f@mail.com', 60, '2026-01-21', '555-7654', 'Calle 12', 'F', 'O+', '1966-10-05'),
(13, 'Roberto Sosa', 'roberto@mail.com', 33, '2026-01-22', '555-1111', 'Calle 13', 'M', 'A-', '1993-05-19'),
(14, 'Claudia Ríos', 'claudia@mail.com', 29, '2026-01-23', '555-2222', 'Calle 14', 'F', 'O+', '1997-12-01'),
(15, 'Andrés Vela', 'andres_v@mail.com', 55, '2026-01-24', '555-3333', 'Calle 15', 'M', 'B+', '1971-04-11'),
(16, 'Patricia Luna', 'patricia@mail.com', 24, '2026-01-25', '555-4444', 'Calle 16', 'F', 'O-', '2002-09-23'),
(17, 'Fernando Cruz', 'fernando@mail.com', 38, '2026-01-26', '555-5555', 'Calle 17', 'M', 'A+', '1988-03-14'),
(18, 'Diana Mora', 'diana@mail.com', 41, '2026-01-27', '555-6666', 'Calle 18', 'F', 'AB+', '1985-07-07'),
(19, 'Gabriel Solís', 'gabriel@mail.com', 27, '2026-01-28', '555-7777', 'Calle 19', 'M', 'O+', '1999-01-31'),
(20, 'Beatriz Peña', 'beatriz@mail.com', 52, '2026-01-29', '555-8888', 'Calle 20', 'F', 'B+', '1974-08-16');

-- 54. Insertar 15 citas.
INSERT INTO Citas (id_cita, id_paciente, id_medico, fecha, estado, costo_consulta) VALUES
(1, 1, 1, '2026-06-04 09:00:00', 'Completada', 150),
(2, 2, 2, '2026-06-04 10:00:00', 'Completada', 120),
(3, 3, 3, '2026-06-05 11:00:00', 'Programada', 130),
(4, 4, 4, '2026-06-06 12:00:00', 'Programada', 160),
(5, 5, 5, '2026-06-07 13:00:00', 'Cancelada', 200),
(6, 6, 6, '2026-06-04 14:00:00', 'Programada', 110),
(7, 7, 7, '2026-06-08 15:00:00', 'Programada', 125),
(8, 8, 8, '2026-06-09 16:00:00', 'Programada', 140),
(9, 9, 9, '2026-06-10 17:00:00', 'Programada', 155),
(10, 10, 10, '2026-06-11 08:00:00', 'Programada', 180),
(11, 11, 1, '2026-06-12 09:30:00', 'Programada', 150),
(12, 12, 2, '2026-06-13 10:30:00', 'Programada', 120),
(13, 13, 3, '2026-06-14 11:30:00', 'Programada', 130),
(14, 14, 4, '2026-06-15 12:30:00', 'Programada', 160),
(15, 15, 5, '2026-06-16 13:30:00', 'Programada', 200);

-- 55. Insertar 10 habitaciones.
INSERT INTO Habitaciones (id_habitacion, numero, id_paciente, disponibilidad) VALUES
(1, '101', 1, 'Ocupada'), (2, '102', 2, 'Ocupada'),
(3, '103', NULL, 'Disponible'), (4, '104', NULL, 'Disponible'),
(5, '105', 5, 'Ocupada'), (6, '201', NULL, 'Disponible'),
(7, '202', NULL, 'Disponible'), (8, '203', 8, 'Ocupada'),
(9, '204', NULL, 'Disponible'), (10, '205', NULL, 'Disponible');

-- 56. Insertar 10 tratamientos.
ALTER TABLE Tratamientos ADD estado VARCHAR(20); -- Columna de control de estado
INSERT INTO Tratamientos (id_treatment, descripcion, id_paciente, estado) VALUES
(1, 'Tratamiento Hipertensión', 1, 'Activo'), (2, 'Tratamiento Asma', 2, 'Activo'),
(3, 'Tratamiento Dermatitis', 3, 'Finalizado'), (4, 'Tratamiento Control Prenatal', 4, 'Activo'),
(5, 'Rehabilitación Neurológica', 5, 'Activo'), (6, 'Tratamiento Arritmia', 6, 'Finalizado'),
(7, 'Control Pediatría', 7, 'Activo'), (8, 'Tratamiento Acné', 8, 'Activo'),
(9, 'Seguimiento Ginecología', 9, 'Finalizado'), (10, 'Terapia Migraña', 10, 'Activo');

-- 57. Insertar 20 medicamentos (Incluyendo registros vencidos para el paso 89).
INSERT INTO Medicamentos (id_medicamento, nombre, id_tratamiento, fecha_vencimiento) VALUES
(1, 'Paracetamol', 1, '2027-12-31'), (2, 'Ibuprofeno', 2, '2025-01-01'), -- Vencido
(3, 'Amoxicilina', 3, '2027-05-20'), (4, 'Loratadina', 4, '2024-08-15'),  -- Vencido
(5, 'Omeprazol', 5, '2026-11-30'), (6, 'Metformina', 6, '2028-02-14'),
(7, 'Losartán', 7, '2027-09-10'), (8, 'Atorvastatina', 8, '2025-06-01'),  -- Vencido
(9, 'Salbutamol', 9, '2026-08-22'), (10, 'Aspirina', 10, '2027-03-15'),
(11, 'Clonazepam', 1, '2028-01-01'), (12, 'Tramadol', 2, '2025-05-10'),  -- Vencido
(13, 'Enalapril', 3, '2026-10-12'), (14, 'Fluoxetina', 4, '2027-07-19'),
(15, 'Sertralina', 5, '2026-12-25'), (16, 'Diclofenaco', 6, '2025-11-11'), -- Vencido
(17, 'Ranitidina', 7, '2027-04-30'), (18, 'Cetirizina', 8, '2026-05-05'),
(19, 'Azitromicina', 9, '2028-06-18'), (20, 'Insulina', 10, '2026-07-04');

-- 58. Insertar pacientes con todos los campos (Garantizando un paciente objetivo de borrado exacto).
INSERT INTO Pacientes (id_paciente, nombre, correo, edad, fecha_registro, telefono, direccion, genero, tipo_sangre, fecha_nacimiento) 
VALUES (21, 'Paciente Eliminación', 'delete@mail.com', 40, '2026-06-04', '555-0000', 'Direccion Test', 'M', 'O+', '1986-01-01');

-- Insertar un paciente que explícitamente contenga la palabra "Prueba" para el paso 90
INSERT INTO Pacientes (id_paciente, nombre, correo, edad, fecha_registro, telefono, direccion, genero, tipo_sangre, fecha_nacimiento) 
VALUES (22, 'Registro de Prueba', 'prueba@mail.com', 20, '2026-06-04', '555-9999', 'Direccion Prueba', 'F', 'A+', '2006-01-01');

-- 59. Insertar médicos especialistas.
INSERT INTO Medicos (id_medico, nombre, correo, salario, id_especialidad, experiencia, turno) 
VALUES (11, 'Dr. Francisco Valle', 'francisco@hospital.com', 6500.00, 1, 18, 'Mañana');

-- 60. Insertar citas con fecha actual (Utilizando CAST para aislar la fecha en 2026).
INSERT INTO Citas (id_cita, id_paciente, id_medico, fecha, estado, costo_consulta) 
VALUES (16, 1, 2, CAST(GETDATE() AS DATE), 'Programada', 150);

-- 61. Insertar citas futuras.
INSERT INTO Citas (id_cita, id_paciente, id_medico, fecha, estado, costo_consulta) 
VALUES (17, 2, 3, '2026-12-25 10:00:00', 'Programada', 130);

-- 62. Insertar habitaciones ocupadas.
INSERT INTO Habitaciones (id_habitacion, numero, id_paciente, disponibilidad) 
VALUES (11, '301', 3, 'Ocupada');

-- 63. Insertar habitaciones disponibles.
INSERT INTO Habitaciones (id_habitacion, numero, id_paciente, disponibilidad) 
VALUES (12, '302', NULL, 'Disponible');

-- 64. Insertar tratamientos activos.
INSERT INTO Tratamientos (id_treatment, descripcion, id_paciente, estado) 
VALUES (11, 'Fisioterapia Lumbar', 11, 'Activo');

-- 65. Insertar tratamientos finalizados.
INSERT INTO Tratamientos (id_treatment, descripcion, id_paciente, estado) 
VALUES (12, 'Tratamiento de Gripe', 12, 'Finalizado'); 

--Módulo 6: Update
-- 66. Actualizar teléfono de un paciente.
UPDATE Pacientes SET telefono = '555-9999' WHERE id_paciente = 1;

-- 67. Actualizar dirección de un paciente.
UPDATE Pacientes SET direccion = 'Nueva Av. Principal 742' WHERE id_paciente = 2;

-- 68. Actualizar salario de un médico.
UPDATE Medicos SET salario = 5500.00 WHERE id_medico = 1;

-- 69. Actualizar turno de un médico.
UPDATE Medicos SET turno = 'Noche' WHERE id_medico = 2;

-- 70. Cambiar estado de una cita.
UPDATE Citas SET estado = 'Completada' WHERE id_cita = 3;

-- 71. Actualizar costo de consulta.
UPDATE Citas SET costo_consulta = 160 WHERE id_cita = 1;

-- 72. Actualizar nombre de especialidad.
UPDATE Especialidades SET nombre = 'Cardiología Avanzada' WHERE id_especialidad = 1;

-- 73. Actualizar disponibilidad de habitación.
UPDATE Habitaciones SET disponibilidad = 'Ocupada' WHERE id_habitacion = 3;

-- 74. Actualizar tratamiento activo.
UPDATE Tratamientos SET estado = 'Finalizado' WHERE id_treatment = 1;

-- 75. Actualizar medicamento.
UPDATE Medicamentos SET nombre = 'Paracetamol 500mg' WHERE id_medicamento = 1;

-- 76. Actualizar correo de paciente.
UPDATE Pacientes SET correo = 'juan_nuevo@mail.com' WHERE id_paciente = 1;

-- 77. Actualizar correo de médico.
UPDATE Medicos SET correo = 'carlos_mendoza@hospital.com' WHERE id_medico = 1;

-- 78. Actualizar fecha de cita.
UPDATE Citas SET fecha = '2026-06-20 14:00:00' WHERE id_cita = 4;

-- 79. Actualizar experiencia del médico.
UPDATE Medicos SET experiencia = 12 WHERE id_medico = 1;

-- 80. Actualizar tipo de sangre.
UPDATE Pacientes SET tipo_sangre = 'AB-' WHERE id_paciente = 2;

--Módulo 7: Delete
-- 81. Eliminar un paciente específico (ID 21 aislado sin referencias).
DELETE FROM Pacientes WHERE id_paciente = 21;

-- 82. Eliminar una cita (ID 14, que está libre).
DELETE FROM Citas WHERE id_cita = 14;

-- 83. Eliminar un medicamento.
DELETE FROM Medicamentos WHERE id_medicamento = 20;

-- 84. Eliminar una habitación.
DELETE FROM Habitaciones WHERE id_habitacion = 12;

-- 85. Eliminar un tratamiento.
DELETE FROM Tratamientos WHERE id_treatment = 12;

-- 86. Eliminar citas canceladas.
DELETE FROM Citas WHERE estado = 'Cancelada';

-- 87. Eliminar pacientes sin citas (Filtro seguro para limpiar registros huérfanos).
DELETE FROM Pacientes WHERE id_paciente NOT IN (SELECT DISTINCT id_paciente FROM Citas WHERE id_paciente IS NOT NULL);

-- 88. Eliminar habitaciones vacías (Garantizado porque eliminamos la FK restrictiva en el paso 48).
DELETE FROM Habitaciones WHERE disponibilidad = 'Disponible' OR id_paciente IS NULL;

-- 89. Eliminar medicamentos vencidos (Validando de forma estricta contra la fecha actual del sistema 2026).
DELETE FROM Medicamentos WHERE fecha_vencimiento < CAST(GETDATE() AS DATE);

-- 90. Eliminar registros de prueba.
DELETE FROM Pacientes WHERE nombre LIKE '%Prueba%' OR correo LIKE '%prueba%';


