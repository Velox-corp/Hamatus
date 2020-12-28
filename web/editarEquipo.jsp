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
    int id_equipo = 0;
    Equipo equipo = null;
    try{
        try{//Aquí va optener el paramtro, pero si no lo encuentra..
            id_equipo = Integer.parseInt(request.getParameter("id"));
        }catch(NullPointerException e1){
            try{//... va a buscar el paramtreo, y si ni una no otra...
                id_equipo = Integer.parseInt((String)request.getAttribute("id"));
            }catch(NullPointerException e2){
                System.out.println("Ni una ni otra");
                desempeño_adecuado = false; // ... entonces hay un error
            }
        }
        System.out.println("Equipo: "+id_equipo);
        sesion = request.getSession();
        equipo = Equipo.obtenerEquipo(id_equipo);
        UsuarioEmpleado liderDiv = (UsuarioEmpleado) sesion.getAttribute("usuario");
        empleadosEquipo = UsuarioEmpleado.obtenerUsuariosEquipo(id_equipo, 0); 
        empleadosLibres = UsuarioEmpleado.obtenerUsuariosEquipo(0, liderDiv.getiD_Division()); 
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
        
        <title>Hamatus -Edición de equipo <%=equipo.getNombre()%>-</title>
        
        <jsp:include page="Prueba-Reu/my-links-boostrap.html" />
        
    </head>
    
    <body class='container-fluid'>
        <jsp:include page="Prueba-Reu/my-head2.jsp" />
        <br>
        <div class="row">
		<div class="col-md-12 text-center">
                    <h3>Edición del equipo de trabajo <%=equipo.getNombre()%></h3>
		</div>
	</div>
        <br>
        
        <div class="row">
            <div class="col-md-12 text-center">
                <h4>Datos del equipo</h4>
            </div>
	</div>
        <br>
            <div class="row">
                    <div class="col-md-6 form-group">
                        <label for=nombreEquipo">
                            Nombre del equipo
                        </label>
                        <input type="text" id='nombreEquipo' name='nombregEquipo' value='<%=equipo.getNombre()%>' readonly="readonly">
                    </div>
                    <div class="col-md-6 form-group">
                        <label for='división'>
                            División correspondiente
                        </label>
                        <input type="text" readonly="readonly" id='division' name='division'>
                    </div>
            </div>
            <br>
            <div class='row'>
                <div class='col-md-12 text-center'>
                    <h4 class='text-center'>Empleados del equipo:</h4>
                </div>
            </div>
                    
            <br>
            <% //for del equipo
                for (int i = 0; i < empleadosEquipo.size(); i++) {
                    UsuarioEmpleado emp = empleadosEquipo.get(i);
                    int mod = (i+1)%3;
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
                                        <a class='btn btn-danger' href='sacarDelEquipo?id=<%=emp.getIDUsuarioE()%>&idE=<%=id_equipo%>'>
                                            Remover empleado del equipo
                                        </a>
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
                                        <a class='btn btn-danger' href='sacarDelEquipo?id=<%=emp.getIDUsuarioE()%>&idE=<%=id_equipo%>'>
                                            Remover empleado del equipo
                                        </a>
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
                                        <a class='btn btn-danger' href='sacarDelEquipo?id=<%=emp.getIDUsuarioE()%>&idE=<%=id_equipo%>'>
                                            Remover empleado del equipo
                                        </a>
                                    </div>
                            </div>
                    </div>
            </div><br>
                <%break;
                }//switch
            }  // for %>
            <br>
            <div class="row">
                <div class="col-md-12 text-center">
                    <h4>Empleados disponibles a añadir</h4>
                </div>
            </div> 
            <br>
            <form method='POST' action='addEmpleadosEquipo'>
                <input type="hidden" name='maxUsers' value='<%=empleadosLibres.size()%>'>
                <input type='hidden' name='idEquipo' value='<%=id_equipo%>'>
            <% //for sin equipo
                for (int i = 0; i < empleadosLibres.size(); i++) {
                    UsuarioEmpleado emp = empleadosLibres.get(i);
                    int mod = (i+1)%3;
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
            </div><br>
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