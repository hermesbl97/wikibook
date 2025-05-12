package com.svalero.basededatos.dao;

import com.svalero.basededatos.exception.UserNotFoundException;

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
        String sql = "SELECT rol FROM usuarios WHERE nombre = ? AND contraseña = SHA1(?)";

        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, nombre);
        statement.setString(2,contraseña);
        ResultSet result = statement.executeQuery();
        if (!result.next()) { //Si la consulta no devuelve nada. Devolverá false
            throw new UserNotFoundException();
        }  //si no encuentra al usuario lanzamos una exception así conseguimos lanzar en una misma función un booleano y un string si es cierto

        return result.getString("rol");
    }
}
