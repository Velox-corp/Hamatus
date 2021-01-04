<%@page import="ClasesSoporte.Conexion"%>
<%@page import="java.sql.*"%>
<%@page language="java" pageEncoding="UTF-8" contentType="text/html"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="JS/Validaciones.js"></script>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>Tablon</title>

        <meta name="description" content="Source code generated using layoutit.com">
        <meta name="author" content="LayoutIt!">

        <jsp:include page="Prueba-Reu/my-links-boostrap.html" />
    </head>
    <body>

        <jsp:include page="Prueba-Reu/my-head2.jsp" />
        <div class="row margin-top-1rem">
            <div class="col-md-1">
            </div>
            <div class="col-md-6">
                <nav>
                    <ul class="pagination">
                        <li class="page-item">
                            <a class="page-link" href="#" style="background-color: #2291C1; color: #FFFFFF">Tab 1</a>
                        </li>
                        <li class="page-item">
                            <a class="page-link" href="#" style="background-color: #2291C1; color: #FFFFFF">Tab 2</a>
                        </li>
                    </ul>
                </nav>
                <div class="card" style="background-color: #e9ecef">
                    <h5 class="card-header">
                        Anuncio
                    </h5>
                    <img alt="Hamatus" src="img/Hamatus.png" class="mx-auto d-block img-fluid">
                </div>
                <br>
                <div class="col-md-13">
                    <form action="controlA?accion=Agregar" method="post" onsubmit="return valida(this)" name="f">
                        <div class="form-group">
                            <label for="nombre">Título</label>
                            <input type="text" maxlength="80" class="form-control" id="tituloa" name="tituloa" placeholder="Titulo" required="required" oncopy="return false" onpaste="return false" autocomplete="off" ondrag="return false"  ondrop="return false">
                        </div>
                        <div class="form-group">
                            <label for="descripcion">Descripción</label>
                            <input type="text" maxlength="500" class="form-control" id="descripciona" name="descripciona" placeholder="Anuncio" required="required" oncopy="return false" onpaste="return false" autocomplete="off" ondrag="return false"  ondrop="return false">
                        </div>
                        <div class="form-group">
                            <input type="date" class="form-control" id="fechaa" oncopy="return false" onpaste="return false" autocomplete="off" ondrag="return false"  ondrop="return false" required="required" onchange="return validarDate(this)">
                        </div>
                        <button type="submit" name="enviar" class="btn btn-dark">Guardar <i class="fa fa-floppy-o" aria-hidden="true"></i></button>
                    </form> 
                </div>
            </div>
            <div class="col-md-4 folio">
                <div class="card" style="background-color: #e9ecef">
                    <h5 class="card-header">
                        Folio
                    </h5>
                    <div class="card-body">
                        <input type="text"class="form-control" placeholder="Texto" oncopy="return false" onpaste="return false" autocomplete="off" ondrag="return false"  ondrop="return false" required="required">
                        <br>    
                        <button class="btn btn-dark form-control">Buscar</button>
                    </div>
                </div>
            </div>
            <br>
        </div>
        <jsp:include page="Prueba-Reu/my-footer.jsp" />
    </body>
</html>