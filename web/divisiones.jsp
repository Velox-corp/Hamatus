<%@page import="MUsuarios.clases.UsuarioEmpleado"%>
<%@page import="MDivisiones.clases.Division"%>
<%@page import="java.util.ArrayList"%>
<%@page language="java" pageEncoding="UTF-8" contentType="text/html" session="true"%>
<%
    boolean obtencionAdecuada = true;
    boolean hayDivisiones = true;
    HttpSession sesion;
    Division idemp;
    ArrayList<Division> divisiones = new ArrayList<Division>();
    int[] totalesDivisiones = null;
    try{
        //Se supone que uno debe ingresar siendo ya un usuario registrado y con los privilegios adecuados
        sesion = request.getSession();
        idemp = (Division) sesion.getAttribute("division");
        divisiones = Division.obtenerDivisiones(idemp.getId_Empresa());
        if(divisiones == null || divisiones.size() == 0){
            System.out.println("No divisiones");
            hayDivisiones = false;
        }else{
            hayDivisiones = true;
            totalesDivisiones = new int[divisiones.size()];
            for (int i = 0; i < divisiones.size(); i++) {
                Division div = divisiones.get(i);
            }
        }
        
    }catch(Exception e){
        obtencionAdecuada = false;
        hayDivisiones = false;
        e.getMessage();
        e.printStackTrace();
    }

    if(!obtencionAdecuada){
        response.sendRedirect("error.jsp");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Divisiones</title>
        <jsp:include page="Prueba-Reu/my-links-boostrap.html" />
    </head>
    <jsp:include page="Prueba-Reu/my-head2.jsp" />
    <body><br>
        <center><h1>Divisiones</h1></center>
        <div class="container margin-top-2rem">   
            <div class="row d-flex justify-content-center">
              <div class="col-sm-8">
                <form action="crearDivision" method="POST"  >
                    <h2>Crear Nueva División</h2>
                    <hr>
                    <div class="form-group">
                        <label for="nombreD">Nombre:</label>
                        <input type="text" class="form-control" id="nombreD" name="nombreD" 
                               onchange="return validarString(this, true, false)"
                               ondrag="return validarString(this, true, false)"
                               ondrop="return validarString(this, true, false)">
                    </div>
                    <div class="form-group">
                        <div class="col-md-8">
                          <button id="submit" name="submit" class="btn btn-dark" value="1">Registrar</button>
                          <a href="" id="cancel" name="cancel" class="btn btn-default">Cancelar</a>
                        </div>
                    </div>
                </form>
                <form role="form" method="POST" action='eliminarDivision'>
                    <hr>
                    <h2>Divisiones Actuales</h2>
                    <hr>
                        <div class="input-group mb-3">		 
                            <div class="input-group-prepend">
                                <span class="input-group-text">Nombre:</span>
                            </div>
                            <input type="text" class="form-control" id="nombreD" name='nombreD' readonly ='readonly'
                                   <% if (obtencionAdecuada) {
                                       for (int i = 0; i < divisiones.size(); i++) {
                                            Division div = divisiones.get(i);
                                    %>
                                   value="<%=div.getNombre()%>"
                                   <%}}
                                   
                                   
                                   %>
                                   onchange="return validarString(this, true, false)"
                                   ondrag="return validarString(this, true, false)"
                                   ondrop="return validarString(this, true, false)">
                            <div class='input-group-append'>
                            <button class="btn btn-info" onclick='return cambiarEstado("nombreD")'>Eliminar</button>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-dark">
                        Actualizar información
                    </button>
                </form>
              </div>
            </div>
        </div><br>
    </body>
    <jsp:include page="Prueba-Reu/my-footer.jsp" />
</html>
