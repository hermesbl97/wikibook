package com.svalero.basededatos.servlet;

import com.svalero.basededatos.dao.UsuarioDAO;
import com.svalero.basededatos.database.Database;
import com.svalero.basededatos.model.Usuario;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;

@WebServlet("/registro_usuarios")
public class NuevoUsuarioServlet extends HttpServlet {

    private ArrayList<String> errors;

    @Override
    public void doPost (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");

        if (!validate(request)) {
            response.getWriter().print(errors.toString());
            return;
        }

        String nombre = request.getParameter("nombre");
        String contraseña = request.getParameter("password");
        Date fechaNacimiento = Date.valueOf(request.getParameter("fecha_nacimiento"));
        String email = request.getParameter("email");

        try{
            Database database = new Database();
            database.connect();
            UsuarioDAO usuarioDAO = new UsuarioDAO(database.getConnection());
            Usuario usuario = new Usuario();
            usuario.setNombre(nombre);
            usuario.setContraseña(contraseña);
            usuario.setFecha_nacimiento(fechaNacimiento);
            usuario.setEmail(email);
            usuario.setRol("user");
            usuario.setActivo(true);

            boolean added = usuarioDAO.añadirUsuario(usuario);
            if (added) {
                response.getWriter().print("OK");
            } else {
                response.getWriter().print("El usuario no ha podido ser registrado");
            }
        } catch (SQLException sqle){
            try{
                response.getWriter().println("Database couldn't be connected");
                sqle.printStackTrace();
                response.getWriter().println("Error SQL: " + sqle.getMessage());
            }catch (IOException ioe){
                ioe.printStackTrace();
            }
            sqle.printStackTrace();
        } catch (IOException ioe){
            ioe.printStackTrace();
        }catch (ClassNotFoundException cnfe){
            cnfe.printStackTrace();
        }
    }

    private boolean validate(HttpServletRequest request) {
        errors = new ArrayList<>();

        String nombre = request.getParameter("nombre");
        String contraseña = request.getParameter("password");
        String email = request.getParameter("email");
        String fechaNacimiento = request.getParameter("fecha_nacimiento");

        if (nombre == null || nombre.isEmpty()) {
            errors.add("El nombre de usuario es obligatorio");
        }
        if (contraseña == null || contraseña.isEmpty()) {
            errors.add("La contraseña es obligatoria");
        }
        if (email == null || email.isEmpty()) {
            errors.add("El email es obligatorio");
        }
        if (fechaNacimiento == null || fechaNacimiento.isEmpty()) {
            errors.add("La fecha de nacimiento es obligatoria");
        }

        return errors.isEmpty();
    }

}

