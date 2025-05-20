<%@ page import="com.svalero.basededatos.model.Resena" %>
<%@ page import="com.svalero.basededatos.database.Database" %>
<%@ page import="com.svalero.basededatos.dao.LibrosDAO" %>
<%@ page import="com.svalero.basededatos.model.Libro" %>
<%@ page import="com.svalero.basededatos.dao.ResenaDAO" %>
<%@ page contentType="text/html; charset=UTF-8" language="java"%>

<%@include file="includes/header.jsp"%>

<script type="text/javascript">
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
          <input type="hidden" name="id_resena" value="<%= libroId %>" >


          <div class="mb-3">
            <h5 class="card-title">Puntuación (0-5)</h5>
            <input type="number" name="puntuacion">
          </div>

          <div class="mb-3">
            <h5 class="card-title">Deja tu opinión</h5>
            <div class="form-floating">
              <textarea class="form-control" style="height: 100px" name="opinion" ></textarea>
            </div>
          </div>
          <div>
            <input class="btn btn-primary mb-3" type="submit" value="Publicar" name="submit" >
          </div>

      </form>

        <div id="result"></div>

    </div>
  </div>
</div>
</body>
</html>
