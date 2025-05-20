package com.svalero.basededatos.model;

import lombok.Data;

@Data
public class Resena {

    private int id_reseña;
    private float puntuacion;
    private boolean apropiada;
    private String opinion;
    private int id_libro;
    private int id_usuario;
    private Float precio;
    private String genero;
    private String editorial;
}
