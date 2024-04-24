/*SELECT nombre FROM producto;
SELECT nombre, precio FROM producto;
SELECT * FROM producto;
SELECT nombre, precio, ROUND((precio *1.0823),2) AS precio FROM producto;
SELECT nombre 'nom de "productos"' , precio euros, ROUND((precio *1.0823),2) AS 'dòlars nord-americans' FROM producto;
SELECT UPPER(nombre) AS nombre, precio FROM producto;
SELECT LOWER(nombre) AS nombre, precio FROM producto;
SELECT nombre, UPPER(SUBSTRING(nombre, 1, 2)) AS inicials FROM fabricante;
SELECT nombre, ROUND(precio,2) AS precio FROM producto;
SELECT nombre, ROUND(precio,0) AS precio FROM producto;
SELECT codigo_fabricante FROM producto;
SELECT distinct codigo_fabricante FROM producto;
SELECT nombre FROM fabricante order by nombre ASC;
SELECT nombre FROM fabricante order by nombre DESC;
SELECT nombre, precio FROM producto order by nombre ASC;
SELECT nombre, precio FROM producto order by precio DESC;
SELECT column1 FROM fabricante;
SELECT * FROM fabricante WHERE codigo BETWEEN  1 AND 5;
SELECT * FROM fabricante WHERE codigo BETWEEN 4 AND 5;
SELECT nombre, precio FROM producto order by precio ASC LIMIT 1;
SELECT nombre, precio FROM producto order by precio DESC LIMIT 1;
SELECT nombre FROM producto WHERE codigo_fabricante = 2;
SELECT producto.nombre, precio, fabricante.nombre FROM producto INNER JOIN fabricante ON fabricante.codigo = producto.codigo_fabricante;
SELECT producto.nombre, precio, fabricante.nombre FROM producto INNER JOIN fabricante ON fabricante.codigo = producto.codigo_fabricante order by fabricante.nombre ASC;
-- Queries de "Universidad"
SELECT apellido1, apellido2, nombre FROM persona WHERE tipo = "alumno" order by apellido1 ASC;
SELECT nombre, apellido1, apellido2 FROM persona WHERE tipo = "alumno" AND telefono IS NULL;
SELECT nombre, apellido1, apellido2 FROM persona WHERE tipo = "alumno" AND fecha_nacimiento BETWEEN "1999-01-01" AND "1999-12-31";
SELECT nombre, apellido1, apellido2 FROM persona WHERE tipo = "profesor" AND telefono IS NULL AND SUBSTRING(nif, 9,9)="K";*/
-- CORREGIDA LA 5:
SELECT nombre FROM asignatura WHERE cuatrimestre = "1" AND id_grado="7" AND curso="3";/*
SELECT apellido1, apellido2, persona.nombre, departamento.nombre departamento FROM ((profesor INNER JOIN persona ON persona.id = id_profesor) INNER JOIN departamento ON departamento.id = profesor.id_departamento) order by apellido1, apellido2, persona.nombre ASC;
SELECT asignatura.nombre, anyo_inicio, anyo_fin FROM (((alumno_se_matricula_asignatura INNER JOIN persona ON persona.id = alumno_se_matricula_asignatura.id_alumno) INNER JOIN asignatura ON asignatura.id = alumno_se_matricula_asignatura.id_asignatura) INNER JOIN curso_escolar ON curso_escolar.id = alumno_se_matricula_asignatura.id_curso_escolar) WHERE nif = "26902806M";
SELECT DISTINCT departamento.nombre FROM grado INNER JOIN asignatura ON asignatura.id_grado = grado.id INNER JOIN profesor ON  profesor.id_profesor = asignatura.id_profesor INNER JOIN departamento ON departamento.id = profesor.id_departamento WHERE grado.id = "4";
SELECT DISTINCT nombre FROM persona INNER JOIN alumno_se_matricula_asignatura ON alumno_se_matricula_asignatura.id_alumno = persona.id INNER JOIN curso_escolar ON curso_escolar.id = alumno_se_matricula_asignatura.id_curso_escolar WHERE tipo = "alumno" AND curso_escolar.anyo_inicio = "2018";
-- Consultes amb RIGHT/LEFT JOIN*/
-- La 1 rectificado el left para que salieran en el caso de que hubieran profes sin departamento, pero no es el caso (12 profes en tabla persona, 12 id's en tabla profes y todos con departamento)
SELECT departamento.nombre, apellido1, apellido2, persona.nombre FROM persona LEFT JOIN profesor ON persona.id = profesor.id_profesor LEFT JOIN departamento ON profesor.id_departamento = departamento.id WHERE tipo = "profesor" ORDER BY departamento.nombre, apellido1, persona.nombre ASC;
-- La 2 rectificado right por left y puesto filtro de profesor, pero siguen sin haber profes sin departamento, son unos currantes todos. :(
SELECT persona.nombre FROM persona LEFT JOIN profesor ON persona.id = profesor.id_profesor WHERE profesor.id_departamento IS NULL AND persona.tipo="profesor";
-- La 3 corregida, estos departamentos no gustan a los profes TT_TT
SELECT departamento.nombre FROM departamento LEFT JOIN profesor ON departamento.id = profesor.id_departamento WHERE profesor.id_departamento IS NULL;/*
SELECT persona.nombre, apellido1, apellido2 FROM persona LEFT JOIN asignatura ON persona.id = asignatura.id_profesor WHERE persona.tipo="profesor" AND asignatura.id_profesor IS NULL;
SELECT * FROM asignatura WHERE id_profesor IS NULL; /*no veig necessari fer join amb un altre taula/*
SELECT departamento.nombre FROM departamento LEFT JOIN profesor ON departamento.id = profesor.id_departamento LEFT JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor WHERE asignatura.id_profesor IS NULL OR asignatura.id_profesor NOT IN ('3','14');
-- Consultes resum
SELECT COUNT(id) FROM persona  WHERE tipo = "alumno";
SELECT COUNT(id) FROM persona WHERE tipo = "alumno" AND fecha_nacimiento BETWEEN "1999-01-01" AND "1999-12-31";
SELECT nombre AS departamento, COUNT(profesor.id_profesor) AS profesores FROM departamento RIGHT JOIN profesor ON departamento.id = profesor.id_departamento GROUP BY departamento.id ORDER BY COUNT(profesor.id_profesor) DESC;
SELECT nombre AS departamento, COUNT(profesor.id_profesor) AS profesores FROM departamento LEFT JOIN profesor ON departamento.id = profesor.id_departamento GROUP BY departamento.nombre;
SELECT grado.nombre, COUNT(asignatura.id_grado) AS Asignaturas FROM grado LEFT JOIN asignatura ON asignatura.id_grado = grado.id GROUP BY(grado.nombre) ORDER BY asignaturas DESC;
SELECT * FROM persona order by fecha_nacimiento DESC LIMIT 1; -- no se com fer per que no surti la fila del null, he posat la condicio WHERE id is not null, i segueix apareixent.
*/