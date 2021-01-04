<%@page import="MUsuarios.clases.Empresa"%>
<%@page import="MUsuarios.clases.UsuarioEmpleado"%>
<%@page contentType="text/html" pageEncoding="UTF-8" session="true"%>
<link rel="stylesheet" type="text/css" href="CSS/estilos.css">
<script src="JS/Validaciones.js"></script>
<%
    HttpSession sesionUser = request.getSession();
    String username = "";
    String nombre_empresa = "";
    int idE = 0;
    boolean obtencionAdecuada = true;
    int indexCat = 1;
    int divT=0;
    try{
        UsuarioEmpleado usuario = (UsuarioEmpleado) sesionUser.getAttribute("usuario");
        Empresa emp = (Empresa) sesionUser.getAttribute("empresa");
        username = usuario.getNombre();
        nombre_empresa = emp.getNombre();
        idE = emp.getIDEmpresa();
        indexCat = usuario.getiD_cat_priv();
        divT=usuario.getiD_Division();
        //obtencionAdecuada = true; 
    }catch(NullPointerException ex){
        System.out.println("Algun error raro de null");
        System.out.println(ex.getMessage());
        ex.printStackTrace();
        obtencionAdecuada = false;
        response.sendRedirect("/error.jsp");
    }catch(Exception e){
        System.out.println("Algun error raro");
        System.out.println(e.getMessage());
        e.printStackTrace();
        obtencionAdecuada = false;
        response.sendRedirect("/error.jsp");
    }
    
%>
<header class="container-fluid">
	<div class="row header align-items-center">
		<div class="col-md-2">
                    <a href ="controlA?accion=home">
                        <img alt="Logo Hamatus" src="img/favicon.png" class="mx-auto d-block icono">
                    </a>
		</div>
                <div class="col-md-2">
                    <h2>Hamatus</h2>
                </div>
                <div class="col-md-2">
                    <%if (obtencionAdecuada){ %>
                        <i><h2>
                            <%=nombre_empresa%>
                            </h2> </i>
                        <%}else{%>
                        <i><h2>
				Empresa registrada
                            </h2></i>
                        <% }%>
                </div>
		<div class="col-md-2">
                    <%if(obtencionAdecuada){ %>
                        <img class="rounded img-fluid" src="cargaRegistro?id=<%=idE%>" alt='Logo <%=nombre_empresa%>'>
                    <%}%>
		</div>
		<div class="col-md-4">
                    <div class='btn-group'>
                        <a class="btn btn-dark" href="CRUD_TU.jsp"> <!-- meter la página que permita edición de usuarios -->
                            <%if (obtencionAdecuada){ %>
                                <%=username%>
                            <%}else{%>
                                Usuario
                            <% }%>
                        </a>
                        <a class='btn btn-dark' href="CerrarSesion">
                            Cerrar Sesión
                        </a>
                    </div>
		</div>
	</div>
        <div class="row">
            <%switch(indexCat){
                case 1: %>
                    <nav id="menu_gral" class="col-md-12 nav center-block justify-content-center" style="height: 3.6rem">
                        <ul style="background-color: #303031">
                            <li><a class="nav-item nav-link btn1" href ="controlA?accion=ListarTipo&tipo_div=<%=divT%>">Anuncios</a></li>
                            <li><a href="empresa.jsp" class="nav-item nav-link btn1">Mi empresa</a></li>
                            <li><a href="" class="nav-item nav-link btn1">Organigrama</a>
                                <ul>
                                    <li><a href="divisiones.jsp" class="sub">Divisiones</a></li>
                                    <li><a href="verEquipos.jsp" class="sub">Equipos</a></li>
                                </ul>
                            </li>
                            <li><a href="docs.jsp" class="nav-item nav-link btn1">Documentos</a></li>
                            <li><a class="nav-item nav-link btn1">Usuarios</a>
                                <ul>
                                    <li><a href="Administrador_new.jsp" class='sub' >Agregar Usuarios</a></li>
                                    <li><a href="verUsuarios.jsp" class='sub' >Ver Usuarios</a></li>
                                </ul>
                            </li>
                        </ul>
                    </nav>
                <%  break;
                case 2: %>
                    <nav id="menu_gral" class="col-md-12 nav center-block justify-content-center" style="height: 3.6rem">
                        <ul style="background-color: #303031">
                            <li><a class="nav-item nav-link btn1" href ="controlA?accion=ListarTipo&tipo_div=<%=divT%>">Anuncios</a></li>
                            <li><a href="empresa.jsp" class="nav-item nav-link btn1">Mi empresa</a></li>
                            <li><a href="" class="nav-item nav-link btn1">Organigrama</a>
                                <ul>
                                    <li><a href="divisiones.jsp" class="sub">Divisiones</a></li>
                                    <li><a href="verEquipos.jsp" class="sub">Equipos</a></li>
                                </ul>
                            </li>
                            <li><a href="docs.jsp" class="nav-item nav-link btn1">Documentos</a></li>
                            <li><a class="nav-item nav-link btn1">Usuarios</a>
                                <ul>
                                    <li><a href="verUsuarios.jsp" class='sub' >Ver Usuarios</a></li>
                                </ul>
                            </li>
                        </ul>
                    </nav>
                <%  break;
                case 3: %>
                    <nav id="menu_gral" class="col-md-12 nav center-block justify-content-center" style="height: 3.6rem">
                        <ul style="background-color: #303031">
                            <li><a class="nav-item nav-link btn1" href ="controlA?accion=home">Anuncios</a></li>
                            <li><a href="empresa.jsp" class="nav-item nav-link btn1">Mi empresa</a></li>
                            <li><a href="" class="nav-item nav-link btn1">Organigrama</a>
                                <ul>
                                    <li><a href="verEquipos.jsp" class="sub">Equipos</a></li>
                                    <li><a href="Creacion_equipos.jsp" class="sub">Crear Equipo</a></li>
                                </ul>
                            </li>
                            <li><a href="docs.jsp" class="nav-item nav-link btn1">Documentos</a></li>
                            <li><a class="nav-item nav-link btn1">Usuarios</a>
                                <ul>
                                    <li><a href="verUsuarios.jsp" class='sub' >Ver Usuarios</a></li>
                                </ul>
                            </li>
                        </ul>
                    </nav>
                <%  break;
                case 4: %>
                    <nav id="menu_gral" class="col-md-12 nav center-block justify-content-center" style="height: 3.6rem">
                        <ul style="background-color: #303031">
                            <li><a class="nav-item nav-link btn1" href ="controlA?accion=home">Anuncios</a></li>
                            <li><a href="empresa.jsp" class="nav-item nav-link btn1">Mi empresa</a></li>
                            <li><a href="" class="nav-item nav-link btn1">Organigrama</a>
                                <ul>
                                    <li><a href="MyEquipo.jsp" class="sub">Mi Equipo</a></li>
                                </ul>
                            </li>
                            <li><a href="docs.jsp" class="nav-item nav-link btn1">Documentos</a></li>
                        </ul>
                    </nav>
                    <% break;
            }%> 
	</div>
</header>
        <br>