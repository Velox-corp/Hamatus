<%@page import="MTablones.Clases.Anuncio"%>
<%@page import="MTablones.Clases.Anuncio"%>
<%@page import="MUsuarios.clases.Empresa"%>
<%@page import="MUsuarios.clases.UsuarioEmpleado"%>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java" session="true"%>
<%
    HttpSession sesion;
    UsuarioEmpleado user;
    Empresa emp;
    Anuncio anuncio = null;
    int ideAnuncio = 0;
    boolean allgood = true;
    try{
        sesion = request.getSession();
        user = (UsuarioEmpleado) sesion.getAttribute("usuario");
        if(user.getiD_cat_priv() > 3){ // si es mayor a 3 es un empleado común
            allgood  = false;
        }
        ideAnuncio = Integer.parseInt(request.getParameter("id"));
        if(ideAnuncio != 0){
            anuncio = Anuncio.buscar(ideAnuncio);
        }
        emp = (Empresa) sesion.getAttribute("empresa");
    }catch(Exception ex){
        allgood = false;
        ex.getMessage();
        ex.printStackTrace();
    }
    if(!allgood) response.sendRedirect("error.jsp");
%>
<!DOCTYPE html>
<html lang='es'>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Elaboración de anuncios -</title>
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
					<a class="nav-link active" href="anuncios.jsp">Anuncios</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="empresa.jsp">Mi empresa</a>
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
            <%if(ideAnuncio == 0){ %>
                <form class="col-md-12" method="post" action="/crearAnuncio"><br>
                    <h2 class="text-center">Creación de anuncio</h2>
                    <br>
                    <div class="card bg-default">
                        <div class="card-header input-group">
                            <div class='input-group-prepend'>
                                <span class='input-group-text'><strong>Titulo:</strong></span>
                            </div>
                            <input name="titulo" class='form-control'/>
                        </div>
                        <div class="card-body input-group">
                            <div class='input-group-prepend'>
                                <span class='input-group-text'>Contenido:</span>
                            </div>
                            <textarea name='contenido' class='form-control'></textarea>
                        </div>
                        <div class="card-footer">
                            <button type="submit" class="btn btn-dark">Ingresar Anuncio</button>
                        </div>
                    </div>
                </form>
            <%}else{%>
            <script src='JS/interaccionBotones.js'></script>
                <form class="col-md-12" method="post" action="/editarAnuncio"><br>
                    <input type='hidden' name='id' value='<%=ideAnuncio%>' >
                    <h2 class="text-center">Edición de anuncio de anuncio</h2>
                    <div class="card bg-default">
                        <div class="card-header input-group">
                            <input name="titulo" id='titulo' value='<%=anuncio.getTitulo()%>' class='form-control'/> 
                            <div class='input-group-append'>
                                <button class='btn btn warning' type="button" onclick='cambiarEstado("titulo")'>Editar</button>
                            </div>
                        </div>
                        <div class="card-body input-group">
                            
                            <textarea name='contenido' id='contenido'  value='<%=anuncio.getDescripcion()%>' class='form-control'></textarea>
                            <div class='input-group-append'>
                                <button class='btn btn warning' type="button" onclick='cambiarEstado("contenido")'>Editar</button>
                            </div>
                        </div>
                        <div class="card-footer">
                            <button type="submit" class="btn btn-dark">Actualizar Anuncio</button>
                        </div>
                    </div>
                </form>
            <% } %>
	</main>
    </body>
    <jsp:include page="Prueba-Reu/my-footer.jsp" />
</html>
