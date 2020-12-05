<%-- 
    Document   : empresa
    Created on : 1/12/2020, 12:06:52 AM
    Author     : maste
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" session="true" language="java" import="MUsuarios.clases.Empresa"%>

<%
    HttpSession sesionEmpresa = request.getSession();
    Empresa emp = (Empresa) sesionEmpresa.getAttribute("empresa");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Hamatus - Empresa -</title>
        <jsp:include page="Prueba-Reu/my-links-boostrap.html" />
    </head>
    <body>
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
			<h1 class="text-center text-primary">
				<%=emp.getNombre()%>
			</h1>
			<h2 class="text-info">
				<%=emp.getRazónsocial()%>
			</h2>
                        <p>
                            <%=emp.getDescripcion()%>
                        </p>
			<p>
				Lorem ipsum dolor sit amet, <strong>consectetur adipiscing elit</strong>. Aliquam eget sapien sapien. Curabitur in metus urna. In hac habitasse platea dictumst. Phasellus eu sem sapien, sed vestibulum velit. Nam purus nibh, lacinia non faucibus et, pharetra in dolor. Sed iaculis posuere diam ut cursus. <em>Morbi commodo sodales nisi id sodales. Proin consectetur, nisi id commodo imperdiet, metus nunc consequat lectus, id bibendum diam velit et dui.</em> Proin massa magna, vulputate nec bibendum nec, posuere nec lacus. <small>Aliquam mi erat, aliquam vel luctus eu, pharetra quis elit. Nulla euismod ultrices massa, et feugiat ipsum consequat eu.</small>
			</p>
		</div>
	</main>
    </body>
    <jsp:include page="Prueba-Reu/my-footer.html" />
</html>
