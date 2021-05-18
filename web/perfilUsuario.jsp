
<%@page import="MDivisiones.clases.Division"%>
<%@page import="MUsuarios.clases.UsuarioEmpleado"%>
<%@page import="MUsuarios.clases.Empresa"%>
<%@page import="MUsuarios.clases.CatPuestos"%>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java" session="true"%>
<!DOCTYPE html>
<html lang='es'>
    <head>
        <meta http-equiv="Content-Type" content="text/html">
        <meta charset="utf-8">
        <title>Perfil De Usuario</title>
        <jsp:include page="Prueba-Reu/my-links-boostrap.html" />
    </head>
    <body>
        <jsp:include page="Prueba-Reu/my-head2.jsp" />
        <%
            HttpSession sesion;
            Empresa emp = null;
            UsuarioEmpleado user = null;
            int id_user = 0;
            try{
                sesion = request.getSession();
                id_user = Integer.parseInt(request.getParameter("id"));
                user = UsuarioEmpleado.getPuestoEmpleadoById(id_user);
            }catch(Exception e){
                
            }
        %>
        <div>
            <div class='col-md-12'>
                <center><h1>Perfil de usuario</h1></center>    
            </div>
        </div><br>
        <main class="container">
            <div class="cubridor2 d-flex justify-content-center align-items-center">
                <div>
                    <center>
                        <div class="container-fliud cubridor2 d-flex justify-content-center align-items-center">
                            <div class="card">
                                <div class="card-body">
                                    <h2><div class="card-title tn"><strong><%=user.getAppat()%> <%=user.getApmat()%> <%=user.getNombre()%></strong></div></h2>
                                    <hr>
                                    <div>
                                        <table>
                                            <tr>
                                                <td>
                                                    <div class="col-md-4"><img src="img/iniciar-sesion.png"></div>
                                                    <br>
                                                </td>
                                                <td>
                                                    <ul class="list-group list-group-flush col-md-12">
                                                        <li class="list-group-item">División: <%=Division.traducirID(user.getiD_Division())%></li>
                                                        <li class="list-group-item">Puesto: <%=CatPuestos.traducirID(user.getiD_cat_priv())%></li>
                                                        <li class="list-group-item">Fecha de nacimiento: <%=user.getFechaNacimiento()%> </li>
                                                        <li class="list-group-item">Correo de contacto: <%=user.getCorreo()%></li>
                                                    </ul>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <a class="btn btn-dark">Enviar mensaje</a>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </center>
                </div>
            </div>
        </main><br>
        <jsp:include page="Prueba-Reu/my-footer.jsp" />
    </body>
</html>
