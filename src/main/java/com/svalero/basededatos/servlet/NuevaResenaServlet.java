package com.svalero.basededatos.servlet;

import com.svalero.basededatos.dao.ResenaDAO;
import com.svalero.basededatos.database.Database;
import com.svalero.basededatos.model.Resena;
import com.svalero.basededatos.model.Usuario;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
@WebServlet("/valorar_libro")
public class NuevaResenaServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");

        // Obtener la sesión y el usuario logueado
        HttpSession currentSession = request.getSession();
        if ((currentSession.getAttribute("rol") == null) || (!currentSession.getAttribute("rol").equals("user"))) {
            response.sendRedirect("/wikibook/login.jsp");
            return;
        }

        Usuario usuario = (Usuario) currentSession.getAttribute("usuario");
        int idUsuario = usuario.getId_usuario();
        float puntuacion = Float.parseFloat(request.getParameter("puntuacion"));
        String opinion = request.getParameter("opinion");
        int id_libro = Integer.parseInt(request.getParameter("id_libro"));

        Resena resena = new Resena();
        resena.setPuntuacion(puntuacion);
        resena.setOpinion(opinion);
        resena.setId_libro(id_libro);
        resena.setId_usuario(idUsuario);

        try {
            Database database = new Database();
            database.connect();
            ResenaDAO resenaDAO = new ResenaDAO(database.getConnection());



            resenaDAO.add(resena);




            response.getWriter().write("OK");

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Error al procesar reseña: " + e.getMessage());
        }

    }
}
