<%@ page import="com.svalero.basededatos.database.Database" %>
<%@ page import="com.svalero.basededatos.dao.UsuarioDAO" %>
<%@ page import="com.svalero.basededatos.model.Usuario" %>
<%@ page import="java.util.List" %>

<%@include file="includes/header_index.jsp"%>

<%
    if ((currentSession.getAttribute("rol") == null) || (!currentSession.getAttribute("rol").equals("admin")) ){
        response.sendRedirect("/wikibook/login.jsp");
    }
%>

<table class="table">
    <thead class="table-dark">
        <tr>
            <th scope="col"> Id usuario</th>
            <th scope="col">Nombre usuario</th>
            <th scope="col">Email</th>
            <th scope="col">Rol</th>
            <th scope="col">Activo</th>
            <th scope="col"></th>
        </tr>
    </thead>
    <tbody>
        <%
            Database database = new Database();
            database.connect();
            UsuarioDAO usuarioDAO = new UsuarioDAO(database.getConnection());
            List<Usuario> usuarioList = usuarioDAO.getUsuarios(search);

            for (Usuario usuario : usuarioList) {
        %>

        <tr>
            <td><%= usuario.getId_usuario()%></td>
            <td><%= usuario.getNombre()%></td>
            <td><%= usuario.getEmail()%></td>
            <td><%= usuario.getRol()%></td>
            <td><%= usuario.isActivo()%></td>
            <td><a href="editar_usuario.jsp?user_id=<%=usuario.getId_usuario()%>" class="btn btn-sm btn-outline-primary btn-custom">
                <i class="fa-solid fa-user-pen"></i></td>
        </tr>
        <%
            }
        %>
    </tbody>
</table>

<%@include file="includes/footer.jsp"%>


