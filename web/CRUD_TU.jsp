<%@page import="MUsuarios.clases.UsuarioEmpleado"%>
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
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>CRUD | TU</title>

        <meta name="description" content="Source code generated using layoutit.com">
        <meta name="author" content="LayoutIt!">

        <jsp:include page="Prueba-Reu/my-links-boostrap.html" />
    </head>
    <body>
        <script src='JS/interaccionBotones.js'></script>
        <jsp:include page="Prueba-Reu/my-head2.jsp" /><br>
        <div class="container-fluid">
            <div class="row margin-top-1rem">
                <div class="col-md-2">
                </div>
                <div class="col-md-8">
                    <div class="container-fluid row justify-content-center">
                        <img alt="Bootstrap Image Preview" src="img/grupo.png" class="rounded-circle">
                    </div>
                    <form role="form" method="POST" action='actualizarUser'>
                        <div class="row form-group justify-content-center">
                            <label for="InputFile" class="margen">
                                Imagen
                            </label>
                            <input type="file" class="form-control-file" id="InputFile">
                            <p class="help-block">
                                Inserte imagen del empleado
                            </p>
                        </div>
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
                                <button class="btn btn-info" onclick='return cambiarEstado("nombre")'>Editar</button>
                            </div>

                        </div>
                        <div class="input-group mb-3">		 
                            <div class="input-group-prepend">
                                <span class="input-group-text">Apellido paterno:</span>
                            </div>
                            <input type="text" class="form-control" id="appat" name='appat' readonly="readonly"
                                   <% if (obtencionAdecuada) {%>
                                   value="<%=appat%>"
                                   <%}%>
                                   onchange="return validarString(this, false, false)"
                                   ondrag="return validarString(this, false, false)"
                                   ondrop="return validarString(this, false, false)">
                            <div class='input-group-append'>
                                <button class="btn btn-info" onclick='return cambiarEstado("appat")'>Editar</button>
                            </div>
                        </div>
                        <div class="input-group mb-3">		 
                            <div class="input-group-prepend">
                                <span class="input-group-text">Apellido Materno:</span>
                            </div>
                            <input type="text" class="form-control" id="apmat" name='apmat' readonly="readonly"
                                   <% if (obtencionAdecuada) {%>
                                   value="<%=apmat%>"
                                   <%}%>
                                   onchange="return validarString(this, false, false)"
                                   ondrag="return validarString(this, false, false)"
                                   ondrop="return validarString(this, false, false)">
                            <div class="input-group-append">
                                <button class="btn btn-info" onclick='return cambiarEstado("apmat")'>Editar</button>
                            </div>
                        </div>
                        <div class="input-group mb-3">
                            <div class="input-group-prepend">
                                <span class="input-group-text">Email:</span>
                            </div>
                            <input type="email" class="form-control" id="Email" name='Email' readonly="readonly"
                                   <% if (obtencionAdecuada) {%>
                                   value="<%=correo%>"
                                   <%}%>
                                   onchange="return validarEmail(this)">
                            <div class='input-group-append'>
                                <button class="btn btn-info" onclick='return cambiarEstado("Email")'>Editar</button>
                            </div>
                        </div>
                        <div class="input-group mb-3">		 
                            <div class="input-group-prepend">
                                <span class="input-group-text">Fecha nacimiento:</span>
                            </div>
                            <input type="date" class="form-control" id="fecha_nacimiento" name='fecha_nacimiento' readonly="readonly"
                                   <% if (obtencionAdecuada) {%>
                                   value='<%=fecha_nac%>'
                                   <%}%>
                                   onchange="return validarDate(this)">
                            <div class='input-group-append'>
                                <button class="btn btn-info" onclick='return cambiarEstado("fecha_nacimiento")'>Editar</button>
                            </div>
                        </div>

                        <h4>Contraseña <small>(Si desea combiar su contraseña, ingrese la vieja contraseña y la nueva a establecer)</small>:</h4>
                        <br>
                        <div class="input-group mb-3">		 
                            <div class="input-group-prepend">
                                <span class="input-group-text">Antigua contraseña:</span>
                            </div>
                            <input type="password" class="form-control" id="pwd" name='pwd'
                                   onchange="return validarPass(this)"
                                   ondrag="return validarPass(this)"
                                   ondrop="return validarPass(this)">
                        </div>
                        <div class="input-group mb-3">		 
                            <div class="input-group-prepend">
                                <span class="input-group-text">Nueva contraseña:</span>
                            </div>
                            <input type="password" class="form-control" id="Npwd" name='Npwd'
                                   onchange="return validarPass(this)"
                                   ondrag="return validarPass(this)"
                                   ondrop="return validarPass(this)">
                        </div>
                        <div class="input-group mb-3">		 
                            <div class="input-group-prepend">
                                <span class="input-group-text">Confirmar contraseña:</span>
                            </div>
                            <input type="password" class="form-control" id="Npwd2" name='Npwd2'
                                   onchange="return validarPass(this)"
                                   ondrag="return validarPass(this)"
                                   ondrop="return validarPass(this)">
                        </div>
                        <button type="submit" class="btn btn-dark">
                            Actualizar información
                        </button>
                    </form>
                </div>
                <div class="col-md-2">
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                </div>
            </div>
        </div>
    </body>
    <jsp:include page="Prueba-Reu/my-footer.jsp" />
</html>