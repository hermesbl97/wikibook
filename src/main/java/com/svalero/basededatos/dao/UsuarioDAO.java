package com.svalero.basededatos.dao;

import com.svalero.basededatos.exception.UserNotFoundException;
import com.svalero.basededatos.model.Usuario;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class UsuarioDAO {
    private Connection connection;

    public UsuarioDAO(Connection connection) {
        this.connection = connection;
    }

    public Usuario loginUsuario(String nombre, String contraseña) throws SQLException, UserNotFoundException {
        String sql = "SELECT id_usuario, nombre, contraseña, email, rol, activo FROM usuarios WHERE nombre = ? AND contraseña = SHA1(?)";

        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, nombre);
        statement.setString(2,contraseña);
        ResultSet result = statement.executeQuery();

        if (!result.next()) { //Si la consulta no devuelve nada. Devolverá false
            throw new UserNotFoundException();
        }  //si no encuentra al usuario lanzamos una exception así conseguimos lanzar en una misma función un booleano y un string si es cierto

        Usuario usuario = new Usuario();
        usuario.setId_usuario(result.getInt("id_usuario"));
        usuario.setNombre(result.getString("nombre"));
        usuario.setContraseña(result.getString("contraseña"));
        usuario.setEmail(result.getString("email"));
        usuario.setRol(result.getString("rol"));
        usuario.setActivo(result.getBoolean("activo"));

        return usuario;
    }


    //Mostramos todos los usuarios sin campo de busqueda
    public ArrayList<Usuario> getUsuarios() throws SQLException, UserNotFoundException{
        String sql = "SELECT * FROM usuarios";
        return launchQuery(sql);
    }

    //Mostramos todos los usuarios teniendo en cuenta el campo de busqueda
    public ArrayList<Usuario> getUsuarios(String search) throws SQLException, UserNotFoundException {
        String sql = "SELECT * FROM usuarios WHERE nombre LIKE ? OR rol LIKE ? OR email LIKE ?";
        if (search == null || search.isEmpty()) {
            return getUsuarios();
        }
        return launchQuery(sql, search);
    }

    //Mostramos todos los usuarios
    private ArrayList<Usuario> launchQuery(String sql, String ...search) throws SQLException {
        PreparedStatement statement = null;
        ResultSet result = null;
        statement = connection.prepareStatement(sql);
        if (search.length > 0) {
            statement.setString(1, "%" + search[0] + "%");
            statement.setString(2, "%" + search[0] + "%");
            statement.setString(3, "%" + search[0] + "%");
        }
        result = statement.executeQuery();

        ArrayList<Usuario> usuarioList = new ArrayList<>();

        while (result.next()) {
            Usuario usuario = new Usuario();
            usuario.setId_usuario(result.getInt("id_usuario"));
            usuario.setNombre(result.getString("nombre"));
            usuario.setContraseña(result.getString("contraseña"));
            usuario.setFecha_nacimiento(result.getDate("fecha_nacimiento"));
            usuario.setEmail(result.getString("email"));
            usuario.setRol(result.getString("rol"));
            usuario.setActivo(result.getBoolean("activo"));
            usuarioList.add(usuario);
        }
        statement.close();

        return usuarioList;
    }


    //Añadimos un usuario
    public boolean añadirUsuario (Usuario usuario) throws SQLException {
        String sql = "INSERT INTO usuarios (nombre, contraseña, email, fecha_nacimiento, rol, activo) VALUES (?,SHA1(?),?,?,?,?)";
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

    public boolean editarUsuarioAdmin (Usuario usuario) throws SQLException {
        String sql = "UPDATE usuarios SET rol = ?, activo = ? WHERE id_usuario = ?";
        PreparedStatement statement = null;
        statement = connection.prepareStatement(sql);

        statement.setString(1, usuario.getRol());
        statement.setBoolean(2, usuario.isActivo());
        statement.setInt(3, usuario.getId_usuario());

        int affectedRows = statement.executeUpdate();

        return affectedRows != 0;
    }

    public boolean editarUsuarioUsuarios (Usuario usuario) throws SQLException {
        if (usuario.getContraseña() != null && !usuario.getContraseña().isEmpty()) {
            String sql = "UPDATE usuarios SET nombre = ?, email = ?, fecha_nacimiento = ?, contraseña = SHA1(?) WHERE id_usuario = ?";
            PreparedStatement statement = null;
            statement = connection.prepareStatement(sql);

            statement.setString(1, usuario.getNombre());
            statement.setString(2, usuario.getEmail());
            statement.setDate(3, usuario.getFecha_nacimiento());
            statement.setString(4, usuario.getContraseña());
            statement.setInt(5, usuario.getId_usuario());

            int affectedRows = statement.executeUpdate();

            return affectedRows != 0;

        } else {
            String sql = "UPDATE usuarios SET nombre = ?, email = ?, fecha_nacimiento = ? WHERE id_usuario = ?";
            PreparedStatement statement = null;
            statement = connection.prepareStatement(sql);

            statement.setString(1, usuario.getNombre());
            statement.setString(2, usuario.getEmail());
            statement.setDate(3, usuario.getFecha_nacimiento());
            statement.setInt(4, usuario.getId_usuario());

            int affectedRows = statement.executeUpdate();

            return affectedRows != 0;
        }
    }

    public Usuario getUsuario (int id_usuario) throws SQLException, UserNotFoundException {
        String sql = "SELECT * FROM usuarios WHERE id_usuario = ?";
        PreparedStatement statement = null;
        ResultSet result = null;

        statement = connection.prepareStatement(sql);
        statement.setInt(1, id_usuario);
        result = statement.executeQuery();

        if (!result.next()){
            throw new UserNotFoundException();
        }
        Usuario usuario = new Usuario();
        usuario.setId_usuario(result.getInt("id_usuario"));
        usuario.setNombre(result.getString("nombre"));
        usuario.setContraseña(result.getString("contraseña"));
        usuario.setEmail(result.getString("email"));
        usuario.setFecha_nacimiento(result.getDate("fecha_nacimiento"));
        usuario.setRol(result.getString("rol"));
        usuario.setActivo(result.getBoolean("activo"));
        statement.close();

        return usuario;
    }

    public boolean delete (int usuarioId) throws SQLException {
        String sql = "DELETE FROM usuarios WHERE id_usuario = ? ";

        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setInt(1, usuarioId);
        int affectedRows = statement.executeUpdate();

        return affectedRows != 0;

    }

}
