<%-- 
    Document   : vistaOrganigrama
    Created on : 1/12/2020, 01:11:02 AM
    Author     : maste
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Hamatus -Vista Organigrama-</title>
        <jsp:include page="Prueba-Reu/my-links-boostrap.html" />
    </head>
    <body>
        <jsp:include page="Prueba-Reu/my-head.jsp" />
        <!--<header class="row">
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
					<a class="nav-link" href="empleados.jsp">empleados</a>
				</li>
			</ul>
		</div>
	</header>-->
        
        
        <main>
            <div class="row">
		<div class="col-md-12">
			<h1 class="text-center text-primary">
				Organigrama empresa
			</h1>
			<div class="row">
				<div class="col-md-12" id='organigrama'>
				</div>
			</div>
			<dl>
				<dt>
					Puesto actual:
				</dt>
				<dd>
					{Puesto_usuario}
				</dd>
				
			</dl>
		</div>
            </div>
            
        </main>
    </body>
    <jsp:include page="Prueba-Reu/my-footer.html" />
</html>
