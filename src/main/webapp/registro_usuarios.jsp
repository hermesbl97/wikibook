<%@ page contentType="text/html; charset=UTF-8" language="java"%>

<%@include file="includes/header.jsp"%>

<script type="text/javascript">
    $(document).ready(function() {
        $("form").on("submit", function(event) {
            event.preventDefault();
            const formValue = $(this).serialize();
            $.ajax({
                url:"/wikibook/registro_usuarios",
                type: "POST",
                data: formValue,
                statusCode: {
                    200: function(response) {
                        console.log("Respuesta del servidor:", response);
                        if (response === "OK") {
                            window.location.href = "/wikibook/";
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

<div class="album py-5 bg-body-territory">
    <div class="container d-flex justify-content-center">
        <form>
            <h1><i class="bi bi-book"> WikiBook</i></h1>
            <h3 class="h3 mb-3 fw-normal">Regístrate como nuevo usuario</h3>
            <div class="input-group mb-2">
                <span class="input-group-text">Nombre de usuario</span>
                <input type="text" id="nombre" name="nombre"  class="form-control">
            </div>

            <div class="input-group mb-2">
                <span class="input-group-text">Contraseña</span>
                <input type="password" id="password" name="password" class="form-control">
            </div>

            <div class="input-group mb-2">
                <span class="input-group-text">Email</span>
                <input type="email" id="email"  name="email" class="form-control">
            </div>

            <div class="input-group mb-2">
                <span class="input-group-text">Fecha de nacimiento</span>
                <input type="date" id="fecha_nacimiento" name="fecha_nacimiento"  class="form-control">
            </div>

            <div>
                <input class="btn btn-primary" type="submit" value="Registrar" name="submit">
            </div>
            <div class="mb-2" id="result"></div>

        </form>
    </div>
</div>