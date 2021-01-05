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

    <title>Documentos</title>

    <meta name="description" content="Source code generated using layoutit.com">
    <meta name="author" content="LayoutIt!">
    
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
        int IDequipo = UsuarioEmpleado.consultarID_Equipo(usuario.getIDUsuarioE());
        if (usuario.getiD_cat_priv() == 3) {
            //Bueno bueno aqui vamos basicamente la idea es que vea todos 
            //los archivos de todos los equipos
            ArrayList<Equipo> equipos = Equipo.obtenerEquipos(usuario.getiD_Division());
            
    %>
    <div class="row margin-top-1rem">
        <% for(Equipo eq: equipos){%> 
        <div class="col-md-4 folio">
            <ul>
                <li>Archivos del equipo: <%= eq.getNombre() %>
                    <ul>
                        <%String ruta_j = request.getServletContext().getRealPath("/archivos/"
                            +eq.getIDEquipo()+"/"); 
                        System.out.println("La ruta es: " + ruta_j);
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
                                    <li>
                                        <a href="downloadFile?e=<%= UsuarioEmpleado.consultarID_Equipo(usuario.getIDUsuarioE()) %>
                                           &fileName=<%=file_j.getName()%>" 
                                           target="_top" data-toggle="tooltip" 
                                           title="Descargar" id="<%=file_j.getAbsolutePath()%>"
                                           ><%=list_j[i]%></a>
                                           <a target="_top" data-toggle="tooltip" title="Eliminar" 
                                              onclick="deleteFile_J(<%= ddoc.getId_MDocumento() %>, '<%= ddoc.getNombre() %>', <%= eq.getIDEquipo() %>)">
                                               <i class="fas fa-trash-alt text-danger"></i>
                                           </a>
                                              <a target="_top" data-toggle="tooltip" 
                                                 title="Modificar" 
                                                 href="mod_docs.jsp?pass=<%= ddoc.getPass() %>&nombre=<%= ddoc.getNombre() %>">
                                               <i class="fas fa-edit text-primary"></i>
                                           </a>
                                           <a target="_top" data-toggle="tooltip" title="Compartir" 
                                              onclick="copy_link('Access.jsp?fileName=<%=file_j.getName()%>&e=<%= ddoc.getEquipo_ID_Equipo() %>')">
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
                        }else{%>
                        <li>No existe el folder del Equipo</li>
                        <%}%>
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
                    <form class="card-body form-group" action="uploadFile_J" method="POST" enctype="multipart/form-data">
                        <div class="mb-3">
                            <label for="file" class="form-label">Insertar archivo</label>
                            <input class="form-control-file" type="file" id="formFile" name="file" required>
                        </div>
                        <label for="pass">Agrege una contraseña al archivo</label>
                        <input class="form-control" name="pass" type="password" placeholder="Inserte contraseña" oncopy="return false" onpaste="return false" autocomplete="off" ondrag="return false"  ondrop="return false" required="required" minlength="10" maxlength="30">
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
                        <label for="id_e">Elija el equipo al que quiere subir el archivo</label>
                        <select class="form-control" name="id_e">
                            <%
                                ArrayList<Equipo> listaequipos = Equipo.obtenerEquipos(usuario.getiD_Division());
                                for (Equipo eqq: listaequipos) {
                                %>
                                <option><%= eqq.getIDEquipo() %>.<%= eqq.getNombre() %></option>
                                <%
                                }
                            %>
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
        <%}%>
    </div>
    <%}else if (IDequipo != 0) {%>
    <div class="row margin-top-1rem">
        <div class="col-md-4 folio">
            <ul>
                <li>Archivos del equipo
                    <ul>
                        <%String ruta = request.getServletContext().getRealPath("/archivos/"
                            +IDequipo+"/"); 
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
                                        M_Documento mdoc = new M_Documento();
                                        D_Documento ddoc = new D_Documento();
                                        //Definimos primero a ddoc
                                        ddoc.ConsultarD_Doc(IDequipo, file.getName());
                                        mdoc.Consultar_mDoc(ddoc.getId_MDocumento(), ddoc.getID_Documento());
                                        if (ddoc.getId_tipo_acceso() != 1) {%>
                                            <li>
                                                <a href="downloadFile?e=<%= UsuarioEmpleado.consultarID_Equipo(usuario.getIDUsuarioE()) %>&fileName=<%=file.getName()%>" 
                                                   target="_top" data-toggle="tooltip" 
                                                   title="Descargar" id="<%=file.getAbsolutePath()%>"
                                                   ><%=list[i]%></a>
                                                   <a target="_top" data-toggle="tooltip" title="Eliminar" 
                                                      onclick="deleteFile(<%= ddoc.getId_MDocumento() %>, '<%= ddoc.getNombre() %>')">
                                                       <i class="fas fa-trash-alt text-dark"></i>
                                                   </a>
                                                      <a target="_top" data-toggle="tooltip" 
                                                         title="Modificar" 
                                                         href="mod_docs.jsp?pass=<%= ddoc.getPass() %>&nombre=<%= ddoc.getNombre() %>">
                                                       <i class="fas fa-edit text-dark"></i>
                                                   </a>
                                                   <a target="_top" data-toggle="tooltip" title="Compartir" 
                                                      onclick="copy_link('Access.jsp?fileName=<%=file.getName()%>&e=<%= ddoc.getEquipo_ID_Equipo() %>')">
                                                       <i class="fas fa-share text-dark"></i>
                                                   </a>
                                            </li>
                                      <%}
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
                            <a class="page-link" href="#" style="color: #F3F3F3; background-color: #2291C1">Subir</a>
                        </li>
                    </ul>
                </nav>
                <div class="card">
                    <form class="card-body form-group" action="uploadFile" method="POST" enctype="multipart/form-data">
                        <div class="mb-3">
                            <label for="file" class="form-label">Insertar archivo</label>
                            <input class="form-control-file" type="file" id="formFile" name="file" required>
                        </div>
                        <label for="pass"><br>Agrege una contraseña al archivo (si no inserta ninguna el mismo sistema le proporcionara una)</label>
                        <input class="form-control" name="pass" type="password" placeholder="Inserte contraseña" oncopy="return false" onpaste="return false" autocomplete="off" ondrag="return false"  ondrop="return false" minlength="10" maxlength="30">
                        <label for="id_tipo_acceso"><br>Elija tipo acceso</label>
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
                        <label for="tipo_archivo"><br>Elija tipo de archivo</label>
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
            <br>
        </div>
        <div class="col-md-1">
        </div>
    </div>
    <% }else if(usuario.getiD_cat_priv() == 1 && IDequipo == 0){%>
    <div class="container">
        <div class="jumbotron">
            <h1 class="display-4">No tienes acceso a la herramienta de documentos</h1>
            <p class="lead">Eres un administrador por lo tanto no tienes acceso 
                a la herramienta de documentos al no poseer un equipo</p>
            <hr class="my-4">
        </div>     
    </div>
    <% }else if(usuario.getiD_cat_priv() == 2 && IDequipo == 0){%>
    <div class="container">
        <div class="jumbotron">
            <h1 class="display-4">No tienes acceso a la herramienta de documentos</h1>
            <p class="lead">Eres un directivo por lo tanto no tienes acceso a la herramienta de documentos, 
            de ser necesario un documento solicita un link de acceso al documento con un colaborador de la empresa</p>
            <hr class="my-4">
        </div>     
    </div>
    <% }  else if(usuario.getiD_cat_priv() == 5 && IDequipo == 0){%>
    <div class="container">
        <div class="jumbotron">
            <h1 class="display-4">No tienes acceso a la herramienta de documentos</h1>
            <p class="lead">Eres un jefe de area por lo tanto no tienes acceso 
                a la herramienta de documentos al no poseer un equipo</p>
            <hr class="my-4">
        </div>     
    </div> %>
    <%}else {%>
    <div class="container">
        <div class="jumbotron">
            <h1 class="display-4">No tienes un equipo asignado</h1>
            <p class="lead">No tienes un equipo asignado con el que puedas trabajar, 
                pero de ser necesario acceder a cierto documento por favor solicitar
                un link de acceso a un colaborador de la empresa o pedir a un jefe 
                de area ingresar a un equipo de trabajo</p>
            <hr class="my-4">
        </div>     
    </div>
    <%
       }
    %>
    <jsp:include page="Prueba-Reu/my-footer.jsp" />
  </body>
  <script src="./JS/enable_tooltip.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
  <script src="./JS/sweetAlert.js"></script>
</html>
