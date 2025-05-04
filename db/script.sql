CREATE DATABASE Wikibook;
CREATE TABLE libros (
                        id_libro int auto_increment primary key,
                        titulo varchar(250) unique,
                        autor varchar (250),
                        fecha_publicacion date,
                        imagen varchar(250),
                        precio float default 0,
                        genero varchar (80),
                        editorial varchar (80),
);