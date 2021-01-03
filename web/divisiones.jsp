<%@page import="MUsuarios.clases.UsuarioEmpleado"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page language="java" pageEncoding="UTF-8" contentType="text/html" session="true"%>
<%
    HttpSession sesion = request.getSession();
    boolean obtencionAdecuada = false;
    try {
        UsuarioEmpleado usuario = (UsuarioEmpleado) sesion.getAttribute("usuario");
        obtencionAdecuada = true;
    } catch (NullPointerException e) {
        obtencionAdecuada = false;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Divisiones</title>
        <jsp:include page="Prueba-Reu/my-links-boostrap.html" />
    </head>
    <jsp:include page="Prueba-Reu/my-head2.jsp" />
    <body><br>
        <center><h1>Divisiones</h1></center>
        <div class="container margin-top-2rem">   
            <div class="row d-flex justify-content-center">
              <div class="col-sm-8">
                <% if (obtencionAdecuada) {%>
                <form action="crearDivision" method="POST"  >
                    <h2>Crear Nueva División</h2>
                    <hr>
                    <div class="form-group">
                        <label for="nombreD">Nombre:</label>
                        <input type="text" class="form-control" id="nombreD" name="nombreD" 
                               onchange="return validarString(this, true, false)"
                               ondrag="return validarString(this, true, false)"
                               ondrop="return validarString(this, true, false)">
                    </div>
                    <div class="form-group">
                        <div class="col-md-8">
                          <button id="submit" name="submit" class="btn btn-dark" value="1">Registrar</button>
                          <a href="" id="cancel" name="cancel" class="btn btn-default">Cancelar</a>
                        </div>
                    </div>
                </form>
                <c:forEach var="p" items="${divisiones}">
                <form role="form" method="POST" action='eliminarDivision'>
                    <hr>
                    <h2>Divisiones Actuales</h2>
                    <hr>
                        <input type="hidden" id="ida" value="${p.getId()}">
                        <div class="input-group mb-3">		 
                            <div class="input-group-prepend">
                                <span class="input-group-text">Nombre:</span>
                            </div
                            <input type="text" class="form-control" id="nombreD" name='nombreD' readonly ='readonly' value="${p.getNombre()}">
                            <div class='input-group-append'>
                                <button type="submit" class="btn btn-dark">
                                    Eliminar
                                </button>
                            </div>                        
                        </div>
                </form>
                </c:forEach>
                <%}%>
              </div>
            </div>
        </div><br>
    </body>
    <jsp:include page="Prueba-Reu/my-footer.jsp" />
</html>
