package com.svalero.basededatos.dao;

import com.svalero.basededatos.model.Libro;
import com.svalero.basededatos.model.Resena;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

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

    public ArrayList<Resena> getResenaLibro(int libroId) throws SQLException {
        ArrayList<Resena> resenas = new ArrayList<>();
        String sql = "SELECT re.*, us.nombre AS nombre FROM resenas re " +
                "INNER JOIN usuarios us ON re.id_usuario = us.id_usuario WHERE re.id_libro = ?";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setInt(1, libroId);
        ResultSet result = statement.executeQuery();

        while (result.next()) {
            Resena resena = new Resena();
            resena.setId_resena(result.getInt("id_resena"));
            resena.setPuntuacion(result.getFloat("puntuacion"));
            resena.setOpinion(result.getString("opinion"));
            resena.setId_libro(result.getInt("id_libro"));
            resena.setId_usuario(result.getInt("id_usuario"));
            resena.setNombre(result.getString("nombre"));
            resenas.add(resena);
        }

        statement.close();
        return resenas;
    }

}