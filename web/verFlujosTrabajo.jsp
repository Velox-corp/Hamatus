<%-- 
    Documento   : verFlujosTrabajo
    Fecha y hora de creación: : 27/04/2021, 10:59:10 PM
    Author     : Armando Jarillo
--%>
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
        <title>Titulo JSP</title>
        <jsp:include page="Prueba-Reu/my-links-boostrap.html" />
    </head>
    <body>
        <jsp:include page="Prueba-Reu/my-head2.jsp" />
        <%
            HttpSession sesionEmpresa;
            UsuarioEmpleado empleado = null;
            ArrayList<FlujoDeTrabajo> flujos = new ArrayList<FlujoDeTrabajo>();
            try{
                sesionEmpresa = request.getSession();
                empleado = (UsuarioEmpleado)sesionEmpresa.getAttribute("usuario");
                switch(empleado.getiD_cat_priv()){
                    case 1:
                        
                        break;
                    case 2:
                        
                        break;
                    case 3:
                        flujos = FlujoDeTrabajo.consultarFlujosLiderDiv(empleado.getiD_Division());
                        break;
                    case 4: 
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
            <% for (int i = 0; i < flujos.size(); i++) {
                FlujoDeTrabajo f = flujos.get(i);
                %>
                <div class="card  container-fluid">
                    <div class="card-header text-white bg-dark row h4 " >  
                        <div class="col-md-6 text-left">
                            <%=f.getTituloFlujo()%>
                        </div>
                        <div class="col-md-5 text-right">
                            Tiempo limite: <%=f.getFechaLimite()%>:<%=f.getHoraLimite()%>
                        </div>
                        <%
                        if( empleado.getiD_cat_priv() == 3 ) { 
                        %>
                            <div class="col-md-1">
                                <a href="editarFlujo.jsp&idf=<%=f.getIdFlujodetrabajo()%>" id="btnDelete"><i class="fa fa-trash" arial-hidden="true"></i></a>
                                <a href="eliminarFlujo&idf=<%=f.getIdFlujodetrabajo()%>" id="btnEdit" class="ml-1"><i class="fa fa-pen" arial-hidden="true"></i></a>
                            </div>
                        <% } %>
                    </div>
                    <div class="card-body">
                            <%=f.getDescripcionFlujo()%>

                    </div>
                    <div class="card-footer align-items-center">
                        <a class="btn btn-dark text-center" href="subirEvidencia.jsp">Subir evidencía</a>
                    </div>
                </div>
                <br>
                <% } %>
                <br>
                <%
                    if(empleado.getiD_cat_priv() == 3 ) { 
                %>
                <a href="nuevoFlujo.jsp">Publicar un nuevo flujo de trabajo</a>
                <% } %>
        </main>
        <jsp:include page="Prueba-Reu/my-footer.jsp" />
    </body>
</html>
