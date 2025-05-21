package com.svalero.basededatos.servlet;


import com.svalero.basededatos.dao.LibrosDAO;
import com.svalero.basededatos.database.Database;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/delete_libro")
public class EliminarLibroServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");

        HttpSession currentSession = request.getSession();
        if ((currentSession.getAttribute("rol") == null) || (!currentSession.getAttribute("rol").equals("admin"))) { //se prohibe el acceso a la gente que no haya iniciado sesión
            response.sendRedirect("/wikibook/login.jsp"); //si no tiene iniciada a sesión lo redirigimos al login
            return; //el return lo ponemos porque sino continua el proceso y borra el juego
        }

        String libroId = request.getParameter("id_libro");

        try {
            Database database = new Database();
            database.connect();
            LibrosDAO librosDAO = new LibrosDAO(database.getConnection());
            librosDAO.delete(Integer.parseInt(libroId)); //borramos libro por id

            response.sendRedirect("/wikibook"); //después del borrado lo redirigimos a la página principal
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } catch (ClassNotFoundException cnfe) {
            cnfe.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
