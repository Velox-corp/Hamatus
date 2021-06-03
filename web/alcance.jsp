<%@page import="MUsuarios.clases.UsuarioEmpleado"%>
<%@page language="java" pageEncoding="UTF-8" contentType="text/html" session="true"%>
<% 
    HttpSession sesion;
    sesion = request.getSession();
    UsuarioEmpleado userverif = (UsuarioEmpleado) sesion.getAttribute("usuario");
    if(userverif != null){
        response.sendRedirect("empresa.jsp");
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset='utf-8'>
    <meta http-equiv='X-UA-Compatible' content='IE=edge'>
    <title>Alcance</title>
    <jsp:include page="Prueba-Reu/my-links-boostrap.html" />
</head>
<body>
    <!-- 
        
███╗   ██╗ █████╗ ██╗   ██╗██╗ ██████╗  █████╗ ████████╗██╗ ██████╗ ███╗   ██╗    ██████╗  █████╗ ██████╗ 
████╗  ██║██╔══██╗██║   ██║██║██╔════╝ ██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║    ██╔══██╗██╔══██╗██╔══██╗
██╔██╗ ██║███████║██║   ██║██║██║  ███╗███████║   ██║   ██║██║   ██║██╔██╗ ██║    ██████╔╝███████║██████╔╝
██║╚██╗██║██╔══██║╚██╗ ██╔╝██║██║   ██║██╔══██║   ██║   ██║██║   ██║██║╚██╗██║    ██╔══██╗██╔══██║██╔══██╗
██║ ╚████║██║  ██║ ╚████╔╝ ██║╚██████╔╝██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║    ██████╔╝██║  ██║██║  ██║
╚═╝  ╚═══╝╚═╝  ╚═╝  ╚═══╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝    ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝
                                                                                                          

      -->
    <jsp:include page="Prueba-Reu/my-head.jsp" />
    <!--
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <a class="navbar-brand" href="#">
            <img src="img/hamatus.png" width="30" height="30" alt="" >
          </a>
          <form class="form-inline">
            <button class="btn btn-outline-success" type="button">Iniciar Sesion</button>
            <button class="btn btn-outline-secondary" type="button">Registrarse</button>
          </form>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
            <div class="navbar-nav">
                <a class="nav-item nav-link" href="index.jsp">Inicio</a>
                <a class="nav-item nav-link" href="tutorial.jsp">¿Como funciona?</a>
                <a class="nav-item nav-link" href="alcance.jsp">Alcance<span class="sr-only">(current)</span></a>
                <a class="nav-item nav-link" href="nosotros.jsp">Acerca de</a>
            </div>
        </div>
    </nav>
    -->
    <!-- 
        
 ██████╗ ██████╗ ███╗   ██╗████████╗███████╗███╗   ██╗████████╗
██╔════╝██╔═══██╗████╗  ██║╚══██╔══╝██╔════╝████╗  ██║╚══██╔══╝
██║     ██║   ██║██╔██╗ ██║   ██║   █████╗  ██╔██╗ ██║   ██║   
██║     ██║   ██║██║╚██╗██║   ██║   ██╔══╝  ██║╚██╗██║   ██║   
╚██████╗╚██████╔╝██║ ╚████║   ██║   ███████╗██║ ╚████║   ██║   
 ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝   ╚═╝   ╚══════╝╚═╝  ╚═══╝   ╚═╝   
                                                               

      -->
      <br>
      <main class="cubridor d-flex align-items-center justify-content-center container jumbotron">
        <div>
            <center><h1 style="margin-right: 38vw">Alcance</h1></center><hr>
            <div class="row">
                <div class="col-md-2">
                    <img class="img-fluid" src="img/social-reach.png" style="height: 10vw">
                </div>
                <div class="col-md-9">
                    <p>
                        Hamatus tiene como alcance:<br>
                        - El registro de los empleados únicamente por un administrador, brindándoles un usuario y contraseña específicos, existiendo un usuario capaz de registrar documentos para todas las áreas, así como la capacidad de proporcionar “folios” en caso de que algún empleado requiera un documento físico. Los empleados pueden registrar documentos únicamente dentro de su área.
                    <br>- La empresa puede personalizar el software, como el nombre, las áreas que habrá y la cantidad de usuarios que estarán registrados.
                    </p>
                </div>
            </div>
        </div>
    </main>


    <!-- 
        

███████╗ ██████╗  ██████╗ ████████╗███████╗██████╗ 
██╔════╝██╔═══██╗██╔═══██╗╚══██╔══╝██╔════╝██╔══██╗
█████╗  ██║   ██║██║   ██║   ██║   █████╗  ██████╔╝
██╔══╝  ██║   ██║██║   ██║   ██║   ██╔══╝  ██╔══██╗
██║     ╚██████╔╝╚██████╔╝   ██║   ███████╗██║  ██║
╚═╝      ╚═════╝  ╚═════╝    ╚═╝   ╚══════╝╚═╝  ╚═╝

      -->

<jsp:include page="Prueba-Reu/my-footer.jsp" />
</body>
</html>
<!--
                                                    ╓╣╢╗
                                                  ,╣▒▒▒▒╣
                                                 @▒▒▒▒▒▒▒╢ ▄▄,
                                              ▄▄█▒▒▒▒▒▄████████▄
                                            ╓▀▀█████▄████████████▄
                                         ,@╣▒▒▒▒▒▒▒▀███████   ▐██▌
                                      ,╦╣▒▒▒▒▒▒▒▒▒▒▒███████   ▄███▄
                                   ,╦╣▒▒▒▒▒▒▒▒▒▒▒▒▒▒█████████████████▄▄
                                ,@▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▐████████████████████▄
                               ╔▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██████████████████████▄
                             ,╣▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▀██████▀▀▀▀▀``▀▀▀▀▀████
                            ╔▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓╜                      ▀█▌
                          ,╣▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
                         ╓╢▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒@
                        ╔▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒╢
                       ╫▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒U
                      ╫▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒╣
                     ╟▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
                    ╓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓╖
                    ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒@
                   ╣▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒╢
                  ]▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒╢
   ▓╢             ╣▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒╣
   ╢╢            ]▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
   ╢╢            ╟▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
   ╢╢            ╢▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
   ╢╢            ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒L
   ▓╢L           ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒[
    ╢▓           ╢▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒╡
    ╟╢@          ║▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒╢
     ▓╢╗         ]▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
      ▓╢@         ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
       ╙╢▓╖       ]▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
         ╩╢▓╖      ╣▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
           ╨╢▓╦     ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒╢
             "▓╢▓╦, ]▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
                 ╙▓╢▓╢▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒╖╓,
                     "╙╝╣▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒╣
-->