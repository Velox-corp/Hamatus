<%@page import="MUsuarios.clases.Empresa"%>
<%@page import="MUsuarios.clases.UsuarioEmpleado"%>
<%@page contentType="text/html" pageEncoding="utf-8" session="true"%>
<script src="JS/Validaciones.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">

<%
    HttpSession sesionUser = request.getSession();
    String username = "";
    String nombre_empresa = "";
    int idE = 0;
    boolean obtencionAdecuada = true;
    int indexCat = 1;
    int divT=0;
    boolean hayLogo = false;
    String redir = "";
    try{
        UsuarioEmpleado usuario = (UsuarioEmpleado) sesionUser.getAttribute("usuario");
        Empresa emp = (Empresa) sesionUser.getAttribute("empresa");
        if(usuario == null || emp == null){
            System.out.println("No hay sesión");
            obtencionAdecuada = false;
            redir = "inicio_sesion.jsp";
        }else{
            username = usuario.getNombre();
            nombre_empresa = emp.getNombre();
            idE = emp.getIDEmpresa();
            hayLogo = (emp.getLogo() != null);
            indexCat = usuario.getiD_cat_priv();
            divT=usuario.getiD_Division();
            obtencionAdecuada = true; 
        }
    }catch(NullPointerException ex){
        System.out.println("Algun error raro de null");
        System.out.println(ex.getMessage());
        ex.printStackTrace();
        obtencionAdecuada = false;
        redir = "error.jsp";
    }catch(Exception e){
        System.out.println("Algun error raro");
        System.out.println(e.getMessage());
        e.printStackTrace();
        obtencionAdecuada = false;
        redir = "error.jsp";
    }
    if(!obtencionAdecuada){
        response.sendRedirect(redir);
    }%>
