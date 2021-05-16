<%-- 
    Document   : docs2
    Created on : 13/05/2021, 06:39:19 PM
    Author     : taspi
--%>

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
                        <tr>
                            <!--Nombre del archivo-->
                            <td>Archivo.txt</td>
                            <td>
                                <center>
                                <a target="_top" data-toggle="tooltip" 
                                     title="Modificar" 
                                     href="mod_docs.jsp?pass=pass&nombre=name">
                                   <i class="fas fa-edit text-dark"></i>
                                </a>
                                </center>
                            </td>
                            <!--Compartir-->
                            <td>
                                <center>
                                <a target="_top" data-toggle="tooltip" title="Compartir" 
                                  onclick="copy_link('Access.jsp?fileName=filename&e=IDequipo')">
                                   <i class="fas fa-share text-dark"></i>
                                </a>
                                </center>
                            </td>
                            <!--Favoritos-->
                            <td>
                                <center>
                                    <a target="_top" data-toggle="tooltip" 
                                         title="Añadir a favoritos" 
                                         href="favoritos?f=id">
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
                        <tr>
                            <!--Nombre del folder-->
                            <td><a target="_top" data-toggle="tooltip" 
                                    title="Ver folder" 
                                    href="docs2.jsp?q=nose">
                                    <i class="far fa-folder text-dark"></i>
                                    Nombre folder
                                </a>
                            </td>
                            <td>
                                <center>
                                <a target="_top" data-toggle="tooltip" 
                                     title="Modificar" 
                                     href="mod_docs.jsp?pass=pass&nombre=name">
                                   <i class="fas fa-edit text-dark"></i>
                                </a>
                                </center>
                            </td>
                            <!--Compartir?-->
                            <td>
                                <center>
                                <a target="_top" data-toggle="tooltip" title="Compartir" 
                                  onclick="copy_link('Access.jsp?fileName=filename&e=IDequipo')">
                                   <i class="fas fa-share text-dark"></i>
                                </a>
                                </center>
                            </td>
                            <!--Favoritos?-->
                            <td>
                                <center>
                                    <a target="_top" data-toggle="tooltip" 
                                         title="Añadir a favoritos" 
                                         href="favoritos?f=id">
                                       <i class="far fa-star" style='color:#ffc107'></i>
                                    </a>
                                </center>
                            </td>
                            <!--Boton borrar?-->
                            <td>
                                <center>
                                <div class="form-check">
                                    <input type="checkbox" class="form-check-input">
                                </div>
                                </center>
                            </td>
                        </tr>
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
