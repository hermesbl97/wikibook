package com.svalero.basededatos.model;

import lombok.Data;

import java.sql.Date;

@Data
public class Poema {

    private int id_poema;
    private String titulo;
    private String contenido;
    private Date fecha_envio;
    private boolean aceptado;
    private int id_usuario;
    private String nombre;
}
