<%@ page import="com.svalero.basededatos.model.Resena" %>
<%@ page import="com.svalero.basededatos.database.Database" %>
<%@ page import="com.svalero.basededatos.dao.LibrosDAO" %>
<%@ page import="com.svalero.basededatos.model.Libro" %>
<%@ page import="com.svalero.basededatos.dao.ResenaDAO" %>
<%@ page import="com.svalero.basededatos.exception.ResenaNotFoundException" %>
<%@ page contentType="text/html; charset=UTF-8" language="java"%>

<%@include file="includes/header.jsp"%>


<%
    if ((currentSession.getAttribute("rol") == null) || (!currentSession.getAttribute("rol").equals("admin")) ){
        response.sendRedirect("/wikibook/login.jsp");
    }
%>

<script>
    $(document).ready(function() {
        $("form").on("submit", function(event) {
            event.preventDefault();
            const formValue = $(this).serialize();

            $.ajax({
                url: "editar_resena",
                type: "POST",
                data: formValue,
                success: function(response) {
                    if (response === "OK") {
                        window.location.href = "/wikibook";
                    } else {
                        $("#result").html("<div class='alert alert-danger' role='alert'>" + response + "</div>");
                    }
                },
                error: function(xhr) {
                    if (xhr.status === 401 || xhr.status === 403) {
                        window.location.href = "/wikibook/login.jsp";
                    } else {
                        $("#result").html("<div class='alert alert-danger' role='alert'>" + xhr.responseText + "</div>");
                    }
                }
            });
        });
    });
</script>


<%
    String resenaId = request.getParameter("id_resena");
    Database database = new Database();
    database.connect();

    ResenaDAO resenaDAO = new ResenaDAO(database.getConnection());

    try{
        Resena resena = resenaDAO.getResenaUsuario(Integer.parseInt(resenaId));
%>


<div class="container d-flex justify-content-center">
    <div class="card mb-3">
        <div class="row g-0">
            <h2>Modifica la reseña</h2>
            <form method="post">
                <input type="hidden" name="id_resena" value="<%= resenaId %>" >

                <div class="mb-3">
                    <h5 class="card-title">Puntuación</h5>
                    <input type="number" name="puntuacion" id="puntuacion" min="0" max="5" step="0.1" value="<%= resena.getPuntuacion()%>" required>
                    <div class="col-auto">
                      <span id="passwordHelpInline" class="form-text">
                          La puntuación debe ser entre 0-5 puntos.
                      </span>
                    </div>
                </div>

                <div class="mb-3">
                    <h5 class="card-title">Opinión</h5>
                    <div class="form-floating">
                        <textarea class="form-control" style="height: 100px" name="opinion" id="opinion" value="<%= resena.getOpinion()%>" required></textarea>
                    </div>
                </div>

                <div class="col-md-4">
                    <label class="form-label">Reseña apropiada</label>
                    <select id="apropiada" name="apropiada" class="form-select" required>
                        <option value="">Selecciona una opción</option>
                        <option value="true" <%= resena.isApropiada() ? "selected" : "" %>>Sí</option>
                        <option value="false" <%= !resena.isApropiada() ? "selected" : "" %>>No</option>
                    </select>
                </div>
                <div>
                    <input class="btn btn-primary mb-3" type="submit" value="Editar" name="submit" >
                </div>

            </form>
            <div id="result"></div>

            <%
            } catch (ResenaNotFoundException rnfe) {
            %>
            <%@include file="includes/resena_not_found.jsp"%>
            <%
                }
            %>

        </div>
    </div>
</div>
</body>
</html>
