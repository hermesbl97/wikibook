package com.svalero.basededatos.model;

import lombok.Data;
import java.sql.Date;


@Data
public class Usuario {
    private int id_usuario;
    private String nombre;
    private String contraseña;
    private String email;
    private Date fecha_nacimiento;
    private String rol;
    private boolean activo;
}

