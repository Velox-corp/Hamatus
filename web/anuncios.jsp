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
            UsuarioEmpleado liderDiv = null;
            int div  = 0;
            ArrayList<Anuncio> anuncios = new ArrayList<Anuncio>();
        %>
        <main class="container">
                <center><h1>Tablón de anuncios</h1></center>
                <br>
                        <%
                            try {
                                sesion = request.getSession();
                                liderDiv = (UsuarioEmpleado) sesion.getAttribute("usuario");
                                div= liderDiv.getiD_Division();
                                anuncios = (ArrayList<Anuncio>)request.getAttribute("anuncios");
                            
                            }catch (Exception e) {
                                    e.getMessage();
                                    e.printStackTrace();
                                }
                        %>
                        
                            <% for (int i = 0; i < anuncios.size(); i++) {
                                Anuncio ad = anuncios.get(i);
                                %>
                                <div class="card  container-fluid">
                                    <div class="card-header text-white bg-dark row h4 " >  
                                        <div class="col-md-7 text-left">
                                            Anuncio <%=ad.getVectorTipoTablon()%>: <%=ad.getTitulo()%>
                                        </div>
                                        <div class="col-md-4 text-right">
                                            <%=ad.getFecha()%>
                                        </div>
                                            <%
                                        if((liderDiv.getiD_cat_priv() == 3 && ad.getVectorTipoTablon().equals("particular")) || (liderDiv.getiD_cat_priv() <= 2 && ad.getVectorTipoTablon().equals("general")) ) { 
                                        %>
                                            <div class="col-md-1">
                                                <a href="controlA?accion=Delete&ida=<%=ad.getId()%>" id="btnDelete"><i class="fa fa-trash" arial-hidden="true"></i></a>
                                                <a href="controlA?accion=ListarID&ida=<%=ad.getId()%>" id="btnEdit" class="ml-1"><i class="fa fa-pen" arial-hidden="true"></i></a>
                                            </div>
                                        <% } %>
                                    </div>
                                    <div class="card-body">
                                            <%=ad.getDescripcion()%>
                                            <input type="hidden" id="id_div" name="id_div" value="<%=div%>">
                                            <input type="hidden" id="ida" value="$<%=ad.getId()%>">
                                    </div>
                                    
                                </div>
                                <br>
                                 <% } %>
                        <% if( liderDiv.getiD_cat_priv() <= 3 ) {  %>
                            <a href="tablon.jsp" id="btnAdd"><i class="far fa-plus-square" arial-hidden="true">Agregar Nuevo</i></a>
                        <% } %> 
        </main>
    </body>
    <jsp:include page="Prueba-Reu/my-footer.jsp" />
</html>
