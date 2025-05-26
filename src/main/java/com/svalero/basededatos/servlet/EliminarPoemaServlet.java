package com.svalero.basededatos.servlet;

import com.svalero.basededatos.dao.PoemaDAO;
import com.svalero.basededatos.dao.ResenaDAO;
import com.svalero.basededatos.database.Database;
import com.svalero.basededatos.model.Poema;
import com.svalero.basededatos.model.Resena;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/eliminar_poema")
public class EliminarPoemaServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");

        HttpSession currentSession = request.getSession();
        if ((currentSession.getAttribute("rol") == null)) {
            return;
        }

        String poemaId = request.getParameter("id_poema");

        try {
            Database database = new Database();
            database.connect();
            PoemaDAO poemaDAO = new PoemaDAO(database.getConnection());
            poemaDAO.deletePoema(Integer.parseInt(poemaId));

            response.sendRedirect("/wikibook/concurso.jsp");

        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } catch (ClassNotFoundException cnfe) {
            cnfe.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

}
