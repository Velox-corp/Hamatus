<%-- 
    Document   : empresa
    Created on : 1/12/2020, 12:06:52 AM
    Author     : maste
--%>

<%@page import="MUsuarios.clases.UsuarioEmpleado"%>
<%@page import="java.io.OutputStream"%>
<%@page import="javax.sql.rowset.serial.SerialBlob"%>
<%@page import="sun.misc.IOUtils"%>
<%@page import="java.sql.Blob"%>
<%@page import="java.io.InputStream"%>
<%@page contentType="text/html" pageEncoding="UTF-8" session="true" language="java" import="MUsuarios.clases.Empresa"%>

<!DOCTYPE html>
<html lang='es'>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Empresa</title>
        <jsp:include page="Prueba-Reu/my-links-boostrap.html" />
    </head>
    <body>
        <jsp:include page="Prueba-Reu/my-head2.jsp" />
        
        <%
            HttpSession sesionEmpresa;
            Empresa emp = null;
            UsuarioEmpleado admin = null;
            boolean hayLogo = false;
            boolean obtencionAdecuada = true;
            String redirect = "";
            try{
                sesionEmpresa  = request.getSession();
                emp = (Empresa) sesionEmpresa.getAttribute("empresa");
                admin = (UsuarioEmpleado) sesionEmpresa.getAttribute("usuario");
                if(admin == null || emp == null){
                    System.out.println("No hay sesión");
                    obtencionAdecuada = false;
                    redirect = "inicio_sesion.jsp";
                }else{
                    hayLogo = (emp.getLogo() != null);
                }
            }catch(Exception e){
                redirect = "error.jsp";
                e.printStackTrace();
                obtencionAdecuada = false;
            }finally{
                if(!obtencionAdecuada){
                    response.sendRedirect(redirect);
                }
            }
        %>

        <main>
		<div class="col-md-12">
                    <div class='row'>
                        <div class='col-md-2'>
                        </div>
                        <div class='col-md-8'>
                            <center><h1><%=emp.getNombre()%></h1></center>
                        </div>
                    </div>
                    <div class='row'>
                        <div  class='col-md-8' style="margin-left: 2rem">
                            <h3>Razón Social:</h3>
                            <h3 style="color: #181818"><i><%=emp.getRazónsocial()%></i></h3>
                            <h3>Descripción:</h3>
                            <p>
                                <%=emp.getDescripcion()%>
                            </p>
                        </div>
                            <% if(hayLogo){ %>
                            <div class='col-md-3'>
                                <img class="mx-auto d-block icono img-fluid" src="cargaRegistro?id=<%=emp.getIDEmpresa()%>" alt='Logo <%=emp.getNombre()%>'>
                            </div>
                        <% } %>
                    </div>
                        <hr><br>
                  <%switch( admin.getiD_cat_priv() ){ 
                        case 1:
                    %>
                            <div style="margin-left: 2rem">
                                <h3>Opciones del Administrador de la empresa</h3><br>

                                <div class='row'>
                                    <div class='col-md-3'>
                                        <a href='divisiones.jsp' class='btn btn-dark btn-large'>
                                            Construir distribución de la empresa
                                        </a>
                                    </div>
                                    <div class='col-md-3'>
                                        <a href='Administrador_new.jsp' class='btn btn-secondary btn-large'>
                                            Crear cuentas de usuarios
                                        </a>
                                    </div>
                                    <div class='col-md-3'>
                                        <a href='Actualizar_Empresa.jsp' class='btn btn-info btn-large'>
                                            Editar información de la empresa
                                        </a>
                                    </div>
                                    <div class='col-md-3'>
                                        <a href='deleteEmpresa' class='btn btn-danger btn-large'>
                                            <strong>Borrar empresa</strong>
                                        </a>
                                    </div>
                                </div>
                            </div> 
                    <%      break;  
                        case 2: %>
                            <div style="margin-left: 2rem">
                                <h3>Opciones del Directivo de la empresa</h3><br>

                                <div class='row'>
                                    <div class='col-md-4'>
                                        <a href='divisiones.jsp' class='btn btn-dark btn-large'>
                                            Construir distribución de la empresa
                                        </a>
                                    </div>
                                </div>
                            </div>
                    <%
                            break;
                        default: 
                            break;
                    }
                    %>
		</div>
	</main>
    </body>
    <jsp:include page="Prueba-Reu/my-footer.jsp" />
</html>
