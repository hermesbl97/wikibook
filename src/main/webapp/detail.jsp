<%@ page import="com.svalero.basededatos.database.Database" %>
<%@ page import="com.svalero.basededatos.dao.LibrosDAO" %>
<%@ page import="com.svalero.basededatos.model.Libro" %>
<%@ page import="com.svalero.basededatos.exception.LibroNotFoundException" %>
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
                <div class="col-md-4">
                    <img src="..." class="img-fluid rounded-start" alt="...">
                </div>
                <div class="col-md-8">
                    <div class="card-body">
                        <h5 class="card-title"><%= libro.getTitulo()%> (Autor: <%= libro.getAutor()%>)</h5>
                        <p class="card-text">Género: <%= libro.getGenero()%></p>
                        <p class="card-text">Editorial: <%= libro.getEditorial()%></p>
                        <p class="card-text"><small class="text-body-secondary">Publicado el <%= libro.getFecha_publicacion()%></small></p>
                        <p class="card-text"><small class="text-body-secondary">Disponible a partir de <%= libro.getPrecio()%>€ </small></p>
                        <button type="button" class="btn btn-outline-warning">Valorar</button>
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

