<%-- 
    Document   : authAccess
    Created on : 31/12/2020, 03:11:21 PM
    Author     : taspi
--%>

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
    boolean obtencionAdecuada = true;
    UsuarioEmpleado usuario = null;
    Empresa emp = null;
    String redirect = "";
    try{
        usuario = (UsuarioEmpleado) sesionUser.getAttribute("usuario");
        emp = (Empresa) sesionUser.getAttribute("empresa");
        if(usuario == null || emp == null){
            System.out.println("No hay sesión");
            obtencionAdecuada = false;
            redirect = "inicio_sesion.jsp";
        }
    }catch(NullPointerException ex){
        System.out.println("Algun error raro de null");
        System.out.println(ex.getMessage());
        ex.printStackTrace();
        obtencionAdecuada = false;
        redirect = "error.jsp";
    }catch(Exception e){
        System.out.println("Algun error raro");
        System.out.println(e.getMessage());
        e.printStackTrace();
        obtencionAdecuada = false;
        redirect = "error.jsp";
    }
    if(!obtencionAdecuada){
        response.sendRedirect(redirect);
    }
    %>
        <div class="container-fliud cubridor d-flex justify-content-center align-items-center">
          <div class="col-md-3">
          </div>
          <div class="col-md-6 card">
              <div class="card-body">
                  <h3>Acceso a documento: <%= request.getParameter("fileName") %></h3>
                  <form action="authAcess" method="POST">
                    <label>Ingrese contraseña de acceso</label>
                    <input name="pass" type="password" class="form-control" placeholder="Ingrese contraseña" oncopy="return false" onpaste="return false">
                    <input name="fileName" type="text" hidden="true" value="<%= request.getParameter("fileName") %>">
                    <input name="e" type="text" hidden="true" value="<%= request.getParameter("e") %>">
                    <input name="q" type="text" hidden="true" value="<%= request.getParameter("q") %>">
                    <br>
                    <div class="justify-content-center">
                        <button type="" class="btn btn-dark">
                            Acceder
                        </button>
                        <a href="docs.jsp" class="btn btn-dark">Cancelar</a>
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
  <script src="./JS/enable_tooltip.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
  <script src="./JS/sweetAlert.js"></script>
</html>