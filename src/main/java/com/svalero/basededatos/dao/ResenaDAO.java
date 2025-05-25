package com.svalero.basededatos.dao;

import com.svalero.basededatos.exception.ResenaNotFoundException;
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

    public ArrayList<Resena> getResenaLibro(int libroId) throws SQLException { //para dar la vista de las valoraciones por usuarios
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

    public Resena getResena (int id_resena) throws SQLException, ResenaNotFoundException {
        String sql = "SELECT * FROM resenas WHERE id_resena = ?";
        PreparedStatement statement = null;
        ResultSet result = null;

        statement = connection.prepareStatement(sql);
        statement.setInt(1, id_resena);
        result = statement.executeQuery();

        if (!result.next()){
            throw new ResenaNotFoundException();
        }

        Resena resena = new Resena();
        resena.setId_resena(result.getInt("id_resena"));
        resena.setOpinion(result.getString("opinion"));
        resena.setPuntuacion(result.getFloat("puntuacion"));
        resena.setNombre(result.getString("nombre"));
        resena.setApropiada(result.getBoolean("apropiada"));

        statement.close();

        return resena;
    }

    public Resena getResenaUsuario (int id_resena) throws SQLException, ResenaNotFoundException {
        String sql = "SELECT re.*, us.nombre AS nombre FROM resenas re " +
        "INNER JOIN usuarios us ON re.id_usuario = us.id_usuario WHERE re.id_resena = ?";

        PreparedStatement statement = null;
        ResultSet result = null;

        statement = connection.prepareStatement(sql);
        statement.setInt(1, id_resena);
        result = statement.executeQuery();

        if (!result.next()){
            throw new ResenaNotFoundException();
        }

        Resena resena = new Resena();
        resena.setId_resena(result.getInt("id_resena"));
        resena.setOpinion(result.getString("opinion"));
        resena.setPuntuacion(result.getFloat("puntuacion"));
        resena.setNombre(result.getString("nombre"));
        resena.setApropiada(result.getBoolean("apropiada"));

        statement.close();

        return resena;
    }

    public boolean editarResena (Resena resena) throws SQLException {
        String sql = "UPDATE resenas SET puntuacion = ?, opinion = ? WHERE id_resena = ?";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setFloat(1, resena.getPuntuacion());
        statement.setString(2, resena.getOpinion());
        statement.setInt(3, resena.getId_resena());
        int affectedRows = statement.executeUpdate();
        return affectedRows != 0;
    }


    public Resena getResenaBorrar(int id_resena) throws SQLException {  //méto do para el borrado
        String sql = "SELECT * FROM resenas WHERE id_resena = ?";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setInt(1, id_resena);
        ResultSet resultSet = statement.executeQuery();

        if (resultSet.next()) {
            Resena resena = new Resena();
            resena.setId_resena(resultSet.getInt("id_resena"));
            resena.setPuntuacion(resultSet.getFloat("puntuacion"));
            resena.setOpinion(resultSet.getString("opinion"));
            resena.setApropiada(resultSet.getBoolean("apropiada"));
            resena.setId_libro(resultSet.getInt("id_libro"));
            resena.setId_usuario(resultSet.getInt("id_usuario"));

            return resena;
        }

        return null;
    }


    public boolean delete (int resenaId) throws SQLException {
        String sql = "DELETE FROM resenas WHERE id_resena = ? ";

        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setInt(1, resenaId);
        int affectedRows = statement.executeUpdate();

        return affectedRows != 0;

    }

}