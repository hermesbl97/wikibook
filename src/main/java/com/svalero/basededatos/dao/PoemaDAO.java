package com.svalero.basededatos.dao;

import com.svalero.basededatos.exception.PoemaNotFoundException;
import com.svalero.basededatos.exception.ResenaNotFoundException;
import com.svalero.basededatos.model.Libro;
import com.svalero.basededatos.model.Poema;
import com.svalero.basededatos.model.Resena;
import com.svalero.basededatos.model.Usuario;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class PoemaDAO {
    private Connection connection;

    public PoemaDAO(Connection connection) {
        this.connection = connection;
    }

    public boolean add(Poema poema) throws SQLException {
        String sql = "INSERT INTO poemas (titulo, contenido, fecha_envio, aceptado, id_usuario) " +
                "VALUES (?, ?, ?, ?, ?)";
        PreparedStatement statement = null;

        statement = connection.prepareStatement(sql);
        statement.setString(1, poema.getTitulo());
        statement.setString(2, poema.getContenido());
        statement.setDate(3, poema.getFecha_envio());
        statement.setBoolean(4, poema.isAceptado());
        statement.setInt(5, poema.getId_usuario());
        ;

        int affectedRows = statement.executeUpdate();

        return affectedRows != 0;
    }


    public ArrayList<Poema> getAll() throws SQLException, PoemaNotFoundException {
        String sql = "SELECT po.*, us.nombre FROM poemas po " +
                "INNER JOIN usuarios us ON po.id_usuario = us.id_usuario";
        return launchQuery(sql);
    }

    public ArrayList<Poema> getAll(String search) throws SQLException, PoemaNotFoundException {
        if (search==null || search.isEmpty()) {
            return getAll();
        }

        String sql = "SELECT po.*, us.nombre FROM poemas po " +
                "INNER JOIN usuarios us ON po.id_usuario = us.id_usuario " +
                "WHERE po.titulo LIKE ? OR nombre LIKE ?";
        return launchQuery(sql, search);
    }

    private ArrayList<Poema> launchQuery(String query, String ...search) throws SQLException, PoemaNotFoundException {
        PreparedStatement statement = connection.prepareStatement(query);
        if (search.length > 0) {
            statement.setString(1, "%"+search[0]+"%");
            statement.setString(2, "%"+search[0]+"%");
        }

        ResultSet result = statement.executeQuery();
        ArrayList<Poema> poemaList = new ArrayList<>();

        while (result.next()){
            Poema poema = new Poema();
            poema.setId_poema(result.getInt("id_poema"));
            poema.setTitulo(result.getString("titulo"));
            poema.setContenido(result.getString("contenido"));
            poema.setFecha_envio(result.getDate("fecha_envio"));
            poema.setAceptado(result.getBoolean("aceptado"));
            poema.setId_usuario(result.getInt("id_usuario"));
            poema.setNombre(result.getString("nombre"));
            poemaList.add(poema);
        }

        statement.close();
        if (poemaList.isEmpty()) {
            throw new PoemaNotFoundException();
        }

        return poemaList;
    }

    public boolean deletePoema (int poemaId) throws SQLException {
        String sql = "DELETE FROM poemas WHERE id_poema = ? ";

        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setInt(1, poemaId);
        int affectedRows = statement.executeUpdate();

        return affectedRows != 0;

    }
}
