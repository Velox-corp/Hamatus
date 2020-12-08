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
    try{
        UsuarioEmpleado usuario = (UsuarioEmpleado) sesion.getAttribute("usuario");
        nombre = usuario.getNombre();
        appat = usuario.getAppat();
        apmat = usuario.getApmat();
        correo = usuario.getCorreo();
        fecha_nac = usuario.getFechaNacimiento();
        obtencionAdecuada = true;
    }catch(NullPointerException e){
        obtencionAdecuada = false;
    }
%>

<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>CRUD</title>

    <meta name="description" content="Source code generated using layoutit.com">
    <meta name="author" content="LayoutIt!">

    <jsp:include page="Prueba-Reu/my-links-boostrap.html" />
  </head>
  <body>

    <jsp:include page="Prueba-Reu/my-head2.jsp" />
    <div class="container-fluid">
	<div class="row margin-top-1rem">
		<div class="col-md-2">
		</div>
		<div class="col-md-8">
                    <div class="container-fluid row justify-content-center">
			<img alt="Bootstrap Image Preview" src="https://www.layoutit.com/img/sports-q-c-140-140-3.jpg" class="rounded-circle">
                    </div>
                    <form role="form" method="POST" action=''>
                                <div class="row form-group justify-content-center">
                                    <label for="InputFile">
						Imagen
                                    </label>
                                    <input type="file" class="form-control-file" id="InputFile">
                                    <p class="help-block">
                                            Inserte imagen del empleado
                                    </p>
				</div>
                                <div class="form-group">		 
                                    <label for="nombre">
                                            Nombre
                                    </label>
                                    <input type="text" class="form-control" id="nombre" name='nombre'
                                           <% if(obtencionAdecuada){%>
                                           value="<%=nombre%>"
                                           <%}%>
                                            onchange="return validarString(this, true, false)"
                               ondrag="return validarString(this, true, false)"
                               ondrop="return validarString(this, true, false)">
				</div>
                                <div class="form-group">		 
                                    <label for="appat">
                                            Apellido paterno
                                    </label>
                                    <input type="text" class="form-control" id="appat" name='appat'
                                           <% if(obtencionAdecuada){%>
                                           value="<%=appat%>"
                                           <%}%>
                                            onchange="return validarString(this, false, false)"
                               ondrag="return validarString(this, false, false)"
                               ondrop="return validarString(this, false, false)">
				</div>
                                <div class="form-group">		 
                                    <label for="apmat">
                                            Apellido materno
                                    </label>
                                    <input type="text" class="form-control" id="apmat" name='apmat'
                                           <% if(obtencionAdecuada){%>
                                           value="<%=apmat%>"
                                           <%}%>
                                            onchange="return validarString(this, false, false)"
                               ondrag="return validarString(this, false, false)"
                               ondrop="return validarString(this, false, false)">
				</div>
				<div class="form-group">
                                    <label for="Email">
                                            Email
                                    </label>
                                    <input type="email" class="form-control" id="Email" name='Email'
                                           <% if(obtencionAdecuada){%>
                                           value="<%=correo%>"
                                           <%}%>
                                           onchange="return validarEmail(this)">>
				</div>
                                <div class="form-group">		 
                                    <label for="fecha_nacimiento">
                                            Fecha de nacimiento
                                    </label>
                                    <input type="date" class="form-control" id="fecha_nacimiento" name='fecha_nacimiento'
                                           <% if(obtencionAdecuada){%>
                                           value='<%=fecha_nac%>'
                                           <%}%>
                                            onchange="return validarDate(this)">
				</div>
				<div class="form-group">
                                    <label for="Puesto">
                                            Puesto
                                    </label>
                                    <input type="text" class="form-control" id="Puesto">
				</div>
                                <div class="form-group">
                                    <label for="equipos">
                                            Equipos
                                    </label>
                                    <input type="text" class="form-control" id="equipos">
				</div>
                                            <br>
				<button type="submit" class="btn btn-primary">
					Actualizar info
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
  <jsp:include page="Prueba-Reu/my-footer.html" />
</html>