<%@ page import="com.svalero.basededatos.database.Database" %>
<%@ page import="com.svalero.basededatos.util.DateUtils" %>
<%@ page import="com.svalero.basededatos.exception.UserNotFoundException" %>
<%@ page contentType="text/html; charset=UTF-8" language="java"%>

<%@include file="includes/header.jsp"%>

<%
    int usuarioId = Integer.parseInt(request.getParameter("id_usuario"));
    Database database = new Database();
    database.connect();
    UsuarioDAO usuarioDAO = new UsuarioDAO(database.getConnection());
    try {
        Usuario usuario = usuarioDAO.getUsuario(usuarioId);
%>
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-7">
            <div class="card shadow-lg rounded-2">
                <div class="card-header bg-white text-black text-center">
                    <h3 class="mb-0">Bienvenido <%= usuario.getNombre()%></h3>
                </div>
                <div class="card-body p-4">
                    <p><strong>Usuario:</strong> <%= usuario.getNombre() %></p>
                    <p><strong>Email:</strong> <%= usuario.getEmail() %></p>
                    <p><strong>Fecha Nacimiento:</strong> <%= DateUtils.format(usuario.getFecha_nacimiento())%></p>
                    <p><strong>Rol:</strong> <%= usuario.getRol() %></p>
                    <p><strong>Estado:</strong> <%= usuario.isActivo() ? "Activo" : "Bloqueado" %></p>
                    <div>
                        <a href="editar_usuario_usuarios.jsp?id_usuario=<%=usuario.getId_usuario()%>"
                            class="btn btn-warning btn-sm" onclick="return confirm('¿Estás seguro de querer editar?')">Editar
                        </a>
                        <a href="delete_usuario?id_usuario=<%=usuario.getId_usuario()%>"
                            class="btn btn-danger btn-sm" onclick="return confirm('¿Estás seguro de querer eliminar tu cuenta?')"> Eliminar cuenta
                        </a>
                </div>
            </div>
        </div>
    </div>
</div>
<%
    } catch (UserNotFoundException unfe) {
%>
    <%@include file="includes/usuario_not_found.jsp"%>
<%
    }
%>
<%@include file="includes/footer.jsp"%>

