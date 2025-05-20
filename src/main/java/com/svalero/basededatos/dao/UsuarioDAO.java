package com.svalero.basededatos.dao;

import com.svalero.basededatos.exception.UserNotFoundException;
import com.svalero.basededatos.model.Usuario;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UsuarioDAO {
    private Connection connection;

    public UsuarioDAO(Connection connection) {
        this.connection = connection;
    }

    public String loginUsuario(String nombre, String contraseña) throws SQLException, UserNotFoundException {
        String sql = "SELECT rol FROM usuarios WHERE nombre = ? AND contraseña = ?";

        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, nombre);
        statement.setString(2,contraseña);
        ResultSet result = statement.executeQuery();
        if (!result.next()) { //Si la consulta no devuelve nada. Devolverá false
            throw new UserNotFoundException();
        }  //si no encuentra al usuario lanzamos una exception así conseguimos lanzar en una misma función un booleano y un string si es cierto

        return result.getString("rol");
    }

    //Añadimos un usuario
    public boolean añadirUsuario (Usuario usuario) throws SQLException {
        String sql = "INSERT INTO usuarios (nombre, contraseña, email, fecha_nacimiento, rol, activo) VALUES (?,?,?,?,?,?)";
        PreparedStatement statement = null;

        statement = connection.prepareStatement(sql);
        statement.setString(1, usuario.getNombre());
        statement.setString(2, usuario.getContraseña());
        statement.setString(3, usuario.getEmail());
        statement.setDate(4, usuario.getFecha_nacimiento());
        statement.setString(5, usuario.getRol());
        statement.setBoolean(6,usuario.isActivo());

        int affectedRows = statement.executeUpdate();

        return affectedRows != 0;
    }

}
