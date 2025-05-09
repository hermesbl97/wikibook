<%@ page contentType="text/html; charset=UTF-8" language="java"%>

<%@include file="includes/header.jsp"%>

<script type="text/javascript">
    $(document).ready(function() {          //quiere decir
        $("form.ajax").on("submit", function(event) {  //cuando proceses el formulario, el botón de tipo submit
            event.preventDefault();
            const form = this;
            const formValue = new FormData(form);
            $.ajax("nuevo_libro", {     //vete al login
                type: "POST",       //envía everything a través de post
                enctype: "multipart/form-data",
                data: formValue,
                processData: false,
                contentType: false,
                statusCode: {
                    200: function(response) {
                        if (response === "OK") {
                            $("#result").html("<div class='alert alert-success' role='alert'>"+ response +"</div>");    //sino tirame en la capa result lo que te tire el servlet
                        } else {
                            $("#result").html("<div class='alert alert-danger' role='alert'>"+ response +"</div>");    //sino tirame en la capa result lo que te tire el servlet
                        }
                    },
                    404: function (response) {
                        $("#result").html("<div class='alert alert-danger' role='alert'>Error al enviar los datos</div>");
                    }
                }
            });
        });
    });
</script>


<div class="album py-5 bg-body-territory">
    <div class="container d-flex justify-content-center">
        <form id="form-nuevo-libro" class="ajax">
        <div class="input-group mb-2">
                <input type="text" id="titulo" name="titulo" placeholder="Harry Potter"  class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default">
            </div>

            <div class="input-group mb-2">
                <input type="text" id="autor" name="autor" placeholder="J.K. Rowling" class="form-control">
            </div>

            <div class="input-group mb-2">
                <input type="date" id="fecha_publicacion"  name="fecha_publicacion" class="form-control">
            </div>

            <div class="input-group mb-2">
                <input type="file" id="imagen" name="imagen"  class="form-control">
            </div>

            <div class="input-group mb-2">
                <input type="text" id="precio" name="precio" placeholder="40" class="form-control">
            </div>

            <div class="input-group mb-2">
                <input type="text"  id="genero" name="genero" placeholder="Fantasía" class="form-control">
            </div>

            <div class="input-group mb-2">
                <input type="text"  id="editorial" name="editorial" placeholder="Bloomsbury Publishing" class="form-control">
            </div>

            <div>
                <input class="btn btn-primary" type="submit" value="Registrar" name="submit">
            </div>

            <div class="mb-2" id="result"></div>

        </form>
    </div>
</div>

<%@include file="includes/footer.jsp"%>