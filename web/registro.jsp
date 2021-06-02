<%@page import="MUsuarios.clases.UsuarioEmpleado"%>
<%@page language="java" pageEncoding="UTF-8" contentType="text/html" session="true"%>
<% 
    HttpSession sesion;
    sesion = request.getSession();
    UsuarioEmpleado userverif = (UsuarioEmpleado) sesion.getAttribute("usuario");
    if(userverif != null){
        response.sendRedirect("empresa.jsp");
    }
%>
<!DOCTYPE html>
<html lang='es'>
<head>
    <meta charset='utf-8'>
    <meta http-equiv='X-UA-Compatible' content='IE=edge'>
    <title>Hamatus</title>
    <jsp:include page="Prueba-Reu/my-links-boostrap.html" />
</head>
<body>
    <jsp:include page="Prueba-Reu/my-head.jsp" />
        <main class="container margin-top-1rem">
            <h1 class="text-center">Registrarse</h1>
            <br>
            <form action="crearEmpresa" method="POST" enctype="multipart/form-data" 
                  onsubmit="return valido(this)" name="registro">
                <div class="row d-flex justify-content-center" >
                    <div class="col-sm-6" id='div_line_right'>
                        <h2 class='text-center'>Información del administrador de la empresa</h2>
                        <hr>
                        <div class="form-group">
                            <label for="nameUser">Nombre:</label>
                            <input type="name" class="form-control" id="nameUser" name="nameUser" 
                                   onchange="return validarString(this, true, false)"
                                   ondrag="return validarString(this, true, false)"
                                   ondrop="return validarString(this, true, false)" oncopy="return false" onpaste="return false" autocomplete="off" ondrag="return false"  ondrop="return false" required="required" maxlength="30" placeholder="Maria">
                          </div>
                        <div class="form-group">
                            <label for="appat">Apellido Paterno:</label>
                            <input type="name" class="form-control" id="appat" name="appat"
                                   onchange="return validarString(this, false, false)"
                                   ondrag="return validarString(this, false, false)"
                                   ondrop="return validarString(this, false, false)" oncopy="return false" onpaste="return false" autocomplete="off" ondrag="return false"  ondrop="return false" required="required" maxlength="30" placeholder="Fernandez">
                          </div>
                        <div class="form-group">
                            <label for="apmat">Apellido Materno:</label>
                            <input type="name" class="form-control" id="apmat" name="apmat"
                                   onchange="return validarString(this, false, false)"
                                   ondrag="return validarString(this, false, false)"
                                   ondrop="return validarString(this, false, false)" oncopy="return false" onpaste="return false" autocomplete="off" ondrag="return false"  ondrop="return false" required="required" maxlength="30" placeholder="Cruz">
                          </div>
                        <div class="form-group">
                            <label for="f_n">Fecha de nacimiento:</label>
                            <input type="date" class="form-control" id="f_n" name="f_n"
                                   onchange="return validarDate(this)" oncopy="return false" onpaste="return false" autocomplete="off" ondrag="return false"  ondrop="return false" required="required" min="1930-01-01" max="2004-01-15">
                          </div>
                        <div class="form-group">
                          <label for="email">Dirección de correo electrónico (correo de la empresa):</label>
                          <input type="email" class="form-control" id="email" name="email"
                                 onchange="return validarEmail(this)" oncopy="return false" onpaste="return false" autocomplete="off" ondrag="return false"  ondrop="return false" required="required" maxlength="250" placeholder="Empresa@gmail.com">
                        </div>
                        <label>* La contraseña debe de tener como minimo 10 caracteres</label><br>
                        <div class="form-group">
                          <label for="pwd">Contraseña:</label>
                          <input type="password" class="form-control" id="pwd" name="pwd" 
                                 onchange="return validarPass(this)" oncopy="return false" onpaste="return false" autocomplete="off" ondrag="return false"  ondrop="return false" required="required" minlength="10" maxlength="30">
                        </div>
                        <div class="form-group">
                            <label for="pwd2">Confirmar contraseña:</label>
                            <input type="password" class="form-control" id="pwd2" name="pwd2" 
                                   onchange="return validarPass(this)" oncopy="return false" onpaste="return false" autocomplete="off" ondrag="return false"  ondrop="return false" required="required" minlength="10" maxlength="30">
                          </div>
                    </div>
                <div class="col-sm-6" id='div_line_left'>
                    <br>
                    <h2 class="text-center">Información de la Empresa</h2>
                        <hr>
                        <div class="form-group">
                            <label for="nameEmpresa">Nombre de la empresa:</label>
                            <input type="name" class="form-control" id="nameEmpresa" name="nameEmpresa"
                                   onchange="return validarString(this, true, false)"
                                   ondrag="return validarString(this, true, false)"
                                   ondrop="return validarString(this, true, false)" oncopy="return false" onpaste="return false" autocomplete="off" ondrag="return false"  ondrop="return false" required="required" placeholder="Velox">
                          </div>
                        <div class="form-group">
                            <label for="description">Descripción:</label>
                            <textarea class="form-control" id="description" name="description" rows="3" 
                                        onchange="return validarStringLong(this)"
                                        onkeydown="return validarStringLongTecla(event,this)"
                                        oninput="contadorCatacteres(event)"
                                        maxlength="200" 
                                        autocomplete="off" ondrag="return false"  
                                        required="required" placeholder="Empresa desarrolladora de servicios web"></textarea>
                            <span id="contador">0/200</span>
                        </div>
                        <div class="form-group">
                            <label for="logo">Logo (Opcional): </label>
                            <input type="file"  accept="image/gif,image/jpeg,image/jpg,image/png" aclass="form-control-file" id="logo" name="logo">
                        </div>
                         <div class="form-group">
                            <label for="razonSocial">Razón Social:</label>
                            <input type="name" class="form-control" id="razonSocial" name="razonSocial"
                                   onchange="return validarString(this, true, true)"
                                   ondrag="return validarString(this, true, true)"
                                   ondrop="return validarString(this, true, true)" oncopy="return false" onpaste="return false" autocomplete="off" ondrag="return false"  ondrop="return false" required="required" placeholder="Velox S. en C. por A.">
                          </div>
                        
                    </div>
                </div>
                <hr>
                <div class="row d-flex justify-content-left">
                    <div class="col-md-12">
                        <label>* Para poder registrarse, es necesario que lea y acepte nuestros Términos y condiciones</label>
                        <div class="form-group">
                            <input type="checkbox" id='tYc' value='true' name='tYc' required="required">
                            <label for="tYc">Acepto los <a href="Terminos_Condiciones.pdf" target="_blank">Términos y condiciones</a></label>
                        </div>
                        <hr>
                        <div class="form-group">
                            <label class="col-md-4 control-label" for="submit"></label>
                            <div class="col-md-8">
                              <button id="submit" name="submit" class="btn btn-dark" value="1">Registrar</button>
                              <button class="btn btn-danger" type="reset" >Limpiar formulario</button>
                            </div>
                          </div>
                    </div>
                </div>
            </form>
        </main>
</body>
<jsp:include page="Prueba-Reu/my-footer.jsp" />
</html>