<%-- 
    Document   : Estadisticas_Directivo
    Created on : 1/06/2021, 07:11:30 AM
    Author     : Uzías
--%>

<%@page import="MDistribucion.Clases.Equipo"%>
<%@page import="MUsuarios.clases.Empresa"%>
<%@page import="MUsuarios.clases.UsuarioEmpleado"%>
<%@page import="MDivisiones.clases.Division"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.JsonObject" %>
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
        <title>Estadisticas - Directivo</title>
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
        <%
        JsonObject js = (JsonObject) request.getAttribute("esemiJSON");
        JsonObject jsD = (JsonObject) request.getAttribute("JSONDocumentos");
        JsonObject jsA = (JsonObject) request.getAttribute("JSONAEm");
        JsonObject jsDE = (JsonObject) request.getAttribute("JSONDocumentosE");
        JsonObject jsF = (JsonObject) request.getAttribute("JSONFechas");
        
        System.out.println("El json es " + js);
        System.out.println("El json docs es " + jsD);
        //int xz = 10;
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
                            <input type="hidden" name="usuario_id" value="<%= id_userxd %>">
                            <input type="hidden" name="privilegio_id" value="<%= id_privilegio %>">
                            <input type="hidden" name="division_id" value="<%= id_division %>">
                    </div> 
                    <div class="col-5">
                        <h2>División o equipo</h2>
                        <select id="eleccion" name="seleccion">
                            <option value="defaultxd">Seleccione una</option>
                            <% 
                            //aqui debe ir el for para imprimir las divisiones y equipos
                            //<option value="?">?</option>
                            for (int x=0; x < divisiones.size(); x++){
                                Division division = divisiones.get(x);
                                int temp = division.getId_Division();
                            %>
                                <option value='DI3<%=division.getId_Division() %>'><%=division.getNombre()%></option>
                            <%
                            }
                            %>
                            <!-- Aqui es para poner los equipos xd -->
                             <% 
                                for (int i=0; i<equipos.size(); i++){
                                    Equipo eq = equipos.get(i);
                                %>
                                <option value="<%= eq.getIDEquipo()%>"><%= eq.getNombre()%></option>
                                <%
                                }
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
                <div class="row justify-content-around" id="saltito">
                    <center><h1>Estadisticas del <%= jsF.get("inicio")%> al <%= jsF.get("fin")%></h1></center>
                </div>
                <div class="row justify-content-around">
                    <div class="col-5">
                        <h2>Estadisticas generales</h2>
                        <div id="dona2xd"></div>
                        <center><h3>Flujos realizados</h3></center>
                    </div>
                    <div class="col-5">
                        <h2>Estadisticas del equipo </h2>
                        
                                    <div id="dona1xd"></div>
                                <center><h3>Flujos hechos</h3></center>
                    </div>
                </div>
                <br>
                <div class="row justify-content-around">
                    <div class="col-5">
                        <div id="barrasxd"></div>
                        <center><h3>Archivos subidos</h3></center>
                    </div>
                    <div class="col-5">
                        <div id="barras3xd"></div>
                        <center><h3>Archivos subidos</h3></center>
                    </div>
                </div>
            </div>
        </div>
        
              
              <script>
            Morris.Donut({
            element: 'dona1xd',
            data: [
              {value: <%= js.get("hechos")%>, label: 'Completos'},
              {value: <%= js.get("noHechos")%>, label: 'Incompletos'}
            ],
            backgroundColor: '#FFFFFF',
            labelColor: '#000000',
            resize: true,
            colors: [
              '#0BA462',
              '#DB0606'
            ]
          });
          
          Morris.Donut({
            element: 'dona2xd',
            data: [
              {value: <%= jsA.get("hechos")%>, label: 'Completos'},
              {value: <%= jsA.get("noHechos")%>, label: 'Incompletos'}
            ],
            backgroundColor: '#FFFFFF',
            labelColor: '#000000',
            resize: true,
            colors: [
              '#0BA462',
              '#DB0606'
            ]
          });
          
          //archivos subidos                   Para el equipo xd
            Morris.Bar({
              element: 'barras3xd',
              data: [
                {x: 'Totales', y: <%= jsD.get("empresa")%>},
                {x: 'Seleccionados', y: <%= jsD.get("equipo")%>}
              ],
              resize: true,
              xkey: 'x',
              ykeys: ['y'],
              labels: ['Archivos']
            }).on('click', function(i, row){
              console.log(i, row);
            });
            
            
            //archivos subidos                   Para la empresa
            Morris.Bar({
              element: 'barrasxd',
              data: [
                {x: 'Totales', y: <%= jsDE.get("empresa")%>},
                {x: 'Seleccionados', y: <%= jsDE.get("equipo")%>}
              ],
              barColors: [
                  '#0BA462'
              ],
              resize: true,
              xkey: 'x',
              ykeys: ['y'],
              labels: ['Archivos']
            });
        </script>
    </body>
    <jsp:include page="Prueba-Reu/my-footer.jsp" />
</html>
