package com.svalero.basededatos.model;

import lombok.Data;

@Data
public class Resena {

    private int id_resena;
    private float puntuacion;
    private boolean apropiada;
    private String opinion;
    private int id_libro;
    private int id_usuario;
    private String nombre;
}