<header class="container-fluid">
	<div class="row header2 align-items-center">
		<div class="col-md-2">
                    <a href ="controlA?accion=home">
                        <img alt="Logo Hamatus" src="img/favicon.png" class="mx-auto d-block icono">
                    </a>
		</div>
                <div class="col-md-2">
                    <h2 style="font-size: 28px">Hamatus</h2>
                </div>
                <div class="col-md-2">
                    <%if (obtencionAdecuada){ %>
                        <i><h2 style="font-size: 28px">
                            <%=nombre_empresa%>
                            </h2> </i>
                        <%}else{%>
                        <i><h2>
				Empresa registrada
                            </h2></i>
                        <% }%>
                </div>
		<div class="col-md-2">
                    <%if(obtencionAdecuada &&  hayLogo){ %>
                        <img class="mx-auto d-block icono" src="cargaRegistro?id=<%=idE%>" alt='Logo <%=nombre_empresa%>'>
                    <%}%>
		</div>
		<div class="col-md-4">
                    <div class='btn-group'>
                        <a class="btn btn-dark" href="CRUD_TU.jsp" style="font-size: 16px; background-color: #303031"> <!-- meter la página que permita edición de usuarios -->
                            <%if (obtencionAdecuada){ %>
                                <%=username%>
                            <%}else{%>
                                Usuario
                            <% }%>
                        </a>
                        <a class='btn btn-dark' href="CerrarSesion" style="font-size: 16px; background-color: #303031">
                            Cerrar Sesión
                        </a>
                    </div>
		</div>
	</div>
        <div class="row">
            <%switch(indexCat){
                case 1: %>
                    <nav id="menu_gral" class="col-md-12 nav center-block justify-content-center" style="height: 5rem">
                        <ul style="background-color: #303031">
                            <li><a class="nav-item nav-link btn1" href ="controlA?accion=home" style="font-size: 12px; padding: 16px">Anuncios</a></li>
                            <li><a href="empresa.jsp" class="nav-item nav-link btn1" style="font-size: 12px; padding: 16px">Mi empresa</a></li>
                            <li><a href="" class="nav-item nav-link btn1" style="font-size: 12px; padding: 16px">Organigrama</a>
                                <ul>
                                    <li><a href="divisiones.jsp" class="sub2" style="font-size: 12px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Divisiones</a></li>
                                    <li><a href="verEquipos.jsp" class="sub2" style="font-size: 12px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Equipos</a></li>
                                    <li><a href="verFlujosTrabajo.jsp" class="sub2" style="font-size: 12px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ver <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;flujos <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;de <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;trabajo</a></li>
                                </ul>
                            </li>
                            <li><a href="docs2.jsp" class="nav-item nav-link btn1" style="font-size: 12px; padding: 16px">Documentos</a></li>
                            <li><a class="nav-item nav-link btn1" style="font-size: 12px; padding: 16px; padding: 16px">Empleados</a>
                                <ul>
                                    <li><a href="Administrador_new.jsp" class='sub2' style="font-size: 12px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Agregar <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Empleados</a></li>
                                    <li><a href="verUsuarios.jsp" class='sub2' style="font-size: 12px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ver <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Empleados</a></li>
                                </ul>
                            </li>
                            <li><a href="Chat.jsp" class="nav-item nav-link btn1" style="font-size: 12px; padding: 16px">Chat</a></li>
                            <li><a href="Stats_Admin.jsp" class="nav-item nav-link btn1" style="font-size: 12px; padding: 16px">Estadísticas</a></li>
                            
                        </ul>
                    </nav>
                <%  break;
                case 2: %>
                    <nav id="menu_gral" class="col-md-12 nav center-block justify-content-center" style="height: 5rem">
                        <ul style="background-color: #303031">
                            <li><a class="nav-item nav-link btn1" href ="controlA?accion=home" style="font-size: 12px; padding: 16px">Anuncios</a></li>
                            <li><a href="empresa.jsp" class="nav-item nav-link btn1" style="font-size: 12px; padding: 16px">Mi empresa</a></li>
                            <li><a href="" class="nav-item nav-link btn1" style="font-size: 12px; padding: 16px">Organigrama</a>
                                <ul>
                                    <li><a href="divisiones.jsp" class="sub2" style="font-size: 12px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Divisiones</a></li>
                                    <li><a href="verEquipos.jsp" class="sub2" style="font-size: 12px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Equipos</a></li>
                                    <li><a href="verFlujosTrabajo.jsp" class="sub2" style="font-size: 12px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ver <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;flujos <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;de <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;trabajo</a></li>
                                </ul>
                            </li>
                            <li><a href="docs2.jsp" class="nav-item nav-link btn1" style="font-size: 12px; padding: 16px">Documentos</a></li>
                            <li><a class="nav-item nav-link btn1" style="font-size: 12px; padding: 16px">Empleados</a>
                                <ul>
                                    <li><a href="verUsuarios.jsp" class='sub2' style="font-size: 12px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ver <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Empleados</a></li>
                                </ul>
                            </li>
                            <li><a href="Chat.jsp" class="nav-item nav-link btn1" style="font-size: 12px; padding: 16px">Chat</a></li>
                            <li><a href="Stats_Directivo.jsp" class="nav-item nav-link btn1" style="font-size: 12px; padding: 16px">Estadísticas</a></li>
                        </ul>
                    </nav>
                <%  break;
                case 3: %>
                    <nav id="menu_gral" class="col-md-12 nav center-block justify-content-center" style="height: 5rem">
                        <ul style="background-color: #303031">
                            <li><a class="nav-item nav-link btn1" href ="controlA?accion=home" style="font-size: 12px; padding: 16px">Anuncios</a></li>
                            <li><a href="empresa.jsp" class="nav-item nav-link btn1" style="font-size: 12px; padding: 16px">Mi empresa</a></li>
                            <li><a href="" class="nav-item nav-link btn1" style="font-size: 12px; padding: 16px">Organigrama</a>
                                <ul>
                                    <li><a href="verEquipos.jsp" class="sub2" style="font-size: 12px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ver <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Equipos</a></li>
                                    <li><a href="Creacion_equipos.jsp" class="sub2" style="font-size: 12px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Crear <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Equipo</a></li>
                                    <li><a href="verFlujosTrabajo.jsp" class="sub2" style="font-size: 12px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ver <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;flujos <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;de <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;trabajo</a></li>
                                </ul>
                            </li>
                            <li><a href="docs2.jsp" class="nav-item nav-link btn1" style="font-size: 12px; padding: 16px">Documentos</a></li>
                            <li><a class="nav-item nav-link btn1" style="font-size: 12px; padding: 16px">Empleados</a>
                                <ul>
                                    <li><a href="verUsuarios.jsp" class='sub2' style="font-size: 12px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ver <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Empleados</a></li>
                                </ul>
                            </li>
                            <li><a href="Chat.jsp" class="nav-item nav-link btn1" style="font-size: 12px; padding: 16px">Chat</a></li>
                            <li><a href="Stats_Lider.jsp" class="nav-item nav-link btn1" style="font-size: 12px; padding: 16px">Estadísticas</a></li>
                        </ul>
                    </nav>
                <%  break;
                case 4: %>
                    <nav id="menu_gral" class="col-md-12 nav center-block justify-content-center" style="height: 5rem">
                        <ul style="background-color: #303031">
                            <li><a class="nav-item nav-link btn1" href ="controlA?accion=home" style="font-size: 12px; padding: 16px">Anuncios</a></li>
                            <li><a href="empresa.jsp" class="nav-item nav-link btn1" style="font-size: 12px; padding: 16px">Mi empresa</a></li>
                            <li><a href="" class="nav-item nav-link btn1" style="font-size: 12px; padding: 16px">Organigrama</a>
                                <ul>
                                    <li><a href="MyEquipo.jsp" class="sub2" style="font-size: 12px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Mi <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Equipo</a></li>
                                    <li><a href="verFlujosTrabajo.jsp" class="sub2" style="font-size: 12px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ver <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;flujos <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;de <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;trabajo</a></li>
                                </ul>
                            </li>
                            <li><a href="docs2.jsp" class="nav-item nav-link btn1" style="font-size: 12px; padding: 16px">Documentos</a></li>
                            <li><a href="Chat.jsp" class="nav-item nav-link btn1" style="font-size: 12px; padding: 16px">Chat</a></li>
                        </ul>
                    </nav>
                    <% break;
            }%> 
	</div>
</header>
        <br>