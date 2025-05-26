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
                url: "registrar_poema",
                type: "POST",
                data: formValue,
                success: function(response) {
                    if (response === "OK") {
                        window.location.href = "/wikibook/concurso.jsp";
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


<div class="container mt-5">
    <h2 class="mb-4">Envía tu poema</h2>

    <form action="PoemaServlet" method="post">
        <div class="mb-3">
            <label for="titulo" class="form-label">Título del poema</label>
            <input type="text" class="form-control" id="titulo" name="titulo" required>
        </div>

        <div class="mb-3">
            <label for="contenido" class="form-label">Contenido del poema</label>
            <textarea class="form-control" id="contenido" name="contenido" required></textarea>
        </div>

        <div class="mb-3">
            <label for="fecha_envio" class="form-label">Fecha de envío</label>
            <input type="date" class="form-control" id="fecha_envio" name="fecha_envio" required>
        </div>

        <input type="hidden" name="id_usuario" value="<%=id_usuario%>">

        <button type="submit" class="btn btn-primary">Enviar Poema</button>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
