
<%@page import="MDivisiones.clases.Division"%>
<%@page import="MUsuarios.clases.UsuarioEmpleado"%>
<%@page import="MUsuarios.clases.Empresa"%>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java" session="true"%>
<!DOCTYPE html>
<html lang='es'>
    <head>
        <meta http-equiv="Content-Type" content="text/html">
        <meta charset="utf-8">
        <title>Titulo JSP</title>
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
        <main class="row container">
            <div class="card bg-default col-md-10">
                <div class="card-header align-items-center">
                    <div class=" card-title"><%=user.getAppat()%> <%=user.getApmat()%> <%=user.getNombre()%></div>
                </div>
                <div class="card-body row">
                    <div class="col-md-4"><img src="img/iniciar-sesion.png"></div>
                    <ul class="list-group list-group-flush col-md-8">
                        <li class="list-group-item">División: <%=Division.traducirID(user.getiD_Division())%></li>
                        <li class="list-group-item">Fecha nacimiento: <%=user.getFechaNacimiento()%> </li>
                        <li class="list-group-item">Correo de contacto: <%=user.getCorreo()%></li>
                    </ul>
                </div>
                <div class="card-footer">
                    <a class="btn btn-dark" href="#">Enviar mensaje</a>
                </div>
            </div>
        </main>
        <jsp:include page="Prueba-Reu/my-footer.jsp" />
    </body>
</html>
