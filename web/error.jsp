<%-- 
    Document   : error
    Created on : 6/12/2020, 06:51:56 PM
    Author     : maste
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang='es'>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ERROR</title>
        <meta http-equiv='X-UA-Compatible' content='IE=edge'>
        <jsp:include page="Prueba-Reu/my-links-boostrap.html" />
    </head>
    <body class='container-fluid'>
        <jsp:include page="Prueba-Reu/my-head.jsp" />
        <br>
        <main class='row'>
            <div class='col-md-12 bg-danger'>
                <h1 class='text-white text-center'>ERROR</h1>
                <br>
                <article>
                    Un error, que te digo, culpa, o nuestra, o de maisicuel, o de java, o del servidor, o de un fantasma.
                </article>
                <br>
                <center><a class='btn btn-danger' href='index.jsp'>Volver al index</a></center>
            </div>
        </main>
        <div
         <jsp:include page="Prueba-Reu/my-footer.html" />
    </body>
</html>
