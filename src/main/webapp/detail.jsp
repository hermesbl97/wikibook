<%@ page import="com.svalero.basededatos.database.Database" %>
<%@ page import="com.svalero.basededatos.dao.LibrosDAO" %>
<%@ page import="com.svalero.basededatos.model.Libro" %>
<%@ page import="com.svalero.basededatos.exception.LibroNotFoundException" %>
<%@ page import="com.svalero.basededatos.util.CurrencyUtils" %>
<%@ page import="com.svalero.basededatos.util.DateUtils" %>
<%@ page contentType="text/html; charset=UTF-8" language="java"%>

<%@include file="includes/header.jsp"%>

<%
    int IdLibro = Integer.parseInt(request.getParameter("id_libro"));
    Database database = new Database();
    database.connect();
    LibrosDAO librosDAO = new LibrosDAO(database.getConnection());
    try {
        Libro libro = librosDAO.get(IdLibro);
%>
    <div class="container d-flex justify-content-center">
        <div class="card mb-3" style="max-width: 700px;">
            <div class="row g-0">
                <div class="col-md-4 d-flex align-items-center justify-content-center">
                    <img src="../wikibook_images/<%= libro.getImagen()%>" class="img-fluid rounded-start" style="width: 100%; height: 70%;" alt="no hay imagen disponible"> <!-- Carpeta anterior y luego vamos a la de Wikibook images -->
                </div>
                <div class="col-md-8">
                    <div class="card-body">
                        <h5 class="card-title"><%= libro.getTitulo()%></h5>
                        <p class="card-text">Autor: <%= libro.getAutor()%></p>
                        <p class="card-text">Género: <%= libro.getGenero()%></p>
                        <p class="card-text">Editorial: <%= libro.getEditorial()%></p>
                        <p class="card-text"><small class="text-body-secondary">Publicado el <%= DateUtils.format(libro.getFecha_publicacion())%></small></p>
                        <p class="card-text"><small class="text-body-secondary">Disponible a partir de <%= CurrencyUtils.format(libro.getPrecio())%>€ </small></p>
                        <%
                            if (rol.equals("user")) {

                        %>
                        <a href="valorar_libro.jsp?id_liro=<%= libro.getId_libro()%>" type="button" class="btn btn-outline-warning">Valorar</a>
                        <%
                            } else if (rol.equals("admin")) {
                        %>
                            <a href="edit_libro.jsp?id_libro=<%= libro.getId_libro()%>" type="button" class="btn btn-outline-info">Editar</a>
                            <a href="delete_libro?id_libro=<%= libro.getId_libro()%>" type="button"
                               onclick="return confirm('¿Estás seguro de querer eliminar el juego?')"
                               class="btn btn-outline-danger">Eliminar</a>
                        <%
                            }
                        %>
                    </div>
                </div>
            </div>
        </div>
    </div>
<%
    } catch (LibroNotFoundException lnfe) {
%>
    <%@include file="includes/libro_not_found.jsp"%>
<%
    }
%>
<%@include file="includes/footer.jsp"%>

