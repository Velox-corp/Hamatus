<%-- 
    Document   : empresa
    Created on : 1/12/2020, 12:06:52 AM
    Author     : maste
--%>

<%@page import="MUsuarios.clases.UsuarioEmpleado"%>
<%@page import="java.io.OutputStream"%>
<%@page import="javax.sql.rowset.serial.SerialBlob"%>
<%@page import="sun.misc.IOUtils"%>
<%@page import="java.sql.Blob"%>
<%@page import="java.io.InputStream"%>
<%@page contentType="text/html" pageEncoding="UTF-8" session="true" language="java" import="MUsuarios.clases.Empresa"%>

<%
    HttpSession sesionEmpresa = request.getSession();
    Empresa emp = (Empresa) sesionEmpresa.getAttribute("empresa");
    UsuarioEmpleado admin = (UsuarioEmpleado) sesionEmpresa.getAttribute("usuario");
%>
<!DOCTYPE html>
<html lang='es'>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Empresa</title>
        <jsp:include page="Prueba-Reu/my-links-boostrap.html" />
    </head>
    <body class=''>
        <jsp:include page="Prueba-Reu/my-head2.jsp" />
        <main class="row">
		<div class="col-md-12">
                    <div class='row'>
                        <div class='col-md-2'>
                        </div>
                        <div class='col-md-8'>
                            <center><h1><br><%=emp.getNombre()%></h1></center>
                        </div>
                    </div>
                    <div style="margin-left: 2rem">
                        <h3>Razón Social:</h3>
                        <h3 style="color: #181818"><%=emp.getRazónsocial()%></h3>
                        <h3>Descripción:</h3>
                        <p>
                            <%=emp.getDescripcion()%>
                        </p>
                    </div>
                    <hr>
                    <div style="margin-left: 2rem">
                        <h3>Opciones del Administrador de la empresa</h3><br>
                        <%--Aquí va tocar meter algo que valide a la cuenta de admin para tener acceso a links especiales para mejor ux--%>
                        <div class='row'>
                            <div class='col-md-4'>
                                <a href='divisiones.jsp' class='btn btn-dark btn-large'>
                                    Construir distribución de la empresa
                                </a>
                            </div>
                            <div class='col-md-4'>
                                <a href='Administrador_new.jsp' class='btn btn-secondary btn-large'>
                                    Crear cuentas de usuarios
                                </a>
                            </div>
                        </div>
                    </div> 
		</div>
	</main>
    </body>
    <jsp:include page="Prueba-Reu/my-footer.jsp" />
</html>
