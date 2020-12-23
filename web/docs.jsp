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
                String id = usuario.getIDUsuarioE().toString();
                String ruta = "/" + id;
                File file;
                File dir = new java.io.File(ruta);

                String[] list = dir.list();

                if (list != null) {
                    if (list.length > 0) {

                        for (int i = 0; i < list.length; i++) {
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
                %>
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
                        <input class="form-control" name="File" type="file">
                        <input class="form-control" name="pass" type="password">
                        <input class="form-control" name="folio" type="text">
                        <input class="form-control" name="Equipo_ID_Equipo" type="text" value="<%= usuario.getIDUsuarioE() %>">
                        <input class="form-control" name="id_D_DOcumento" type="number">
                        <input class="form-control" name="id_usuario_p" type="number">
                        <div class="justify-content-center">
                            <button type="" class="btn btn-primary">
                                Guardar Cambios
                            </button>
                            <button type="button" class="btn btn-primary">
                                Cancelar
                            </button>
                        </div>
                    </form
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