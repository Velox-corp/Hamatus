<%-- 
    Documento   : MyEquipo
    Fecha y hora de creación: : 3/01/2021, 06:31:59 PM
    Author     : Armando Jarillo
--%>

<%@page import="MDistribucion.Clases.EUsuarioEquipo"%>
<%@page import="MDistribucion.Clases.Equipo"%>
<%@page import="MUsuarios.clases.UsuarioEmpleado"%>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java" session="true"%>
<%
    HttpSession sesion;
    UsuarioEmpleado user;
    Equipo equipo = null;
    boolean procesoCorrecto = true;
    try{
        sesion = request.getSession();
        user = (UsuarioEmpleado) sesion.getAttribute("usuario");
        equipo = Equipo.obtenerEquipo(EUsuarioEquipo.buscarEquipo(user.getIDUsuarioE()));
    }catch(Exception e){
        e.getMessage();
        e.printStackTrace();
        procesoCorrecto = false;
    }
    if(!procesoCorrecto){
        response.sendRedirect("error.jsp");
    }
%>
<!DOCTYPE html>
<html lang='es'>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="utf-8">
        <title>Hamatus -Mi equipo-</title>
    <jsp:include page="Prueba-Reu/my-links-boostrap.html" />
    </head>
    <body>
        <jsp:include page="Prueba-Reu/my-head2.jsp" />
        
        <div class="row">
            <div class="col-md-3"></div>
            <div class="col-md-6 bg-info card text-white align-items-center">
                <div class="card-header">
                     <h2 class="card-title">Mi equipo</h2>
                </div>
                <div class="card-body">
                    <div class="card-text">
                        Usted pertenece al equipo: <strong><%=equipo.getNombre()%></strong>
                    </div>
                    <br>
                    <a class="card-link text-white" href="docs.jsp">Trabaje con su equipo Aquí</a>
                </div>
            </div>
            <div class="col-md-3"></div>
        </div>
        
        <jsp:include page="Prueba-Reu/my-footer.jsp" />
    </body>
</html>
