<%@page import="java.util.Set"%>
<%@page import="MDocumentos.Clases.D_Documento"%>
<%@page import="java.util.Hashtable"%>
<%@page import="MUsuarios.clases.Empresa"%>
<%@page import="MUsuarios.clases.UsuarioEmpleado"%>
<%@page import="java.io.File"%>
<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Documentos</title>

    <meta name="description" content="Source code generated using layoutit.com">
    <meta name="author" content="LayoutIt!">
    
    <jsp:include page="Prueba-Reu/my-links-boostrap.html" />
  </head>
  <body>
      <!-- a reutilizar codigo se a dicho -->
    <jsp:include page="Prueba-Reu/my-head2.jsp" />
    <div class="row margin-top-1rem">
        <div class="col-md-4 folio">
            <ul>
                <li>Archivos del equipo
                    <ul>
                        <%
                        HttpSession sesionUser = request.getSession();
                        boolean obtencionAdecuada = false;
                        UsuarioEmpleado usuario = null;
                        Empresa emp = null;
                        try{
                            usuario = (UsuarioEmpleado) sesionUser.getAttribute("usuario");
                            emp = (Empresa) sesionUser.getAttribute("empresa");
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
                        String ruta = request.getServletContext().getRealPath("/archivos/"
                            +usuario.getiD_Division()+"/"); 
                        System.out.println("La ruta es: " + ruta);
                        if (ruta != null) {        
                            java.io.File file;
                            java.io.File dir = new java.io.File(ruta);
                            String[] list = dir.list();
                            System.out.println(list.length);
                            if (list.length > 0) {
                            //Lista de lo que debe de entrar
                                for (int i=0; i < list.length; i++) {
                                    file = new java.io.File(ruta +"/"+ list[i]);
                                    if (file.isFile()) {

                                %>
                                <li>
                                    <a href="downloadFile?filePath=<%=file.getAbsolutePath()%>&fileName=<%=file.getName()%>" 
                                       target="_top" data-toggle="tooltip" 
                                       title="Descargar" id="<%=file.getAbsolutePath()%>"><%=list[i]%></a>
                                       <a href="#" target="_top" data-toggle="tooltip" title="Eliminar">
                                           <i class="fas fa-trash-alt text-danger"></i>
                                       </a>
                                       <a href="#" target="_top" data-toggle="tooltip" title="Modificar">
                                           <i class="fas fa-edit text-primary"></i>
                                       </a>
                                       <a href="#" target="_top" data-toggle="tooltip" title="Compartir" 
                                          onclick="copy_link('<%=file.getAbsolutePath()%>')">
                                           <i class="fas fa-share text-primary"></i>
                                       </a>
                                </li>
                                <%
                                    }
                                }
                            }else{
                            %>
                                <li>No existen archivos dentro del folder del equipo</li>
                            <%
                            }
                        }else{
                        %>
                        <li>No existe el folder del Equipo por favor almacene un archivo para crear uno</li>
                        <%
                        }
                        %>
                    </ul>
                </li>
            </ul>
        </div>
        <div class="col-md-7">
                <nav>
                    <ul class="pagination">
                        <li class="page-item">
                            <a class="page-link" href="#">Subir</a>
                        </li>
                    </ul>
                </nav>
                <div class="card">
                    <form class="card-body form-group" action="uploadFile" method="POST" enctype="multipart/form-data">
                        <div class="mb-3">
                            <label for="file" class="form-label">Insertar archivo</label>
                            <input class="form-control-file" type="file" id="formFile" name="file" required>
                        </div>
                        <label for="pass">Agrege una contraseña al archivo</label>
                        <input class="form-control" name="pass" type="password" placeholder="Inserte contraseña" required>
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
                        <br>
                        <div class="justify-content-center">
                            <button type="" class="btn btn-primary">
                                Subir Archivo
                            </button>
                            <a href="docs.jsp" class="btn btn-danger">Cancelar</a>
                        </div>
                    </form>
                </div> 
            <br>
        </div>
        <div class="col-md-1">
        </div>
    </div>
    <jsp:include page="Prueba-Reu/my-footer.jsp" />
  </body>
  <script src="./JS/enable_tooltip.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
  <script src="./JS/sweetAlert.js"></script>
</html>
