<%@ page import="com.svalero.basededatos.database.Database" %>
<%@ page import="com.svalero.basededatos.dao.LibrosDAO" %>
<%@ page import="com.svalero.basededatos.model.Libro" %>
<%@ page import="com.svalero.basededatos.exception.LibroNotFoundException" %>
<%@ page import="com.svalero.basededatos.util.CurrencyUtils" %>
<%@ page import="com.svalero.basededatos.util.DateUtils" %>
<%@ page import="com.svalero.basededatos.dao.ResenaDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="com.svalero.basededatos.model.Resena" %>
<%@ page contentType="text/html; charset=UTF-8" language="java"%>

<%@include file="includes/header.jsp"%>

<%
    int libroId = Integer.parseInt(request.getParameter("id_libro"));
    Database database = new Database();
    database.connect();
    LibrosDAO librosDAO = new LibrosDAO(database.getConnection());
    ResenaDAO resenaDAO = new ResenaDAO(database.getConnection());

    try {
        Libro libro = librosDAO.get(libroId);
        List<Resena> resenaList = resenaDAO.getResenaLibro(libroId);

%>

<!-- Mostrar detalles del libro -->
<div class="mt-4">
    <div class="container d-flex justify-content-center">
        <div class="card w-50 mb-3 mx-auto" style="width: 700px;">
            <div class="row g-0">
                <div class="col-md-4 d-flex align-items-center justify-content-center">
                    <img src="../wikibook_images/<%= libro.getImagen()%>" class="img-fluid rounded-start" style="width: 100%; height: 70%;" alt="no hay imagen disponible">
                </div>
                <div class="col-md-8">
                    <div class="card-body">
                        <h5 class="card-title"><%= libro.getTitulo()%></h5>
                        <p class="card-text">Autor: <%= libro.getAutor()%></p>
                        <p class="card-text">Género: <%= libro.getGenero()%></p>
                        <p class="card-text">Editorial: <%= libro.getEditorial()%></p>
                        <p class="card-text"><small class="text-body-secondary">Publicado el <%= DateUtils.format(libro.getFecha_publicacion())%></small></p>
                        <p class="card-text"><small class="text-body-secondary">Disponible a partir de <%= CurrencyUtils.format(libro.getPrecio())%></small></p>
                        <%
                            if (rol.equals("user")) {
                        %>
                        <a href="valorar_libro.jsp?id_libro=<%= libro.getId_libro()%>" type="button" class="btn btn-outline-warning">Valorar</a>
                        <%
                        }

                        if (rol.equals("admin")) {
                        %>
                        <a href="editar_libro.jsp?id_libro=<%= libro.getId_libro()%>" class="btn btn-info">Editar</a>
                        <a href="delete_libro?id_libro=<%= libro.getId_libro()%>" onclick="return confirm('¿Estás seguro de querer eliminar el libro?')" class="btn btn-danger">Eliminar</a>
                        <%
                            }
                        %>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="mt-4">
        <h3 class="text-center mt-4 mb-3"><i>Valoraciones del libro</i></h3>

        <!-- Mostrar reseñas -->
        <%
            for (Resena resena : resenaList) {
        %>
        <div class="card w-50 mb-3 mx-auto" style="width: 700px;">
            <div class="card-body">
                <h5 class="card-title"><%= resena.getNombre()%> <small><%= resena.getPuntuacion() %>/5</small> <i class="bi bi-star-fill" style="color: gold;"></i></h5>
                <p class="card-text"><%= resena.getOpinion() %></p>
                <div class="text-end mt-3">
                    <%
                        if (!rol.equals("anonymous")){
                    %>
                    <a href="detail_resena.jsp?id_resena=<%= resena.getId_resena()%>" type="button"
                       class="btn btn-success">Ver detalle</a>
                    <a href="eliminar_resena?id_resena=<%= resena.getId_resena()%>" type="button"
                       onclick="return confirm('¿Estás seguro de querer eliminarla?')"
                       class="btn btn-danger">Borrar</a>
                    <%
                        }
                    %>
                </div>
            </div>
        </div>
    </div>
</div>
    <%
        }

} catch (LibroNotFoundException lnfe) {
%>
<%@include file="includes/libro_not_found.jsp"%>
<%
}
%>
<%@include file="includes/footer.jsp"%>
