

<%@page import="MTablones.Clases.Anuncio"%>
<%@page import="java.util.ArrayList"%>
<%@page import="MUsuarios.clases.UsuarioEmpleado"%>
<%@page import="java.sql.*"%>
<%@page language="java" pageEncoding="UTF-8" contentType="text/html"%>

<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>Editar Anuncios</title>


        <jsp:include page="Prueba-Reu/my-links-boostrap.html" />
    </head>
    <body>
        <jsp:include page="Prueba-Reu/my-head2.jsp" />
        <h2 class="text-center">Modificación de anuncios</h2>
        <div class="row margin-top-1rem d-block align-items-center">
            <div class='col-md-3'></div>
            <div class="col-md-6">
                    <%
                    HttpSession sesion;
                    UsuarioEmpleado liderDiv;
                    try{
                        sesion = request.getSession();
                        liderDiv = (UsuarioEmpleado) sesion.getAttribute("usuario");
                        int divEdit = liderDiv.getiD_Division();
                        ArrayList<Anuncio>anuncios = new ArrayList<Anuncio>();
                        anuncios = (ArrayList<Anuncio>)request.getAttribute("anuncios");
                    %>
                    <script src='JS/interaccionBotones.js'></script>
                    <form action="controlA?accion=Update"  class='card' method="post">

                        <% for (int i = 0; i < anuncios.size(); i++) {
                                Anuncio p = anuncios.get(i);
                        %>
                        <div class='card-header'>
                            <input type="hidden" id="idmod" name="idmod" value="<%=p.getId()%>">
                            <input type="hidden" id="id_div" name="id_div" value="<%=divEdit%>">
                                <div class="input-group">
                                    <div class='input-group-prepend'>
                                        <label class='input-group-text' for="mod_titulo">Titulo</label>
                                    </div>
                                    <input type="text" value="<%=p.getTitulo()%>" readonly="readonly" class="form-control" id="mod_titulo" name="mod_titulo" required="required">
                                    <button class='btn btn-info input-group-append' onclick="return cambiarEstado('mod_titulo')">Editar</button>
                                </div>
                                
                        </div>  
                        <div class=" card-body input-group">
                           <div class='input-group-prepend'>
                                <label class='input-group-text' for="mod_descripcion">Descripción:</label>
                            </div>
                            <textarea type="text" readonly="readonly" class="form-control" id="mod_descripcion" name="mod_descripcion" required="required"><%=p.getDescripcion()%></textarea>
                            <button class='btn btn-info input-group-append' onclick="return cambiarEstado('mod_descripcion')">Editar</button>
                        </div>
                        <div class='card-footer'>
                            <button type="submit" name="enviar" class="btn btn-primary">Guardar<i class="fa fa-floppy-o" aria-hidden="true"></i></button>
                        </div>
                        <% } %> 
                    </form> 
                    <%
                        }catch (Exception e) {
                        e.getMessage();
                        e.printStackTrace();
                        response.sendRedirect("error.jsp");
                    }
                    %>
            </div>
        </div>
        <jsp:include page="Prueba-Reu/my-footer.jsp" />
    </body>
</html>
