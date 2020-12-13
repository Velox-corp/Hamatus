<%-- 
    Document   : editarEquipo
    Created on : 8/12/2020, 01:39:12 AM
    Author     : maste
--%>

<%@page import="MDistribucion.Clases.Equipo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="MUsuarios.clases.UsuarioEmpleado"%>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java" session="true"%>

<%
    String redirect = "";
    boolean desempeño_adecuado = true;
    HttpSession sesion;
    ArrayList<UsuarioEmpleado> empleadosEquipo = new ArrayList<UsuarioEmpleado>();
    ArrayList<UsuarioEmpleado> empleadosLibres = new ArrayList<UsuarioEmpleado>();
    int id_equipo;
    Equipo equipo;
    try{
        id_equipo = Integer.parseInt(request.getParameter("id"));
        sesion = request.getSession();
        UsuarioEmpleado liderDiv = (UsuarioEmpleado) sesion.getAttribute("usuario");
        //equipo = ?;
        empleadosEquipo = UsuarioEmpleado.obtenerUsuariosEquipo(liderDiv.getIDUsuarioE()); 
        empleadosLibres = UsuarioEmpleado.obtenerUsuariosEquipo(0); 
    }catch(Exception e){
        redirect = "error.jsp";
        desempeño_adecuado = false;
    }

    if(!desempeño_adecuado){
        response.sendRedirect(redirect);
    }
%>
    
<!DOCTYPE html>
<html lang='es'>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv='X-UA-Compatible' content='IE=edge'>
        
        <title>Hamatus -Edición de equipo <%--equipo.gerNombre_equipo()--%>-</title>
        
        <jsp:include page="Prueba-Reu/my-links-boostrap.html" />
        
    </head>
    
    <body class='container-fluid'>
        <jsp:include page="Prueba-Reu/my-head2.jsp" />
        <br>
        <div class="row">
		<div class="col-md-12 text-center">
                    <h3>Edición del equipo de trabajo <%--equipo.gerNombre_equipo()--%></h3>
		</div>
	</div>
        <br>
        <form method="post" action="crearEquipoTrabajo">
            <input type="hidden" name="empleadosEquipo" value="<%=empleadosEquipo.size()%>">
            <div class="row">
                    <div class="col-md-6 form-group">
                        <label for=nombreEquipo">
                            Nombre del equipo:
                        </label>
                        <input type="text" id='nombreEquipo' name='nombregEquipo'>
                    </div>
                    <div class="col-md-6 form-group">
                        <label for='división'>
                            División correspondiente
                        </label>
                        <input type="text" readonly="readnoly" id='division' name='division'>
                    </div>
            </div>
            <br>
                    <h4 class='text-center'>Empleados del equipo:</h4>
            <br>
            <% //for del equipo
                for (int i = 0; i < empleadosEquipo.size(); i++) {
                    UsuarioEmpleado emp = empleadosEquipo.get(i);
                    int mod = i%3;
                    switch(mod){
                        case 1:
                    %>
            <div class="row">
                    <div class="col-md-4">
                            <div class="card text-white bg-primary">
                                    <h5 class="card-header">
                                            <%=emp.getAppat()%> <%=emp.getApmat()%> <%=emp.getNombre()%>
                                    </h5>
                                    <div class="card-body">
                                        <label for="empleado_<%=emp.getIDUsuarioE()%>">Estado en el equipo:</label>
                                        <!--Pendiente la validación de pertenencía -->
                                        <input type="checkbox" id='empleado_<%=emp.getIDUsuarioE()%>' value='true' name='empleado_<%=emp.getIDUsuarioE()%>'>
                                    </div>
                            </div>
                    </div>
                    <%      break;
                        case 2: %>
                    <div class="col-md-4">
                            <div class="card text-white bg-primary">
                                    <h5 class="card-header">
                                            <%=emp.getAppat()%> <%=emp.getApmat()%> <%=emp.getNombre()%>
                                    </h5>
                                    <div class="card-body">
                                        <label for="empleado_<%=emp.getIDUsuarioE()%>">Incluir en el equipo:</label>
                                        <input type="checkbox" id='empleado_<%=emp.getIDUsuarioE()%>' value='true' name='empleado_<%=emp.getIDUsuarioE()%>'>
                                    </div>
                            </div>
                    </div>
                            <% break;
                        case 0:
                            %>
                    <div class="col-md-4">
                            <div class="card text-white bg-primary">
                                    <h5 class="card-header">
                                            <%=emp.getAppat()%> <%=emp.getApmat()%> <%=emp.getNombre()%>
                                    </h5>
                                    <div class="card-body">
                                        <label for="empleado_<%=emp.getIDUsuarioE()%>">Incluir en el equipo:</label>
                                        <input type="checkbox" id='empleado_<%=emp.getIDUsuarioE()%>' value='true' name='empleado_<%=emp.getIDUsuarioE()%>'>
                                    </div>
                            </div>
                    </div>
            </div>
                <%break;
                }//switch
            }  // for %>
                
            
            <% //for sin equipo
                for (int i = 0; i < empleadosLibres.size(); i++) {
                    UsuarioEmpleado emp = empleadosLibres.get(i);
                    int mod = i%3;
                    switch(mod){
                        case 1:
                    %>
            <div class="row">
                    <div class="col-md-4">
                            <div class="card text-white bg-primary">
                                    <h5 class="card-header">
                                            <%=emp.getAppat()%> <%=emp.getApmat()%> <%=emp.getNombre()%>
                                    </h5>
                                    <div class="card-body">
                                        <label for="empleado_<%=emp.getIDUsuarioE()%>">Estado en el equipo:</label>
                                        <!--Pendiente la nueva forma de asignación -->
                                        <input type="checkbox" id='empleado_<%=emp.getIDUsuarioE()%>' value='true' name='empleado_<%=emp.getIDUsuarioE()%>'>
                                    </div>
                            </div>
                    </div>
                    <%      break;
                        case 2: %>
                    <div class="col-md-4">
                            <div class="card text-white bg-primary">
                                    <h5 class="card-header">
                                            <%=emp.getAppat()%> <%=emp.getApmat()%> <%=emp.getNombre()%>
                                    </h5>
                                    <div class="card-body">
                                        <label for="empleado_<%=emp.getIDUsuarioE()%>">Incluir en el equipo:</label>
                                        <input type="checkbox" id='empleado_<%=emp.getIDUsuarioE()%>' value='true' name='empleado_<%=emp.getIDUsuarioE()%>'>
                                    </div>
                            </div>
                    </div>
                            <% break;
                        case 0:
                            %>
                    <div class="col-md-4">
                            <div class="card text-white bg-primary">
                                    <h5 class="card-header">
                                            <%=emp.getAppat()%> <%=emp.getApmat()%> <%=emp.getNombre()%>
                                    </h5>
                                    <div class="card-body">
                                        <label for="empleado_<%=emp.getIDUsuarioE()%>">Incluir en el equipo:</label>
                                        <input type="checkbox" id='empleado_<%=emp.getIDUsuarioE()%>' value='true' name='empleado_<%=emp.getIDUsuarioE()%>'>
                                    </div>
                            </div>
                    </div>
            </div>
                    <%break;
                    }//switch
                }  // for %>
                
                
            <div class='row'>
                <div class='col-md-12'>
                    <button class='btn btn-success' type="submit">Ejecutar cambios</button>
                </div>
            </div>
        </form>
        <jsp:include page="Prueba-Reu/my-footer.html" />
    </body>
</html>