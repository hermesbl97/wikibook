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
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;

@WebServlet("/editar_resena")
public class EditarResenaServlet extends HttpServlet {

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

        int idResena = Integer.parseInt(request.getParameter("id_resena"));
        String puntuacion = request.getParameter("puntuacion");
        String opinion = request.getParameter("opinion");
        Boolean apropiada = Boolean.parseBoolean(request.getParameter("apropiada"));

        try{
            Database datababase = new Database();
            datababase.connect();
            ResenaDAO resenaDAO = new ResenaDAO(datababase.getConnection());
            Resena resena = new Resena();
            resena.setId_resena(idResena);
            resena.setOpinion(opinion);
            resena.setPuntuacion(Float.parseFloat(puntuacion));
            resena.setApropiada(apropiada);

            boolean edited = resenaDAO.editarResena(resena);
            if (edited) {
                response.getWriter().print("OK");
            } else {
                response.getWriter().print("No se ha podido actualizar la reseña");
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

        if (request.getParameter("opinion").isEmpty()){
            errors.add("La opinión no puede estar vacía");
        if (request.getParameter("puntuación").isEmpty()){
            errors.add("La puntuación no puede estar vacía");
        }
        }
        if (request.getParameter("apropiada").isEmpty()){
            errors.add("El campo apropiada no puede estar vacío");
        }

        return errors.isEmpty();
    }
}
