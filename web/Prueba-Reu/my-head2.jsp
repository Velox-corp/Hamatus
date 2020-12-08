<%-- 
    Document   : my-head2
    Created on : 2/12/2020, 01:06:03 AM
    Author     : taspi
--%>

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
                <div class="col-md-1">
                    <h2>Hamatus</h2>
                </div>
                <div class="col-md-1">
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
		<div class="col-md-5">
		</div>
		<div class="col-md-3">
                    <a class="active" href="CRUD_TU.jsp"> <!-- meter la página que permita edición de usuarios -->
                        <%if (obtencionAdecuada){ %>
                        <h3>
                            <%=username%>
                        </h3> 
                        <%}else{%>
			<h3>
				USUARIO
			</h3>
                        <% }%>
                    </a>
		</div>
	</div>
	<div class="row">
		<div class="col-md-12 nav center-block justify-content-center">
                    <a class="nav-item nav-link" href="anuncios.jsp">Anuncios</a>
                    <a class="nav-item nav-link" href="empresa.jsp">Mi empresa</a>
                    <a class="nav-item nav-link" href="vistaOrganigrama.jsp">Organigrama</a>
                    <a class="nav-item nav-link" href="docs.jsp">Documentos</a>
                    <a class="nav-item nav-link" href="equipos.jsp">Equipos</a>
                    <a class="nav-item nav-link" href="empleados.jsp">Empleados</a>
                    <a class="nav-item nav-link" href="Administrador_new.jsp">Crud Completo</a>
		</div>
	</div>
</header>
