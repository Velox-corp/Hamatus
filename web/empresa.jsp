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
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Hamatus - Empresa -</title>
        <jsp:include page="Prueba-Reu/my-links-boostrap.html" />
    </head>
    <body class='container-fluid'>
        <jsp:include page="Prueba-Reu/my-head2.jsp" />
        <!--
        <header class="row">
		<div class="col-md-12">
			<div class="row">
				<div class="col-md-2">
					<img alt="Logo_hamatus" class="rounded-circle" />
				</div>
				<div class="col-md-5">
					<a class="text-primary text-left" href='index.jsp'>
						Hamatus
					</a>
				</div>
				<div class="col-md-5">
					<p class="text-right">
                                            <a class="nav-link active" href="usuario.jsp">{Username}</a>
					</p>
				</div>
			</div>
			<ul class="nav nav-tabs">
				<li class="nav-item">
					<a class="nav-link" href="anuncios.jsp">Anuncios</a>
				</li>
				<li class="nav-item">
					<a class="nav-link active" href="empresa.jsp">Mi empresa</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="vistaOrganigrama.jsp">Organigrama</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="documentos.jsp">Documentos</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="equipos.jsp">Equipos</a>
				</li>
                                <li class="nav-item">
					<a class="nav-link" href="empleados.jsp">empleados</a>
				</li>
			</ul>
		</div>
	</header>
        -->
        <main class="row">
		<div class="col-md-12">
                    <div class='row'>
                        <div class='col-md-2'>
                            <%--
                                //Gracias Tenorio por facilitarme este código de shiee
                            InputStream iS = emp.sacarLogo(emp.getIDEmpresa());
                            Blob logo = null;
                            byte[] imgData = new byte[iS.available()];
                            logo = new SerialBlob(IOUtils.readFully(iS, -1, true));
                            response.setContentType("image/gif");
                            OutputStream o = response.getOutputStream();
                            o.write(logo.getBytes(1, (int) logo.length()));
                            o.flush();
                            o.close();    
                            --%>
                        </div>
                        <div class='col-md-10'>
                            <h1 class="text-center text-primary">
                                    <%=emp.getNombre()%>
                            </h1>
                        </div>
                    </div>
			<h2 class="text-info">
				<%=emp.getRazónsocial()%>
			</h2>
                        <p>
                            <%=emp.getDescripcion()%>
                        </p>
                        <hr>
                        <h3>Opciones de administrador de empresa</h3>
                        <%--Aquí va tocar meter algo que valide a la cuenta de admin para tener acceso a links especiales para mejor ux--%>
                        <div class='row'>
                            <div class='col-md-5'>
                                <a href='organigrama.jsp' class='btn btn-primary btn-large'>
                                    Construir distribución empresa
                                </a>
                            </div>
                            <div class='col-md-2'></div>
                            <div class='col-md-5'>
                                <a href='Adiministrador_new.jsp' class='btn btn-secondary btn-large'>
                                    Crear cuentas de usuarios
                                </a>
                            </div>
                        </div>
                        
		</div>
	</main>
    </body>
    <jsp:include page="Prueba-Reu/my-footer.html" />
</html>
