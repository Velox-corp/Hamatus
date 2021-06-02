
<%@page import="MDivisiones.clases.Division"%>
<%@page import="MUsuarios.clases.CatPuestos"%>
<%@page import="MUsuarios.clases.Empresa"%>
<%@page import="java.util.ArrayList"%>
<%@page import="MUsuarios.clases.UsuarioEmpleado"%>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java" session="true"%>

<%
    HttpSession sesion;
    UsuarioEmpleado user = null;
    boolean obtencionAdecuada = true;
    String redirect = "";
    ArrayList<UsuarioEmpleado> empleados = new ArrayList<UsuarioEmpleado>();
    ArrayList<Division> divs = new ArrayList<Division>();
    try{
        sesion = request.getSession();
        user = (UsuarioEmpleado) sesion.getAttribute("usuario");
        Empresa emp = (Empresa) sesion.getAttribute("empresa");
        
        if(user == null || emp == null){
            obtencionAdecuada = false;
            redirect = "inicio_sesion.jsp";
        }else{
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
                    obtencionAdecuada = false;
                    redirect = "error.jsp";
                    break;
                default:
                    break;
            }
            divs = Division.obtenerDivisiones(emp.getIDEmpresa());
        }
    }catch(Exception e){
        e.getMessage();
        e.printStackTrace();
        obtencionAdecuada = false;
        redirect = "error.jsp";
    }
    if(!obtencionAdecuada){
        response.sendRedirect(redirect);
    }
%>
    
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Vista de empleados</title>
        <jsp:include page="Prueba-Reu/my-links-boostrap.html" />
    </head>
    <body>
        <jsp:include page="Prueba-Reu/my-head2.jsp" />
        <div class='row'>
            <div class='col-md-12'>
                <center><h1>Empleados</h1></center>    
            </div>
        </div>
        <br>
        <div class="row margin-top-1rem">
		<div class="col-md-1">
		</div>
		<div class="col-md-10">
                <table class="table table-hover table-responsive  text-center align-items-center">
                    <thead>
                        <tr class="ti">
                            <th>Apellido paterno</th>
                            <th>Apellido materno</th>
                            <th>Nombre(s)</th>
                            <th>Fecha nacimiento</th>
                            <th>Correo</th>
                            <th>Division</th>
                            <th>Puesto</th>
                            <th style="background-color: #6c757d">Acciones</th>
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
                                <td>
                                    <% for (int j = 0; j < divs.size(); j++) { 
                                        Division div = divs.get(j);
                                        if(div.getId_Division() == empleado.getiD_Division()){
                                    %>
                                            <%=div.getNombre()%>
                                    <%      break;
                                        }
                                       } %>            
                                    
                                </td>
                                <td><%=CatPuestos.traducirID(empleado.getiD_cat_priv())%></td>
                                <td class='justify-content-center'>
                                    <a htef="#" class="active text-primary">Enviar mensaje<br></a>
                                    <% if ((empleado.getiD_cat_priv() > 1 && user.getiD_cat_priv() == 1) || (empleado.getiD_cat_priv() > 2 && user.getiD_cat_priv() == 2) ){ %>
                                    <a href='editarPuesto.jsp?id=<%=empleado.getIDUsuarioE()%>' class="active text-danger">Cambiar puesto<br></a>
                                    <a href="borrarEmpleado?id=<%=empleado.getIDUsuarioE()%>" class="active text-danger">Eliminar<br></a>
                                    <%}else if (empleado.getiD_cat_priv() > 3 && user.getiD_cat_priv() == 3){ %>
                                        <a href="borrarEmpleado?id=<%=empleado.getIDUsuarioE()%>" class="active text-danger">Eliminar</a>
                                    <% } else { %>
                                    Ninguna
                                    <% } %>
                                </td>
                            </tr>
                            
                        <%   }
                        } %>
                    </tbody>
                </table>
                    <hr>
                    <br><% if(user.getiD_cat_priv() == 1){ %>
                    <a class='text-center btn btn-dark' href='Administrador_new.jsp'>Agregar más Usuarios</a>
                            <% }%>
            </div>
        </div><br>
        <jsp:include page="Prueba-Reu/my-footer.jsp" />
    </body>
</html>
