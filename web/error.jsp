<%-- 
    Document   : error
    Created on : 6/12/2020, 06:51:56 PM
    Author     : maste
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" session="true" language="java" isErrorPage="true"%>
<!DOCTYPE html>
<html lang='es'>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ERROR</title>
        <meta http-equiv='X-UA-Compatible' content='IE=edge'>
        <jsp:include page="Prueba-Reu/my-links-boostrap.html" />
    </head>
    <body>
        <jsp:include page="Prueba-Reu/my-head.jsp" />
        <main class='row cubridor  text-white d-flex align-items-center'>
            <div class='col-md-12 bg-danger padding-5rem'>
                <h1 class='text-white text-center'>ERROR</h1>
                <br>
                <article class='text-center'>
                    <strong>Posibles Causas del error</strong>
                    <ul>
                        <li>Error de validación de ingresos del usuario</li>
                        <li>Error de autentificación y/o autorización del usuario</li>
                        <li>Error en operaciones en la base de datos</li>
                        <li>Y no me se más, chance el programa simplemente murió</li>
                    </ul>
                </article>
                <br>
                
                <center>
                    <a class='btn btn-danger' href='index.jsp'>Volver al index</a>
                    <a class='btn btn-danger' href="controlA?action=home" >Volver al tablón de anuncios</a>
                </center>
            </div>
        </main>
        <div
         <jsp:include page="Prueba-Reu/my-footer.jsp" />
    </body>
</html>
