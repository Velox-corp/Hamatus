<%-- 
    Document   : verEquipos
    Created on : 8/12/2020, 01:41:46 AM
    Author     : maste
--%>

<%@page import="MDivisiones.clases.Division"%>
<%@page import="MUsuarios.clases.Empresa"%>
<%@page import="MDistribucion.Clases.EUsuarioEquipo"%>
<%@page import="MDistribucion.Clases.Equipo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="MUsuarios.clases.UsuarioEmpleado"%>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java" session="true"%>

<%
    boolean obtencionAdecuada = true;
    String redirect = "";
    boolean sonTotales = false;
    boolean hayEquipos = true;
    HttpSession sesion;
    UsuarioEmpleado liderDiv = null;
    ArrayList<Equipo> equipos = new ArrayList<Equipo>();
    int[] totalesEquipos = null;
    try{
        //Se supone que uno debe ingresar siendo ya un usuario registrado y con los privilegios adecuados
        sesion = request.getSession();
        liderDiv = (UsuarioEmpleado) sesion.getAttribute("usuario");
        if(liderDiv == null){
            obtencionAdecuada = false;
            redirect = "inicio_sesion.jsp";
        }else{
            switch(liderDiv.getiD_cat_priv()){
                case 1:
                    equipos = Equipo.obtenerAllEquipos( ((Empresa)sesion.getAttribute("empresa")).getIDEmpresa() );
                    sonTotales = true;
                    break;
                case 2:
                    equipos = Equipo.obtenerAllEquipos(((Empresa)sesion.getAttribute("empresa")).getIDEmpresa());
                    sonTotales = true;
                    break;
                case 3:
                    equipos = Equipo.obtenerEquipos(liderDiv.getiD_Division());
                    sonTotales = false;
                    break;
                case 4:
                    obtencionAdecuada = false;
                    redirect = "error.jsp";
                    break;
            }
        
            if(equipos == null || equipos.size() == 0){
                hayEquipos = false;
            }else{
                hayEquipos = true;
                totalesEquipos = new int[equipos.size()];
                for (int i = 0; i < equipos.size(); i++) {
                    Equipo equip = equipos.get(i);
                    totalesEquipos[i] = EUsuarioEquipo.getTotalEmpleadosEquipo(equip.getIDEquipo());
                    if(totalesEquipos[i] == -1){
                        obtencionAdecuada = false;
                        redirect = "error.jsp";
                        break;
                    }
                }
            }
        }
    }catch(Exception e){
        obtencionAdecuada = false;
        redirect = "error.jsp";
        hayEquipos = false;
        e.getMessage();
        e.printStackTrace();
    }

    if(!obtencionAdecuada){
        response.sendRedirect(redirect);
    }
%>
    
