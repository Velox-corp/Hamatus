<%-- 
    Document   : docs2
    Created on : 13/05/2021, 06:39:19 PM
    Author     : taspi
--%>

<%@page import="MDocumentos.Clases.cat_clasif_doc"%>
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
            query = (request.getParameter("q").equals(null)?"":request.getParameter("q")) + "/";
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
                <div class="btn-group-vertical">
                  <a type="button" class="btn btn-dark">
                      Ver favoritos
                      <i class="fas fa-star text-white"></i>
                  </a>
                  <a type="button" class="btn btn-dark">
                      Ver archivos
                      <i class="fas fa-folder-open text-white"></i>
                  </a>
                    <a type="button" class="btn btn-dark" href="makeDir?q=<%= query %>">
                      Crear nueva carpeta
                      <i class="fas fa-folder-plus text-white"></i>
                  </a>
                </div>
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
                                } else {                                
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
                            } else if( IDequipo != 0 ){//Este if es de los usuario comunenes
                                String ruta = request.getServletContext().getRealPath("/archivos/"
                                +String.valueOf(IDequipo)+"/"+(query != null ? query : ""));
                                if (ruta != null) {//Existe un folder        
                                    java.io.File file;
                                    java.io.File dir = new java.io.File(ruta);
                                    String[] list = dir.list();
                                    System.out.println(list.length);
                                    if (list.length > 0) { //EL directorio tiene archivos
                                        //Lista de lo que debe de entrar
                                        for (int i=0; i < list.length; i++) {
                                            //Iteraciones de los archivos de la carpeta
                                            file = new java.io.File(ruta +"/"+ list[i]);
                                            if (file.isFile()) {
                                                M_Documento mdoc = new M_Documento();
                                                D_Documento ddoc = new D_Documento();
                                                
                                                ddoc.ConsultarD_Doc(IDequipo, file.getName());
                                                mdoc.Consultar_mDoc(ddoc.getId_MDocumento(), ddoc.getID_Documento());
                                                cat_clasif_doc cat = new cat_clasif_doc();
                                                if(ddoc.getId_tipo_acceso() != 1){%>
                                                    <tr>
                                                    <!--Nombre del archivo-->
                                                    <td>
                                                        <a href="downloadFile?e=<%= UsuarioEmpleado.consultarID_Equipo(usuario.getIDUsuarioE()) %>&fileName=<%=file.getName()%>" 
                                                           target="_top" data-toggle="tooltip" 
                                                           title="Descargar" id="<%=file.getAbsolutePath()%>"
                                                           ><%= list[0] %></a>
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
                                                            onclick="copy_link('Access.jsp?fileName=<%=file.getName()%>&e=<%= ddoc.getEquipo_ID_Equipo() %>')">
                                                            <i class="fas fa-share text-dark"></i>
                                                        </a>
                                                        </center>
                                                    </td>
                                                    <!--Favoritos-->
                                                    <td>
                                                        <center>
                                                            <%
                                                                if(cat.query_doc_state(ddoc.getID_Documento())==1){
                                                                    %>
                                                                    <a target="_top" data-toggle="tooltip" 
                                                                         title="Añadir a favoritos" 
                                                                         href="fav?f=<%= ddoc.getId() %>">
                                                                       <i class="far fa-star" style='color:#ffc107'></i>
                                                                    </a>
                                                                    <%
                                                                }else{
                                                                    %>
                                                                    <a target="_top" data-toggle="tooltip" 
                                                                         title="Quitar a favoritos" 
                                                                         href="fav?f=<%= ddoc.getId() %>">
                                                                       <i class="fas fa-star" style='color:#ffc107'></i>
                                                                    </a>
                                                                    <%
                                                                }
                                                            %>
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
                                                    }else if(file.isDirectory()){
                                                %>
                                                <tr>
                                                    <!--Nombre del folder-->
                                                    <td><a target="_top" data-toggle="tooltip" 
                                                            title="Ver folder" 
                                                            href="docs2.jsp?q=<%= ruta_j + "/" + file.getName() %>">
                                                            <i class="far fa-folder text-dark"></i>
                                                            <%= file.getName() %>
                                                        </a>
                                                    </td>
                                                    <!--modificar nombre carpeta-->
                                                    <td>
                                                        <center>
                                                        <a target="_top" data-toggle="tooltip" 
                                                             title="Modificar nombre de la carpeta" 
                                                             href="#" onclick="changefolderName(<%= file.getName() %>)">
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
                                                               href="#" onclick="borrarCarpeta(<%= file.getName() %>)">
                                                            <i class="fas fa-trash-alt text-dark"></i>
                                                            </a>
                                                        </center>
                                                    </td>
                                                </tr>
                                                <%}
                                            }
                                        }
                                    }else{
                                        //No hay archivos
                                        %>
                                        <tr>
                                            <td>
                                            No hay documentos guardados o
                                                carpetas creadas, por favor guardar
                                                un documento o crear una carpeta
                                            </td>
                                        </tr>
                                        <%
                                    }
                                }else{
                                    //No hay folder
                                    %>
                                    <tr rowspan="5">
                                        <td>
                                        No hay folder del equipo o
                                            carpetas creadas, por favor guardar
                                            un documento o crear una carpeta
                                        </td>
                                    </tr>
                                    <%
                                }
                            }else if(usuario.getiD_cat_priv() == 1 && IDequipo == 0){
                                %>
                                <tr>
                                    <td>
                                    <center>No tiene acceso a la funcion de los 
                                        documentos si necesita acceder a alguno por favor
                                    solicitar un link de acceso</center>
                                    </td>
                                </tr>
                                <%
                            }else if(usuario.getiD_cat_priv() == 2 && IDequipo == 0){
                                %>
                                <tr>
                                    <td>
                                    <center>No tiene acceso a la funcion de los 
                                        documentos si necesita acceder a alguno por favor
                                    solicitar un link de acceso</center>
                                    </td>
                                </tr>
                                <%
                            }else if(usuario.getiD_cat_priv() == 3 && IDequipo == 0){
                                %>
                                <tr>
                                    <td>
                                    <center>No tiene acceso a la funcion de los 
                                        documentos si necesita acceder a alguno por favor
                                    solicitar un link de acceso</center>
                                    </td>
                                </tr>
                                <%
                            }else {
                                %>
                                <tr>
                                    <td>
                                    <center>No tiene acceso a la funcion de los 
                                        documentos si necesita acceder a alguno por favor
                                    solicitar un link de acceso</center>
                                    </td>
                                </tr>
                                <%
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
    <!--<script src="./JS/sweetAlert0.js"></script>
    Carajo tendre que pasarlas para aqui abajo TwT-->
    <script>
        function confirmation(){
            Swal.fire({
                position: 'top-end',
                title: "Documento correctamente guardado",
                icon:'success',
                showConfirmButton: false,
                timer: 1500
            });
        }
                function too_w(){
            var titulo = decode_utf8("Su archivo pesa más de 15Mb");
            Swal.fire({
                title: titulo,
                text:'Contacte al administrador',
                icon:'error'
            });
        }

        function file_sec(){
            var titulo = decode_utf8("Lamentablemente no se permiten archivos con esa nomenclatura");
            Swal.fire({
                title: titulo,
                text:'Por motivos de seguridad tampoco se aceptan archivos .sql .java .py .js .rar y .zip',
                icon:'error'
            });
        }

        function confirmation_del(){
            Swal.fire({
                position: 'top-end',
                title: "Documento correctamente borrado",
                icon:'success',
                showConfirmButton: false,
                timer: 1500
            });
        }

        function error(){
            Swal.fire({

                title: "Hubo un error",
                text:'Contacte al administrador',
                icon:'error'
            });
        }

        function wrong_pass(){
            var titulo = decode_utf8(encode_utf8("Contraseña incorrecta"));
            var text = decode_utf8(encode_utf8('Ingrese otra vez la contraseña'));
            Swal.fire({
                title: titulo,
                text:text,
                icon:'error'
            });
        }

        function true_pass(pass){
            var text = decode_utf8('La contraseña es: ');
            Swal.fire({
                title: "Documento correctamente guardado",
                text:text + pass ,
                icon:'success'
            });
        }

        function copy_link(id){
            const text = window.location.host + "/Hamatus/" + id;
            console.log(text);
            navigator.clipboard.writeText(text).then(function() {
            /* clipboard successfully set */
                Swal.fire({
                    text:'Comparta el link para poder mostrar este archivo a otros colaboradores de la empresa',
                    position: 'top-end',
                    icon:'success',
                    showConfirmButton: false,
                    timer: 3000,
                    timerProgressBar: true
                });
            }, function() {
              /* clipboard write failed */
              Swal.fire({
                    text:'A sucedido un error contacte al administrador',
                    position: 'top-end',
                    icon:'error',
                    showConfirmButton: false,
                    timer: 3000,
                    timerProgressBar: true
                });
            });
        }

        function deleteFile(id_m, fileName){
            var titulo = decode_utf8('¿Estas seguro de que quieres borrar el archivo?');
            var text = decode_utf8('La contraseña es: ');
            Swal.fire({
                title: titulo,
                text: "Recuerda que no podras recuperarlo",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#dc3545',
                cancelButtonColor: '#343a40',
                confirmButtonText: 'Si por favor',
                cancelButtonText: 'Cancelar'
            }).then((result) => {
                if (result.isConfirmed) {
                  window.location = "deleteFile?id_M="+id_m+"&fileName="+fileName;
                }
            });
        }

        function deleteFile_J(id_m, fileName, id_e){
            var titulo = decode_utf8('¿Estas seguro de que quieres borrar el archivo?');
            var text = decode_utf8('La contraseña es: ');
            Swal.fire({
                title: titulo,
                text: "Recuerda que no podras recuperarlo",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#dc3545',
                cancelButtonColor: '#343a40',
                confirmButtonText: 'Si por favor',
                cancelButtonText: 'Cancelar'
            }).then((result) => {
                if (result.isConfirmed) {
                  window.location = "deleteFile_J?id_M="+id_m+"&fileName="+fileName+"&id_e="+id_e;
                }
            });
        }


        window.onload = function(){
            if (getParameterByName('flag') == 'true') {
                confirmation();
            }else if(getParameterByName('flag') == 'false'){
                error();
            }else if(getParameterByName('flag_del') == 'false'){
                error();
            }else if(getParameterByName('flag_del') == 'true'){
                confirmation_del();
            }else if(getParameterByName('flag') == 'exist'){
                Swal.fire({
                    title:"Lo sentimos, el archivo ya existe",
                    icon:'warning'
                });
            }else if(getParameterByName('flag') == 'wrong_pass'){
                wrong_pass();
            }else if(getParameterByName('flag') == 'true_pass'){
                var pass = getParameterByName('pass');
                true_pass(pass);
            }
            else if(getParameterByName('flag') == 'too_w'){
                too_w();
            }
            else if(getParameterByName('flag') == 'file_sec'){
                file_sec();
            }
        }

        /**
         * @param String name
         * @return String
         */
        function getParameterByName(name) {
            name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
            var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
            results = regex.exec(location.search);
            return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
        }

        function encode_utf8(s) {
          return unescape(encodeURIComponent(s));
        }

        function decode_utf8(s) {
          return decodeURIComponent(escape(s));
        }
    </script>
</html>
