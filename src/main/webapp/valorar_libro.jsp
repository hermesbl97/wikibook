    <%@ page import="com.svalero.basededatos.database.Database" %>
    <%@ page contentType="text/html; charset=UTF-8" language="java"%>
    <%@include file="includes/header.jsp"%>


    <%
        if ((currentSession.getAttribute("rol") == null) || (!currentSession.getAttribute("rol").equals("user")) ){
            response.sendRedirect("/wikibook/login.jsp");
        }
    %>

    <script>
        $(document).ready(function() {
            $("form").on("submit", function(event) {
                event.preventDefault();
                const formValue = $(this).serialize();

                $.ajax({
                    url: "valorar_libro",
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
      String libroId = request.getParameter("id_libro");
      Database database = new Database();
      database.connect();
    %>


    <div class="container d-flex justify-content-center">
      <div class="card mb-3">
        <div class="row g-0">
          <h2>Tu opinión nos ayuda</h2>
          <form method="post">
              <input type="hidden" name="id_libro" value="<%= libroId %>" >

              <div class="mb-3">
                <h5 class="card-title">Puntuación</h5>
                  <input type="number" name="puntuacion" id="puntuacion" min="0" max="5" step="0.1" required>
                  <div class="col-auto">
                      <span id="passwordHelpInline" class="form-text">
                          La puntuación debe ser entre 0-5 puntos.
                      </span>
                  </div>
              </div>

              <div class="mb-3">
                <h5 class="card-title">Deja tu opinión</h5>
                <div class="form-floating">
                  <textarea class="form-control" style="height: 100px" name="opinion" id="opinion" required></textarea>
                </div>
              </div>
              <div>
                <input class="btn btn-primary mb-3" type="submit" value="Publicar" name="submit" required>
              </div>

          </form>

            <div id="result"></div>

        </div>
      </div>
    </div>
    </body>
    </html>
