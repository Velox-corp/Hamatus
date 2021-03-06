<%@page import="MDivisiones.clases.Division"%>
<%@page import="MDistribucion.Clases.Equipo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="MUsuarios.clases.UsuarioEmpleado"%>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java" session="true"%>

<%
    String redirect = "";
    boolean desempeño_adecuado = true;
    HttpSession sesion;
    ArrayList<UsuarioEmpleado> empleadosEquipo = new ArrayList<UsuarioEmpleado>();
    ArrayList<UsuarioEmpleado> empleadosLibres = new ArrayList<UsuarioEmpleado>();
    int id_equipo = 0;
    Equipo equipo = null;
    try{
        try{//Aquí va optener el paramtro, pero si no lo encuentra..
            id_equipo = Integer.parseInt(request.getParameter("id"));
        }catch(NullPointerException e1){
            try{//... va a buscar el paramtreo, y si ni una no otra...
                id_equipo = Integer.parseInt((String)request.getAttribute("id"));
            }catch(NullPointerException e2){
                System.out.println("Ni una ni otra");
                desempeño_adecuado = false; // ... entonces hay un error
            }
        }
        sesion = request.getSession();
        equipo = Equipo.obtenerEquipo(id_equipo);
        UsuarioEmpleado liderDiv = (UsuarioEmpleado) sesion.getAttribute("usuario");
        if(liderDiv == null){
            desempeño_adecuado = false;
            redirect = "inicio_sesion.jsp";
        }else{
            empleadosEquipo = UsuarioEmpleado.obtenerUsuariosEquipo(id_equipo, 0); 
            empleadosLibres = UsuarioEmpleado.obtenerUsuariosEquipo(0, liderDiv.getiD_Division()); 
        }
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
        
        <title>Edición de equipo: <%=equipo.getNombre()%></title>
        
        <jsp:include page="Prueba-Reu/my-links-boostrap.html" />
        
    </head>
    
    <body>
        <jsp:include page="Prueba-Reu/my-head2.jsp" />
        <div class="container margin-top-1rem">
        <center><h1>Edición del equipo de trabajo <%=equipo.getNombre()%></h1></center>
        <div class="row">
            <h3 class='text-info'>Datos del equipo</h3>
	</div>
        <script src='JS/interaccionBotones.js'></script>
            <form action="cambioNameE" method="POST">
                <div class="row">
                <input type='hidden' name='idEquipo' value='<%=id_equipo%>'>
                    <div class="col-md-6 form-group">
                        <label for=nombreEquipo">
                            Nombre del equipo:
                        </label>
                        <input type="text" id='nombregEquipo' name='nombregEquipo' value='<%=equipo.getNombre()%>'
                                readonly="readonly" class="form-control"
                                onchange="return validarString(this, true, false)"
                                ondrag="return validarString(this, true, false)"
                                ondrop="return validarString(this, true, false)"
                               >
                        
                        <button class='btn btn-info' type="button" onclick="cambiarEstado('nombregEquipo','divBtn')" style="margin-top: .5vw">Editar</button>
                        
                        </div>
                    <div class="col-md-6 form-group">
                        <label for='división'>
                            División correspondiente:
                        </label>
                        <input type="text" readonly="readonly" id='division' name='division' value='<%=Division.traducirID(equipo.getIDDivision())%>' class="form-control">
                    </div>
                
                    <div class="row" id="divBtn" hidden="hidden">
                    <button class='btn btn-dark' type="submit">Cambiar nombre</button>
                    </div>
                
                </div>
            </form>
            <br>
            <div class="row">
                <h3 class='text-info'>Empleados del equipo</h3>
            </div>                    
            <br>
            <% //for del equipo
                if(empleadosEquipo.size() != 0){
                for (int i = 0; i < empleadosEquipo.size(); i++) {
                    UsuarioEmpleado emp = empleadosEquipo.get(i);
                    int mod = (i+1)%3;
                    switch(mod){
                        case 1:
                    %>
            <div class="row">
                    <div class="col-md-4">
                            <div class="card text-white" style="background-color: #6c757d">
                                    <h5 class="card-header">
                                            <%=emp.getAppat()%> <%=emp.getApmat()%> <%=emp.getNombre()%>
                                    </h5>
                                    <div class="card-body">
                                        <a class='btn btn-dark' href='sacarDelEquipo?id=<%=emp.getIDUsuarioE()%>&idE=<%=id_equipo%>'>
                                            Remover empleado del equipo
                                        </a>
                                    </div>
                            </div>
                    </div>
                    <%      break;
                        case 2: %>
                    <div class="col-md-4">
                            <div class="card text-white" style="background-color: #6c757d">
                                    <h5 class="card-header">
                                            <%=emp.getAppat()%> <%=emp.getApmat()%> <%=emp.getNombre()%>
                                    </h5>
                                    <div class="card-body">
                                        <a class='btn btn-dark' href='sacarDelEquipo?id=<%=emp.getIDUsuarioE()%>&idE=<%=id_equipo%>'>
                                            Remover empleado del equipo
                                        </a>
                                    </div>
                            </div>
                    </div>
                            <% break;
                        case 0:
                            %>
                    <div class="col-md-4">
                            <div class="card text-white" style="background-color: #6c757d">
                                    <h5 class="card-header">
                                            <%=emp.getAppat()%> <%=emp.getApmat()%> <%=emp.getNombre()%>
                                    </h5>
                                    <div class="card-body">
                                        <a class='btn btn-dark' href='sacarDelEquipo?id=<%=emp.getIDUsuarioE()%>&idE=<%=id_equipo%>'>
                                            Remover empleado del equipo
                                        </a>
                                    </div>
                            </div>
                    </div>
            </div><br>
                <%break;
                }//switch
            }  // for
            if(empleadosEquipo.size()% 3 != 0){ %>
                </div>
            <%}
            }else{
            %>
            <div class='row'>
                <div clas='col-md-12'>
                    <h3 class='text-danger'>No hay usuarios en el equipo</h3>
                </div>
            </div>
            <% } %>
            <br>
            <div class="row">
                <h3 class='text-info'>Empleados disponibles a añadir</h3>
            </div>
            <div class="row">
                <small class="text-secondary">Seleccione todos los empleados que quiera añadir y confirme la agregación de estos</small>
            </div>
            <br>
            <form method='POST' action='addEmpleadosEquipo'>
                <input type="hidden" name='maxUsers' value='<%=empleadosLibres.size()%>'>
                <input type='hidden' name='idEquipo' value='<%=id_equipo%>'>
            <% //for sin equipo
                if(empleadosLibres.size() != 0){
                for (int i = 0; i < empleadosLibres.size(); i++) {
                    UsuarioEmpleado emp = empleadosLibres.get(i);
                    int mod = (i+1)%3;
                    switch(mod){
                        case 1:
                    %>
            <div class="row">
                    <div class="col-md-4">
                            <div class="card text-white" style="background-color: #6c757d">
                                    <h5 class="card-header">
                                            <%=emp.getAppat()%> <%=emp.getApmat()%> <%=emp.getNombre()%>
                                    </h5>
                                    <div class="card-body">
                                         <label for="empleado_<%=(i+1)%>">Incluir en el equipo:</label>
                                        <input type="checkbox" id='empleado_<%=(i+1)%>' value='true' name='empleado_<%=(i+1)%>'>
                                        <input type='hidden' name='idE_<%=(i+1)%>' id='idE_<%=(i+1)%>' value='<%=emp.getIDUsuarioE()%>'>
                                    </div>
                            </div>
                    </div>
                    <%      break;
                        case 2: %>
                    <div class="col-md-4">
                            <div class="card text-white" style="background-color: #6c757d">
                                    <h5 class="card-header">
                                            <%=emp.getAppat()%> <%=emp.getApmat()%> <%=emp.getNombre()%>
                                    </h5>
                                    <div class="card-body">
                                        <label for="empleado_<%=(i+1)%>">Incluir en el equipo:</label>
                                        <input type="checkbox" id='empleado_<%=(i+1)%>' value='true' name='empleado_<%=(i+1)%>'>
                                        <input type='hidden' name='idE_<%=(i+1)%>' id='idE_<%=(i+1)%>' value='<%=emp.getIDUsuarioE()%>'>
                                    </div>
                            </div>
                    </div>
                            <% break;
                        case 0:
                            %>
                    <div class="col-md-4">
                            <div class="card text-white" style="background-color: #6c757d">
                                    <h5 class="card-header">
                                            <%=emp.getAppat()%> <%=emp.getApmat()%> <%=emp.getNombre()%>
                                    </h5>
                                    <div class="card-body">
                                        <label for="empleado_<%=(i+1)%>">Incluir en el equipo:</label>
                                        <input type="checkbox" id='empleado_<%=(i+1)%>' value='true' name='empleado_<%=(i+1)%>'>
                                        <input type='hidden' name='idE_<%=(i+1)%>' id='idE_<%=(i+1)%>' value='<%=emp.getIDUsuarioE()%>'>
                                    </div>
                            </div>
                    </div>
            </div><br>
                    <%break;
                    }//switch
                }  // for
                if(empleadosLibres.size() % 3 != 0){
                    %>
                    </div>
                    <% } 
                    } else{
                    %>
                <div class='row'>
                <div clas='col-md-12'>
                    <h3 class='text-danger text-center'>No hay usuarios disponibles a asignar</h3>
                </div>
                </div>
                <% } %> 
            <div class='row' style="margin-top: 1vw">
                <button class='btn btn-dark' type="submit">Agregar usuarios</button>
            </div>
            </form><br>
        </div>
        <jsp:include page="Prueba-Reu/my-footer.jsp" />
    </body>
</html>