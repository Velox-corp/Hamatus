<%-- 
    Document   : Stats_Admin
    Created on : 13/05/2021, 08:33:23 AM
    Author     : Uzías
--%>
<%@page import="MDistribucion.Clases.Equipo"%>
<%@page import="MUsuarios.clases.Empresa"%>
<%@page import="MUsuarios.clases.UsuarioEmpleado"%>
<%@page import="MDivisiones.clases.Division"%>
<%@page import="java.util.ArrayList"%>
<%@page language="java" contentType="text/html" pageEncoding="UTF-8" session="true"%>
<%
    
    HttpSession sesion = request.getSession();
    ArrayList<Division> divisiones = new ArrayList<Division>();
    ArrayList<Equipo> equipos = new ArrayList<Equipo>();
    int id_userxd = -1;
    int id_privilegio = 0;
    int id_division = 0;
    
    //para que no explote (o eso espero)
    try {
        UsuarioEmpleado usuario = (UsuarioEmpleado) sesion.getAttribute("usuario");
        if (usuario == null){
            response.sendRedirect("inicio_sesion.jsp");
        } else {
            divisiones = Division.obtenerDivisiones( ((Empresa)sesion.getAttribute("empresa")).getIDEmpresa() );
            equipos = Equipo.obtenerAllEquipos( ((Empresa)sesion.getAttribute("empresa")).getIDEmpresa() );
            id_userxd = usuario.getIDUsuarioE(); //aqui me quede xd
            id_division = usuario.getiD_Division();
            if (id_userxd > -1){
                id_privilegio = usuario.getiD_cat_priv();
            }
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
        <title>Estadisticas - Lider</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>
        
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
        try {
            String posibleError = request.getParameter("fecha");
            if(posibleError.equals("bad")){
        %>
        <div class="alertaxd">
            <div class="alert alert-dismissible alert-warning">
                <h4 class="alert-heading">¡Ups!</h4>
                <p class="mb-0">Por favor asegurate de elegir las fechas de manera correcta</p>
            </div>
        </div>
        <%
            }
        } catch (NullPointerException f){
            System.out.println("Finisimo, esto es lo que debe pasar, no hay variables en la url");
        }
        %>
        
        <!-- POr si hay error de seleccion (la dejó en "blanco" -->
        <% 
        try {
         String posibleError2 = request.getParameter("opcion");    
          if (posibleError2.equals("bad")){
        %>
        <div class="alertaxd">
            <div class="alert alert-dismissible alert-warning">
                <h4 class="alert-heading">¡Ups!</h4>
                <p class="mb-0">Por favor asegurate de elegir una división o equipo</p>
            </div>
        </div>
        <%
              
          }
        } catch(NullPointerException f){
          System.out.println("Fino señores, es normal xd");      
        }
            
        %>
        
        <% 
        try {
         String posibleError3 = request.getParameter("noteam");    
          if (posibleError3.equals("bad")){
        %>
        <div class="alertaxd">
            <div class="alert alert-dismissible alert-danger">
                <h4 class="alert-heading">¡Ups!</h4>
                <p class="mb-0">Parece que no es posible mostrar las estadisticas para el equipo o división seleccionado</p>
                <p class="mb-0">Probablemente no haya equipos registrados, o flujos de trabajo para obtener estadisticas</p>
            </div>
        </div>
        <%
              
          }
        } catch(NullPointerException f){
          System.out.println("Fino señores, es normal xd");      
        }
            
        %>
        
        <!-- 
        Al ser un administrador puede elegir de que division o equipo de su empresa
        se mostrará la estadística
        -->
        <!-- Seleccion del periodo de tiempo -->
        <div class="formu_tiempo">
            <div class="container bs" id="hola">
                <div class="row justify-content-around">
                    <div class="col-5">
                            <form method="POST" action="afterFormulario">
                            <h2 id="titulazoxd" class="text-white">Periodo de tiempo</h2>
                            <h3 class="titxd text-white">Del</h3> <input id="fecha_in" name="fecha_in" type="date" min="2021-01-01"
                                                              oncopy="return false" ondrag="return false"
                                                              ondrop="return false" onpaste="return false"
                                                              required="required" onchange="return fechasStats(true)"
                                                              >
                            <h3 class="titxd text-white"><br>Al</h3> <input id="fecha_fin" name="fecha_fin" type="date" min="2021-01-01"
                                                             oncopy="return false" ondrag="return false"
                                                              ondrop="return false" onpaste="return false"
                                                              required="required" onchange="return fechasStats(false)"
                                                             >
                            
                            <!-- Aqui van a ir los parametros invisibles, el id del usuario y el de la empresa -->
                            <input type="hidden" name="usuario_id" value="<%= id_userxd %>">
                            <input type="hidden" name="privilegio_id" value="<%= id_privilegio %>">
                            <input type="hidden" name="division_id" value="<%= id_division %>">
                    </div>
                    <div class="col-5">
                        <input type="hidden" name="seleccion" value="DI3<%= id_division %>">
                        <button type="submit" class="btn btn-dark btn-large">Generar graficas</button><br>
                    </div>
                    </form>
                </div>
            </div>
        </div>
    <jsp:include page="Prueba-Reu/my-footer.jsp" />
</html>
