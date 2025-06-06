<%@ page import="com.svalero.basededatos.database.Database" %>
<%@ page import="com.svalero.basededatos.dao.LibrosDAO" %>
<%@ page import="com.svalero.basededatos.model.Libro" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" language="java"%>

<%@include file="includes/header_index.jsp"%>

    <main>
        <div>
        <h2>Listado de libros</h2>
        </div>
        <%
            if (rol.equals("admin")){
        %>
            <div>
                <a href="editar_libro.jsp" type="button" class="btn btn-outline-success"> <b> Añadir libro </b> <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="green" class="bi bi-plus-square" viewBox="0 0 16 16">
                    <path d="M14 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1zM2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2z"/>
                    <path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4"/>
                </svg> </a>
            </div>
        <%
            }
        %>
        <div>
            <ol class="list-group list-group-numbered">
            <%
                Database database = new Database();
                database.connect();
                LibrosDAO librosDAO = new LibrosDAO(database.getConnection());

                List<Libro> libroList = librosDAO.getAll(search);
                for (Libro libro: libroList){
            %>
            <li class="list-group-item d-flex justify-content-between align-items-start">
                <div class="ms-2 me-auto">
                    <div class="fw-bold"><a href="detail.jsp?id_libro=<%=libro.getId_libro()%>" class="link-success link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover"><%= libro.getTitulo()%> </a> (<%=libro.getAutor()%>)</div>
                    <%= libro.getGenero()%>
                </div>
                <%
                    float mediaValoracion = librosDAO.obtenerMediaValoraciones(libro.getId_libro());
                %>
                <span class="badge text-bg-primary rounded-pill">
                <%= (mediaValoracion > 0) ? String.format("%.1f", mediaValoracion) : "?" %> <!--Si no hay media mostrará un interrogante -->
                    <i class="bi bi-star-fill" style="color: white;"></i>
                </span>
            </li>
            <%
                }
            %>
            </ol>
        </div>


<%@include file="includes/footer.jsp"%>