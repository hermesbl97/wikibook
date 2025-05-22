package com.svalero.basededatos.servlet;

import com.svalero.basededatos.dao.LibrosDAO;
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
import java.sql.SQLException;

@WebServlet("/delete_usuario")
public class EliminarUsuarioServlet extends HttpServlet {

        @Override
        protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            response.setCharacterEncoding("UTF-8");

            HttpSession currentSession = request.getSession();
            if ((currentSession.getAttribute("rol") == null)) { //se prohibe el acceso a la gente que no haya iniciado sesión
                response.sendRedirect("/wikibook/login.jsp"); //si no tiene iniciada a sesión lo redirigimos al login
                return; //el return lo ponemos porque sino continua el proceso y borra el juego
            }

            String usuarioId = request.getParameter("id_usuario");
            try {
                Database database = new Database();
                database.connect();
                UsuarioDAO usuarioDAO = new UsuarioDAO(database.getConnection());
                Usuario usuario = usuarioDAO.getUsuario(Integer.parseInt(usuarioId));
                usuarioDAO.delete(Integer.parseInt(usuarioId)); //borramos usuario por id

                if (usuario.getRol().equals("admin")) {
                    response.sendRedirect("/wikibook/usuarios.jsp"); //después del borrado lo redirigimos a la página principal
                } else if (usuario.getRol().equals("user")) {
                    response.sendRedirect("/wikibook/");
                }

            } catch (SQLException sqle) {
                sqle.printStackTrace();
            } catch (ClassNotFoundException cnfe) {
                cnfe.printStackTrace();
            } catch (Exception e) {
                e.printStackTrace();
            }

        }
}
