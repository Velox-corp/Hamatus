<%@page import="MUsuarios.clases.UsuarioEmpleado"%>
<%@page import="MDivisiones.Servlets.crearDivisiones"%>
<%@page language="java" pageEncoding="UTF-8" contentType="text/html" session="true"%>
<%
    HttpSession sesion = request.getSession();
    boolean obtencionAdecuada = false;
    String nombre = "";
    String appat = "";
    String apmat = "";
    String correo = "";
    String fecha_nac = "";
    try {
        UsuarioEmpleado usuario = (UsuarioEmpleado) sesion.getAttribute("usuario");
        nombre = usuario.getNombre();
        appat = usuario.getAppat();
        apmat = usuario.getApmat();
        correo = usuario.getCorreo();
        fecha_nac = usuario.getFechaNacimiento();
        //NOTA, el id no lo vamos a meter, se va obtener por parte de la sesión para ocultarlo
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
                <form action="crearDivisiones" method="POST" enctype="multipart/form-data" >
                    <h2>Crear Nueva División</h2>
                    <hr>
                    <div class="form-group">
                        <label for="nameUser">Nombre:</label>
                        <input type="name" class="form-control" id="nameUser" name="nombreD" 
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
                <form role="form" method="POST" action='eliminarDivision'>
                    <hr>
                    <h2>Divisiones Actuales</h2>
                    <hr>
                        <div class="input-group mb-3">		 
                            <div class="input-group-prepend">
                                <span class="input-group-text">Nombre:</span>
                            </div>
                            <input type="text" class="form-control" id="nombre" name='nombre' readonly ='readonly'
                                   <% if (obtencionAdecuada) {%>
                                   value="<%=nombre%>"
                                   <%}%>
                                   onchange="return validarString(this, true, false)"
                                   ondrag="return validarString(this, true, false)"
                                   ondrop="return validarString(this, true, false)">
                            <div class='input-group-append'>
                            <button class="btn btn-info" onclick='return cambiarEstado("nombre")'>Eliminar</button>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-dark">
                        Actualizar información
                    </button>
                </form>
              </div>
            </div>
        </div><br>
    </body>
    <jsp:include page="Prueba-Reu/my-footer.jsp" />
</html>
