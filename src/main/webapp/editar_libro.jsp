<%@ page import="com.svalero.basededatos.database.Database" %>
<%@ page import="com.svalero.basededatos.dao.LibrosDAO" %>
<%@ page import="com.svalero.basededatos.model.Libro" %>
<%@ page contentType="text/html; charset=UTF-8" language="java"%>

<%@include file="includes/header.jsp"%>

<%
    if ((currentSession.getAttribute("rol") == null) || (!currentSession.getAttribute("rol").equals("admin"))) {
        response.sendRedirect("/wikibook/login.jsp");
    }

    String action = null;
    Libro libro = null;
    String libroId = request.getParameter("id_libro");
    if (libroId != null) {
         action = "Editar";
        Database database = new Database();
        database.connect();
        LibrosDAO librosDAO = new LibrosDAO(database.getConnection());
        libro = librosDAO.get(Integer.parseInt(libroId));
    } else {
        action = "Registrar";
    }
%>

<script type="text/javascript">
    $(document).ready(function() {          //quiere decir
        $("form").on("submit", function(event) {  //cuando proceses el formulario, el botón de tipo submit
            event.preventDefault();
            const form = $("form")[0];
            const formValue = new FormData(form);
            $.ajax("editar_libro", {
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
        <form>
            <h1><i class="bi bi-book"> WikiBook</i></h1>
            <h3 class="h3 mb-3 fw-normal"><%=action %> libro</h3>
            <div class="input-group mb-2">
                <span class="input-group-text">Título</span>
                <input type="text" id="titulo" name="titulo" placeholder="Harry Potter"  class="form-control"
                       aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default"
                       value="<%= libro != null ? libro.getTitulo() : "" %>">  <!-- El ?  funciona como un if y los : actúa como else    -->
                </div>

                <div class="input-group mb-2">
                    <span class="input-group-text">Autor</span>
                    <input type="text" id="autor" name="autor" placeholder="J.K. Rowling" class="form-control"
                           value="<%= libro != null ? libro.getAutor() : "" %>">
                </div>

                <div class="input-group mb-2">
                    <span class="input-group-text">Fecha de publicación</span>
                    <input type="date" id="fecha_publicacion"  name="fecha_publicacion" class="form-control"
                           value="<%= libro != null ? libro.getFecha_publicacion() : "" %>">
                </div>

                <div class="input-group mb-2">
                    <span class="input-group-text">Foto Portada</span>
                    <input type="file" id="imagen" name="imagen"  class="form-control">
                </div>

                <div class="input-group mb-2">
                    <span class="input-group-text">Precio</span>
                    <input type="text" id="precio" name="precio" placeholder="40" class="form-control"
                           value="<%= libro != null ? libro.getPrecio() : "" %>">
                </div>

                <div class="input-group mb-2">
                    <span class="input-group-text">Género</span>
                    <input type="text"  id="genero" name="genero" placeholder="Fantasía" class="form-control"
                           value="<%= libro != null ? libro.getGenero() : "" %>">
                </div>

                <div class="input-group mb-2">
                    <span class="input-group-text">Editorial</span>
                    <input type="text"  id="editorial" name="editorial" placeholder="Bloomsbury Publishing" class="form-control"
                           value="<%= libro != null ? libro.getEditorial() : "" %>">
                </div>

                <div>
                    <input class="btn btn-primary" type="submit" value="Enviar" name="submit">
                </div>

                <input type="hidden" name="action" value="<%= action%>">

                <%
                    if (action.equals("Editar")) {
                %>
                <input type="hidden" name="libroId" value= "<%= libro.getId_libro()%>"> <!-- Nos permite facilitar el  ID del libro al realizar la acción de modificar o registrar -->

                <%
                    }
                %>

                <div class="mb-2" id="result"></div>

        </form>
    </div>
</div>

<%@include file="includes/footer.jsp"%>