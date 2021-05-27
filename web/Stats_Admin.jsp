<%-- 
    Document   : Stats_Admin
    Created on : 13/05/2021, 08:33:23 AM
    Author     : Uzías
--%>

<%@page import="MUsuarios.clases.Empresa"%>
<%@page import="MUsuarios.clases.UsuarioEmpleado"%>
<%@page import="MDivisiones.clases.Division"%>
<%@page import="java.util.ArrayList"%>
<%@page language="java" contentType="text/html" pageEncoding="UTF-8" session="true"%>
<%
    HttpSession sesion = request.getSession();
    ArrayList<Division> divisiones = new ArrayList<Division>();
    
    //para que no explote (o eso espero)
    try {
        UsuarioEmpleado usuario = (UsuarioEmpleado) sesion.getAttribute("usuario");
        if (usuario == null){
            response.sendRedirect("inicio_sesion.jsp");
        } else {
            divisiones = Division.obtenerDivisiones( ((Empresa)sesion.getAttribute("empresa")).getIDEmpresa() );
            int id_userxd = usuario.getIDUsuarioE(); //aqui me quede xd
        }
    } catch (Exception e){
        e.getMessage();
        e.printStackTrace();
        response.sendRedirect("error.jsp");
    }
%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html">
        <title>Estadisticas - Administrador</title>
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js"></script>
        <script src="http://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>
        
        <link link rel="stylesheet" type="text/css" href="lib/morris.css">
        <script src="lib/morris.min.js"></script>
        <jsp:include page="Prueba-Reu/my-links-boostrap.html" />
    </head>
    <jsp:include page="Prueba-Reu/my-head2.jsp" />
    <body><br>
        
        <!-- Primero debo obtener el ID de la empresa, obligatoriamente para enviarlo despues a un servlet  --> 
        <!-- Se me ocurre obtener la sesion del admin, obtener el id_empresa y enviarlo con atributo hidden al servlet -->
        
        <center><h1>Estadisticas</h1></center>
        <!-- POr si hay error de fechas  -->
        <% 
        String posibleError = request.getParameter("fecha");    
            if (posibleError.equals("bad")){
        %>
        <div class="alertaxd">
            <div class="alert alert-dismissible alert-warning">
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                <h4 class="alert-heading">¡Ups!</h4>
                <p class="mb-0">Por favor asegurate de elegir las fechas de manera correcta</p>
            </div>
        </div>
        <%
            }
        %>
        <!-- POr si hay error de seleccion (la dejó en "blanco" -->
        <% 
        String posibleError2 = request.getParameter("opcion");    
            if (posibleError2.equals("bad")){
        %>
        <div class="alertaxd">
            <div class="alert alert-dismissible alert-warning">
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                <h4 class="alert-heading">¡Ups!</h4>
                <p class="mb-0">Por favor asegurate de elegir una división o equipo</p>
            </div>
        </div>
        <%
            }
        %>
        
        
        <!-- 
        Al ser un administrador puede elegir de que division o equipo de su empresa
        se mostrará la estadística
        -->
        <!-- Seleccion del periodo de tiempo -->
        <div class="formu_tiempo">
            <div class="card bg-light" id="hola">
                <div class="row justify-content-around">
                    <div class="col-5">
                            <form method="POST" action="afterFormulario">
                            <h2 id="titulazoxd">Periodo de tiempo</h2>
                            <h3 class="titxd">Del</h3> <input id="fecha_in" name="fecha_in" type="date" min="2021-01-01"
                                                              oncopy="return false" ondrag="return false"
                                                              ondrop="return false" onpaste="return false"
                                                              required="required" onchange="return fechasStats(true)"
                                                              >
                            <h3 class="titxd">Al</h3> <input id="fecha_fin" name="fecha_fin" type="date" min="2021-01-01"
                                                             oncopy="return false" ondrag="return false"
                                                              ondrop="return false" onpaste="return false"
                                                              required="required" onchange="return fechasStats(false)"
                                                             >
                            
                            <!-- Aqui van a ir los parametros invisibles, el id del usuario y el de la empresa -->
                            <input type="hidden" name="empresa_id" value="">
                            <input type="hidden" name="usuario_id" value="">
                    </div>
                    <div class="col-5">
                        <h2>División o equipo</h2>
                        <select id="eleccion" name="seleccionxd">
                            <option value="defaultxd">Seleccione una</option>
                            <% 
                            //aqui debe ir el for para imprimir las divisiones y equipos
                            //<option value="?">?</option>
                            %>
                        </select> <br>
                        <button type="submit" class="btn-dark">Generar graficas</button>
                    </div>
                    </form>
                </div>
            </div>
        </div>
              <!-- ##################### A partir de aqui vendrán las gráficas ####################### -->          
        <div class="cont_graficas">
            <div class="card bg-light" id="adios">
                <div class="row justify-content-around">
                    <div class="col-5">
                        <h2>Estadisticas generales</h2>
                        <div id="barrasxd"></div>
                        <center><h3>Archivos subidos</h3></center>
                    </div>
                    <div class="col-5">
                        <h2>Estadisticas del equipo </h2>
                        <div class="row">
                            <div class="col-6">
                                
                                    <div id="dona1xd"></div>
                                <center><h3>Flujos hechos</h3></center>
                            </div>
                            <div class="col-6">
                                <div id="dona2xd"></div>
                                <center><h3>Usuarios activos</h3></center>
                            </div>
                        </div>
                    </div>
                </div>
                <br>
                <div class="row justify-content-around">
                    <div class="col-5">
                        <div id="barras2xd"></div>
                        <center><h3>Flujos realizados</h3></center>
                    </div>
                    <div class="col-5">
                        <div id="barras3xd"></div>
                        <center><h3>Archivos subidos</h3></center>
                    </div>
                </div>
            </div>
        </div>
        
              
              
              <script src="JS/graficas_estadisticas.js"></script>
    </body>
    <jsp:include page="Prueba-Reu/my-footer.jsp" />
</html>
