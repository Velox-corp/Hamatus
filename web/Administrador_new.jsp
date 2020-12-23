<%@page import="MUsuarios.clases.Empresa"%>
<%@page import="MUsuarios.clases.UsuarioEmpleado"%>
<%@page language="java" pageEncoding="UTF-8" contentType="text/html" session="true"%>
<%
    HttpSession sesionAdmin;
    UsuarioEmpleado admin;
    //ArrayList <Division> divisiones = new ArrayList<Division>();
    boolean procesocorrecto =  true;
    try{
        sesionAdmin = request.getSession();
        admin = (UsuarioEmpleado)sesionAdmin.getAttribute("usuario");
        if (admin.getiD_cat_priv() != 1){
            procesocorrecto = false;
            
        }else{
            //divisiones = Divison.getDivisiones();
        }
        procesocorrecto = true;
    }catch(Exception e){
        e.getMessage();
        e.printStackTrace();
        procesocorrecto = false;
    }
    if(!procesocorrecto){
        response.sendRedirect("error.jsp");
    }
%>
<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Administrador</title>

    <meta name="description" content="Source code generated using layoutit.com">
    <meta name="author" content="LayoutIt!">

    <jsp:include page="Prueba-Reu/my-links-boostrap.html" />

  </head>
  <body>

        <jsp:include page="Prueba-Reu/my-head2.jsp" />
        
	<div class="row margin-top-1rem">
		<div class="col-md-2">
		</div>
		<div class="col-md-8">
			<h3 class="text-center">
				Ingrese un nuevo empleado en el sistema
			</h3>
			<form role="form" action='agregarEmpleado'>
                            <div class="form-group">
                            <label for="nameUser">Nombre:</label>
                            <input type="name" class="form-control" id="nameUser" name="nameUser" 
                                   onchange="return validarString(this, true, false)"
                                   ondrag="return validarString(this, true, false)"
                                   ondrop="return validarString(this, true, false)">
                          </div>
                            <div class="form-group">
                                <label for="appat">Apellido Paterno:</label>
                                <input type="name" class="form-control" id="appat" name="appat"
                                       onchange="return validarString(this, false, false)"
                                       ondrag="return validarString(this, false, false)"
                                       ondrop="return validarString(this, false, false)">
                           </div>
                            <div class="form-group">
                                <label for="apmat">Apellido Materno:</label>
                                <input type="name" class="form-control" id="apmat" name="apmat"
                                       onchange="return validarString(this, false, false)"
                                       ondrag="return validarString(this, false, false)"
                                       ondrop="return validarString(this, false, false)">
                              </div>
                            <div class="form-group">
                                <label for="f_n">Fecha de nacimiento:</label>
                                <input type="date" class="form-control" id="f_n" name="f_n"
                                       onchange="return validarDate(this)">
                              </div>
                            <div class="form-group">
                              <label for="email">Direccion de correo: (correo de la empresa)</label>
                              <input type="email" class="form-control" id="email" name="email"
                                     onchange="return validarEmail(this)">
                            </div>
                            <div class="form-group">
                              <label for="pwd">Contraseña:</label>
                              <input type="password" class="form-control" id="pwd" name="pwd" 
                                     onchange="return validarPass(this)">
                            </div>
                            <div class="form-group">
                                <label for="pwd2">Confirma tu contraseña:</label>
                                <input type="password" class="form-control" id="pwd2" name="pwd2" 
                                       onchange="return validarPass(this)">
                            </div>
                            <div class="form-group">
                                    <label for="Img">
                                            Imagen
                                    </label>
                                    <input type="file" class="form-control-file" id="Img">
                                    <!--<p class="help-block">
                                            Example block-level help text here.
                                    </p>-->
                            </div>
                            <div class="row">
                                <div class="col-md-2">
                                    <div class="dropdown">
                                        <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
                                            Aquí debería seleccionarse  la división o el puesto o tener para ambos
                                        </button>
                                        <div class="dropdown-menu">
                                          <a class="dropdown-item" href="#">Link 1</a>
                                          <a class="dropdown-item" href="#">Link 2</a>
                                          <a class="dropdown-item" href="#">Link 3</a>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-7"></div>
                                <div class="col-md-3">
                                    <div class="row">
                                        <button type="submit" class="btn btn-primary">
                                                Guardar empleado
                                        </button>
                                        <button type="reset" class="btn btn-danger">
                                                Borrar campos
                                        </button>
                                    </div>
                                </div>
                            </div>
			</form>
		</div>
		<div class="col-md-2">
		</div>
	</div>
  </body>
  <jsp:include page="Prueba-Reu/my-footer.html" />
</html>