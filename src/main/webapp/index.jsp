<%@ page import="com.svalero.basededatos.database.Database" %>
<%@ page import="com.svalero.basededatos.dao.LibrosDAO" %>
<%@ page import="com.svalero.basededatos.model.Libro" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" language="java"%>

<%@include file="includes/header.jsp"%>

    <main>
        <div>
            <p> ¿Eres un fanático de nuestros libros? Aquí encontrarás toda la información de tus libros favoritos.
                Valóralos y deja tu opinión para ayudar a otros usuarios
            </p>
        </div>
        <div>
            <ol class="list-group list-group-numbered">
            <%
                Database database = new Database();
                database.connect();
                LibrosDAO librosDAO = new LibrosDAO(database.getConnection());
                List<Libro> libroList = librosDAO.getAll();
                for (Libro libro: libroList){
            %>
            <li class="list-group-item d-flex justify-content-between align-items-start">
                <div class="ms-2 me-auto">
                    <div class="fw-bold"><a href="detail.jsp?id_libro=<%=libro.getId_libro()%>" class="link-success link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover"><%= libro.getTitulo()%> </a> (<%=libro.getAutor()%>)</div>
                    <%= libro.getGenero()%>
                </div>
                <span class="badge text-bg-primary rounded-pill">14</span>
            </li>
            <%
                }
            %>
            </ol>
        </div>


<%@include file="includes/footer.jsp"%>