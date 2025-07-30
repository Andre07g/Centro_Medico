CREATE DATABASE IF NOT EXISTS Centro_Medico;

USE Centro_Medico;

-- ARCHIVO DDL

CREATE TABLE IF NOT EXISTS medicos (
id_medico INT auto_increment PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
tipo VARCHAR(100) NOT NULL,
dias_consulta_semanales INT,
horas_consulta INT,
en_sustitucion TINYINT,
sustituciones_realizadas INT 
);

CREATE TABLE IF NOT EXISTS empleados (
id_empleado INT auto_increment PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
tipo VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS pacientes (
id_paciente INT auto_increment PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
id_medico_asignado INT,
FOREIGN KEY (id_medico_asignado) REFERENCES medicos(id_medico)
);

CREATE TABLE IF NOT EXISTS vacaciones (
id_vacaciones INT auto_increment PRIMARY KEY,
id_empleado INT,
id_medico INT,
dias_planificados INT,
dias_tomados INT,
FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado),
FOREIGN KEY(id_medico) REFERENCES medicos(id_medico)
);
