
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
    int idEquipo = 0;
    try{
        sesion = request.getSession();
        user = (UsuarioEmpleado) sesion.getAttribute("usuario");
        if(user == null ){
            System.out.println("No hay sesión");
            procesoCorrecto = false;
            redirect = "inicio_sesion.jsp";
        }else{
            idEquipo = EUsuarioEquipo.buscarEquipo(user.getIDUsuarioE());
            if(idEquipo !=0 && idEquipo!= -1){
                equipo = Equipo.obtenerEquipo(idEquipo);
            }
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
        <title>Mi Equipo</title>
    <jsp:include page="Prueba-Reu/my-links-boostrap.html" />
    </head>
    <body>
        <jsp:include page="Prueba-Reu/my-head2.jsp" />
        <br>
        <main class="container">
            <div class="cubridor2 d-flex justify-content-center align-items-center">
                <div>
                    <center>
                        <div class="container-fliud cubridor2 d-flex justify-content-center align-items-center">
                            <% if(idEquipo == 0 || idEquipo == -1){ %>
                                <div class="card">
                                    <div class="card-header bg-danger">
                                        <h2 class="card-title text-center text-white">No se posee equipo</h2>
                                    </div>
                                    <div class="card-body text-secondary">
                                        En estos momentos, usted no posee un equipo de trabajo, lo que limita sus acciones dentro de la plataforma, favor de ponerse en contancto con el líder de división respectivo para ser asignado a algún equipo
                                        
                                    </div>
                                </div>
                            <% }else{ %>
                                <div class="card">
                                    <div class="card-body">
                                        <H1>Mi equipo</H1>
                                        <hr>
                                        <label><br>Usted pertenece al equipo: <strong><%=equipo.getNombre()%></strong></label>
                                        <br><br>
                                        <a class="btn btn-dark" href="listaDeEmpleados.jsp?id=<%=equipo.getIDEquipo()%>">Ver integrantes del equipo</a>
                                        <br><br>
                                        <a class="btn btn-dark" href="docs.jsp">Trabajar con el equipo</a>
                                        <br><br>
                                    </div>
                                </div>
                            <% }%>
                        </div>
                    </center>
                </div>
            </div>
        </main>
        <br>
    </body>
    <jsp:include page="Prueba-Reu/my-footer.jsp" />
</html>
