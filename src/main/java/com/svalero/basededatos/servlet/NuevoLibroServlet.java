package com.svalero.basededatos.servlet;

import com.svalero.basededatos.dao.LibrosDAO;
import com.svalero.basededatos.dao.UsuarioDAO;
import com.svalero.basededatos.database.Database;
import com.svalero.basededatos.exception.UserNotFoundException;
import com.svalero.basededatos.model.Libro;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.sql.Date;
import java.sql.SQLException;
import java.util.UUID;

@WebServlet("/nuevo_libro") //URL a la que se asocia el servlet
@MultipartConfig //Al servet hay que decirle que esté preparado para recibir cosas binarias
public class NuevoLibroServlet extends HttpServlet {

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { //procesare la info que le mandemos desde el formulario login
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");

        HttpSession currentSession = request.getSession();
        if ((currentSession.getAttribute("rol") == null) || (!currentSession.getAttribute("rol").equals("admin"))) {
            response.sendRedirect("/wikibook");
        }

        String titulo = request.getParameter("titulo"); //recogemos a través del request los datos del formulario. Asociamos tanto username como password a los valores que nos introducen en el formulario
        String autor = request.getParameter("autor");
        String fecha_publicacion = request.getParameter("fecha_publicacion");
        Part imagen = request.getPart("imagen");
        String precio = request.getParameter("precio");
        String genero = request.getParameter("genero");
        String editorial = request.getParameter("editorial");


        try {
            Database database = new Database();
            database.connect();
            LibrosDAO librosDAO = new LibrosDAO(database.getConnection());
            Libro libro = new Libro();
            libro.setTitulo(titulo);
            libro.setAutor(autor);
            libro.setFecha_publicacion(new Date(System.currentTimeMillis()));

            //Procesa la imagen del juego
            String filename = "default.jpg";
            if (imagen.getSize() !=0) {
                filename = UUID.randomUUID() + ".jpg"; //con esto creamos un nombre de imagen aleatorio porque si dos personas suben una foto con un mismo nombre se sobreescribirían o chocarían entre ellas
            }
            //String imagePath = getServletContext().getAttribute("imagePath").toString();
            String imagePath = "C:\\Users\\Hermes\\Downloads\\apache-tomcat-9.0.102\\apache-tomcat-9.0.102\\webapps\\wikibook_images";
            InputStream inputStream = imagen.getInputStream(); //representación de la foto en datos
            Files.copy(inputStream, Path.of(imagePath + File.separator + filename)); //copiame el InputStream (la foto) a la ruta de la carpeta (imagePath), seguido de la barra separadora, y del nombre del fichero generado aleatoriamente

            libro.setImagen(filename);
            libro.setPrecio(Float.parseFloat(precio));
            libro.setGenero(genero);
            libro.setEditorial(editorial);
            boolean anadido = librosDAO.add(libro);

            if (anadido) {
                response.getWriter().println("OK");
            } else {
                response.getWriter().println("Error al registrar libro");
            }
            
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
        } catch (Exception e) {
            e.printStackTrace();
    }
}

}