<!DOCTYPE html>
<html lang='es'>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv='X-UA-Compatible' content='IE=edge'>
        
        <title>Visualización de equipos</title>
        
        <jsp:include page="Prueba-Reu/my-links-boostrap.html" />
        
    </head>
    
    <body>
        <jsp:include page="Prueba-Reu/my-head2.jsp" />
        <div class="container margin-top-1rem">
            <center><h1>Equipos de trabajo guardados</h1></center>
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
                            <div class="card text-white" style="background-color: #6c757d">
                                    <h5 class="card-header">
                                            <%=eq.getNombre()%>
                                    </h5>
                                    <div class="card-body text-center ">
                                        Total de empleados: <strong><%=totalesEquipos[i]%></strong>
                                    <% if(sonTotales){ %>
                                        <br>
                                        Division: <strong><%=Division.traducirID(eq.getIDDivision())%> </strong>
                                        <br>
                                        <a class="btn btn-dark text-center margin-top-1rem" href='listaDeEmpleados.jsp?id=<%=eq.getIDEquipo()%>'>
                                            Ver integrantes del equipo
                                        </a>
                                        </div>  
                                    <% } else{ %>
                                        <br>
                                        <a class="btn btn-dark text-center margin-top-1rem" href='listaDeEmpleados.jsp?id=<%=eq.getIDEquipo()%>'>
                                            Ver integrantes del equipo
                                        </a>
                                        
                                        <a class='btn btn-dark text-center margin-top-1rem' href='editarEquipo.jsp?id=<%=eq.getIDEquipo()%>'>
                                            Editar equipo
                                        </a>
                                        </div>
                                        <div class='card-footer text-center'>
                                            <a class='btn btn-info text-center' href='eliminarEquipo?id=<%=eq.getIDEquipo()%>'>
                                                Eliminar equipo
                                            </a>
                                        </div>
                                    <% } %>
                            </div>
                    </div><br>
                    <%      break;
                        case 2: %>
                    <div class="col-md-4">
                            <div class="card text-white" style="background-color: #6c757d">
                                    <h5 class="card-header">
                                            <%=eq.getNombre()%>
                                    </h5>
                                    <div class="card-body text-center ">
                                        Total de empleados: <strong><%=totalesEquipos[i]%></strong>
                                    <% if(sonTotales){ %>
                                        <br>
                                        Division: <strong><%=Division.traducirID(eq.getIDDivision())%> </strong>
                                        <br>
                                        <a class="btn btn-dark text-center margin-top-1rem" href='listaDeEmpleados.jsp?id=<%=eq.getIDEquipo()%>'>
                                            Ver integrantes del equipo
                                        </a>
                                        </div>  
                                    <% } else{ %>
                                        <br>
                                        <a class="btn btn-dark text-center margin-top-1rem" href='listaDeEmpleados.jsp?id=<%=eq.getIDEquipo()%>'>
                                            Ver integrantes del equipo
                                        </a>
                                        
                                        <a class='btn btn-dark text-center margin-top-1rem' href='editarEquipo.jsp?id=<%=eq.getIDEquipo()%>'>
                                            Editar equipo
                                        </a>
                                        </div>
                                        <div class='card-footer text-center'>
                                            <a class='btn btn-info text-center' href='eliminarEquipo?id=<%=eq.getIDEquipo()%>'>
                                                Eliminar equipo
                                            </a>
                                        </div>
                                    <% } %>
                            </div>
                    </div><br>
                            <% break;
                        case 0:
                            %>
                    <div class="col-md-4">
                            <div class="card text-white" style="background-color: #6c757d">
                                    <h5 class="card-header">
                                            <%=eq.getNombre()%>
                                    </h5>
                                    <div class="card-body text-center ">
                                        Total de empleados: <strong><%=totalesEquipos[i]%></strong>
                                        <% if(sonTotales){ %>
                                            <br>
                                            Division: <strong><%=Division.traducirID(eq.getIDDivision())%> </strong>
                                            <br>
                                            <a class="btn btn-dark text-center margin-top-1rem" href='listaDeEmpleados.jsp?id=<%=eq.getIDEquipo()%>'>
                                                Ver integrantes del equipo
                                            </a>
                                            </div>  
                                        <% } else{ %>
                                            <br>
                                            <a class="btn btn-dark text-center margin-top-1rem" href='listaDeEmpleados.jsp?id=<%=eq.getIDEquipo()%>'>
                                                Ver integrantes del equipo
                                            </a>

                                            <a class='btn btn-dark text-center margin-top-1rem' href='editarEquipo.jsp?id=<%=eq.getIDEquipo()%>'>
                                                Editar equipo
                                            </a>
                                            </div>
                                            <div class='card-footer text-center'>
                                                <a class='btn btn-info text-center' href='eliminarEquipo?id=<%=eq.getIDEquipo()%>'>
                                                    Eliminar equipo
                                                </a>
                                            </div>
                                        <% } %>
                            </div>
                    </div>
                </div><br>
                    <%break;
                    }//switch
                }  // for 
                if(equipos.size() % 3 != 0){ %>
                </div>
            <% } %>
            <br>
            <%if(liderDiv.getiD_cat_priv() == 3){ %>
                <a class='btn btn-primary ' href='Creacion_equipos.jsp'>¡Registrar un nuevo equipo!</a>
                
            <%  }
             }else{
            if(liderDiv.getiD_cat_priv() == 3){ %>
            
                <div class='row d-flex justify-content-center'>
                    <div class='col-md-6 card align-items-center text-white' style="background-color: #2291C1">
                        <h5 class='card-header text-capitalize'>No Hay Equipos</h5>

                        <div class='card-body'>
                            <article class='card-text'>
                                No se tienen equipos registrados en esta división.
                            </article>
                        </div>
                        <div class='card-footer'>
                            <a class='btn btn-dark capitalize' href='Creacion_equipos.jsp'>¡Registrar un nuevo equipo!</a>
                        </div>
                    </div>
                </div>
            <br>
            
            <%}else{%>
             <div class='row d-flex justify-content-center'>
                    <div class='col-md-6 card text-white align-items-center' style="background-color: #2291C1">
                        <h5 class='card-header text-capitalize'>No Hay Equipos</h5>

                        <div class='card-body'>
                            <article class='card-text'>
                                No se tienen equipos registrados en ninguna división.
                            </article>
                        </div>
                    </div>
                </div>
             <% } 
        } %>
    </div>
        <jsp:include page="Prueba-Reu/my-footer.jsp" />
    </body>
</html>