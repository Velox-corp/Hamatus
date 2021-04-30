<%-- 
    Documento   : editarFlujo
    Fecha y hora de creación: : 27/04/2021, 11:40:15 PM
    Author     : Armando Jarillo
--%>
<%@page import="MFlujos.Clases.FlujoDeTrabajo"%>
<%@page import="MUsuarios.clases.UsuarioEmpleado"%>
<%@page import="MUsuarios.clases.Empresa"%>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java" session="true"%>
<!DOCTYPE html>
<html lang='es'>
    <head>
        <meta http-equiv="Content-Type" content="text/html">
        <meta charset="utf-8">
        <title>Edicion flujo de trabajo</title>
        <jsp:include page="Prueba-Reu/my-links-boostrap.html" />
    </head>
    <body>
        <jsp:include page="Prueba-Reu/my-head2.jsp" />
        <%
            HttpSession sesionEmpresa;
            Empresa emp = null;
            UsuarioEmpleado admin = null;
            int id = 0;
            FlujoDeTrabajo f = null;
            try{
                id = Integer.parseInt(request.getParameter("idf"));
                f = FlujoDeTrabajo.consultaFlujo(id);
            }catch(Exception e){
                
            }
        %>
        <script src='JS/interaccionBotones.js'></script>
        <div class='row text-center'>
            <h2 class='col-md-12 text-center'>Editar un flujo de trabajo</h2>
        </div>
        <main class="row margin-top-1rem">
            <div class="col-md-3">
            </div>
            <div class="col-md-6">
                <form action="editarFlujo" method="post" class="card">
                    <input type='hidden' name='idF' value='<%=id%>'>
                    <h5 class="card-header">
                        Edición de datos del flujo
                    </h5>
                    <div class="card-body">
                            <div class="input-group mb-2">
                                <div class='input-group-prepend'>
                                    <label class='input-group-text' for="mod_titulo">Titulo</label>
                                </div>
                                <input type="text" value="<%=f.getTituloFlujo()%>" readonly="readonly" class="form-control" id="mod_titulo" name="mod_titulo" required="required">
                                <button class='btn btn-info input-group-append' onclick="return cambiarEstado('mod_titulo')">Editar</button>
                            </div>
                                <br>
                            <div class="input-group mb-2">
                                <div class='input-group-prepend'>
                                    <label class='input-group-text' for="mod_des">Descripción</label>
                                </div>
                                <textarea type="text" readonly="readonly" class="form-control" id="mod_des" name="mod_des" required="required"><%=f.getDescripcionFlujo()%></textarea>
                                <button class='btn btn-info input-group-append' onclick="return cambiarEstado('mod_des')">Editar</button>
                            </div>
                            <br>
                            <div class="input-group mb-2">
                                <div class='input-group-prepend'>
                                    <label class='input-group-text' for="mod_fecha">Fecha Limite</label>
                                </div>
                                <input type="date" value="<%=f.getTituloFlujo()%>" readonly="readonly" class="form-control" id="mod_fecha" name="mod_fecha" required="required">
                                <button class='btn btn-info input-group-append' onclick="return cambiarEstado('mod_fecha')">Editar</button>
                            </div>
                                <br>
                            <div class="input-group mb-2">
                                <div class='input-group-prepend'>
                                    <label class='input-group-text' for="mod_hora">Hora Limite</label>
                                </div>
                                <input type=time value="<%=f.getTituloFlujo()%>" readonly="readonly" class="form-control" id="mod_hora" name="mod_hora" required="required">
                                <button class='btn btn-info input-group-append' onclick="return cambiarEstado('mod_hora')">Editar</button>
                            </div>
                            
                    </div>
                    <div class="card-footer">
                        <button type="submit" name="enviar" class="btn btn-primary">Editar datos<i class="fa fa-floppy-o" aria-hidden="true"></i></button>
                    </div>
                </form>

            </div>
        </main>
        
        <jsp:include page="Prueba-Reu/my-footer.jsp" />
    </body>
</html>
