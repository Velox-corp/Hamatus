<%-- 
    Document   : Creacion_equipos
    Created on : 8/12/2020, 12:03:37 AM
    Author     : maste
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="MUsuarios.clases.UsuarioEmpleado"%>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java" session="true"%>

<%
    String redirect = "";
    boolean desempeño_adecuado = true;
    
    UsuarioEmpleado liderDiv = null;
    //insertar aparte el objeto división
    ArrayList<UsuarioEmpleado> empleados = new ArrayList<UsuarioEmpleado>();
    try{
        //Se supone que uno debe ingresar siendo ya un usuario registrado y con los privilegios adecuados
        HttpSession sesion = request.getSession();
        liderDiv = (UsuarioEmpleado) sesion.getAttribute("usuario");
        System.out.println(liderDiv.getNombre());
        empleados = UsuarioEmpleado.obtenerUsuarios(liderDiv.getIDUsuarioE()); //RECORDATORIO PARA EL FUTURO, debe traer aparte a los que no tienen equipo
    }catch(Exception e){
        redirect = "error.jsp";
        desempeño_adecuado = false;
        e.getMessage();
        e.printStackTrace();
        e.getCause();
        e.getStackTrace();
    }

    if(!desempeño_adecuado){
        //response.sendRedirect(redirect);
    }
%>
    
<!DOCTYPE html>
<html lang='es'>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv='X-UA-Compatible' content='IE=edge'>
        
        <title>Hamatus -Creación de equipos-</title>
        
        <jsp:include page="Prueba-Reu/my-links-boostrap.html" />
        
    </head>
    
    <body class='container-fluid'>
        <jsp:include page="Prueba-Reu/my-head2.jsp" />
        <br>
        <div class="row">
		<div class="col-md-12 text-center text-primary">
                    <h3>Creación de nuevo equipo de trabajo</h3>
		</div>
	</div>
        <br>
        <form method="post" action="crearEquipoTrabajo">
            <input type="hidden" name="maxEmpleados" value="<%=empleados.size()%>">
            <div class="row">
                    <div class="col-md-6 form-group">
                        <label for=nombreEquipo">
                            Nombre del equipo:
                        </label>
                        <input type="text" id='nombreEquipo' name='nombreEquipo'>
                    </div>
                    <input type="hidden" name='id_div' value='<%=liderDiv.getiD_Division()%>' readonly='readonly'>
                    <div class="col-md-6 form-group">
                        <label for='división'>
                            División correspondiente
                        </label>
                        <input type="text" readonly="readonly"  name='division' value='<%=liderDiv.getiD_Division()%>'>
                        
                    </div>
            </div>
            <br>
            <%
                for (int i = 0; i < empleados.size(); i++) {
                    UsuarioEmpleado emp = empleados.get(i);
                    int mod = (i+1)%3;
                    switch(mod){
                        case 1:%>
            <div class="row">
                    <div class="col-md-4">
                            <div class="card text-white bg-primary">
                                    <h5 class="card-header">
                                            <%=emp.getAppat()%> <%=emp.getApmat()%> <%=emp.getNombre()%>
                                    </h5>
                                    <div class="card-body">
                                        <label for="empleado_<%=emp.getIDUsuarioE()%>">Incluir en el equipo:</label>
                                        <input type="checkbox" id='empleado_<%=emp.getIDUsuarioE()%>' value='true' name='empleado_<%=emp.getIDUsuarioE()%>'
                                    </div>
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
            <br>
                    <%break;
                    }//switch
                }  // for %>
                <div class='row'>
                    <div class='col-md-12'>
                        <button class='btn btn-success' type="submit">Crear equipo de trabajo</button>
                    </div>
                </div>
        </form>
        <jsp:include page="Prueba-Reu/my-footer.html" />
    </body>
</html>
