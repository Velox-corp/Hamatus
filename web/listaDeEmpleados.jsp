
<%@page import="MDistribucion.Clases.EUsuarioEquipo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="MUsuarios.clases.UsuarioEmpleado"%>
<%@page import="MUsuarios.clases.Empresa"%>
<%@page import="MDistribucion.Clases.Equipo"%>
<%@page import="MUsuarios.clases.CatPuestos"%>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java" session="true"%>
<!DOCTYPE html>
<html lang='es'>
    <head>
        <meta http-equiv="Content-Type" content="text/html">
        <meta charset="utf-8">
        <title>Lista De Empleados</title>
        <jsp:include page="Prueba-Reu/my-links-boostrap.html" />
    </head>
    <body>
        <jsp:include page="Prueba-Reu/my-head2.jsp" />
        <%
            HttpSession sesion;
            UsuarioEmpleado user = null;
            Equipo equipos = null;
            int equipo = 0;
            ArrayList<UsuarioEmpleado> usuarios = new ArrayList<UsuarioEmpleado>();
            try{
                sesion = request.getSession();
                user = (UsuarioEmpleado)sesion.getAttribute("usuario");
                equipo = Integer.parseInt(request.getParameter("id"));
                 
                usuarios =  UsuarioEmpleado.obtenerUsuariosEquipo(equipo, user.getiD_Division());
                equipos = Equipo.obtenerEquipo(equipo);
                
            }catch(Exception e){
                e.printStackTrace();
            }
        %>
        <div><br>
            <div class='col-md-12'>
                <center><h1>Listado de empleados de <%=equipos.getNombre()%></h1></center>    
            </div>
        </div>
        <br>
        <main class="container">
            <%
                if(!usuarios.isEmpty()){
                for (int idx = 0; idx < usuarios.size(); idx++) {
                        UsuarioEmpleado userx = usuarios.get(idx);
            %>
            <div class="cubridor3 d-flex justify-content-center align-items-center">
                <div class="container_6">
                    <img alt="Bootstrap Image Preview" src="img/integrante.png">
                </div>
                <div>
                    <center>
                        <div class="container-fliud cubridor3 d-flex justify-content-center align-items-center">
                            <div class="card container_5">
                                <div class="card-body">
                                    <%=userx.getAppat()%> <%=userx.getApmat()%> <%=userx.getNombre()%> | <%=CatPuestos.traducirID(userx.getiD_cat_priv())%>
                                    <hr>
                                    <table>
                                        <tr>
                                            <td class="td2">
                                                <a class="btn btn-dark" href='perfilUsuario.jsp?id=<%=userx.getIDUsuarioE()%>'>Ver perfíl de usuario</a>
                                            </td>
                                            <td class="td2">
                                                <a href="agregarSala?id_sala_tipo=1&&id_contacto=<%=userx.getIDUsuarioE()%>" class="btn btn-secondary btn-large">Enviar mensaje</a>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </center>
                </div>
            </div><br>
            <% }
            }else{
            %>  
            <div> <!--mentale diseño por mi-->
                No hay usuarios en este equipo
            </div>
            <% }%>
        </main>
    </body><br>
    <jsp:include page="Prueba-Reu/my-footer.jsp" />
</html>