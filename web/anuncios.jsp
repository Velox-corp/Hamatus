<%-- 
    Document   : anuncios
    Created on : 30/11/2020, 10:58:13 PM
    Author     : maste
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang='es'>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Hamatus - P. principal -</title>
        <jsp:include page="Prueba-Reu/my-links-boostrap.html" />
    </head>
    <jsp:include page="Prueba-Reu/my-head2.jsp" />
    <body>
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
					<a class="nav-link" href="empresa.jsp">Mi empresa</a>
				</li>
				<li class="nav-item">
					<a class="nav-link " href="vistaOrganigrama.jsp">Organigrama</a>
				</li>
				<li class="nav-item">
					<a class="nav-link " href="documentos.jsp">Documentos</a>
				</li>
				<li class="nav-item">
					<a class="nav-link " href="equipos.jsp">Equipos</a>
				</li>
                                <li class="nav-item">
					<a class="nav-link " href="empleados.jsp">empleados</a>
				</li>
			</ul>
		</div>
	</header>
        -->
	<main class="row">
            <div class="col-md-12"><br>
                <center><h1>Tablón de anuncios</h1></center>
                    <%-- Aquí va tocar meter un for para que se beneren todos los anuncios --%>
			<div class="card bg-default">
				<h3 class="card-header">
					{titulo_anuncio}
				</h3>
				<div class="card-body">
					<p class="card-text">
						{mensaje_anuncio}
					</p>
				</div>
				<div class="card-footer btn-group btn-group-md-6" role="group">
                                    <a class="btn btn-dark" href="elaboradorAnuncios.jsp?id=<%=0%>">
                                        Editar anuncio
                                    </a>
                                    <a class="btn bd" href="<%--sevletEliminaciónAnuncioNombre--%>?id=<%=0%>">
                                        Eliminar anuncio
                                    </a>
				</div>
			</div>
		</div>
        </main>
    </body>
    <jsp:include page="Prueba-Reu/my-footer.jsp" />
</html>
