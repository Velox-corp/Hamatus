<%@page import="MUsuarios.clases.UsuarioEmpleado"%>
<%@page import="ClasesSoporte.Conexion"%>
<%@page import="java.sql.*"%>
<%@page language="java" pageEncoding="UTF-8" contentType="text/html"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                                    <%
            HttpSession sesion;
            UsuarioEmpleado liderDiv;

                 sesion = request.getSession();
                 liderDiv = (UsuarioEmpleado) sesion.getAttribute("usuario");
                 int iddivision=liderDiv.getiD_Division();

        %>
        <jsp:include page="Prueba-Reu/my-head2.jsp" />
        <div class="row margin-top-1rem">
            <div class="col-md-1">
            </div>
            <div class="col-md-6">
                <nav>
                    <ul class="pagination">
                        <li class="page-item">
                            <a class="page-link" href="#">Tab 1</a>
                        </li>
                        <li class="page-item">
                            <a class="page-link" href="#">Tab 2</a>
                        </li>
                    </ul>
                </nav>
                <div class="card">
                    <h5 class="card-header">
                        Anuncio
                    </h5>
                    <div class="input-group mb-3">

                        <form action="controlA?accion=Agregar&iddivision=<%=iddivision%>" method="post">
                            <input type="hidden" id="iddivision" name="iddivision" value="<%=iddivision%>"> 
                            <div class="form-group">
                                <label for="nombre">Titulo</label>
                                <input type="text" class="form-control" id="tituloa" name="tituloa" placeholder="Titulo" required="required">
                            </div>
                            <div class="form-group">
                                <label for="descripcion">Descripcion</label>
                                <input type="text" class="form-control" id="descripciona" name="descripciona" placeholder="Anuncio" required="required">
                            </div>
                            <div class="form-group">
                                
                            </div>
                            <button type="submit" name="enviar" class="btn btn-primary">Guardar <i class="fa fa-floppy-o" aria-hidden="true"></i></button>
                        </form> 

                    </div>
                </div>
                <br>

            </div>
            <div class="col-md-4 folio">
                <div class="card">
                    <h5 class="card-header">
                        Folio
                    </h5>
                    <div class="card-body">
                        <input type="text"class="form-control" placeholder="texto">
                        <br>    
                        <button class="btn btn-primary form-control">Buscar</button>
                    </div>
                </div>
            </div>
            <br>
            <jsp:include page="Prueba-Reu/my-footer.jsp" />
        </div>
    </body>
</html>