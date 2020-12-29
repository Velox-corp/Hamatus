<%-- 
    Document   : editarPuesto
    Created on : 28/12/2020, 11:22:06 PM
    Author     : maste
--%>

<%@page import="MUsuarios.clases.UsuarioEmpleado"%>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java" session="true"%>
<%
    UsuarioEmpleado admin;
    int idEmpleado = 0;
    UsuarioEmpleado empleado = null;
    HttpSession sesion;
    boolean todoBien = true;
    try{
        sesion = request.getSession();
        admin = (UsuarioEmpleado) sesion.getAttribute("usuario");
        if (admin.getiD_cat_priv() > 3){ //dentro del catalogo ya sería un empleado proletario
            todoBien = false;
        }else{
            idEmpleado = Integer.parseInt(request.getParameter("id"));
            empleado = UsuarioEmpleado.getPuestoEmpleadoById(idEmpleado);
            //tocaría meter un traductor de ides en la parte de la división
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
                    <p>División actual: <input type='text' id='oldPuesto' value='' ></p>
                    <button onclick="activarCambio('newDiv')" class='btn btn-info'>
                        Hacer cambio de división
                    </button>
                    <select id='newDiv' name='newDiv'>
                        <!-- Aquí un metodo para sacar todas las divisiones posibles-->
                    </select>
                </div>
                <div class="col-md-6 align-items-center">
                    <p>Privilegios actulales: <input type='text' id='oldPriv' value=''></p>
                    <button onclick="activarCambio('newPriv')" class='btn btn-info'>
                        Hacer cambio de privilegios
                    </button>
                    <select id='newDiv' name='newPriv'>
                        <!-- Aquí un metodo para sacar todas los privilegios posibles-->
                    </select>
                </div>
            </div>
            <div class='row align-items-center'>
                <div class='col-md-12'>
                    <button class='btn btn-success' type="submit">
                        Guardar cambios
                    </button>
                </div>
            </div>
        </form>
        <jsp:include page="Prueba-Reu/my-footer.jsp" />
    </body>
</html>
