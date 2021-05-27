<%-- 
    Document   : Stats_Admin
    Created on : 13/05/2021, 08:33:23 AM
    Author     : Uzías
--%>

<%@page language="java" contentType="text/html" pageEncoding="UTF-8" session="true"%>
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
        <center><h1>Estadisticas</h1></center>
        <!-- 
        Al ser un administrador puede elegir de que division o equipo de su empresa
        se mostrará la estadística
        -->
        <!-- Seleccion del periodo de tiempo -->
        <div class="formu_tiempo">
            <div class="card bg-light" id="hola">
                <div class="row justify-content-around">
                    <div class="col-5">
                            <form method="" action="#">
                            <h2 id="titulazoxd">Periodo de tiempo</h2>
                            <h3 class="titxd">Del</h3> <input id="fecha_in" type="date">
                            <h3 class="titxd">Al</h3> <input id="fecha_fin" type="date">
                    </div>
                    <div class="col-5">
                        <button type="submit" class="btn-dark">Generar graficas</button>
                    </div>
                    </form>
                </div>
            </div>
        </div>
              <!-- A partir de aqui vendrán las gráficas -->          
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