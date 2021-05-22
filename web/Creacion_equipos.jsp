<%@page import="MDivisiones.clases.Division"%>
<%@page import="java.util.ArrayList"%>
<%@page import="MUsuarios.clases.UsuarioEmpleado"%>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java" session="true"%>

<%
    boolean desempeño_adecuado = true;
    HttpSession sesion;
    ArrayList<UsuarioEmpleado> empleados = new ArrayList<UsuarioEmpleado>();
    UsuarioEmpleado liderDiv = null;
    String redirect = "";
    try{
        //Se supone que uno debe ingresar siendo ya un usuario registrado y con los privilegios adecuados
        sesion = request.getSession();
        liderDiv = (UsuarioEmpleado) sesion.getAttribute("usuario");
        if(liderDiv == null ){
            System.out.println("No hay sesión");
            desempeño_adecuado = false;
            redirect = "inicio_sesion.jsp";
        }else{
            if(liderDiv.getiD_cat_priv() != 3){ //esta función solo debería ejecutarla un lider de división
                desempeño_adecuado = false;
                redirect = "error.jsp";
            }else{
                empleados = UsuarioEmpleado.obtenerUsuariosEquipo(0, liderDiv.getiD_Division()); //RECORDATORIO PARA EL FUTURO, debe traer aparte a los que no tienen equipo
                desempeño_adecuado = true;
            }
        }
    }catch(Exception e){
        desempeño_adecuado = false;
        e.printStackTrace();
        redirect = "error.jsp";
    }

    if(!desempeño_adecuado){
        response.sendRedirect(redirect);
    }
%>
    
<!DOCTYPE html>
<html lang='es'>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset='utf-8'">
        
        <title>Creación de equipos</title>
        
        <jsp:include page="Prueba-Reu/my-links-boostrap.html" />
        
    </head>
    
    <body>
        <jsp:include page="Prueba-Reu/my-head2.jsp" />
        <div class="container margin-top-1rem">
            <center><h1>Crear equipos</h1></center>    
        <br>
        <form method="post" action="crearEquipoTrabajo">
            <input type="hidden" name="maxEmpleados" value="<%=empleados.size()%>">
            <div class="row">
                    <div class="col-md-6 form-group">
                        <label for=nombreEquipo">
                            Nombre del equipo:
                        </label>
                        <input class="h4 form-control" type="text" id='nombreEquipo' name='nombreEquipo' oncopy="return false" onpaste="return false" autocomplete="off" ondrag="return false"  ondrop="return false" required="required" maxlength="30">
                    </div>
                    <div class="col-md-6 form-group">
                        <label for='división'>
                            División correspondiente:
                        </label>
                        <input class="h4 form-control" type="text" readonly="readonly" id='division'  value='<%=Division.traducirID(liderDiv.getiD_Division()) /*está debería cambiar por el nombre de la división*/%>' name='division'>
                        <input type='hidden' readonly="readonly" id='divH' name='divH' value='<%=liderDiv.getiD_Division()%>'>
                    </div>
            </div>
            <%
            if(empleados.size() > 0){ 
                for (int i = 0; i < empleados.size(); i++) {
                    UsuarioEmpleado emp = empleados.get(i);
                    int mod = (i+1)%3;
                    switch(mod){
                        case 1:
                    %>
            <div class="row">
                    <div class="col-md-4">
                            <div class="card text-white" style="background-color: #6c757d">
                                    <h5 class="card-header">
                                            <%=emp.getAppat()%> <%=emp.getApmat()%> <%=emp.getNombre()%>
                                    </h5>
                                    <div class="card-body">
                                        <label for="empleado_<%=(i+1)%>">Incluir en el equipo:</label>
                                        <input type="checkbox" id='empleado_<%=(i+1)%>' value='true' name='empleado_<%=(i+1)%>'>
                                        <input type='hidden' name='idE_<%=(i+1)%>' id='idE_<%=(i+1)%>' value='<%=emp.getIDUsuarioE()%>'>
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
                                   <div class="card-body ">
                                        <label for="empleado_<%=(i+1)%>">Incluir en el equipo:</label>
                                        <input type="checkbox" id='empleado_<%=(i+1)%>' value='true' name='empleado_<%=(i+1)%>'>
                                        <input type='hidden' name='idE_<%=(i+1)%>' id='idE_<%=(i+1)%>' value='<%=emp.getIDUsuarioE()%>'>
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
                                        <label for="empleado_<%=(i+1)%>">Incluir en el equipo:</label>
                                        <input type="checkbox" id='empleado_<%=(i+1)%>' value='true' name='empleado_<%=(i+1)%>'>
                                        <input type='hidden'  name='idE_<%=(i+1)%>' id='idE_<%=(i+1)%>'  value='<%=emp.getIDUsuarioE()%>'>
                                    </div>
                            </div>
                    </div>
            </div>
                                    
                    <%break;
                    }//switch
                }  // for
                if(empleados.size() % 3 != 0){
                    %>
                    </div>
                    <%}
            } else {%>
            <div class='row'>
                <div class='col-md-3'></div>
                <div class="col-md-6 card text-white bg-danger text-center ">
                    <h2 class='card-body text-white '><strong>No hay empleados Disponibles a asignar</strong></h2>
                </div>
            </div>
            <% } %>
                    <br>
                    <div class='row align-items-center'>
                    <div class='col-md-10'>
                        <button class='btn btn-dark btn-large' type="submit">Crear equipo de trabajo</button>
                    </div>
                </div>
            </form>
        <jsp:include page="Prueba-Reu/my-footer.jsp" />
    </body>
</html>
