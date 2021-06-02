<%@page import="java.util.ArrayList"%>
<%@page import="MDivisiones.clases.Division"%>
<%@page import="MUsuarios.clases.Empresa"%>
<%@page import="MUsuarios.clases.UsuarioEmpleado"%>
<%@page language="java" pageEncoding="UTF-8" contentType="text/html" session="true"%>
<%
    HttpSession sesionAdmin;
    UsuarioEmpleado admin;
    Empresa emp;
    ArrayList<Division> divisiones = new ArrayList<Division>();
    boolean procesocorrecto;
    String redirect = "";
    try {
        sesionAdmin = request.getSession();
        admin = (UsuarioEmpleado) sesionAdmin.getAttribute("usuario");
        if (admin == null) {
            System.out.println("No hay sesión");
            procesocorrecto = false;
            redirect = "inicio_sesion.jsp";
        } else {
            if (admin.getiD_cat_priv() == 1) {
                procesocorrecto = true;
                emp = (Empresa) sesionAdmin.getAttribute("empresa");
                divisiones = Division.obtenerDivisiones(emp.getIDEmpresa());
            } else {
                procesocorrecto = false;
                //divisiones = Divison.getDivisiones();
            }
        }
    } catch (Exception e) {
        e.getMessage();
        e.printStackTrace();
        procesocorrecto = false;
        redirect = "error.jsp";
    }
    if (!procesocorrecto) {
        response.sendRedirect(redirect);
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
                <center><h1>Ingrese un nuevo empleado en el sistema</h1></center>
                <br>
                    <%
                        if (divisiones.size() <= 1) {

                    %>
                <div class="alert alert-warning" role="alert">
                    <strong class="alert-heading h3">¡Aviso!</strong> 
                    <p>Favor de agregar divisiones antes de agregar usuarios.<br><br>
                    <a href="divisiones.jsp" class="active">
                        Agregar divisiones.
                    </a>
                    </p>
                </div>
                
                <% //request.getRequestDispatcher("controlA?accion=home").forward(request, response);
                } else {
                %>
                <form role="form" action='agregarEmpleado' method='POST' onsubmit="return valido(this)" name="registro">
                    <div class="form-group">
                        <label for="nameUser">Nombre:</label>
                        <input type="name" class="form-control" id="nameUser" name="nameUser" 
                               onchange="return validarString(this, true, false)"
                               ondrag="return validarString(this, true, false)"
                               ondrop="return validarString(this, true, false)" oncopy="return false" onpaste="return false" autocomplete="off" ondrag="return false"  ondrop="return false" required="required" maxlength="30">
                    </div>
                    <div class="form-group">
                        <label for="appat">Apellido Paterno:</label>
                        <input type="name" class="form-control" id="appat" name="appat"
                               onchange="return validarString(this, false, false)"
                               ondrag="return validarString(this, false, false)"
                               ondrop="return validarString(this, false, false)" oncopy="return false" onpaste="return false" autocomplete="off" ondrag="return false"  ondrop="return false" required="required" maxlength="30">
                    </div>
                    <div class="form-group">
                        <label for="apmat">Apellido Materno:</label>
                        <input type="name" class="form-control" id="apmat" name="apmat"
                               onchange="return validarString(this, false, false)"
                               ondrag="return validarString(this, false, false)"
                               ondrop="return validarString(this, false, false)" oncopy="return false" onpaste="return false" autocomplete="off" ondrag="return false"  ondrop="return false" required="required" maxlength="30">
                    </div>
                    <div class="form-group">
                        <label for="f_n">Fecha de nacimiento:</label>
                        <input type="date" class="form-control" id="f_n" name="f_n"
                               onchange="return validarDate(this)" oncopy="return false" onpaste="return false" autocomplete="off" ondrag="return false"  ondrop="return false" required="required">
                    </div>
                    <div class="form-group">
                        <label for="email">Dirección de correo electrónico: </label>
                        <input type="email" class="form-control" id="email" name="email"
                               onchange="return validarEmail(this)" oncopy="return false" onpaste="return false" autocomplete="off" ondrag="return false"  ondrop="return false" required="required" maxlength="250">
                    </div>
                    <div class="form-group">
                        <label for="pwd">Contraseña:</label>
                        <input type="password" class="form-control" id="pwd" name="pwd" 
                               onchange="return validarPass(this)" oncopy="return false" onpaste="return false" autocomplete="off" ondrag="return false"  ondrop="return false" required="required" minlength="10" maxlength="30">
                    </div>
                    <div class="form-group">
                        <label for="pwd2">Confirma tu contraseña:</label>
                        <input type="password" class="form-control" id="pwd2" name="pwd2" 
                               onchange="return validarPass(this)" oncopy="return false" onpaste="return false" autocomplete="off" ondrag="return false"  ondrop="return false" required="required" minlength="10" maxlength="30">
                    </div>
                    <hr>
                    <div class="row">
                        <div class="col-md-6">
                            <select class="form-select" name="division" id="division" onchange="return alterarPuestos()">
                                <option  value='cero' selected>Seleccione la división a la que pertenece</option>
                                <% for (int i = 0; i < divisiones.size(); i++) {
                                        Division div = divisiones.get(i);%>
                                <option value="<%=div.getNombre()%>"> <%=div.getNombre()%></option>
                                <% } %>
                            </select>
                            <br>
                            <br>
                            <select class="form-select" id="jerarquia" name="jerarquia">
                                <option value="cero">Seleccione una jerarquia</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <div class="row">

                                <button type="submit" class="btn btn-dark mr">
                                    Guardar empleado
                                </button>
                                <button type="reset" class="btn btn-danger">
                                    Borrar campos
                                </button>
                            </div>
                        </div>
                    </div><br>
                </form>
                <%
                    }
                %>
            </div>
        </div>
        <script src='JS/manejoDivYJer.js'></script>
    </body>
    <jsp:include page="Prueba-Reu/my-footer.jsp" />
</html>