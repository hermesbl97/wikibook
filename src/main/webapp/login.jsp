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

    <link rel="canonical" href="https://getbootstrap.com/docs/5.3/examples/sign-in/">

    <script src="/docs/5.3/assets/js/color-modes.js"></script>

    <link href="/docs/5.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-SgOJa3DmI69IUzQ2PVdRZhwQ+dy64/BUtbMJw1MZ8t5HZApcHrRKUc4W0kG879m7">

    <link rel="apple-touch-icon" href="/docs/5.3/assets/img/favicons/apple-touch-icon.png" sizes="180x180">
    <link rel="icon" href="/docs/5.3/assets/img/favicons/favicon-32x32.png" sizes="32x32" type="image/png">
    <link rel="icon" href="/docs/5.3/assets/img/favicons/favicon-16x16.png" sizes="16x16" type="image/png">
    <link rel="manifest" href="/docs/5.3/assets/img/favicons/manifest.json">
    <link rel="mask-icon" href="/docs/5.3/assets/img/favicons/safari-pinned-tab.svg" color="#712cf9">
    <link rel="icon" href="/docs/5.3/assets/img/favicons/favicon.ico">
    <meta name="theme-color" content="#712cf9">


    <style>
        .bd-placeholder-img {
            font-size: 1.125rem;
            text-anchor: middle;
            -webkit-user-select: none;
            -moz-user-select: none;
            user-select: none;
        }

        @media (min-width: 768px) {
            .bd-placeholder-img-lg {
                font-size: 3.5rem;
            }
        }

        .b-example-divider {
            width: 100%;
            height: 3rem;
            background-color: rgba(0, 0, 0, .1);
            border: solid rgba(0, 0, 0, .15);
            border-width: 1px 0;
            box-shadow: inset 0 .5em 1.5em rgba(0, 0, 0, .1), inset 0 .125em .5em rgba(0, 0, 0, .15);
        }

        .b-example-vr {
            flex-shrink: 0;
            width: 1.5rem;
            height: 100vh;
        }

        .bi {
            vertical-align: -.125em;
            fill: currentColor;
        }

        .nav-scroller {
            position: relative;
            z-index: 2;
            height: 2.75rem;
            overflow-y: hidden;
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

        .btn-bd-primary {
            --bd-violet-bg: #712cf9;
            --bd-violet-rgb: 112.520718, 44.062154, 249.437846;

            --bs-btn-font-weight: 600;
            --bs-btn-color: var(--bs-white);
            --bs-btn-bg: var(--bd-violet-bg);
            --bs-btn-border-color: var(--bd-violet-bg);
            --bs-btn-hover-color: var(--bs-white);
            --bs-btn-hover-bg: #6528e0;
            --bs-btn-hover-border-color: #6528e0;
            --bs-btn-focus-shadow-rgb: var(--bd-violet-rgb);
            --bs-btn-active-color: var(--bs-btn-hover-color);
            --bs-btn-active-bg: #5a23c8;
            --bs-btn-active-border-color: #5a23c8;
        }

        .bd-mode-toggle {
            z-index: 1500;
        }

        .bd-mode-toggle .bi {
            width: 1em;
            height: 1em;
        }

        .bd-mode-toggle .dropdown-menu .active .bi {
            display: block !important;
        }
    </style>

    <!-- Custom styles for this template -->
    <link href="sign-in.css" rel="stylesheet">
</head>

<%@include file="includes/header.jsp"%>

<script type="text/javascript">
    $(document).ready(function() {          //quiere decir
        $("form").on("submit", function(event) {  //cuando proceses el formulario, el botón de tipo submit
            event.preventDefault();
            const formValue = $(this).serialize();
            $.ajax("login", {     //vete al login
                type: "POST",       //envía everything a través de post
                data: formValue,
                statusCode: {
                    200: function(response) {
                        if (response === "OK") {
                            window.location.href = "/wikibook";   //si everything va bien ve a la página de wikibook
                        } else {
                            $("#result").html("<div class='alert alert-danger' role='alert'>"+ response +"</div>");    //sino tirame en la capa result lo que te tire el servlet
                        }
                    }
                }
            });
        });
    });
</script>


<main class="form-signin w-100 m-auto">
    <div class="container d-flex justify-content-center">
        <form>
            <h1><i class="bi bi-book"> WikiBook</i></h1>
            <h3 class="h3 mb-3 fw-normal">Regístrate</h3>

            <div class="form-floating mb-2" >
                <input type="text" class="form-control" id="floatingInput" name="username">
                <label for="floatingInput">Nombre de usuario</label>
            </div>
            <div class="form-floating mb-2">
                <input type="password" class="form-control" id="floatingPassword" name="password">
                <label for="floatingPassword">Contraseña</label>
            </div>
            <div class="mb-2">
                <input class="btn btn-warning w-100 py-2" type="submit" value="Iniciar sesión">
            </div>
            <div class="mb-2">
                ¿No tienes una cuenta? <a href="register.jsp" class="link-info link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover">Regístrate</a></p>
            </div>
            <div class="mb-2" id="result"></div>
        </form>
    </div>
</main>
<script defer src="/docs/5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-k6d4wzSIapyDyv1kpU366/PK5hCdSbCRGRCMv+eplOQJWyd1fbcAu9OCUj5zNLiq"></script>

</body>
</html>