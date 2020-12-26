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
              <%
                  /*
                if (request.getAttribute("flag_file_ok") != null) {
                    if ((boolean)request.getAttribute("flag_file_ok") == true) {
                        out.print(request.getAttribute("flag_file_ok"));
                    }
                }*/
  
                  
                HttpSession sesionUser = request.getSession();
                boolean obtencionAdecuada = false;
                UsuarioEmpleado usuario = null;
                Empresa emp = null;
                try{
                    usuario = (UsuarioEmpleado) sesionUser.getAttribute("usuario");
                    emp = (Empresa) sesionUser.getAttribute("empresa");
                    obtencionAdecuada = true; 
                }catch(NullPointerException ex){
                    obtencionAdecuada = false;
                }
                String ruta = request.getRealPath("/archivos/"
                        +usuario.getIDUsuarioE().toString()+"/");
                
                File file;
                File dir = new java.io.File(ruta);

                String[] list = dir.list();

                if (list != null) {
                    if (list.length > 0) {
                        for (int i = 1; i <= list.length; i++) {
                            file = new java.io.File(ruta + list[i]);
                            if (file.isFile()) {
                %>
                <li class="list-item">
                    <a href="/downloadFile?ruta=<%=file.getAbsolutePath()%>&fileName=<%=file.getName()%>" target="_top"><%=list[i]%></a>
                </li>    
                <%
                            }
                        }
                    }
                }else{
                %>
                <li class="list-item">
                    Aun no existen archivos o carpetas
                </li>  
                <%
                }
                %>-->
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
                        <label for="folio">Inserte un folio</label>
                        <input class="form-control" name="folio" type="text" placeholder="Inserte folio">
                        <label for="Equipo_ID_Equipo">Equipo_ID_Equipo</label>
                        <input class="form-control" name="Equipo_ID_Equipo" type="number" value="<%= usuario.getIDUsuarioE() %>" readonly>
                        <label for="id_tipo_acceso">Inserte tipo acceso</label>
                        <input class="form-control" name="id_tipo_acceso" type="number" placeholder="Inserte tipo acceso" required>
                        <label for="id_D_DOcumento">Inserte id_D_DOcumento</label>
                        <input class="form-control" name="id_D_DOcumento" type="number" placeholder="Inserte id_D_DOcumento" required>
                        <br>
                        <div class="justify-content-center">
                            <button type="" class="btn btn-primary">
                                Subir Archivo
                            </button>
                            <button type="button" class="btn btn-primary">
                                Cancelar
                            </button>
                        </div>
                    </form>
                </div> 
            <br>
        </div>
        <div class="col-md-1">
        </div>
    </div>
    </div>
    <jsp:include page="Prueba-Reu/my-footer.html" />
  </body>
</html>