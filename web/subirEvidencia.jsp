<%-- 
    Documento   : subirEvidencia
    Fecha y hora de creación: : 29/04/2021, 11:27:31 PM
    Author     : Armando Jarillo
--%>
<%@page import="MFlujos.Clases.FlujoDeTrabajo"%>
<%@page import="MDocumentos.Clases.D_Documento"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Hashtable"%>
<%@page import="MUsuarios.clases.UsuarioEmpleado"%>
<%@page import="MUsuarios.clases.Empresa"%>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java" session="true"%>
<!DOCTYPE html>
<html lang='es'>
    <head>
        <meta http-equiv="Content-Type" content="text/html">
        <meta charset="utf-8">
        <title>Subir evidencias</title>
        <jsp:include page="Prueba-Reu/my-links-boostrap.html" />
    </head>
    <body>
        <jsp:include page="Prueba-Reu/my-head2.jsp" />
        <%
            HttpSession sesionUser = request.getSession();
            boolean obtencionAdecuada = false;
            UsuarioEmpleado usuario = null;
            Empresa emp = null;
            FlujoDeTrabajo flujo = FlujoDeTrabajo.consultaFlujo(Integer.parseInt(request.getParameter("idf")));
            try{
                usuario = (UsuarioEmpleado) sesionUser.getAttribute("usuario");
                emp = (Empresa) sesionUser.getAttribute("empresa");
                if(usuario == null || emp == null){
                        System.out.println("No hay sesión");
                        obtencionAdecuada = false;
                        response.sendRedirect("inicio_sesion.jsp");
                    }
            }catch(Exception ex){
                System.out.println("Error");
                System.out.println(ex.getMessage());
                ex.printStackTrace();
                obtencionAdecuada = false;
                response.sendRedirect("error.jsp");
            }
        %>
    <center><h1>Subir evidencia</h1></center><br>
        <main class="container" style="margin-right: 6rem">
        <div>
            <div class="card col-md-10">
                <div class='card-header text-center'>
                    Adjunte el archivo aquí
                </div>
                    <form class="card-body form-group" action="subirEvidencia" method="POST" enctype="multipart/form-data">
                        <div class="mb-3">
                            <label for="file" class="form-label">Insertar evidencia <small>&nbsp;&nbsp;(El tamaño del archivo no debe superar los 15 MB)</small></label>
                            <input class="form-control-file" type="file" id="file" name="file" required>
                        </div>
                        <div class="mb-3">
                            <label for="tipo_archivo">Elija tipo de archivo</label>
                            <select class="form-control" name="tipo_archivo">
                                <option>Digital</option>
                                <option>Escaneado</option>
                            </select>
                            <input type='hidden' name='idf' value='<%=flujo.getIdFlujodetrabajo()%>'>
                        </div>
                        <div class="justify-content-center">
                            <button type="submit" class="btn btn-dark">
                                Subir Archivo
                            </button>
                            <button  type='reset' class="btn btn-danger btn-large">Cancelar</button>
                        </div>
                    </form>
                </div>
        </div></main><br><br>
        <jsp:include page="Prueba-Reu/my-footer.jsp" />
    </body>
</html>
