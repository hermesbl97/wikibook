package com.svalero.basededatos.servlet;


import com.svalero.basededatos.dao.UsuarioDAO;
import com.svalero.basededatos.database.Database;
import com.svalero.basededatos.model.Usuario;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;

@WebServlet("/editar_usuario_usuarios")
public class EditarUsuarioUsuariosServlet extends HttpServlet {

    private ArrayList<String> errors;

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");

        HttpSession currentSession = request.getSession();
        if ((currentSession.getAttribute("rol") == null) || (!currentSession.getAttribute("rol").equals("user"))) {
            response.sendRedirect("/wikibook/login.jsp");
            return;
        }

        if (!validate(request)){
            response.getWriter().print(errors.toString());
            return;
        }

        int idUsuario = Integer.parseInt(request.getParameter("id_usuario"));
        String nombre = request.getParameter("nombre");
        String contraseña = request.getParameter("password");
        String email = request.getParameter("email");
        Date fecha_nacimiento = Date.valueOf(request.getParameter("fecha_nacimiento"));

        try{
            Database datababase = new Database();
            datababase.connect();
            UsuarioDAO usuarioDAO = new UsuarioDAO(datababase.getConnection());
            Usuario usuario = new Usuario();
            usuario.setId_usuario(idUsuario);
            usuario.setNombre(nombre);
            usuario.setContraseña(contraseña);
            usuario.setEmail(email);
            usuario.setFecha_nacimiento(fecha_nacimiento);

            boolean edited = usuarioDAO.editarUsuarioUsuarios(usuario);
            if (edited) {
                response.getWriter().print("OK");
            } else {
                response.getWriter().print("No se ha podido actualizar el usuario");
            }
        } catch (SQLException sqle){
            try{
                response.getWriter().println("No se ha podido conectar con la base de datos");
                sqle.printStackTrace();
                response.getWriter().println("Error SQL: " + sqle.getMessage());
            }catch (IOException ioe){
                ioe.printStackTrace();
            }
            sqle.printStackTrace();
        }catch (IOException ioe){
            ioe.printStackTrace();
        }catch (ClassNotFoundException cnfe){
            cnfe.printStackTrace();
        }
    }

    private boolean validate(HttpServletRequest request){
        errors = new ArrayList<>();

        if (request.getParameter("nombre").isEmpty()){
            errors.add("El nombre no puede estar vacio");
        }
        if (request.getParameter("password").isEmpty()){
           errors.add("La contraseña no puede estar vacía");
        }
        if (request.getParameter("email").isEmpty()){
           errors.add("El campo email no puede estar vacío");
        }
        if (request.getParameter("fecha_nacimiento").isEmpty()){
           errors.add("La fecha de nacimiento no puede estar vacía");
        }

        return errors.isEmpty();
    }
}
