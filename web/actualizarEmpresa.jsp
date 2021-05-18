<%@page import="MUsuarios.clases.UsuarioEmpleado"%>
<%@page import="java.io.OutputStream"%>
<%@page import="javax.sql.rowset.serial.SerialBlob"%>
<%@page import="sun.misc.IOUtils"%>
<%@page import="java.sql.Blob"%>
<%@page import="java.io.InputStream"%>
<%@page contentType="text/html" pageEncoding="UTF-8" session="true" language="java" import="MUsuarios.clases.Empresa"%>

<!DOCTYPE html>
<html lang='es'>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Empresa</title>
        <jsp:include page="Prueba-Reu/my-links-boostrap.html" />
    </head>
    <body>
        <jsp:include page="Prueba-Reu/my-head2.jsp" />
        
        <%
            HttpSession sesionEmpresa;
            Empresa emp = null;
            UsuarioEmpleado admin = null;
            boolean hayLogo = false;
            boolean obtencionAdecuada = true;
            String redirect = "";
            try{
                sesionEmpresa  = request.getSession();
                emp = (Empresa) sesionEmpresa.getAttribute("empresa");
                admin = (UsuarioEmpleado) sesionEmpresa.getAttribute("usuario");
                if(admin == null || emp == null){
                    System.out.println("No hay sesión");
                    obtencionAdecuada = false;
                    redirect = "inicio_sesion.jsp";
                }else{
                    hayLogo = (emp.getLogo() != null);
                }
            }catch(Exception e){
                redirect = "error.jsp";
                e.printStackTrace();
                obtencionAdecuada = false;
            }finally{
                if(!obtencionAdecuada){
                    response.sendRedirect(redirect);
                }
            }
        %>
        
        <%switch( admin.getiD_cat_priv() ){ 
                        case 1:
                    %>
        <div class="container-fluid">
            <div class="row margin-top-1rem">
                <div class="col-md-2">
                </div>
                <div class="col-md-8">
                    <% if(hayLogo){ %>
                    <form role="form" method="POST" action='actualizarLogo'>
                        <div class='container-fluid row justify-content-center'>
                            <img class="rounded-circle" src="cargaRegistro?id=<%=emp.getIDEmpresa()%>" alt='Logo <%=emp.getNombre()%>'>
                        </div><br>
                    </form>
                    <% } %>
                    <form role="form" method="POST" action='actualizarEmpresa'>
                        <div class="input-group mb-3">		 
                            <div class="input-group-prepend">
                                <span class="input-group-text">Nombre:</span>
                            </div>
                            <input type="text" class="form-control" id="nombre" name='nombre' readonly ='readonly'
                                   <% if (obtencionAdecuada) {%>
                                   value="<%=emp.getNombre()%>"
                                   <%}%>
                                   onchange="return validarString(this, true, false)"
                                   ondrag="return validarString(this, true, false)"
                                   ondrop="return validarString(this, true, false)" oncopy="return false" onpaste="return false" autocomplete="off" ondrag="return false"  ondrop="return false" required="required" maxlength="30">
                            <div class='input-group-append'>
                                <button class="btn btn-info" onclick='return cambiarEstado("nombre")'>Editar</button>
                            </div>
                        </div>
                        <div class="input-group mb-3">		 
                            <div class="input-group-prepend">
                                <span class="input-group-text">Razón Social:</span>
                            </div>
                            <input type="text" class="form-control" id="razon" name='razon' readonly="readonly"
                                   <% if (obtencionAdecuada) {%>
                                   value="<%=emp.getRazónsocial()%>"
                                   <%}%>
                                   onchange="return validarString(this, false, false)"
                                   ondrag="return validarString(this, false, false)"
                                   ondrop="return validarString(this, false, false)" oncopy="return false" onpaste="return false" autocomplete="off" ondrag="return false"  ondrop="return false" required="required" maxlength="30">
                            <div class='input-group-append'>
                                <button class="btn btn-info" onclick='return cambiarEstado("razon")'>Editar</button>
                            </div>
                        </div>
                        <div class="input-group mb-3">		 
                            <div class="input-group-prepend">
                                <span class="input-group-text">Descripción:</span>
                            </div>
                            <input type="text" class="form-control" id="descripcion" name='descripcion' readonly="readonly"
                                   <% if (obtencionAdecuada) {%>
                                   value="<%=emp.getDescripcion()%>"
                                   <%}%>
                                   onchange="return validarString(this, false, false)"
                                   ondrag="return validarString(this, false, false)"
                                   ondrop="return validarString(this, false, false)">
                            <div class="input-group-append" oncopy="return false" onpaste="return false" autocomplete="off" ondrag="return false"  ondrop="return false" required="required" maxlength="30">
                                <button class="btn btn-info" onclick='return cambiarEstado("descripcion")'>Editar</button>
                            </div>
                        </div>                        
                        <button type="submit" class="btn btn-dark">
                            Actualizar información
                        </button>
                    </form>
                </div><%
                            break;
                        default: 
                            break;
                    }
                    %>
                <div class="col-md-2">
                </div>
            </div>
        </div><br><br><br>
    </body>
    <jsp:include page="Prueba-Reu/my-footer.jsp" />
</html>
