<%-- 
    Documento   : subirEvidencia
    Fecha y hora de creación: : 29/04/2021, 11:27:31 PM
    Author     : Armando Jarillo
--%>
<%@page import="MDocumentos.Clases.D_Documento"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Hashtable"%>
<%@page import="MUsuarios.clases.UsuarioEmpleado"%>
<%@page import="MUsuarios.clases.Empresa"%>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java" session="true"%>
<!DOCTYPE html>
<html lang='es'>
    <head>
        <meta http-equiv="Content-Type" content="text/html">
        <meta charset="utf-8">
        <title>Subir evidencias</title>
        <jsp:include page="Prueba-Reu/my-links-boostrap.html" />
    </head>
    <body>
        <jsp:include page="Prueba-Reu/my-head2.jsp" />
        <%
            HttpSession sesionUser = request.getSession();
            boolean obtencionAdecuada = false;
            UsuarioEmpleado usuario = null;
            Empresa emp = null;
            try{
                usuario = (UsuarioEmpleado) sesionUser.getAttribute("usuario");
                emp = (Empresa) sesionUser.getAttribute("empresa");
                if(usuario == null || emp == null){
                        System.out.println("No hay sesión");
                        obtencionAdecuada = false;
                        response.sendRedirect("inicio_sesion.jsp");
                    }
            }catch(Exception ex){
                System.out.println("Error");
                System.out.println(ex.getMessage());
                ex.printStackTrace();
                obtencionAdecuada = false;
                response.sendRedirect("error.jsp");
            }
        %>
        <div class="row text-center">
            <h2 class="text-primary text-center col-md-12">Subir evidencía</h2>
        </div>
        <div class="row container align-items-center">
            <div class="card col-md-10">
                    <form class="card-body form-group" action="uploadEvidence" method="POST" enctype="multipart/form-data">
                        <div class="mb-3">
                            <label for="formfile" class="form-label">Insertar archivo <small>(El tamaño del archivo no debe superar los 15 MB)</small></label>
                            <input class="form-control-file" type="file" id="formFile" name="file" required>
                        </div>
                        <label for="pass">Agrege una contraseña al archivo</label>
                        <input class="form-control" name="pass" type="password" placeholder="Inserte contraseña" oncopy="return false" onpaste="return false" autocomplete="off" ondrag="return false"  ondrop="return false" required="required" minlength="10" maxlength="30">
                        <!--
                        <label for="id_tipo_acceso">Elija tipo acceso</label>
                        <select class="form-control" name="id_tipo_acceso">
                            <%--
                                Hashtable<Integer, String> list = D_Documento.consultarCat_Tipo_Acceso();
                                Set<Integer> keys = list.keySet();
                                for (Integer key:keys) {
                                    System.out.println(key);
                                %>
                                <option><%= key %>.<%= list.get(key) %></option>
                                <%
                                }
                            --%> 
                            -->
                        </select>
                        <input name="dictionary" value="<%= list %>" hidden="true">
                        <label for="tipo_archivo">Elija tipo de archivo</label>
                        <select class="form-control" name="tipo_archivo">
                            <option>Digital</option>
                            <option>Escaneado</option>
                        </select>
                        <br>
                        <div class="justify-content-center">
                            <button type="" class="btn btn-dark">
                                Subir Archivo
                            </button>
                            <a href="docs.jsp" class="btn btn-dark">Cancelar</a>
                        </div>
                    </form>
                </div>
        </div>
        <jsp:include page="Prueba-Reu/my-footer.jsp" />
    </body>
</html>
