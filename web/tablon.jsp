<%@page import="MUsuarios.clases.UsuarioEmpleado"%>
<%@page import="ClasesSoporte.Conexion"%>
<%@page import="java.sql.*"%>
<%@page language="java" pageEncoding="UTF-8" contentType="text/html" session = "true" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>Tablon</title>

        <jsp:include page="Prueba-Reu/my-links-boostrap.html" />
    </head>
    <body>
                                    <%
            HttpSession sesion;
            UsuarioEmpleado liderDiv;
            boolean obtencionAdecuada = true;
            String redirect = "";
            int iddivision = 0;
            try{
                sesion = request.getSession();
                liderDiv = (UsuarioEmpleado) sesion.getAttribute("usuario");
                if(liderDiv == null){
                    obtencionAdecuada = false;
                    redirect = "inicio_sesion.jsp";
                }else{
                   iddivision =liderDiv.getiD_Division();
                }
            }catch (Exception e) {
                e.getMessage();
                e.printStackTrace();
                response.sendRedirect("error.jsp");
                obtencionAdecuada = false;
                redirect = "error.jsp";
            }
            if(!obtencionAdecuada){
                response.sendRedirect(redirect);
            }
                    
        %>
        <jsp:include page="Prueba-Reu/my-head2.jsp" />
        <div class="row margin-top-1rem">
            <div class="col-md-3">
            </div>
            <div class="col-md-6">
                
                <div class="card">
                    <h5 class="card-header">
                        Anuncio
                    </h5>
                    <div class="card-body">

                        <form action="controlA?accion=Agregar&iddivision=<%=iddivision%>" method="post">
                            <input type="hidden" id="iddivision" name="iddivision" value="<%=iddivision%>"> 
                            <div class="form-group mb-2">
                                <label for="nombre">Titulo</label>
                                <input type="text" class="form-control" id="tituloa" name="tituloa" placeholder="Titulo" required="required">
                            </div>
                            <div class="form-group mb-2">
                                <label for="descripcion">Descripcion</label>
                                <textarea type="text" class="form-control" id="descripciona" name="descripciona" placeholder="Anuncio" required="required"></textarea>
                            </div>
                            <br>
                            <button type="submit" name="enviar" class="btn btn-primary">Guardar <i class="fa fa-floppy-o" aria-hidden="true"></i></button>
                        </form> 

                    </div>
                </div>

            </div>
            
        </div>
        <br>
       <jsp:include page="Prueba-Reu/my-footer.jsp" />
        
    </body>
</html>