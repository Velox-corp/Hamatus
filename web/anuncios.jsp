<%@page import="MTablones.Clases.Anuncio"%>
<%@page import="java.util.ArrayList"%>
<%@page import="MUsuarios.clases.UsuarioEmpleado"%>
<%@page import="ClasesSoporte.Conexion"%>
<%@page import="java.sql.*"%>
<%@page language="java" pageEncoding="UTF-8" contentType="text/html"%>

<!DOCTYPE html>
<html lang='es'>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Anuncios</title>
        <jsp:include page="Prueba-Reu/my-links-boostrap.html" />
    </head>
    <jsp:include page="Prueba-Reu/my-head2.jsp" />
    <body>
        
        <%
            HttpSession sesion;
            UsuarioEmpleado liderDiv;
            int divPart = 0;
            int divGen = 0;
            ArrayList<Anuncio> anuncios = new ArrayList<Anuncio>();
        %>
        <main class="row">
            <div class="col-md-12"><br>
                <center><h1>Tablón de anuncios</h1></center>
                    <%-- Aquí va tocar meter un for para que se beneren todos los anuncios --%>
                <div class="card bg-default">
                    <div class="table-responsive">
                        <%
                            try {
                                sesion = request.getSession();
                                liderDiv = (UsuarioEmpleado) sesion.getAttribute("usuario");
                                int div = liderDiv.getiD_Division();
                                anuncios = (ArrayList<Anuncio>)request.getAttribute("anuncios");
                                
                        %>
                        
                        <table class="table table-hover">
                            <% for (int i = 0; i < anuncios.size(); i++) {
                                Anuncio ad = anuncios.get(i);
                                if(liderDiv.getiD_Division() == divPart || liderDiv.getiD_Division() == divGen) { 
                            %>
}
                                <thead class="thead-dark" >   
                                    <tr>
                                        <th colspan="4"> Anuncio <%=ad.getVectorTipoTablon()%>: <%=ad.getTitulo()%></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td> <%=ad.getId()%></td>
                                        <td> <%=ad.getDescripcion()%></td>
                                        <td>  <%=ad.getFecha()%> </td>
                                        <td>
                                            <input type="hidden" id="id_div" name="id_div" value="<%=div%>">
                                            <input type="hidden" id="ida" value="$<%=ad.getId()%>">
                                            
                                            <a href="controlA?accion=Delete&ida=<%=ad.getId()%>" id="btnDelete"><i class="fa fa-trash" arial-hidden="true"></i></a>
                                            <a href="controlA?accion=ListarID&ida=<%=ad.getId()%>" id="btnEdit" class="ml-1"><i class="fa fa-pen" arial-hidden="true"></i></a>
                                                
                                        </td>
                                        <%--<jsp:include page="Opciones"/>--%>
                                    </tr>
                                </tbody>
                                <% }else{ %>
                                <thead class="thead-dark" >   
                                    <tr>
                                        <th colspan="3"> Anuncio <%=ad.getVectorTipoTablon()%>: <%=ad.getTitulo()%></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td> <%=ad.getId()%></td>
                                        <td> <%=ad.getDescripcion()%></td>
                                        <td>  <%=ad.getFecha()%> </td> 
                                        </td>
                                        <%--<jsp:include page="Opciones"/>--%>
                                    </tr>
                                </tbody>
                                <% }
                                } %>
                        </table>
                        <% if((liderDiv.getiD_Division() == divPart) || (divPart == 0 && liderDiv.getiD_cat_priv() == 3) || (liderDiv.getiD_Division() == divGen) || (divGen == 0 && (liderDiv.getiD_cat_priv() == 2 || liderDiv.getiD_cat_priv() == 1 )) ) {  %>
                            <a href="tablon.jsp" id="btnAdd"><i class="far fa-plus-square" arial-hidden="true">Agregar Nuevo</i></a>
                        <% } 
                         }catch (Exception e) {
                                    e.getMessage();
                                    e.printStackTrace();
                                }
                        %> 
                    </div>
                </div>
            </div>
        </main>
    </body>
    <jsp:include page="Prueba-Reu/my-footer.jsp" />
</html>
