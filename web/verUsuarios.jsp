
<%@page import="MDivisiones.clases.Division"%>
<%@page import="MUsuarios.clases.CatPuestos"%>
<%@page import="MUsuarios.clases.Empresa"%>
<%@page import="java.util.ArrayList"%>
<%@page import="MUsuarios.clases.UsuarioEmpleado"%>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java" session="true"%>

<%
    HttpSession sesion;
    UsuarioEmpleado user = null;
    boolean todoBien = true;
    ArrayList<UsuarioEmpleado> empleados = new ArrayList<UsuarioEmpleado>();
    try{
        sesion = request.getSession();
        user = (UsuarioEmpleado) sesion.getAttribute("usuario");
        Empresa emp = (Empresa) sesion.getAttribute("empresa");
        switch(user.getiD_cat_priv()){ //dentro del catalogo ya sería un empleado proletario
            case 1:
                empleados = UsuarioEmpleado.obtenerUsuarios(emp.getIDEmpresa());
                break;
            case 2:
                empleados = UsuarioEmpleado.obtenerUsuarios(emp.getIDEmpresa());
                break;
            case 3:
                empleados = UsuarioEmpleado.obtenerUsuarios(emp.getIDEmpresa(),user.getiD_Division());
                break;
            case 4:
                todoBien = false;
                break;
            default:
                break;
        }
    }catch(Exception e){
        e.getMessage();
        e.printStackTrace();
        todoBien = false;
    }
    if(!todoBien){
        response.sendRedirect("error.jsp");
    }
%>
    
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Hamatus -Vista de empleados-</title>
        <jsp:include page="Prueba-Reu/my-links-boostrap.html" />
    </head>
    <body>
        <jsp:include page="Prueba-Reu/my-head2.jsp" />
        <div class='row'>
            <div class='col-md-12'>
                <h3 class='text-center'>Empleados</h3>
            </div>
        </div>
        <br>
        <div class="row align-items-center">
            <div class="col-md-12 align-items-center text-center">
                <table class="table table-hover table-responsive  text-center align-items-center">
                    <thead>
                        <tr>
                            <th>Apellido paterno</th>
                            <th>Apellido materno</th>
                            <th>Nombre(s)</th>
                            <th>Fecha nacimiento</th>
                            <th>Correo</th>
                            <th>Division</th>
                            <th>Puesto</th>
                            <th class="text-danger">Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (empleados != null){
                            for (int i = 0; i < empleados.size(); i++) { //va tocar meter alguna función que traduzca los ides de división y jerarquía
                                UsuarioEmpleado empleado = empleados.get(i);%> 
                            <tr>
                                <td><%=empleado.getAppat()%></td>
                                <td><%=empleado.getApmat()%></td>
                                <td><%=empleado.getNombre()%></td>
                                <td><%=empleado.getFechaNacimiento()%></td>
                                <td><%=empleado.getCorreo()%></td>
                                <td><%=Division.traducirID(empleado.getiD_Division())%></td>
                                <td><%=CatPuestos.traducirID(empleado.getiD_cat_priv())%></td>
                                <td class='btn-group-vertical'>
                                    <% if ((empleado.getiD_cat_priv() > 1 && user.getiD_cat_priv() == 1) || (empleado.getiD_cat_priv() > 2 && user.getiD_cat_priv() == 2) || (empleado.getiD_cat_priv() > 3 && user.getiD_cat_priv() == 3)){ %>
                                    <a href='editarPuesto.jsp?id=<%=empleado.getIDUsuarioE()%>'>Cambiar puesto</a>
                                    <a href="borrarEmpleado?id=<%=empleado.getIDUsuarioE()%>" class="active text-danger">Eliminar</a>
                                    <%}else{ %>
                                    Ninguna
                                    <% } %>
                                </td>
                            </tr>
                            
                        <%   }
                        } %>
                    </tbody>
                </table>
                    <br><% if(user.getiD_cat_priv() == 1){ %>
                    <a class='text-center btn btn-dark' href='Administrador_new.jsp'>Agregar más Usuarios</a>
                            <% }%>
            </div>
        </div>
        <jsp:include page="Prueba-Reu/my-footer.jsp" />
    </body>
</html>
