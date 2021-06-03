<%@page import="MUsuarios.clases.Empresa"%>
<%@page import="MDivisiones.clases.divi"%>
<%@page import="MDivisiones.clases.Division"%>
<%@page import="java.util.ArrayList"%>
<%@page import="MUsuarios.clases.UsuarioEmpleado"%>
<%@page language="java" pageEncoding="UTF-8" contentType="text/html" session="true"%>
<%
    HttpSession sesion = request.getSession();
    boolean obtencionAdecuada = true;
    String redirect = "";
    ArrayList<Division> divisiones = new ArrayList<Division>();
    try {
        UsuarioEmpleado usuario = (UsuarioEmpleado) sesion.getAttribute("usuario");
        if(usuario == null ){
            System.out.println("No hay sesión");
            obtencionAdecuada = false;
            redirect = "inicio_sesion.jsp";
        }else{
            obtencionAdecuada = true;
            divisiones = Division.obtenerDivisiones( ((Empresa)sesion.getAttribute("empresa")).getIDEmpresa() );
        }
    } catch (NullPointerException e) {
        obtencionAdecuada = false;
        redirect = "error.jsp";
    }
    if(!obtencionAdecuada){
        response.sendRedirect(redirect);
    }
%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html">
        <title>Divisiones</title>
        <jsp:include page="Prueba-Reu/my-links-boostrap.html" />
    </head>
    <jsp:include page="Prueba-Reu/my-head2.jsp" />
    <body><br>
        <center><h1>Divisiones</h1></center>
        <div class="container margin-top-2rem">   
            <div class="row d-flex justify-content-center">
              <div class="col-sm-8">
                <% if (obtencionAdecuada) {%>
                <form action="crearDivision" method="POST"  >
                    <h2>Crear Nueva División</h2>
                    <hr>
                    <div class="form-group">
                        <label for="nombreD">Nombre:</label>
                        <input type="text" class="form-control" id="nombreD" name="nombreD" 
                               onchange="return validarString(this, true, false)"
                               ondrag="return validarString(this, true, false)"
                               ondrop="return validarString(this, true, false)" oncopy="return false" onpaste="return false" autocomplete="off" ondrag="return false"  ondrop="return false" required="required">
                    </div>
                    <div class="form-group">
                        <div class="col-md-8">
                          <button id="submit" name="submit" class="btn btn-dark mrd" value="1">Registrar</button>
                          <a href="" id="cancel" name="cancel" class="btn btn-secondary btn-large">Cancelar</a>
                        </div>
                    </div>
                </form>
                <hr>
                <h2>Divisiones Actuales</h2>
                <hr>
                <% for (int i = 0; i < divisiones.size(); i++) {
                                Division division = divisiones.get(i);%> 
                                <div class="input-group mb-3" style="background-color: #e9ecef">		 
                                    <div class="input-group-prepend">
                                        <span class="input-group-text">Nombre:</span>
                                    </div>
                                    <input class="h4 form-control" value='<%=division.getNombre()%>' readonly='readonly'/>
                                    <% if(division.getId_Jerarquia() != 1){ %>
                                    <div class="input-group-append">
                                        <a href="javascript:funcion()">
                                            <a class="btn btn-danger btn-large" href="eliminarDivision?id=<%=division.getId_Division()%>" onclick="return confirmation()">ELIMINAR</a>
                                    </div>
                                    <% } %>
                                </div>                                
                        <%   }
                     %>
                <%}%>
              </div>
            </div>
        </div><br>
    </body>
    <jsp:include page="Prueba-Reu/my-footer.jsp" />
</html>
