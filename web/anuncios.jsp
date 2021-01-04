<%@page import="MUsuarios.clases.UsuarioEmpleado"%>
<%@page import="ClasesSoporte.Conexion"%>
<%@page import="java.sql.*"%>
<%@page language="java" pageEncoding="UTF-8" contentType="text/html"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang='es'>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Anuncios</title>
        <jsp:include page="Prueba-Reu/my-links-boostrap.html" />
    </head>
    <jsp:include page="Prueba-Reu/my-head2.jsp" />
    <body>
        <!--
        <header class="row">
                <div class="col-md-12">
                        <div class="row">
                                <div class="col-md-2">
                                        <img alt="Logo_hamatus" class="rounded-circle" />
                                </div>
                                <div class="col-md-5">
                                    <a class="text-primary text-left" href='index.jsp'>
                                                Hamatus
                                        </a>
                                </div>
                                <div class="col-md-5">
                                        <p class="text-right">
                                            <a class="nav-link active" href="usuario.jsp">{Username}</a>
                                        </p>
                                </div>
                        </div>
                        <ul class="nav nav-tabs">
                                <li class="nav-item">
                                        <a class="nav-link" href="anuncios.jsp">Anuncios</a>
                                </li>
                                <li class="nav-item">
                                        <a class="nav-link" href="empresa.jsp">Mi empresa</a>
                                </li>
                                <li class="nav-item">
                                        <a class="nav-link " href="vistaOrganigrama.jsp">Organigrama</a>
                                </li>
                                <li class="nav-item">
                                        <a class="nav-link " href="documentos.jsp">Documentos</a>
                                </li>
                                <li class="nav-item">
                                        <a class="nav-link " href="equipos.jsp">Equipos</a>
                                </li>
                                <li class="nav-item">
                                        <a class="nav-link " href="empleados.jsp">empleados</a>
                                </li>
                        </ul>
                </div>
        </header>
        -->
        <%
            HttpSession sesion;
            UsuarioEmpleado liderDiv;
        %>
        <main class="row">
            <div class="col-md-12"><br>
                <center><h1>Tablón de anuncios</h1></center>
                    <%-- Aquí va tocar meter un for para que se beneren todos los anuncios --%>
                <div class="card bg-default">
                    <div class="table-responsive">
                        <%
                            try {
                                sesion = request.getSession();
                                liderDiv = (UsuarioEmpleado) sesion.getAttribute("usuario");
                                int div = liderDiv.getiD_Division();
                                if (liderDiv.getiD_cat_priv() == 2 || liderDiv.getiD_cat_priv() == 3 ) {
                        %>
                        <table class="table table-hover"><a href="tablon.jsp" id="btnAdd"><i class="far fa-plus-square" arial-hidden="true">Agregar Nuevo</i></a>
                            <c:forEach var="p" items="${anuncios}">
                                <thead class="thead-dark" >
                                    <tr>
                                        <th colspan="4"  >${p.getTitulo()}</th>
                                        <%
                                            if(liderDiv.getiD_Division()==4){%>
                                        <label>Anuncio general</label>
                                        <%       
                                            }else if(liderDiv.getiD_Division()==6){%>
                                        <label>Anuncio particular</label>
                                        <%     
                                            }else{%>
                                        <label>Anuncio</label>
                                        <%     
                                            }
                                        %>
                                
                                
                                
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>${p.getId()}</td>
                                        <td>${p.getDescripcion()}</td>
                                        <td>${p.getFecha()}</td>

                                        <td>
                                            <input type="hidden" id="id_div" name="id_div" value="<%=div%>">
                                            <input type="hidden" id="ida" value="${p.getId()}">
                                            <a href="controlA?accion=Delete&ida=${p.getId()} " id="btnDelete"><i class="fa fa-trash" arial-hidden="true"></i></a>
                                            <a href="controlA?accion=ListarID&ida=${p.getId()}" id="btnEdit" class="ml-1"><i class="fa fa-pen" arial-hidden="true"></i></a>

                                        </td>
                                        <%--<jsp:include page="Opciones"/>--%>
                                    </tr>
                                </tbody>
                            </c:forEach>
                        </table>
                        <%
                                    } else {%>
                        <table class="table table-hover"><a href="tablon.jsp" id="btnAdd"><i class="far fa-plus-square" arial-hidden="true">Agregar Nuevo</i></a>
                            <c:forEach var="p" items="${anuncios}">
                                <thead class="thead-dark" >
                                    <tr>
                                        <th colspan="4"  >${p.getTitulo()}</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>${p.getId()}</td>
                                        <td>${p.getDescripcion()}</td>
                                        <td>${p.getFecha()}</td>
                                    </tr>
                                </tbody>
                                <input type="hidden" id="id_div" name="id_div" value="<%=div%>">
                                <input type="hidden" id="ida" value="${p.getId()}">
                            </c:forEach>
                        </table>            
                                                <%}
                                } catch (Exception e) {
                                    e.getMessage();
                                    e.printStackTrace();
                                }
                        %> 
                    </div>
                </div>
            </div>
        </main>
    </body>
    <jsp:include page="Prueba-Reu/my-footer.jsp" />
</html>
