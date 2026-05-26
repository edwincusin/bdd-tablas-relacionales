-- Parte 1 – Crear Base de Datos --

CREATE DATABASE biclioteca_db;

-- Parte 2 – Crear Tablas --
--Tabla libros
CREATE TABLE libros(
	codigo varchar(5) PRIMARY KEY,
	titulo varchar(50) NOT NULL,
	paginas int NOT NULL
);

--Tabla autores
CREATE TABLE autores(
	id int PRIMARY KEY, 
	nombre varchar(50) NOT NULL,
	pais varchar(30) NOT NULL
);


--Parte 3 – Tabla de Rompimiento
--Crear una tabla llamada: libro_autor
CREATE TABLE libro_autor(
	la_libro_codigo_fk varchar(5) NOT NULL,
	la_autor_id_fk int NOT NULL,
	anio_publicacion int NOT NULL,

	constraint fk_libro FOREIGN key (la_libro_codigo_fk) REFERENCES libros(codigo),
	constraint fk_autor FOREIGN KEY (la_autor_id_fk) REFERENCES autores(id),

	CONSTRAINT pk_libro_por_autor PRIMARY KEY (la_libro_codigo_fk,la_autor_id_fk) --CLAVE COMPUESTA
);


--Parte 4 – Insertar Datos
--Libros ● 4 registros
INSERT INTO libros(codigo, titulo, paginas)
VALUES
('L001','Cien Años de Soledad',417),
('L002','Don Quijote',863),
('L003','El Principito',96),
('L004','Clean Code',464);


--Autores ● 3 registros
INSERT INTO autores(id, nombre, pais)
VALUES
(1,'Gabriel Garcia Marquez','Colombia'),
(2,'Miguel de Cervantes','España'),
(3,'Antoine de Saint-Exupery','Francia');


--libro_autor ● 5 relaciones

INSERT INTO libro_autor(la_libro_codigo_fk,la_autor_id_fk,anio_publicacion)
VALUES('L001',1,1967),
		('L002',2,1605),
		('L003',3,1943),
		('L004',1,2008),
		('L004',2,2008);

--Parte 5 – Consultas SQL
--Realizar las siguientes consultas:
/*
Consulta 1
Mostrar:
● título del libro
● nombre del autor
● país
● año de publicación
Utilizando INNER JOIN.
*/

SELECT l.titulo, a.nombre, a.pais, la.anio_publicacion
FROM libros l
inner join libro_autor la
on l.codigo = la.la_libro_codigo_fk
inner join autores a
on la.la_autor_id_fk = a.id 



--Consulta 2
--Mostrar únicamente libros publicados después del año 2020.
SELECT l.titulo, a.nombre, a.pais, la.anio_publicacion
FROM libros l
inner join libro_autor la
on l.codigo = la.la_libro_codigo_fk
inner join autores a
on la.la_autor_id_fk = a.id 
where la.anio_publicacion >2020;


--Consulta 3
--Mostrar únicamente autores de un país específico usando WHERE.
SELECT *
FROM autores a
WHERE a.pais='Colombia';


--Consulta 4
--Ordenar los libros por año de publicación descendente.
SELECT l.titulo, a.nombre, a.pais, la.anio_publicacion
FROM libros l
inner join libro_autor la
on l.codigo = la.la_libro_codigo_fk
inner join autores a
on la.la_autor_id_fk = a.id 
ORDER by la.anio_publicacion desc;

--Consulta 5
--Contar cuántos libros tiene cada autor utilizando:
--COUNT()
--GROUP BY
SELECT a.nombre, count(la.la_autor_id_fk) as numero_libros
FROM autores a
inner join libro_autor la
on la.la_autor_id_fk = a.id 
GROUP BY a.nombre;


--Parte 6 – Modificación de la Tabla
/*Agregar una nueva columna a la tabla libros:
Campo Tipo
precio double precision*/
ALTER TABLE libros
add column precio double precision;  






--● actualizar mínimo 3 precios
UPDATE libros 
SET precio =50.50
WHERE codigo='L001';

UPDATE libros 
SET precio =60.50
WHERE codigo='L002';

UPDATE libros 
SET precio =70.10
WHERE codigo='L003';

/*● realizar un SELECT mostrando:
○ título
○ precio*/
SELECT titulo, precio FROM libros;










