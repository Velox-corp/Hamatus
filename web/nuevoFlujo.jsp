<%-- 
    Documento   : nuevoFlujo
    Fecha y hora de creación: : 27/04/2021, 11:39:36 PM
    Author     : Armando Jarillo
--%>
<%@page import="MDistribucion.Clases.Equipo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="MUsuarios.clases.UsuarioEmpleado"%>
<%@page import="MUsuarios.clases.Empresa"%>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java" session="true"%>
<!DOCTYPE html>
<html lang='es'>
    <head>
        <meta http-equiv="Content-Type" content="text/html">
        <meta charset="utf-8">
        <title>Crear nuevo flujo de trabajo</title>
        <jsp:include page="Prueba-Reu/my-links-boostrap.html" />
    </head>
    <body>
        <jsp:include page="Prueba-Reu/my-head2.jsp" />
        <%
            HttpSession sesionEmpresa;
            UsuarioEmpleado liderDiv = null;
            ArrayList<Equipo> equipos = new ArrayList<Equipo>();
            try{
                sesionEmpresa = request.getSession();
                if(liderDiv == null){
                    
                    response.sendRedirect("inicio_sesion.jsp");
                }
                liderDiv = (UsuarioEmpleado) sesionEmpresa.getAttribute("usuario");
                if(liderDiv.getiD_cat_priv() != 3) response.sendRedirect("error.jsp");
                equipos = Equipo.obtenerEquipos(liderDiv.getiD_Division());
            }catch(Exception e){
                e.printStackTrace();
            }
            
        %>
        <div class='row text-center'>
            <h2 class='col-md-12 text-center'>Ingresar un nuevo flujo de trabajo</h2>
        </div>
        <main class="row margin-top-1rem">
            <div class="col-md-3">
            </div>
            <div class="col-md-6">
                <form action="crearFlujo" method="post" class="card">
                    <h5 class="card-header">
                        Crear nuevo flujo de trabajo
                    </h5>
                    <div class="card-body">
                            <div class="form-group mb-2">
                                <label for="titulof">Titulo</label>
                                <input type="text" class="form-control" id="titulof" name="titulof" placeholder="Titulo" required="required"
                                    onchange="return validarString(this, true, false)"
                                    ondrag="return validarString(this, true, false)"
                                    ondrop="return validarString(this, true, false)" 
                                       >
                            </div>
                            <div class="form-group mb-2">
                                <label for="descripcionf">Descripcion</label>
                                <textarea type="text" class="form-control" id="descripcionf" name="descripcionf" placeholder="Descripción del flujo" required="required"
                                        onchange="return validarStringLong(this)"
                                        onkeydown="return validarStringLongTecla(event,this)"
                                        ondrag="return validarStringLong(this)"
                                        ondrop="return validarStringLong(this)"
                                        oninput="contadorCatacteres(event)"
                                        
                                        maxlength="200"></textarea>
                                <span id="contador">0/200</span>
                            </div>
                            <div class="form-group mb-2">
                                <label for="fechal">Fecha limite</label>
                                <input type="date" class="form-control" id="fecha_l" name="fecha_l" required="required" onchange="return validarDate(this)">
                            </div>
                            <div class="form-group mb-2">
                                <label for="hora_l">Hora limite</label>
                                <input type="time" class="form-control" id="hora_l" name="hora_l"  required="required">
                            </div>  
                            <div class="form-group mb-2">
                                <label for="equipo">Equipo asignado</label>
                                <select id="equipo" name='equipo'>
                                    <option value='0' selected>Seleccione un equipo de trabajo</option>
                                    <% for (int i = 0; i < equipos.size(); i++) { 
                                    Equipo eq = equipos.get(i); %>
                                    <option value="<%=eq.getIDEquipo()%>" ><%=eq.getNombre()%></option>
                                    <% } %>
                                </select>
                            </div>
                    </div>
                    <div class="card-footer">
                        <button type="submit" name="enviar" class="btn btn-primary">Crear nuevo flujo <i class="fa fa-floppy-o" aria-hidden="true"></i></button>
                    </div>
                </form>

            </div>
        </main>
        <jsp:include page="Prueba-Reu/my-footer.jsp" />
    </body>
</html>
