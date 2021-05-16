
<%@page import="MDistribucion.Clases.EUsuarioEquipo"%>
<%@page import="MDistribucion.Clases.Equipo"%>
<%@page import="MUsuarios.clases.UsuarioEmpleado"%>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java" session="true"%>
<%
    HttpSession sesion;
    UsuarioEmpleado user;
    Equipo equipo = null;
    boolean procesoCorrecto = true;
    String redirect = "";
    try{
        sesion = request.getSession();
        user = (UsuarioEmpleado) sesion.getAttribute("usuario");
        if(user == null ){
            System.out.println("No hay sesión");
            procesoCorrecto = false;
            redirect = "inicio_sesion.jsp";
        }else{
            equipo = Equipo.obtenerEquipo(EUsuarioEquipo.buscarEquipo(user.getIDUsuarioE()));
        }
    }catch(Exception e){
        e.getMessage();
        e.printStackTrace();
        procesoCorrecto = false;
        redirect = "error.jsp";
    }
    if(!procesoCorrecto){
        response.sendRedirect(redirect);
    }
%>
<!DOCTYPE html>
<html lang='es'>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="utf-8">
        <title>Mi equipo</title>
    <jsp:include page="Prueba-Reu/my-links-boostrap.html" />
    </head>
    <body>
        <jsp:include page="Prueba-Reu/my-head2.jsp" />
        
        <div class="row">
            <div class="col-md-3"></div>
            <div class="col-md-6 card text-white align-items-center" style="background-color: #6c757d">
                <div class="card-header">
                    <h2 class="card-title" style="color: white">Mi equipo</h2>
                </div>
                <div class="card-body">
                    <div class="card-text">
                        Usted pertenece al equipo: <strong><%=equipo.getNombre()%></strong>
                    </div>
                    <br>
                    <a class="btn btn-dark" href="listaDeEmpleados.jsp">Ver integrantes del equipo</a>
                </div>
            </div>
        </div><br><br>
    </body>
    <jsp:include page="Prueba-Reu/my-footer.jsp" />
</html>
