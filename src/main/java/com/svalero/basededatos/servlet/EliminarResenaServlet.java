package com.svalero.basededatos.servlet;

import com.svalero.basededatos.dao.ResenaDAO;
import com.svalero.basededatos.dao.UsuarioDAO;
import com.svalero.basededatos.database.Database;
import com.svalero.basededatos.model.Resena;
import com.svalero.basededatos.model.Usuario;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/eliminar_resena")
public class EliminarResenaServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");

        HttpSession currentSession = request.getSession();
        if ((currentSession.getAttribute("rol") == null)) {
            return;
        }

        String resenaId = request.getParameter("id_resena");

        try {
            Database database = new Database();
            database.connect();
            ResenaDAO resenaDAO = new ResenaDAO(database.getConnection());
            Resena resena = resenaDAO.getResenaBorrar(Integer.parseInt(resenaId));
            resenaDAO.delete(Integer.parseInt(resenaId));

            response.sendRedirect("/wikibook");

        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } catch (ClassNotFoundException cnfe) {
            cnfe.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

}
