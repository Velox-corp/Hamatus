<%-- 
    Documento   : verFlujosTrabajo
    Fecha y hora de creación: : 27/04/2021, 10:59:10 PM
    Author     : Armando Jarillo
--%>
<%@page import="MDivisiones.clases.Division"%>
<%@page import="MDistribucion.Clases.EUsuarioEquipo"%>
<%@page import="MFlujos.Clases.FlujoDeTrabajo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="MUsuarios.clases.UsuarioEmpleado"%>
<%@page import="MUsuarios.clases.Empresa"%>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java" session="true"%>
<!DOCTYPE html>
<html lang='es'>
    <head>
        <meta http-equiv="Content-Type" content="text/html">
        <meta charset="utf-8">
        <title>Flujos de Trabajo</title>
        <jsp:include page="Prueba-Reu/my-links-boostrap.html" />
    </head>
    <body>
        <jsp:include page="Prueba-Reu/my-head2.jsp" />
        <%
            HttpSession sesion;
            UsuarioEmpleado empleado = null;
            ArrayList<FlujoDeTrabajo> flujos = new ArrayList<FlujoDeTrabajo>();
            boolean isAll = false;
            ArrayList<Division> divisiones = new ArrayList<Division>();
            try{
                sesion = request.getSession();
                empleado = (UsuarioEmpleado)sesion.getAttribute("usuario");
                switch(empleado.getiD_cat_priv()){
                    case 1:
                        isAll = true;
                        divisiones = Division.obtenerDivisiones( ((Empresa)sesion.getAttribute("empresa")).getIDEmpresa() );
                        for (int i = 0; i < divisiones.size(); i++) {
                            Division div = divisiones.get(i);
                                flujos.addAll(FlujoDeTrabajo.consultarFlujosLiderDiv(div.getId_Division()));
                            }
                        break;
                    case 2:
                        isAll = true;
                        divisiones = Division.obtenerDivisiones( ((Empresa)sesion.getAttribute("empresa")).getIDEmpresa() );
                        for (int i = 0; i < divisiones.size(); i++) {
                            Division div = divisiones.get(i);
                                flujos.addAll(FlujoDeTrabajo.consultarFlujosLiderDiv(div.getId_Division()));
                            }
                        break;
                    case 3:
                        isAll = false;
                        flujos = FlujoDeTrabajo.consultarFlujosLiderDiv(empleado.getiD_Division());
                        break;
                    case 4: 
                        isAll = false;
                        flujos = FlujoDeTrabajo.consultarFlujosEmpleado(EUsuarioEquipo.buscarEquipo(empleado.getIDUsuarioE()));
                        break;
                    default:
                        
                        break;
                }
            }catch(Exception e){
                e.getMessage();
                e.printStackTrace();
            }
            
        %>
        
        <div class='row'>
            <div class='col-md-12 align-items-center'>
                <h2 class="align-items-center text-center">Flujos de trabajo</h2>  
            </div>
        </div>
        <br>
        <main class='container'>
            
            <% 
                if(isAll){
                for (int j = 0; j < divisiones.size(); j++) {
                    Division d = divisiones.get(j);
                    for (int i = 0; i < flujos.size(); i++) {
                    FlujoDeTrabajo f = flujos.get(i);
                    %>
                <div class="card container-fluid">
                    <div class="card-header text-white bg-dark h4 " >
                        <div class='row text-center'>
                            <span clas='col-md-12'><%=d.getNombre()%></span>
                        </div>
                        <div class='row'>
                            <div class="col-md-6 text-left">
                                <%=f.getTituloFlujo()%>
                            </div>
                            <div class="col-md-5 text-right">
                                Tiempo limite: <%=f.getFechaLimite()%> | <%=f.getHoraLimite()%>
                            </div>
                            <%
                            if( empleado.getiD_cat_priv() == 3 ) { 
                            %>
                                <div class="col-md-1 text-right">
                                    <a href="editarFlujo.jsp?idf=<%=f.getIdFlujodetrabajo()%>" id="btnEdit"><i class="fa fa-pen" arial-hidden="true"></i></a>
                                    <a href="eliminarFlujo?idf=<%=f.getIdFlujodetrabajo()%>" id="btnDelete" class="ml-1"><i class="fa fa-trash" arial-hidden="true"></i></a>
                                </div>
                            <% } %>
                        </div>
                    </div>
                    <div class="card-body">
                            <%=f.getDescripcionFlujo()%>
                            <br>
                            <% if( f.isEntregado() ){ %>
                            Estado: <strong class="text-success">ENTREGADO</strong>
                            <% } else { %>
                            Estado: <strong class="text-danger">NO ENTREGADO</strong>
                            <% } %>
                    </div>
                    
                        <% if(empleado.getiD_cat_priv() == 3 && f.isEntregado()){ %>
                            <div class="card-footer  text-center">
                                <a class="btn btn-dark text-center" href="descargaEvidencia?idF=<%=f.getIdFlujodetrabajo()%>"
                                   target="_top" data-toggle="tooltip" >Descargar Documento</a>
                            </div>
                        <% } else if(empleado.getiD_cat_priv() == 4 && !f.isEntregado()) { %>
                            <div class="card-footer text-center">
                                <a class="btn btn-dark text-center" href="subirEvidencia.jsp?idf=<%=f.getIdFlujodetrabajo()%>">Subir evidencía</a>
                            </div>
                        <% }%>
                    
                </div>
                <br>
                <%  } 
                   }
                } else { /*Lo mismo pero sin la parte de arriba */ 
                    for (int i = 0; i < flujos.size(); i++) {
                    FlujoDeTrabajo f = flujos.get(i);
                    %>
                <div class="card container-fluid">
                    <div class="card-header text-white bg-dark h4 " >
                        <div class='row'>
                            <div class="col-md-6 text-left">
                                <%=f.getTituloFlujo()%>
                            </div>
                            <div class="col-md-5 text-right">
                                Tiempo limite: <%=f.getFechaLimite()%> | <%=f.getHoraLimite()%>
                            </div>
                            <%
                            if( empleado.getiD_cat_priv() == 3 ) { 
                            %>
                                <div class="col-md-1">
                                    <a href="editarFlujo.jsp?idf=<%=f.getIdFlujodetrabajo()%>" id="btnEdit"><i class="fa fa-pen" arial-hidden="true"></i></a>
                                    <a href="eliminarFlujo?idf=<%=f.getIdFlujodetrabajo()%>" id="btnDelete" class="ml-1"><i class="fa fa-trash" arial-hidden="true"></i></a>
                                </div>
                            <% } %>
                        </div>
                        
                    </div>
                    <div class="card-body">
                            <%=f.getDescripcionFlujo()%>
                            <br>
                            <% if( f.isEntregado() ){ %>
                            Estado: <strong class="text-success">ENTREGADO</strong>
                            <% } else { %>
                            Estado: <strong class="text-danger">NO ENTREGADO</strong>
                            <% } %>
                    </div>
                    
                        <% if(empleado.getiD_cat_priv() == 3 && f.isEntregado()){ %>
                            <div class="card-footer  text-center">
                                <a class="btn btn-dark text-center" href="descargaEvidencia?idF=<%=f.getIdFlujodetrabajo()%>"
                                   target="_top" data-toggle="tooltip" >Descargar Documento</a>
                            </div>
                        <% } else if(empleado.getiD_cat_priv() == 4 && !f.isEntregado()) { %>
                            <div class="card-footer text-center">
                                <a class="btn btn-dark text-center" href="subirEvidencia.jsp?idf=<%=f.getIdFlujodetrabajo()%>">Subir evidencía</a>
                            </div>
                        <% }%>
                    
                </div>
                <br>
                <%  } %>  
                <br>
                <%
                    if(empleado.getiD_cat_priv() == 3 ) { 
                %>
                <a  class="btn btn-primary" href="nuevoFlujo.jsp">Publicar un nuevo flujo de trabajo</a>
                <% } 
                }%>
        </main>
        <jsp:include page="Prueba-Reu/my-footer.jsp" />
    </body>
</html>
