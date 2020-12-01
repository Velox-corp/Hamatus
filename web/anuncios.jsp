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
        <link rel="stylesheet" href='CSS/guia_estilos.css'>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
    </head>
    <body class="container-fluid">
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
	<main class="row">
		<div class="col-md-12">
			<h1 class="text-center text-primary">
				Tablón de anuncios
			</h1>
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
                                    <a class="btn btn-info" href="elaboradorAnuncios.jsp?id=<%=0%>">
                                        Editar anuncio
                                    </a>
                                    <a class="btn btn-danger" href="<%--sevletEliminaciónAnuncioNombre--%>?id=<%=0%>">
                                        Eliminar anuncio
                                    </a>
				</div>
			</div>
		</div>
        </main>
    </body>
</html>
