<%-- 
    Document   : verEquipos
    Created on : 8/12/2020, 01:41:46 AM
    Author     : maste
--%>

<%@page import="MDistribucion.Clases.EUsuarioEquipo"%>
<%@page import="MDistribucion.Clases.Equipo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="MUsuarios.clases.UsuarioEmpleado"%>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java" session="true"%>

<%
    boolean desempeño_adecuado = true;
    boolean hayEquipos = true;
    HttpSession sesion;
    UsuarioEmpleado liderDiv;
    ArrayList<Equipo> equipos = new ArrayList<Equipo>();
    int[] totalesEquipos = null;
    try{
        //Se supone que uno debe ingresar siendo ya un usuario registrado y con los privilegios adecuados
        sesion = request.getSession();
        liderDiv = (UsuarioEmpleado) sesion.getAttribute("usuario");
        equipos = Equipo.obtenerEquipos(liderDiv.getIDUsuarioE());
        if(equipos == null || equipos.size() == 0){
            System.out.println("No equipos");
            hayEquipos = false;
        }else{
            hayEquipos = true;
            totalesEquipos = new int[equipos.size()];
            for (int i = 0; i < equipos.size(); i++) {
                Equipo equip = equipos.get(i);
                totalesEquipos[i] = EUsuarioEquipo.getTotalEmpleadosEquipo(equip.getIDEquipo());
                if(totalesEquipos[i] == -1){
                    desempeño_adecuado = false;
                    break;
                }
            }
        }
        
    }catch(Exception e){
        desempeño_adecuado = false;
        hayEquipos = false;
        e.getMessage();
        e.printStackTrace();
    }

    if(!desempeño_adecuado){
        response.sendRedirect("error.jsp");
    }
%>
    
<!DOCTYPE html>
<html lang='es'>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv='X-UA-Compatible' content='IE=edge'>
        
        <title>Hamatus -Visualización de equipos-</title>
        
        <jsp:include page="Prueba-Reu/my-links-boostrap.html" />
        
    </head>
    
    <body class='container-fluid'>
        <jsp:include page="Prueba-Reu/my-head2.jsp" />
        <br>
        <div class="row">
		<div class="col-md-12 text-center">
                    <h4>Equipos de trabajo guardados</h4>
		</div>
	</div>
        <br>
            
            <%if (hayEquipos){
                for (int i = 0; i < equipos.size(); i++) {
                    Equipo eq = equipos.get(i);
                    int mod = (i+1)%3;
                    switch(mod){
                        case 1:
                    %>
            <div class="row">
                    <div class="col-md-4">
                            <div class="card text-white bg-primary">
                                    <h5 class="card-header">
                                            <%=eq.getNombre()%>
                                    </h5>
                                    <div class="card-body">
                                        <label for='tot_equip_<%=totalesEquipos[i]%>'>Total de empleados</label>
                                        <input type='number' id='tot_equip_<%=eq.getIDEquipo()%>' value='<%=totalesEquipos[i]%>'>
                                        <br>
                                        <a class='btn btn-info' href='editarEquipo.jsp?id=<%=eq.getIDEquipo()%>'>
                                            Editar equipo
                                        </a>
                                    </div>
                                    <div class='card-footer'>
                                        <a class='btn btn-danger' href='eliminarEquipo?id=<%=eq.getIDEquipo()%>'>
                                            EliminarEquipo
                                        </a>
                                    </div>
                            </div>
                    </div>
                    <%      break;
                        case 2: %>
                    <div class="col-md-4">
                            <div class="card text-white bg-primary">
                                    <h5 class="card-header">
                                            <%=eq.getNombre()%>
                                    </h5>
                                    <div class="card-body">
                                        <label for='tot_equip_<%=totalesEquipos[i]%>'>Total de empleados</label>
                                        <input type='number' id='tot_equip_<%=eq.getIDEquipo()%>' value='<%=totalesEquipos[i]%>'>
                                        <br>
                                        <a class='btn btn-info' href='editarEquipo.jsp?id=<%=eq.getIDEquipo()%>'>
                                            Editar equipo
                                        </a>
                                    </div>
                                    <div class='card-footer'>
                                        <a class='btn btn-danger' href='eliminarEquipo?id=<%=eq.getIDEquipo()%>'>
                                            Eliminar Equipo
                                        </a>
                                    </div>    
                            </div>
                    </div>
                            <% break;
                        case 0:
                            %>
                    <div class="col-md-4">
                            <div class="card text-white bg-primary">
                                    <h5 class="card-header">
                                            <%=eq.getNombre()%>
                                    </h5>
                                    <div class="card-body">
                                        <label for='tot_equip_<%=totalesEquipos[i]%>'>Total de empleados</label>
                                        <input type='number' id='tot_equip_<%=eq.getIDEquipo()%>' value='<%=totalesEquipos[i]%>'>
                                        <br>
                                        <a class='btn btn-info' href='editarEquipo.jsp?id=<%=eq.getIDEquipo()%>'>
                                            Editar equipo
                                        </a>
                                    </div>
                                    <div class='card-footer'>
                                        <a class='btn btn-danger' href='eliminarEquipo?id=<%=eq.getIDEquipo()%>'>
                                            Eliminar Equipo
                                        </a>
                                    </div>
                            </div>
                    </div>
            </div>
                    <%break;
                    }//switch
                }  // for 
            } // if
            else{%>
            <div class='row align-items-center'>
                <div class='col-md-6 card text-white bg-info'>
                    <h5 class='card-header text-capitalize'>No Hay Equipos</h5>
                </div>
                <div class='card-body'>
                    <article class='card-text'>
                        No se tienen equipos registrados en esta división.
                    </article>
                </div>
                <div class='card-footer'>
                    <a class='btn btn-success capitalize' href='Creacion_equipos.jsp'>¡Registrar un nuevo equipo!</a>
                </div>
            </div>
            <br>
            <%}%>
        <jsp:include page="Prueba-Reu/my-footer.jsp" />
    </body>
</html>