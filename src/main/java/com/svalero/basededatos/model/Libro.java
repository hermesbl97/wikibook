package com.svalero.basededatos.model;

import lombok.Data;

import java.sql.Date;

@Data
public class Libro {

    private int id_libro;
    private String titulo;
    private String autor;
    private Date fecha_publicacion;
    private String imagen;
    private Float precio;
    private String genero;
    private String editorial;
    private String edicion;

}
