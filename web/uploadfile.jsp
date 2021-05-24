<%-- 
    Document   : uploadfile
    Created on : 13/05/2021, 04:06:23 PM
    Author     : taspi
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="MDistribucion.Clases.Equipo"%>
<%@page import="java.util.List"%>
<%@page import="MDocumentos.Clases.M_Documento"%>
<%@page import="java.util.Set"%>
<%@page import="MDocumentos.Clases.D_Documento"%>
<%@page import="java.util.Hashtable"%>
<%@page import="MUsuarios.clases.Empresa"%>
<%@page import="MUsuarios.clases.UsuarioEmpleado"%>
<%@page import="java.io.File"%>
<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Subir documentos</title>
    
    <jsp:include page="Prueba-Reu/my-links-boostrap.html" />
  </head>
  <body>
      <!-- a reutilizar codigo se a dicho -->
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
        }catch(NullPointerException ex){
            System.out.println("Algun error raro de null");
            System.out.println(ex.getMessage());
            ex.printStackTrace();
            obtencionAdecuada = false;
            response.sendRedirect("error.jsp");
        }catch(Exception e){
            System.out.println("Algun error raro");
            System.out.println(e.getMessage());
            e.printStackTrace();
            obtencionAdecuada = false;
            response.sendRedirect("error.jsp");
        }/*
        try {
            String sCarpAct = request.getServletContext().getRealPath("/");
            //String sCarpAct = ServletContext.getRealPath("/");
            System.out.println(sCarpAct);
            File dir = new File(sCarpAct +"/archivos");//Primero creamos el directorio
            if (!dir.exists()) {
                dir.mkdirs();
            }            
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
        int IDequipo = UsuarioEmpleado.consultarID_Equipo(usuario.getIDUsuarioE());
        */
        %>
    <div class="row margin-top-1rem">
        <div class="col-md-2"></div>
        <div class="col-md-8">
                <nav>
                    <ul class="pagination">
                        <li class="page-item">
                            <a class="page-link" style="color: #F3F3F3; background-color: #2291C1" href="uploadfile.jsp">Subir archivos</a>
                        </li>
                        <li class="page-item">
                            <a class="page-link" style="color: #F3F3F3; background-color: #2291C1" href="docs2.jsp">Ver archivos</a>
                        </li>
                    </ul>
                </nav>
                <div class="card">
                    <form class="card-body form-group" action="uploadFile" method="POST" enctype="multipart/form-data">
                        <div class="mb-3">
                            <label for="file" class="form-label">Insertar archivo <small>(El tamaño del archivo no debe superar los 15 MB)</small></label>
                            <input class="form-control-file" type="file" id="formFile" name="file" required>
                        </div>
                        <label for="pass">Agrege una contraseña al archivo</label>
                        <input class="form-control" name="pass" type="password" placeholder="Inserte contraseña" oncopy="return false" onpaste="return false" autocomplete="off" ondrag="return false"  ondrop="return false" required="required" minlength="10" maxlength="30">
                        <label for="q">Agrege una ruta al archivo (de no insertar la ruta solo se guardara en la carpeta principal)</label>
                        <input class="form-control" name="q" type="text" placeholder="/ejemplo" oncopy="return false" onpaste="return false" autocomplete="off" ondrag="return false"  ondrop="return false" minlength="2" maxlength="40">
                        <label for="id_tipo_acceso">Elija tipo acceso</label>
                        <select class="form-control" name="id_tipo_acceso">
                            <%
                                Hashtable<Integer, String> list = D_Documento.consultarCat_Tipo_Acceso();
                                Set<Integer> keys = list.keySet();
                                for (Integer key:keys) {
                                    System.out.println(key);
                                %>
                                <option><%= key %>.<%= list.get(key) %></option>
                                <%
                                }
                            %>
                        </select>
                        <input name="dictionary" value="<%= list %>" hidden="true">
                        <label for="tipo_archivo">Elija tipo de archivo</label>
                        <select class="form-control" name="tipo_archivo">
                            <option>Digital</option>
                            <option>Escaneado</option>
                        </select>
                        <label for="id_cat_clasif_doc">Seleccione si quiere que este archivo sea favorito</label>
                        <select class="form-control" name="id_cat_clasif_doc">
                            <option>Normal</option>
                            <option>Favorito</option>
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
            <br>
        </div>
        <div class="col-md-2"></div>
    </div>
    <jsp:include page="Prueba-Reu/my-footer.jsp" />
  </body>
  <script src="./JS/enable_tooltip.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
  <script src="./JS/sweetAlert.js"></script>
</html>
