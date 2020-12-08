<%-- 
    Document   : verEquipos
    Created on : 8/12/2020, 01:41:46 AM
    Author     : maste
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="MUsuarios.clases.UsuarioEmpleado"%>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java" session="true"%>

<%
    String redirect = "";
    boolean desempeño_adecuado = true;
    HttpSession sesion;
    //ArrayList<Equipos> equipos = new ArrayList<Equipos>();
    try{
        //Se supone que uno debe ingresar siendo ya un usuario registrado y con los privilegios adecuados
        sesion = request.getSession();
        UsuarioEmpleado liderDiv = (UsuarioEmpleado) sesion.getAttribute("usuario");
        //equipos = Equipo.traerEquipos(liderdiv.getIDUsuarioE());
    }catch(Exception e){
        redirect = "error.jsp";
        desempeño_adecuado = false;
    }

    if(!desempeño_adecuado){
        response.sendRedirect(redirect);
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
                    <h4>Creación de nuevo equipo de trabajo</h4>
		</div>
	</div>
        <br>
            <input type="hidden" name="maxEmpleados" value="<%--=equipos.size()--%>">
            <div class="row">
                    <div class="col-md-6 form-group">
                        <label for=nombreEquipo">
                            Nombre del equipo:
                        </label>
                        <input type="text" id='nombreEquipo' name='nombregEquipo'>
                    </div>
                    <div class="col-md-6 form-group">
                        <label for='división'>
                            División correspondiente
                        </label>
                        <input type="text" readonly="readnoly" id='division' name='division'>
                    </div>
            </div>
            <br>
            <%
                for (int i = 0; i < 5/*equipos.size(), el 5 para que no marque error*/; i++) {
                    //Equipo eq = equipos.get(i);
                    int mod = i%3;
                    switch(mod){
                        case 1:
                    %>
            <div class="row">
                    <div class="col-md-4">
                            <div class="card text-white bg-primary">
                                    <h5 class="card-header">
                                            <%--=eq.getNombre()--%>
                                    </h5>
                                    <div class="card-body">
                                        <a class='btn btn-info' href='editarEquipo.jsp?id=<%--=eq.getId()--%>'>
                                            Editar equipo
                                        </a>
                                    </div>
                            </div>
                    </div>
                    <%      break;
                        case 2: %>
                    <div class="col-md-4">
                            <div class="card text-white bg-primary">
                                    <h5 class="card-header">
                                            <%--=eq.getNombre()--%>
                                    </h5>
                                    <div class="card-body">
                                        <a class='btn btn-info' href='editarEquipo.jsp?id=<%--=eq.getId()--%>'>
                                            Editar equipo
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
                                            <%--=eq.getNombre()--%>
                                    </h5>
                                    <div class="card-body">
                                        <a class='btn btn-info' href='editarEquipo.jsp?id=<%--=eq.getId()--%>'>
                                            Editar equipo
                                        </a>
                                    </div>
                            </div>
                    </div>
            </div>
                    <%break;
                    }//switch
                }  // for %>
        <jsp:include page="Prueba-Reu/my-footer.html" />
    </body>
</html>