<%@page import="MUsuarios.clases.Empresa"%>
<%@page import="MUsuarios.clases.UsuarioEmpleado"%>
<%@page language="java" pageEncoding="UTF-8" contentType="text/html"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset='utf-8'>
    <meta http-equiv='X-UA-Compatible' content='IE=edge'>
    <title>Acceso</title>
    <jsp:include page="Prueba-Reu/my-links-boostrap.html" />
</head>
<body>
    <%--Ok basicamente la logica del documento es que si tienes el suficiente acceso
    puedes ver este doc esto a traves de tu inicio de sesion y si no 
    perteneces a la empresa te manda a error--%>
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
    %>
    <jsp:include page="Prueba-Reu/my-head2.jsp" />
        <div class="container margin-top-1rem cubridor d-flex justify-content-center align-items-center">
            <div class="card">
                <div class="card-body">
                    <h2>Acceder al documento solicitado</h2>
                    <br>
                    <form method="POST" action="authAcess">
                        <div class="form-group">
                          <label for="pass">Contraseña del documento</label>
                          <input type="password" class="form-control" name="pass" required="true">
                          <input type="text" hidden="true" value="<%= request.getParameter("action")%>"
                                 name="action">
                          <input type="text" hidden="true" value="<%= request.getParameter("path_doc")%>"
                                 name="path_doc">
                        </div>
                        <button type="submit" class="btn btn-primary">Acceder</button>
                    </form>
                    <br>
                </div>
            </div>
        </div>
</body>
<jsp:include page="Prueba-Reu/my-footer.html" />
</html>