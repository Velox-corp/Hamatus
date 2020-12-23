
<%@page import="java.util.ArrayList"%>
<%@page import="MUsuarios.clases.UsuarioEmpleado"%>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java" session="true"%>

<%
    HttpSession sesion;
    UsuarioEmpleado user;
    boolean todoBien = true;
    ArrayList<UsuarioEmpleado> empleados = new ArrayList<UsuarioEmpleado>();
    try{
        sesion = request.getSession();
        user = (UsuarioEmpleado) sesion.getAttribute("usuario");
        if (user.getiD_cat_priv() > 3){ //dentro del catalogo ya sería un empleado proletario
            todoBien = false;
        }else{
            empleados = UsuarioEmpleado.obtenerUsuarios(user.getIDUsuarioE());
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
        <title>Hamatus -vista de empleados-</title>
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
            <div class="col-md-11 align-items-center">
                <table class="table table-hover table-responsive">
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
                                <td>{Nombre_division}</td>
                                <td>{detalle_jerarquía}</td>
                                <td><a href="borrarEmpleado?id=<%=empleado.getIDUsuarioE()%>" class="active text-danger">Eliminar</a></td>
                            </tr>
                            
                        <%   }
                        } %>
                    </tbody>
                </table>
            </div>
        </div>
        <jsp:include page="Prueba-Reu/my-footer.html" />
    </body>
</html>
