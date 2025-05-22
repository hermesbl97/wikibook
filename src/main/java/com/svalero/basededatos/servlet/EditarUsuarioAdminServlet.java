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

@WebServlet("/editar_usuario_admin")
public class EditarUsuarioAdminServlet extends HttpServlet {

    private ArrayList<String> errors;

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");

        HttpSession currentSession = request.getSession();
        if ((currentSession.getAttribute("rol") == null) || (!currentSession.getAttribute("rol").equals("admin"))) {
            response.sendRedirect("/wikibook/login.jsp");
            return;
        }

        if (!validate(request)){
            response.getWriter().print(errors.toString());
            return;
        }

        int idUsuario = Integer.parseInt(request.getParameter("id_usuario"));
        String rol = request.getParameter("rol");
        Boolean activo = Boolean.parseBoolean(request.getParameter("activo"));

        try{
            Database datababase = new Database();
            datababase.connect();
            UsuarioDAO usuarioDAO = new UsuarioDAO(datababase.getConnection());
            Usuario usuario = new Usuario();
            usuario.setId_usuario(idUsuario);
            usuario.setRol(rol);
            usuario.setActivo(activo);


            boolean edited = usuarioDAO.editarUsuarioAdmin(usuario);
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

        if (request.getParameter("rol").isEmpty()){
            errors.add("El rol no puede estar vacio");
        }
        if (request.getParameter("activo").isEmpty()){
           errors.add("El estado no puede estar vacio");
        }

        return errors.isEmpty();
    }
}
