<%@ page import="com.svalero.basededatos.database.Database" %>
<%@ page import="com.svalero.basededatos.dao.PoemaDAO" %>
<%@ page import="com.svalero.basededatos.model.Poema" %>
<%@ page import="com.svalero.basededatos.util.DateUtils" %>
<%@ page import="com.svalero.basededatos.exception.PoemaNotFoundException" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html; charset=UTF-8" language="java"%>

<%@include file="includes/header_index.jsp"%>

<div class="container py-4">
    <div class="p-5 mb-4 bg-body-tertiary rounded-3">
        <div class="container-fluid py-5 h-100 text-bg-dark"><h1 class="display-5 fw-bold">¡Participa en nuestro Concurso de Poemas!</h1>
            <p>
                ¿Tienes un poema que quieres compartir con el mundo?
                Esta es tu oportunidad para brillar y mostrar tu talento literario.
                Envía tu mejor creación y forma parte de esta experiencia única.
            </p>
            <p>
                Solo tienes que rellenar el formulario con el título y el contenido de tu poema.
                No importa si eres principiante o experto, ¡todas las voces cuentan!
            </p>
            <p>
                Anímate y déjanos leer lo que tu alma quiere contar.
            </p>
            <p><strong>¡Esperamos tu participación!</strong></p>
            <small>Necesitas estar registrado para poder inscribirte</small>
            <div>
                <%
                    if (rol.equals("anonymous")){
                %>
                <a href="login.jsp" class="btn btn-outline-light" type="button">Regístrate</a>
                <%
                    }
                    if (rol.equals("user")){
                %>
                <a href="registrar_poema.jsp" class="btn btn-outline-light" type="button">Inscríbete en el concurso</a>
                <%
                    }
                %>
            </div>
        </div>

        <!-- Meter lista de poemas si eres admin-->
        <%
            if (rol.equals("admin")){
                Database database = new Database();
                database.connect();
                PoemaDAO poemaDAO = new PoemaDAO(database.getConnection());

                try {
                    ArrayList<Poema> poemaList = poemaDAO.getPoemaList();
                    for (Poema poema: poemaList) {

        %>
        <div class="container py-4">
            <div class="h-100 p-5 bg-body-tertiary border rounded-3"><h2><%=poema.getTitulo()%> por <u><i><%=poema.getNombre()%></i></u></h2>
                <p><%=poema.getContenido()%></p>
                <div class="d-flex justify-content-between align-items-center mt-3">
                    <small class="text-start">Enviado el <%= DateUtils.format(poema.getFecha_envio())%></small>
                    <a href="eliminar_poema?id_poema=<%= poema.getId_poema()%>"
                       onclick="return confirm('¿Estás seguro de querer eliminar el poema?')"
                       class="btn btn-danger">Eliminar</a>
                </div>
            </div>
        </div>
        <%
            }

        } catch (PoemaNotFoundException pnfe) {
        %>
        <%@include file="includes/libro_not_found.jsp"%>
        <%
            }
        }
        %>
    </div>
</div>

<%@include file="includes/footer.jsp"%>