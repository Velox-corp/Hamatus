<%-- 
    Documento   : listaDeEmpleados
    Fecha y hora de creación: : 7/04/2021, 05:16:34 PM
    Author     : Armando Jarillo
--%>
<%@page import="MDistribucion.Clases.EUsuarioEquipo"%>
<%@page import="java.util.ArrayList"%>
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
            UsuarioEmpleado user = null;
            int equipo = 0;
            ArrayList<UsuarioEmpleado> usuarios = new ArrayList<UsuarioEmpleado>();
            try{
                sesion = request.getSession();
                user = (UsuarioEmpleado)sesion.getAttribute("usuario");
                if(user.getiD_cat_priv()== 2){
                    equipo = Integer.parseInt(request.getParameter("id"));
                }
                equipo = EUsuarioEquipo.buscarEquipo(user.getIDUsuarioE());
                usuarios =  UsuarioEmpleado.obtenerUsuariosEquipo(equipo, user.getiD_Division());
                
            }catch(Exception e){
                e.printStackTrace();
            }
        %>
        <main class="container">
            <h3>Listado de empleados</h3>
            <br>
            <%
                for (int idx = 0; idx < usuarios.size(); idx++) {
                        UsuarioEmpleado userx = usuarios.get(idx);
            %>
            <div class="row  bg-primary">
                <div class='card-header align-items-center'>
                    <span class='card-title'><%=userx.getAppat()%> <%=user.getApmat()%> <%=user.getNombre()%> </span>
                </div>
                <div class="card-body align-items-center">
                    <a href="perfilUsuario?id=<%=userx.getIDUsuarioE()%>">Ver perfíl de usuario</a>
                    <br><br>
                    <a>Enviar mensaje</a>
                </div>
            </div
            <br>
            <% }
            %>
            
        </main>
        <jsp:include page="Prueba-Reu/my-footer.jsp" />
    </body>
</html>