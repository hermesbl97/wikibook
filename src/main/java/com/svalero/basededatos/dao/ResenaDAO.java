package com.svalero.basededatos.dao;

import com.svalero.basededatos.model.Libro;
import com.svalero.basededatos.model.Resena;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class ResenaDAO {
    private Connection connection;
    public ResenaDAO(Connection connection) { //como no tenemos el valor connection porque está en otra clase. Lo pedimos creamos un constructor
        this.connection = connection;
    }

    public void add(Resena resena) throws SQLException {
        String sql = "INSERT INTO resenas (puntuacion, opinion, id_libro, id_usuario) VALUES (?, ?, ?, ?)";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setFloat(1, resena.getPuntuacion());
        statement.setString(2, resena.getOpinion());
        statement.setInt(3, resena.getId_libro());
        statement.setInt(4, resena.getId_usuario());

        statement.executeUpdate();
    }

}
