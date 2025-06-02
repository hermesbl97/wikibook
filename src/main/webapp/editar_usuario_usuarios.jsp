<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ page import="com.svalero.basededatos.database.Database" %>
<%@ page import="com.svalero.basededatos.exception.UserNotFoundException" %>
<%@ page import="com.svalero.basededatos.model.Usuario" %>
<%@ page import="com.svalero.basededatos.dao.UsuarioDAO" %>
<%@include file="includes/header.jsp"%>

<%
    if ((currentSession.getAttribute("rol") == null) || (!currentSession.getAttribute("rol").equals("user")) ){
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
                url:"editar_usuario_usuarios",
                type: "POST",
                data: formValue,
                statusCode: {
                    200: function(response) {
                        console.log("Respuesta del servidor:", response);
                        if (response === "OK") {
                            window.location.href = "/wikibook/detail_usuario.jsp?id_usuario=<%=usuario.getId_usuario()%>";
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
        <label class="form-label">Nombre de usuario</label>
        <input type="text" class="form-control" id="nombre" name="nombre" value="<%= usuario.getNombre()%>" required>
    </div>

    <div class="col-md-4">
        <label class="form-label">Email</label>
        <input type="email" class="form-control" id="email" name="email" value="<%= usuario.getEmail()%>" required>
    </div>

    <div class="col-md-4">
        <label class="form-label">Fecha de nacimiento</label>
        <input type="date" class="form-control" id="fecha_nacimiento" name="fecha_nacimiento" value="<%=usuario.getFecha_nacimiento()%>" required>
    </div>

    <div class="col-md-4">
        <label class="form-label">Contraseña</label>
        <span class="form-text">
                          Introduce la contraseña si deseas modificarla
        </span>
        <input type="password" class="form-control" id="password" name="password">
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