<%-- 
    Document   : docs2
    Created on : 13/05/2021, 06:39:19 PM
    Author     : taspi
--%>

<%@page import="MDistribucion.Clases.Equipo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="MDocumentos.Clases.D_Documento"%>
<%@page import="MDocumentos.Clases.M_Documento"%>
<%@page import="java.io.File"%>
<%@page import="MUsuarios.clases.Empresa"%>
<%@page import="MUsuarios.clases.UsuarioEmpleado"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Documentos</title>
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
        }
        //Esta es la query de la ubucación de los archivos
        String query = "";
        int IDequipo = UsuarioEmpleado.consultarID_Equipo(usuario.getIDUsuarioE());
        try {
            String sCarpAct = request.getServletContext().getRealPath("/");
            System.out.println(sCarpAct);
            File dir = new File(sCarpAct +"/archivos");
            if (!dir.exists()) {//Verificamos que exista el directorio
                dir.mkdirs();
            }
            query = request.getParameter("q") + "/";
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
        String ruta_j = request.getServletContext().getRealPath("/archivos/"
                            +String.valueOf(IDequipo)+"/"+(query != null ? query : ""));
        %>
        <div class="row margin-top-1rem">
            <div class="col-md-1"></div>
            <div class="col-md-3 folio">
                <!--Aqui adentro vendran los botones de favoritos y documentos-->
                <!--Caray porque no me salen como los botones de arriba UnU ni modo-->
                <nav>
                    <ul class="div-like-btn">
                        <li class="list-item-style-none">
                            <a href="#">VER ARCHIVOS</a>
                        </li>
                        <li class="list-item-style-none">
                            <a href="#">VER FAVORITOS</a>
                        </li>
                    </ul>
                </nav>
            </div>
            <div class="col-md-7">
                <!--Tabla visualizadora de archivos-->
                <table class="table">
                    <thead>
                      <tr>
                        <th>Nombre del archivo</th>
                        <th><center>Modificar</center></th>
                        <th><center>Compartir</center></th>
                        <th><center>Favoritos</center></th>
                        <th>
                            <center>
                                <button type="button" class="btn btn-danger"
                                     data-toggle="tooltip" data-placement="top"
                                     title="Si deseas borrar un archivo tienes que 
                                     seleccionar almenos una casilla"
                                     >Borrar</button>
                            </center>
                        </th>
                      </tr>
                    </thead>
                    <tbody>
                        <!--Empieza la diversion UwU-->
                        <%
                        if (usuario.getiD_cat_priv() == 3) {
                            //Bueno bueno aqui vamos basicamente la idea es que vea todos 
                            //los archivos de todos los equipos
                            ArrayList<Equipo> equipos = Equipo.obtenerEquipos(usuario.getiD_Division());
                            
                            for(Equipo eq: equipos){
                                if (ruta_j != null) {        
                                    java.io.File file_j;
                                    java.io.File dir_j = new java.io.File(ruta_j);
                                    String[] list_j = dir_j.list();
                                    System.out.println(list_j.length);
                                    if (list_j.length > 0) {
                                        //Lista de lo que debe de entrar
                                        for (int i=0; i < list_j.length; i++) {
                                            file_j = new java.io.File(ruta_j +"/"+ list_j[i]);
                                            if (file_j.isFile()) {
                                                M_Documento mdoc = new M_Documento();
                                                D_Documento ddoc = new D_Documento();
                                                //Definimos primero a ddoc
                                                ddoc.ConsultarD_Doc(eq.getIDEquipo(), file_j.getName());
                                                mdoc.Consultar_mDoc(ddoc.getId_MDocumento(), ddoc.getID_Documento());
                        %>
                        <tr>
                            <!--Nombre del archivo-->
                            <td>
                                <a href="downloadFile?e=<%= eq.getIDEquipo() %>&fileName=<%=file_j.getName()%>" 
                                   target="_top" data-toggle="tooltip" 
                                   title="Descargar" id="<%=file_j.getAbsolutePath()%>"
                                   ><%=list_j[i]%></a>
                            </td>
                            <!--modificar-->
                            <td>
                                <center>
                                <a target="_top" data-toggle="tooltip" 
                                    title="Modificar" 
                                    href="mod_docs_J.jsp?pass=<%= ddoc.getPass() %>&nombre=<%= ddoc.getNombre() %>&e=<%= ddoc.getEquipo_ID_Equipo() %>">
                                <i class="fas fa-edit text-dark"></i>
                                </a>
                                </center>
                            </td>
                            <!--Compartir-->
                            <td>
                                <center>
                                <a target="_top" data-toggle="tooltip" title="Compartir" 
                                    onclick="copy_link('Access.jsp?fileName=<%=file_j.getName()%>&e=<%= ddoc.getEquipo_ID_Equipo() %>')">
                                    <i class="fas fa-share text-dark"></i>
                                </a>
                                </center>
                            </td>
                            <!--Favoritos-->
                            <td>
                                <center>
                                    <a target="_top" data-toggle="tooltip" 
                                         title="Añadir a favoritos" 
                                         href="fav?f=<%= ddoc.getId() %>">
                                       <i class="far fa-star" style='color:#ffc107'></i>
                                    </a>
                                </center>
                            </td>
                            <!--Boton borrar-->
                            <td>
                                <center>
                                <div class="form-check">
                                    <input type="checkbox" class="form-check-input">
                                </div>
                                </center>
                            </td>
                        </tr>
                        <%
                            }else if(file_j.isDirectory()){
                        %>
                        <tr>
                            <!--Nombre del folder-->
                            <td><a target="_top" data-toggle="tooltip" 
                                    title="Ver folder" 
                                    href="docs2.jsp?q=<%= ruta_j + "/" + file_j.getName() %>">
                                    <i class="far fa-folder text-dark"></i>
                                    <%= file_j.getName() %>
                                </a>
                            </td>
                            <!--modificar nombre carpeta-->
                            <td>
                                <center>
                                <a target="_top" data-toggle="tooltip" 
                                     title="Modificar nombre de la carpeta" 
                                     href="#" onclick="changefolderName(<%= file_j.getName() %>)">
                                   <i class="fas fa-edit text-dark"></i>
                                </a>
                                </center>
                            </td>
                            <!--Compartir?-->
                            <td>
                                <center>
                                    <a>...</a>
                                </center>
                            </td>
                            <!--Favoritos?-->
                            <td>
                                <center>
                                    <a>...</a>
                                </center>
                            </td>
                            <!--Boton borrar?-->
                            <td>
                                <center>
                                    <a target="_top" data-toggle="tooltip" title="Eliminar carpeta" 
                                       href="#" onclick="borrarCarpeta(<%= file_j.getName() %>)">
                                    <i class="fas fa-trash-alt text-dark"></i>
                                    </a>
                                </center>
                            </td>
                        </tr>
                        <%
                            }
                                }
                                    }
                                        }else{
                                    %>
                                    <tr>
                                        <td>
                                        <center>No hay documentos guardados o
                                            carpetas creadas, por favor guardar
                                            un documento o crear una carpeta</center>
                                        </td>
                                    </tr>
                                    <%
                                }
                            }       
                        %>
                    </tbody>
                 </table>
            </div>
            <div class="col-md-1"></div>
        </div>
        <jsp:include page="Prueba-Reu/my-footer.jsp" />
    </body>
    <script src="./JS/enable_tooltip.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
    <script src="./JS/sweetAlert.js"></script>
</html>
