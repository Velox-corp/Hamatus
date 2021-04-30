<%-- 
    Documento   : subirEvidencia
    Fecha y hora de creación: : 29/04/2021, 11:27:31 PM
    Author     : Armando Jarillo
--%>
<%@page import="MUsuarios.clases.UsuarioEmpleado"%>
<%@page import="MUsuarios.clases.Empresa"%>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java" session="true"%>
<!DOCTYPE html>
<html lang='es'>
    <head>
        <meta http-equiv="Content-Type" content="text/html">
        <meta charset="utf-8">
        <title>Subir evidencias</title>
        <jsp:include page="Prueba-Reu/my-links-boostrap.html" />
    </head>
    <body>
        <jsp:include page="Prueba-Reu/my-head2.jsp" />
        <%
            HttpSession sesionEmpresa;
            Empresa emp = null;
            UsuarioEmpleado admin = null;
        %>
        
        <jsp:include page="Prueba-Reu/my-footer.jsp" />
    </body>
</html>
