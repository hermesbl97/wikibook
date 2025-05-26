package com.svalero.basededatos.servlet;

import com.svalero.basededatos.dao.PoemaDAO;
import com.svalero.basededatos.dao.UsuarioDAO;
import com.svalero.basededatos.database.Database;
import com.svalero.basededatos.model.Poema;
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

@WebServlet("/registrar_poema")
public class NuevoPoemaServlet extends HttpServlet {

    private ArrayList<String> errors;

    @Override
    public void doPost (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");

        if (!validate(request)) {
            response.getWriter().print(errors.toString());
            return;
        }

        String titulo = request.getParameter("titulo");
        String contenido = request.getParameter("contenido");
        Date fecha_envio = Date.valueOf(request.getParameter("fecha_envio"));
        int id_usuario = Integer.parseInt(request.getParameter("id_usuario"));


        try{
            Database database = new Database();
            database.connect();
            PoemaDAO poemaDAO = new PoemaDAO(database.getConnection());
            Poema poema = new Poema();
            poema.setTitulo(titulo);
            poema.setContenido(contenido);
            poema.setFecha_envio(fecha_envio);
            poema.setId_usuario(id_usuario);
            poema.setAceptado(true);


            boolean added = poemaDAO.add(poema);
            if (added) {
                response.getWriter().print("OK");
            } else {
                response.getWriter().print("El poema no ha podido ser registrado");
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

        String titulo = request.getParameter("titulo");
        String contenido = request.getParameter("contenido");
        String fecha_envio = request.getParameter("fecha_envio");

        if (titulo == null || titulo.isEmpty()) {
            errors.add("El titulo del poema es obligatorio");
        }
        if (contenido == null || contenido.isEmpty()) {
            errors.add("El texto del poema es obligatorio");
        }

        if (fecha_envio == null || fecha_envio.isEmpty()) {
            errors.add("La fecha de envío es obligatoria");
        }

        return errors.isEmpty();
    }


}
