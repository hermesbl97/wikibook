<%@ page import="com.svalero.basededatos.database.Database" %>
<%@ page import="com.svalero.basededatos.util.DateUtils" %>
<%@ page import="com.svalero.basededatos.exception.UserNotFoundException" %>
<%@ page import="com.svalero.basededatos.dao.ResenaDAO" %>
<%@ page import="com.svalero.basededatos.model.Resena" %>
<%@ page import="com.svalero.basededatos.exception.ResenaNotFoundException" %>
<%@ page contentType="text/html; charset=UTF-8" language="java"%>

<%@include file="includes/header.jsp"%>

<%
    int resenaId = Integer.parseInt(request.getParameter("id_resena"));
    Database database = new Database();
    database.connect();
    ResenaDAO resenaDAO = new ResenaDAO(database.getConnection());
    try {
        Resena resena = resenaDAO.getResenaUsuario(resenaId);
%>
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-7">
            <div class="card shadow-lg rounded-2">
                <div class="card-header bg-white text-black text-center">
                    <h3 class="mb-0">Reseña de <%= resena.getNombre()%></h3>
                </div>
                <div class="card-body p-4">
                    <p><strong>Puntuación:</strong> <%= resena.getPuntuacion() %>/5 <i class="bi bi-star-fill" style="color: gold;"></i></p>
                    <p><strong>Opinión: </strong> <%= resena.getOpinion() %></p>
                    <p><strong>Apropiada:</strong> <%= resena.isApropiada() ? "Sí" : "No" %></p>

                    <div class="text-end mt-3">
                        <%
                            if (rol.equals("admin")){
                        %>
                        <a href="editar_resena.jsp?id_resena=<%= resena.getId_resena()%>" type="button"
                           onclick="return confirm('¿Estás seguro de querer editar?')"
                           class="btn btn-success">Editar</a>
                        <a href="eliminar_resena?id_resena=<%= resena.getId_resena()%>" type="button"
                           onclick="return confirm('¿Estás seguro de querer eliminar la reseña?')"
                           class="btn btn-danger">Borrar</a>
                        <%
                            }
                        %>
                    </div>
                </div>
            </div>
        </div>
    </div>
        <%
    } catch (ResenaNotFoundException rnfe) {
%>
    <%@include file="includes/resena_not_found.jsp"%>
        <%
    }
%>
    <%@include file="includes/footer.jsp"%>

