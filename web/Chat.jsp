

<%@page import="MDistribucion.Clases.Equipo"%>
<%@page import="MUsuarios.clases.Empresa"%>
<%@page import="MChat.Clases.UsuarioSala"%>
<%@page import="MDistribucion.Clases.EUsuarioEquipo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="MUsuarios.clases.UsuarioEmpleado"%>
<%@page language="java" pageEncoding="UTF-8" contentType="text/html" session = "true" %>
<!DOCTYPE html>



<html lang='es'>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <title>Chat</title>

        <jsp:include page="Prueba-Reu/my-links-boostrap.html" />

    </head>
    <body>
        <jsp:include page="Prueba-Reu/my-head2.jsp" />
        <center><h1>Chat</h1></center>
        <%  HttpSession sesionUser = request.getSession();
            HttpSession sesion;
            boolean sonTotales = false;
            boolean hayEquipos = true;
            ArrayList<Equipo> equipos = new ArrayList<Equipo>();
            int[] totalesEquipos = null;

            String username = "";
            int id_user = 0;
            boolean obtencionAdecuada = true;
            String redirect = "";
            UsuarioEmpleado liderDiv = null;
            ArrayList<UsuarioEmpleado> empleados = new ArrayList<UsuarioEmpleado>();

            UsuarioEmpleado usuario = (UsuarioEmpleado) sesionUser.getAttribute("usuario");
            username = usuario.getNombre();

            //UsuarioSala ussala = new UsuarioSala();

            try {

                id_user = usuario.getIDUsuarioE();
                //Se supone que uno debe ingresar siendo ya un usuario registrado y con los privilegios adecuados
                sesion = request.getSession();
                liderDiv = (UsuarioEmpleado) sesion.getAttribute("usuario");
                if (liderDiv == null) {
                    obtencionAdecuada = false;
                    redirect = "inicio_sesion.jsp";
                } else {
                    switch (liderDiv.getiD_cat_priv()) {
                        case 1:
                            equipos = Equipo.obtenerAllEquipos(((Empresa) sesion.getAttribute("empresa")).getIDEmpresa());
                            sonTotales = true;
                            break;
                        case 2:
                            equipos = Equipo.obtenerAllEquipos(((Empresa) sesion.getAttribute("empresa")).getIDEmpresa());
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

                    if (equipos == null || equipos.size() == 0) {
                        hayEquipos = false;
                    } else {
                        hayEquipos = true;
                        totalesEquipos = new int[equipos.size()];
                        for (int i = 0; i < equipos.size(); i++) {
                            Equipo equip = equipos.get(i);
                            totalesEquipos[i] = EUsuarioEquipo.getTotalEmpleadosEquipo(equip.getIDEquipo());
                            if (totalesEquipos[i] == -1) {
                                obtencionAdecuada = false;
                                redirect = "error.jsp";
                                break;
                            }
                        }
                    }
                }
            } catch (Exception e) {
                obtencionAdecuada = false;
                redirect = "error.jsp";
                hayEquipos = false;
                e.getMessage();
                e.printStackTrace();
            }

            if (!obtencionAdecuada) {
                response.sendRedirect(redirect);
            }
//**********************************************
            try {
                Empresa emp = (Empresa) sesionUser.getAttribute("empresa");

                if (usuario == null || emp == null) {
                    obtencionAdecuada = false;
                    redirect = "inicio_sesion.jsp";
                } else {
                    empleados = UsuarioEmpleado.obtenerUsuarios(emp.getIDEmpresa());
                }

            } catch (Exception e) {
                e.getMessage();
                e.printStackTrace();
                obtencionAdecuada = false;
                redirect = "error.jsp";
            }

        %>
        <br>
        <br>
        <div class="card grey lighten-3 chat-room">
            <div class="card-body">

                <!-- Grid row -->
                <div class="row px-lg-2 px-2">

                    <!-- Grid column -->
                    <div class="col-md-4 col-xl-4 px-0">

                        <!--Equipos -->

                        <div class="white z-depth-1 px-3 pt-3 pb-0">
                            <ul class="list-unstyled friend-list">
                                <%if (hayEquipos) {
                                        for (int i = 0; i < equipos.size(); i++) {
                                            Equipo eq = equipos.get(i);
                                            int mod = (i + 1) % 3;
                                            switch (mod) {
                                                case 1:%>
                                <li class="p-2">
                                    <a href="#" class="d-flex justify-content-between">
                                        <img src="https://th.bing.com/th/id/Ree7152e8726a45d295373b446058d4a2?rik=pkHhcsYFi5k%2bhA&pid=ImgRaw" alt="avatar" class="avatar rounded-circle d-flex align-self-center mr-2 z-depth-1" width="50" height="50">
                                        <div class="text-small">
                                            <strong><%=eq.getNombre()%></strong>
                                            <!--  
                                            <input type="hidden" id="id_contacto" name="id_contacto" class="id_contacto" value="#">
                                            -->
                                            <p class="last-message text-muted">
                                                Enviar mensaje
                                            </p>
                                        </div>
                                        <div class="chat-footer">
                                            <p class="text-smaller text-muted mb-0">Estado</p>
                                            <span class="text-muted float-right"><i class="fas fa-mail-reply" aria-hidden="true"></i></span>

                                        </div>
                                    </a>
                                </li>
                                <%   }
                                        }
                                    }
                                %>
                            </ul>
                        </div>

                        <!--Usuarios -->

                        <h6 class="font-weight-bold mb-3 text-center text-lg-left">Contactos</h6>
                        <div class="white z-depth-1 px-3 pt-3 pb-0">
                            <ul class="list-unstyled friend-list">
                                <%if (empleados != null) {
                                        for (int i = 0; i < empleados.size(); i++) { //va tocar meter alguna función que traduzca los ides de división y jerarquía
                                            UsuarioEmpleado empleado = empleados.get(i);%> 
                                <li class="p-2">
                                    <a href="agregarSala?id_sala_tipo=<%=1%>&id_contacto=<%=empleado.getIDUsuarioE()%>&id_usuario=<%=id_user%>" class="d-flex justify-content-between">
                                        <img src="https://th.bing.com/th/id/Ree7152e8726a45d295373b446058d4a2?rik=pkHhcsYFi5k%2bhA&pid=ImgRaw" alt="avatar" class="avatar rounded-circle d-flex align-self-center mr-2 z-depth-1" width="50" height="50">
                                        <div class="text-small">
                                            <strong><%=empleado.getNombre()%></strong>
                                            <!--<input type="hidden" id="id_usuario" name="id_usuario" class="id_usuario" value="<%=id_user%>">
                                            <input type="hidden" id="id_contacto" name="id_contacto" class="id_contacto" value="<%=empleado.getIDUsuarioE()%>">
                                            <input type="hidden" id="id_sala_tipo" name="id_sala_tipo" class="id_sala_tipo" value="<%=1%>">-->
                                            
                                            <p class="last-message text-muted">
                                                Enviar mensaje
                                            </p>
                                        </div>
                                        <div class="chat-footer">
                                            <p class="text-smaller text-muted mb-0">Estado</p>
                                            <span class="text-muted float-right"><i class="fas fa-mail-reply" aria-hidden="true"></i></span>

                                        </div>
                                    </a>
<!--
                                    <form class="col-md-12" method="get" action="agregarSala">
                                        <img src="https://th.bing.com/th/id/Ree7152e8726a45d295373b446058d4a2?rik=pkHhcsYFi5k%2bhA&pid=ImgRaw" alt="avatar" class="avatar rounded-circle d-flex align-self-center mr-2 z-depth-1" width="50" height="50">
                                        <div class="text-small">
                                            <strong><%=empleado.getNombre()%></strong>
                                            <input type="hidden" id="id_usuario" name="id_usuario" class="id_usuario" value="<%=id_user%>">
                                            <input type="hidden" id="id_contacto" name="id_contacto" class="id_contacto" value="<%=empleado.getIDUsuarioE()%>">
                                            <input type="hidden" id="id_sala_tipo" name="id_sala_tipo" class="id_sala_tipo" value="<%=1%>">

                                            <button  type="submit" class="last-message btn btn-dark">
                                                Enviar mensaje
                                            </button>
                                        </div>
                                        <div class="chat-footer">
                                            <p class="text-smaller text-muted mb-0">Estado</p>
                                            <span class="text-muted float-right"><i class="fas fa-mail-reply" aria-hidden="true"></i></span>

                                        </div>
                                    </form> -->
                                </li>
                                <%   }
                                    }%>
                            </ul>
                        </div>

                    </div>
                    <!-- Grid column -->

                    <!-- Grid column -->
                    <div class="col-md-6 col-xl-8 pl-md-3 px-lg-auto px-0">
                        <!--
                                                <div class="chat-message">
                                                    <center>
                                                        <iframe src="Mensajes.jsp" height="500" width="500">
                        
                                                        </iframe>
                                                    </center>
                                                </div>
                        
                    </div>
                        <!-- Grid column -->

                    </div>
                    <!-- Grid row -->

                </div>
            </div>
            <br>
            </body>
            <jsp:include page="Prueba-Reu/my-footer.jsp" />

            </html>
