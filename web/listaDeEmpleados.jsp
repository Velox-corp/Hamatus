
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
                if(user.getiD_cat_priv()== 2){
                    equipo = Integer.parseInt(request.getParameter("id"));
                }
                equipo = EUsuarioEquipo.buscarEquipo(user.getIDUsuarioE());
                usuarios =  UsuarioEmpleado.obtenerUsuariosEquipo(equipo, user.getiD_Division());
                equipos = Equipo.obtenerEquipo(EUsuarioEquipo.buscarEquipo(user.getIDUsuarioE()));
                
            }catch(Exception e){
                e.printStackTrace();
            }
        %>
        <div class='row'>
            <div class='col-md-12'>
                <center><h1>Listado de empleados de <%=equipos.getNombre()%></h1></center>    
            </div>
        </div>
        <br>
        <main class="container">
            <%
                for (int idx = 0; idx < usuarios.size(); idx++) {
                        UsuarioEmpleado userx = usuarios.get(idx);
            %>
            <div class="sec">
                <article>
                    <div class="container_4">
                        <%=userx.getAppat()%> <%=user.getApmat()%> <%=user.getNombre()%> | <%=CatPuestos.traducirID(user.getiD_cat_priv())%>
                        <hr>
                    <div>
                        <table>
                            <tr>
                                <td>
                                    <a class="btn btn-dark" href='perfilUsuario.jsp?id=<%=userx.getIDUsuarioE()%>'>Ver perfíl de usuario</a>
                                </td>
                                <td>
                                    <a class="btn btn-dark">Enviar mensaje</a>
                                </td>
                            </tr>
                        </table>
                    </div>
                    </div>
                </article>
            </div>
            <br>
            <% }
            %>
            
        </main>
    </body>
    <jsp:include page="Prueba-Reu/my-footer.jsp" />
</html>
