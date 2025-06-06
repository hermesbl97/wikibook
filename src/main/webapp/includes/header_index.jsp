<%@ page import="com.svalero.basededatos.dao.UsuarioDAO" %>
<%@ page import="com.svalero.basededatos.model.Usuario" %>
<%@ page contentType="text/html; charset=UTF-8" language="java"%>

<!doctype html>
<html lang="en" data-bs-theme="auto">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.145.0">
    <title>WikiBook</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>


    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <meta name="theme-color" content="#712cf9">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> <!--añadimos librería ajax-->


    <style>

        @media (min-width: 768px) {
            .bd-placeholder-img-lg {
                font-size: 3.5rem;
            }
        }



        .bi {
            vertical-align: -.125em;
            fill: currentColor;
        }

        .nav-scroller .nav {
            display: flex;
            flex-wrap: nowrap;
            padding-bottom: 1rem;
            margin-top: -1px;
            overflow-x: auto;
            text-align: center;
            white-space: nowrap;
            -webkit-overflow-scrolling: touch;
        }
        .bd-mode-toggle .bi {
            width: 1em;
            height: 1em;
        }

        .bd-mode-toggle .dropdown-menu .active .bi {
            display: block !important;
        }
    </style>

</head>


<body>
<header class="p-3 text-bg-dark">
    <div class="container">
        <div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
            <a href="/wikibook" class="d-flex align-items-center mb-2 mb-lg-0 text-white text-decoration-none">
                <h3><i class="bi bi-book"> WikiBook</i></h3>
            </a>
            <%
                HttpSession currentSession = request.getSession();
                String rol = "anonymous";
                if (currentSession.getAttribute("rol") != null) { //si la sesión es distinto de nulo entonces el atributo rol existe significa que hay una sesión
                    rol = currentSession.getAttribute("rol").toString(); //es un objeto pero lo tenemos que declarar como String
                }

                String search = request.getParameter("search");

            %>

            <ul class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
                <li><a href="/wikibook" class="nav-link px-2 text-secondary">Home</a></li>
                <%
                    if (rol.equals("admin")) {
                %>
                <li><a href="usuarios.jsp" class="nav-link px-2 text-white">Usuarios</a></li>
                <%
                    }

                    Integer id_usuario = (Integer) currentSession.getAttribute("id_usuario");
                    if (rol.equals("user")) {
                %>
                <li><a href="detail_usuario.jsp?id_usuario=<%= id_usuario %>" class="nav-link px-2 text-white">Perfil</a></li>
                <%
                    }
                    if (!rol.equals("anonymous")){
                %>
                <li><a href="concurso.jsp" class="nav-link px-2 text-white">Concurso</a></li>
                <%
                    }
                %>
            </ul>

            <form class="col-12 col-lg-auto mb-3 mb-lg-0 me-lg-3" method="get" action="<%= request.getRequestURI()%>">
                <input type="text" class="form-control form-control-dark text-bg-dark" placeholder="Search..." name="search" id="search"
                value="<%= search != null ? search : ""%>">
            </form>

            <div class="text-end">
                <a type="button" class="btn btn-outline-light me-2" href="/wikibook/registro_usuarios.jsp">Regístrate</a>
                <%
                    if (rol.equals("anonymous")) {
                %>
                <a type="button" class="btn btn-warning" href="/wikibook/login.jsp">Iniciar sesión</a>
                <%
                    } else {
                %>
                <a type="button" class="btn btn-danger" href="/wikibook/logout">Cerrar sesión</a>
                <%
                    }
                %>
            </div>
        </div>
    </div>
</header>
