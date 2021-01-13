<%-- 
    Document   : editarPuesto
    Created on : 28/12/2020, 11:22:06 PM
    Author     : maste
--%>

<%@page import="MUsuarios.clases.Empresa"%>
<%@page import="MUsuarios.clases.CatPuestos"%>
<%@page import="java.util.ArrayList"%>
<%@page import="MDivisiones.clases.Division"%>
<%@page import="MUsuarios.clases.UsuarioEmpleado"%>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java" session="true"%>
<%
    UsuarioEmpleado admin;
    int idEmpleado = 0;
    UsuarioEmpleado empleado = null;
    HttpSession sesion;
    ArrayList<Division> divisiones = new ArrayList<Division>();
    boolean todoBien = true;
    String redirect = "";
    try{
        sesion = request.getSession();
        admin = (UsuarioEmpleado) sesion.getAttribute("usuario");
        if(admin == null){
            todoBien = false;
            redirect = "inicio_sesion.jsp";
        }else{
            if (admin.getiD_cat_priv() > 2){ //dentro del catalogo ya sería un empleado proletario
                todoBien = false;
                redirect = "error.jsp";
            }else{
                idEmpleado = Integer.parseInt(request.getParameter("id"));
                empleado = UsuarioEmpleado.getPuestoEmpleadoById(idEmpleado);
                Empresa emp = (Empresa)sesion.getAttribute("empresa");
                divisiones = Division.obtenerDivisiones(emp.getIDEmpresa());
                //tocaría meter un traductor de ides en la parte de la división
            }
        }
    }catch(Exception e){
        e.getMessage();
        e.printStackTrace();
        todoBien = false;
        redirect = "error.jsp";
    }
    if(!todoBien){
        response.sendRedirect(redirect);
    }
    
%>

<!DOCTYPE html>
<html lang='es'>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cambio de puesto</title>
        <jsp:include page="Prueba-Reu/my-links-boostrap.html" />
    </head>
    <body>
        <jsp:include page="Prueba-Reu/my-head2.jsp" />
        
        <div class='row'>
            <div class='col-md-12 text-center'>
                <h3>Detalle de empleado de <strong><%=empleado.getAppat()%> <%=empleado.getApmat()%> <%=empleado.getNombre()%>.</strong></h3>
            </div>
        </div> <br>
        <form class='' method="POST" role='form' action='cambioDePuesto'>
            <input type="hidden" value="<%=empleado.getIDUsuarioE()%>" name='ideUserCambio'>
            <div class='row'>
                <div class='col-md-6 align-items-center'>
                    <p>División actual: <input type='text' id='oldPuesto' value='<%=Division.traducirID(empleado.getiD_Division())%>' readonly='readonly'></p>
                    <button onclick="return habilitarCampo('newDiv')" class='btn btn-info'>
                        Hacer cambio de división
                    </button><br>
                    <select id='newDiv' name='newDiv' readonly='readonly' onchange='return alterarPuestos()' disabled>
                        <option  value='0' selected>Seleccione la división a donde hacer la transferencía</option>
                                        <% for (int i = 0; i < divisiones.size(); i++) {
                                            Division div = divisiones.get(i); %>
                                            <option value="<%=div.getNombre()%>"> <%=div.getNombre()%></option>
                                        <% } %>
                    </select>
                </div>
                <div class="col-md-6 align-items-center">
                    <p>Privilegios actulales: <input type='text' id='oldPriv' value='<%=CatPuestos.traducirID(empleado.getiD_cat_priv())%>' readonly='readonly'></p>
                    <button onclick="return habilitarCampo('newPriv')" class='btn btn-info'>
                        Hacer cambio de privilegios
                    </button>
                    <select id='newPriv' name='newPriv' readonly='readonly' disabled>
                        <option value='0' selected>Seleccione el nuevo tipo de rango</option>
                        <%switch(empleado.getiD_cat_priv()){
                            case 2: %>
                                <option value='2'>Directivo</option>
                                <% break;
                            case 3: %>
                                <option value='3'>Jefe de área</option>
                                <option value='4'>Empleado general</option>
                                <% break;
                            case 4: %>
                                <option value='3'>Jefe de área</option>
                                <option value='4'>Empleado general</option>
                            <%  break;
                        }%>
                    </select>
                </div>
            </div>
                    <br>
            <div class='row align-items-center'>
                <div class='col-md-12'>
                    <button class='btn btn-success text-center' type="submit">
                        Guardar cambios
                    </button>
                </div>
            </div>
        </form>
                    <script src='JS/editPuesto.js'></script>
        <jsp:include page="Prueba-Reu/my-footer.jsp" />
    </body>
</html>
