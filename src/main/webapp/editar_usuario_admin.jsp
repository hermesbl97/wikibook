<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ page import="com.svalero.basededatos.model.Libro" %>
<%@ page import="com.svalero.basededatos.database.Database" %>
<%@ page import="com.svalero.basededatos.dao.LibrosDAO" %>
<%@ page import="com.svalero.basededatos.exception.UserNotFoundException" %>
<%@ page import="com.svalero.basededatos.model.Usuario" %>
<%@ page import="com.svalero.basededatos.dao.UsuarioDAO" %>
<%@include file="includes/header.jsp"%>

<%
    if ((currentSession.getAttribute("rol") == null) || (!currentSession.getAttribute("rol").equals("admin")) ){
        response.sendRedirect("/wikibook/login.jsp");
    }

    int usuarioId = Integer.parseInt(request.getParameter("id_usuario"));

    Database database = new Database();
    database.connect();
    UsuarioDAO usuarioDAO = new UsuarioDAO(database.getConnection());

    try{
        Usuario usuario = usuarioDAO.getUsuario(usuarioId);
%>

<script type="text/javascript">
    $(document).ready(function() {
        $("form").on("submit", function(event) {
            event.preventDefault();
            const formValue = $(this).serialize();
            $.ajax({
                url:"editar_usuario_admin",
                type: "POST",
                data: formValue,
                statusCode: {
                    200: function(response) {
                        console.log("Respuesta del servidor:", response);
                        if (response === "OK") {
                            window.location.href = "/wikibook/usuarios.jsp";
                        } else {
                            $("#result").html("<div class='alert alert-danger' role='alert'>" + response + "</div>");
                        }
                    },
                    404: function (response) {
                        $("#result").html("<div class='alert alert-danger' role='alert'>Error al enviar datos</div>");
                    },
                    500: function(response){
                        console.error("Server error:", response);
                        $("#result").html("<div class='alert alert-danger' role='alert' " + response.toString() + "</div>");
                    }
                }
            });
        });
    });
</script>


<form>
    <div class="col-md-4">
        <label class="form-label">Editar el usuario:<b><%= usuario.getNombre()%></b></label>
    </div>

    <div class="col-md-4">
        <label class="form-label">Rol</label>
        <select id="rol" name="rol" class="form-select" required>
            <option value="">Selecciona una opción</option>
            <option value="admin" <%= "admin".equals(usuario.getRol()) ? "selected" : "" %>>Admin</option>
            <option value="user" <%= "user".equals(usuario.getRol()) ? "selected" : "" %>>Usuario</option>
        </select>
    </div>

    <div class="col-md-4">
        <label class="form-label">Estado del usuario</label>
        <select id="activo" name="activo" class="form-select" required>
            <option value="">Selecciona una opción</option>
            <option value="true" <%= usuario.isActivo() ? "selected" : "" %>>Activo</option>
            <option value="false" <%= !usuario.isActivo() ? "selected" : "" %>>Bloqueado</option>
        </select>
    </div>

    <div class="col-12">
        <button class="btn btn-primary" type="submit" onclick="return confirm('¿Deseas confirmar?')">Guardar</button>
    </div>

    <input type="hidden" name="id_usuario" value="<%= usuarioId %>">
    <div id="result"></div>
</form>
<%
    } catch (UserNotFoundException unfe) {
%>
    <%@include file="includes/usuario_not_found.jsp"%>
<%
    }
%>

<%@include file="includes/footer.jsp"%>