

<%@page import="java.sql.*"%>
<%@page language="java" pageEncoding="UTF-8" contentType="text/html"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>Editar Anuncios</title>

        <meta name="description" content="Source code generated using layoutit.com">
        <meta name="author" content="LayoutIt!">

        <jsp:include page="Prueba-Reu/my-links-boostrap.html" />
    </head>
    <body>
        <jsp:include page="Prueba-Reu/my-head2.jsp" />
        <center><h1>Editar anuncio</h1></center>
        <div class="container margin-top-2rem">
        <div class="row d-flex justify-content-center">
              <div class="col-sm-8">
                    <form action="controlA?accion=Update" method="post">

                        <c:forEach var="p" items="${anuncios}">
                            <input type="hidden" id="idmod" name="idmod" value="${p.getId()}">
                            <div class="form-group">
                                <label for="nombre">Título</label>
                                <input type="text" value="${p.getTitulo()}" class="form-control" id="mod_titulo" name="mod_titulo" required="required" oncopy="return false" onpaste="return false" autocomplete="off" ondrag="return false"  ondrop="return false">
                            </div>
                            <div class="form-group">
                                <label for="descripcion">Descripción</label>
                                <input type="text" value="${p.getDescripcion()}" class="form-control" id="mod_descripcion" name="mod_descripcion" required="required" oncopy="return false" onpaste="return false" autocomplete="off" ondrag="return false"  ondrop="return false">
                            </div>
                            <div class="form-group">
                                <input type="date" class="form-control" id="fechaa" required="required" oncopy="return false" onpaste="return false" autocomplete="off" ondrag="return false"  ondrop="return false">
                            </div>
                            <button type="submit" name="enviar" class="btn btn-dark">Guardar<i class="fa fa-floppy-o" aria-hidden="true"></i></button>

                        </c:forEach> 
                    </form> 
            </div>
        </div>
        </div>
    </body>
</html>
