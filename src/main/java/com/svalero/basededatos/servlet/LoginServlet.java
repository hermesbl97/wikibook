package com.svalero.basededatos.servlet;

import com.svalero.basededatos.dao.UsuarioDAO;
import com.svalero.basededatos.database.Database;
import com.svalero.basededatos.exception.UserNotFoundException;
import lombok.Data;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/login") //URL a la que se asocia el servlet
public class LoginServlet extends HttpServlet {

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException { //procesare la info que le mandemos desde el formulario login
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");

        String nombre = request.getParameter("username"); //recogemos a través del request los datos del formulario. Asociamos tanto username como password a los valores que nos introducen en el formulario
        String contraseña = request.getParameter("password");

        try {
            Database database = new Database();
            database.connect();
            UsuarioDAO usuarioDAO = new UsuarioDAO(database.getConnection());
            String rol =usuarioDAO.loginUsuario(nombre, contraseña);

            //creamos la sesión y redirigimos al usuario a la página home
            HttpSession session = request.getSession(); //creamos una sesión
            session.setAttribute("username", nombre);
            session.setAttribute("rol", rol);
            response.getWriter().print("OK");

        } catch (SQLException sqle) {
            try {
                response.getWriter().println("No se ha podido conectar con la base de datos");
            } catch (IOException ioe) {
                ioe.printStackTrace();
            }
            sqle.printStackTrace();
        } catch (ClassNotFoundException cnfe) {
            cnfe.printStackTrace();
        } catch (IOException ioe) {
            ioe.printStackTrace();
        } catch (UserNotFoundException unfe) {
            try{
                response.getWriter().println("Usuario/Contraseña incorrectos");
            } catch (IOException ioe){
                ioe.printStackTrace();
            }
        }

    }

}
