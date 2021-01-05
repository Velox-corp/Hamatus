<%-- 
    Document   : mod_docs
    Created on : 31/12/2020, 12:40:19 AM
    Author     : taspi
--%>

<%@page import="MUsuarios.clases.Empresa"%>
<%@page import="MUsuarios.clases.UsuarioEmpleado"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Hashtable"%>
<%@page import="MDocumentos.Clases.D_Documento"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset='utf-8'>
    <meta http-equiv='X-UA-Compatible' content='IE=edge'>
    <title>Hamatus</title>
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
    }%>
        <div class="container-fliud cubridor d-flex justify-content-center align-items-center">
          <div class="col-md-3">
          </div>
          <div class="col-md-6 card">
              <div class="card-body">
                  <form action="updateFile_J" method="POST" enctype="multipart/form-data">
                      <div class="mb-3">
                    <label for="file" class="form-label">Insertar archivo(Nota:si usted quiere actualizar el archivo introduzca el archivo en caso contrario dejelo libre)</label>
                    <input class="form-control-file" type="file" id="formFile" name="file">
                </div>
                <label for="pass">Agrege una contraseña al archivo</label>
                <input class="form-control" name="pass" type="password" 
                       placeholder="Inserte contraseña" required value="<%= request.getParameter("pass") %>">
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
                    <input name="nombre" value="<%= request.getParameter("nombre") %>" hidden="true">
                    <input name="id_e" value="<%= request.getParameter("e") %>" hidden="true">
                    <br>
                    <div class="justify-content-center">
                        <button type="" class="btn btn-primary">
                            Actualizar Archivo
                        </button>
                        <a href="docs.jsp" class="btn btn-primary">Volver</a>
                    </div>
                  </form>
              </div>
          </div>
          <div class="col-md-3">
          </div>
            </div>
        </div>
</body>
<jsp:include page="Prueba-Reu/my-footer.jsp" />
</html>