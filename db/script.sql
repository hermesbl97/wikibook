CREATE DATABASE Wikibook;
create table usuarios (
                          id_usuario int unsigned primary key auto_increment,
                          nombre varchar(60) unique,
                          contraseña varchar(180),
                          email varchar (250),
                          fecha_nacimiento date,
                          rol varchar(30) default 'user',
                          activo boolean default true
);

CREATE TABLE libros (
                        id_libro int auto_increment primary key,
                        titulo varchar(250) unique,
                        autor varchar (250),
                        fecha_publicacion date,
                        imagen varchar(250),
                        precio float default 0,
                        genero varchar (80),
                        editorial varchar (80)
);

CREATE TABLE resenas (
                         id_resena INT AUTO_INCREMENT PRIMARY KEY,
                         puntuacion FLOAT,
                         opinion VARCHAR(500),
                         apropiada BOOLEAN DEFAULT TRUE,
                         id_usuario INT UNSIGNED NOT NULL,
                         id_libro INT NOT NULL,
                         FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
                         FOREIGN KEY (id_libro) REFERENCES libros(id_libro) ON DELETE CASCADE
);

CREATE TABLE poemas (
                        id_poema INT AUTO_INCREMENT PRIMARY KEY,
                        titulo VARCHAR(250),
                        contenido TEXT,
                        fecha_envio DATE,
                        aceptado BOOLEAN DEFAULT TRUE,
                        id_usuario INT UNSIGNED NOT NULL,
                        FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE
);
