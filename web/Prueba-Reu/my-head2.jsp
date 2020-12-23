<%@page import="MUsuarios.clases.Empresa"%>
<%@page import="MUsuarios.clases.UsuarioEmpleado"%>
<%@page contentType="text/html" pageEncoding="UTF-8" session="true"%>
<%
    HttpSession sesionUser = request.getSession();
    String username = "";
    String nombre_empresa = "";
    boolean obtencionAdecuada = false;
    try{
        UsuarioEmpleado usuario = (UsuarioEmpleado) sesionUser.getAttribute("usuario");
        Empresa emp = (Empresa) sesionUser.getAttribute("empresa");
        username = usuario.getNombre();
        nombre_empresa = emp.getNombre();
        obtencionAdecuada = true; 
    }catch(NullPointerException ex){
        obtencionAdecuada = false;
    }
    
%>
<header class="container-fluid">
	<div class="row header align-items-center">
		<div class="col-md-2">
                    <a href="anuncios.jsp">
                        <img alt="Hamatus" src="img/favicon.png" class="mx-auto d-block icono">
                    </a>
		</div>
                <div class="col-md-2">
                    <h2>Hamatus</h2>
                </div>
                <div class="col-md-2">
                    <%if (obtencionAdecuada){ %>
                        <i><h3>
                            <%=nombre_empresa%>
                            </h3> </i>
                        <%}else{%>
                        <i><h3>
				Empresa registrada
                            </h3></i>
                        <% }%>
                </div>
		<div class="col-md-3">
		</div>
		<div class="col-md-3">
                    <div class='btn-group'>
                        <a class="btn btn-dark" href="CRUD_TU.jsp"> <!-- meter la página que permita edición de usuarios -->
                            <%if (obtencionAdecuada){ %>
                                <%=username%>
                            <%}else{%>
                                USUARIO
                            <% }%>
                        </a>
                        <a class='btn btn-dark' href="CerrarSesion">
                            Cerrar Sesión
                        </a>
                    </div>
		</div>
	</div>
	<div class="row">
		<div class="col-md-12 nav center-block justify-content-center">
                    <a class="nav-item nav-link btn1" href="anuncios.jsp">Anuncios</a>
                    <a class="nav-item nav-link btn1" href="empresa.jsp">Mi empresa</a>
                    <a class="nav-item nav-link btn1" href="vistaOrganigrama.jsp">Organigrama</a>
                    <a class="nav-item nav-link btn1" href="docs.jsp">Documentos</a>
                    <a class="nav-item nav-link btn1" href="equipos.jsp">Equipos</a>
                    <a class="nav-item nav-link btn1" href="empleados.jsp">Empleados</a>
                    <a class="nav-item nav-link btn1" href="Administrador_new.jsp">Crud Completo</a>
		</div>
	</div>
</header>
