<%-- 
    Document   : organigrama
    Created on : 1/12/2020, 12:12:19 AM
    Author     : maste
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang='es'>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Hamatus - Organigrama -</title>
        <!--<link rel="stylesheet" href='CSS/guia_estilos.css'>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
        -->
        <jsp:include page="Prueba-Reu/my-links-boostrap.html" />
    </head>
    
    <body
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
					<a class="nav-link" href="empresa.jsp">Mi empresa</a>
				</li>
				<li class="nav-item">
					<a class="nav-link active" href="vistaOrganigrama.jsp">Organigrama</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="documentos.jsp">Documentos</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="equipos.jsp">Equipos</a>
				</li>
                                <li class="nav-item">
					<a class="nav-link " href="empleados.jsp">empleados</a>
				</li>
			</ul>
		</div>
	</header>-->
        <script src='JS/'></script>
        <div class="row">
		<div class="col-md-12">
			<h1 class="text-center text-primary">
				Organigrama empresa
			</h1>
                        <form  method="post" action='' class='container-fluid'>
                            <div class="col-md-1">
                                    <div class="btn-group btn-group-vertical btn-group-lg" role="group">

                                            <button class="btn btn-secondary" type="button" onclick=''>
                                                    Agregar nodo
                                            </button>
                                    </div>
                            </div>
                            <div class="col-md-11">
                                        <div class="row">
                                                <div class="col-md-3">
                                                </div>
                                                <div class="col-md-6">
                                                        <div class="card text-white bg-primary">
                                                                <h5 class="card-header">
                                                                        {Nombre_empresa}
                                                                </h5>
                                                                <div class="card-body">
                                                                        <p class="card-text">
                                                                                Nombres directivos
                                                                        </p>
                                                                </div>
                                                                <div class="card-footer">
                                                                        Null
                                                                </div>
                                                        </div>
                                                </div>
                                                <div class="col-md-3">
                                                </div>
                                        </div>
                                        <div class="row">
                                                <div class="col-md-4">
                                                        <div class="card text-white bg-info">
                                                                <h5 class="card-header" name='nombre_nodo_'>
                                                                        {Nombre_nodo_ejemplo}
                                                                </h5>
                                                                <div class="card-body">
                                                                        <p class="card-text" name='nombre_lider_'>
                                                                                {Nombres lideres}
                                                                        </p>
                                                                        <p class="card-text" name='nombre_empleado_'>
                                                                                {Nombres empleados subordinados}
                                                                        </p>
                                                                </div>
                                                                <div class="card-footer">
                                                                        Eliminar
                                                                </div>
                                                        </div>
                                                </div>
                                                <div class="col-md-4">
                                                </div>
                                                <div class="col-md-4">
                                                </div>
                                        </div>
                                </div>
                            <button type="submit" class="btn btn-success">
                                    Guardar diagrama
                            </button>
                        </form>
                    </div>
            
	</div>
        <jsp:include page="Prueba-Reu/my-footer.jsp" />
    </body>
</html>
