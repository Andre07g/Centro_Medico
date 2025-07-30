-- SCRIPTS DQL

-- Numero de pacientes atentidos por cada medico

SELECT m.nombre, count(*) AS cantidad_pacientes
FROM pacientes
JOIN medicos m ON pacientes.id_medico_asignado = m.id_medico
GROUP BY m.nombre;

-- Total de dias de vacaciones planificadas y disfrutadas por cada empleado

SELECT m.nombre, v.dias_planificados, v.dias_tomados
FROM vacaciones v
JOIN medicos m ON m.id_medico = v.id_medico 

UNION

SELECT e.nombre, v.dias_planificados, v.dias_tomados
FROM vacaciones v
JOIN empleados e ON e.id_empleado = v.id_empleado;

-- Medicos con mayor cantidad de horas de consulta en la semana

SELECT nombre, (dias_consulta_semanales*horas_consulta) AS Horas_semanales
FROM medicos
ORDER BY Horas_semanales DESC
LIMIT 3;

-- Medico con mayor cantidad de horas semanales

SELECT nombre, (dias_consulta_semanales*horas_consulta) AS Horas_semanales
FROM medicos
WHERE (dias_consulta_semanales*horas_consulta) = (SELECT MAX(dias_consulta_semanales*horas_consulta) FROM medicos );

-- Numero de sustituciones realizadas por cada medico sustituto

SELECT nombre, sustituciones_realizadas 
FROM medicos
WHERE tipo = "sustituto";

-- Numero de medicos que estan actualmente en sustitucion

SELECT count(*) 
FROM medicos
WHERE en_sustitucion = 1;

-- Horas totales de consulta por medico por dia de la semana

SELECT nombre, horas_consulta
FROM medicos;

-- Medico con mayor cantidad de pacientes asignados

SELECT m.nombre, count(*) 
FROM pacientes
JOIN medicos m ON pacientes.id_medico_asignado = m.id_medico
GROUP BY m.nombre
LIMIT 1;

-- Empleados con mas de 10 dias de vacaciones disfrutadas

SELECT m.nombre, v.dias_tomados
FROM vacaciones v
JOIN medicos m ON m.id_medico = v.id_medico 
WHERE v.dias_tomados > 10

UNION

SELECT e.nombre, v.dias_tomados
FROM vacaciones v
JOIN empleados e ON e.id_empleado = v.id_empleado
WHERE v.dias_tomados > 10;

-- Medicos que actualmente estan realizando una sustitucion


-- Promedio de horas por dia de medico de consulta a la semana (suponiendo que todos trabajasen 6 dias)

SELECT nombre, tipo, ROUND((dias_consulta_semanales*horas_consulta)/6,1) AS Promedio_hora_diaria
FROM medicos;

-- Medicos con mas de 5 pacientes y sus horas semanales de consulta

SELECT me.nombre, me.Pacientes, (m.horas_consulta*m.dias_consulta_semanales) AS Horas_semanales
FROM (SELECT m.nombre,count(*) AS Pacientes FROM pacientes JOIN medicos m ON pacientes.id_medico_asignado = m.id_medico GROUP BY m.nombre) AS me
JOIN medicos m ON me.nombre = m.nombre
WHERE me.Pacientes > 5;

-- Total de vacaciones planificadas y tomadas por cada tipo de empleado

SELECT m.tipo, SUM(v.dias_planificados) AS Dias_Planificados, SUM(v.dias_tomados) AS Dias_Tomados
FROM vacaciones v
JOIN medicos m ON v.id_medico = m.id_medico
GROUP BY m.tipo

UNION

SELECT e.tipo, SUM(v.dias_planificados) AS Dias_Planificados, SUM(v.dias_tomados) AS Dias_Tomados
FROM vacaciones v
JOIN empleados e ON v.id_empleado = e.id_empleado
GROUP BY e.tipo;

-- Total de pacientes por cada tipo de medico

SELECT m.tipo, count(*) AS cantidad_pacientes
FROM pacientes
JOIN medicos m ON pacientes.id_medico_asignado = m.id_medico
GROUP BY m.tipo;

-- Numero de sustituciones por tipo de medico

SELECT tipo, SUM(sustituciones_realizadas)
FROM medicos
GROUP BY tipo;

-- Empleados y medicos con mas de 20 dias de vacaciones planeadas

SELECT m.nombre, v.dias_planificados
FROM vacaciones v
JOIN medicos m ON m.id_medico = v.id_medico 
WHERE v.dias_planificados > 20

UNION

SELECT e.nombre, v.dias_planificados
FROM vacaciones v
JOIN empleados e ON e.id_empleado = v.id_empleado
WHERE v.dias_planificados > 20;

-- Medicos con el mayor numero de pacientes actualmente en sustitucion

SELECT m.nombre, count(*) AS pacientes
FROM pacientes
JOIN medicos m ON pacientes.id_medico_asignado = m.id_medico
WHERE m.en_sustitucion = 1 
GROUP BY m.nombre;

-- Total de horas de consulta por especialidad

SELECT tipo, SUM(dias_consulta_semanales*horas_consulta) AS Horas_semanales
FROM medicos
GROUP BY tipo