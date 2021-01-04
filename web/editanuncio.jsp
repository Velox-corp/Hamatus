

<%@page import="MUsuarios.clases.UsuarioEmpleado"%>
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
        <div class="row margin-top-1rem">
            <div class="col-md-6">
                <div class="input-group mb-3">
                    <%
                    HttpSession sesion;
                    UsuarioEmpleado liderDiv;
                    try{
                        sesion = request.getSession();
                        liderDiv = (UsuarioEmpleado) sesion.getAttribute("usuario");
                        int divEdit = liderDiv.getiD_Division();
                    
                    %>
                    
                    <form action="controlA?accion=Update" method="post">

                        <c:forEach var="p" items="${anuncios}">
                            <input type="hidden" id="idmod" name="idmod" value="${p.getId()}">
                            <input type="hidden" id="id_div" name="id_div" value="<%=divEdit%>">
                            
                            <div class="form-group">
                                <label for="nombre">Titulo</label>
                                <input type="text" value="${p.getTitulo()}" class="form-control" id="mod_titulo" name="mod_titulo" required="required">
                            </div>
                            <div class="form-group">
                                <label for="descripcion">Descripcion</label>
                                <input type="text" value="${p.getDescripcion()}" class="form-control" id="mod_descripcion" name="mod_descripcion" required="required">
                            </div>
                            <div class="form-group">
                                <input type="date" class="form-control" id="fechaa">
                            </div>
                            <button type="submit" name="enviar" class="btn btn-primary">Guardar<i class="fa fa-floppy-o" aria-hidden="true"></i></button>

                        </c:forEach> 
                    </form> 
                    <%
                        }catch (Exception e) {
                        e.getMessage();
                        e.printStackTrace();
                    }
                    %>
                </div>
            </div>
        </div>
    </body>
</html>
