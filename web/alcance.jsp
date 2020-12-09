<%@page language="java" pageEncoding="UTF-8" contentType="text/html"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset='utf-8'>
    <meta http-equiv='X-UA-Compatible' content='IE=edge'>
    <title>Hamatus</title>
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
      <main class="cubridor d-flex align-items-center justify-content-center container">
        <div>
            <center><H1>¿Para quien?</H1></center>
            <div class="row">
                <div class="col-md-3">
                    <img class="img-fluid" src="data:image/png;base64,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">
                </div>
                <div class="col-md-9">
                    <p>
                    Lorem ipsum, dolor sit amet consectetur adipisicing elit.
                    Debitis ab placeat sit minima explicabo vitae ut ipsum,
                    reprehenderit aperiam nulla officia facere! Error accusantium
                    magnam repellat. Incidunt eum perspiciatis ab?
                    Lorem ipsum, dolor sit amet consectetur adipisicing elit.
                    Debitis ab placeat sit minima explicabo vitae ut ipsum,
                    reprehenderit aperiam nulla officia facere! Error accusantium
                    magnam repellat. Incidunt eum perspiciatis ab?
                    Lorem ipsum, dolor sit amet consectetur adipisicing elit.
                    Debitis ab placeat sit minima explicabo vitae ut ipsum,
                    reprehenderit aperiam nulla officia facere! Error accusantium
                    magnam repellat. Incidunt eum perspiciatis ab?
                    Lorem ipsum, dolor sit amet consectetur adipisicing elit.
                    Debitis ab placeat sit minima explicabo vitae ut ipsum,
                    reprehenderit aperiam nulla officia facere! Error accusantium
                    magnam repellat. Incidunt eum perspiciatis ab?
                    </p>
                </div>
            </div>
            <br>
            <div class="row">
                <div class="col-md-3">
                    <img class="img-fluid" src="data:image/png;base64,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">
                </div>
                <div class="col-md-9">
                    <p align="justify">
                        Lorem ipsum, dolor sit amet consectetur adipisicing elit.
                        Debitis ab placeat sit minima explicabo vitae ut ipsum,
                        reprehenderit aperiam nulla officia facere! Error accusantium
                        magnam repellat. Incidunt eum perspiciatis ab? Lorem ipsum, dolor sit amet consectetur adipisicing elit.
                        Debitis ab placeat sit minima explicabo vitae ut ipsum,
                        reprehenderit aperiam nulla officia facere! Error accusantium
                        magnam repellat. Incidunt eum perspiciatis ab? Lorem ipsum, dolor sit amet consectetur adipisicing elit.
                        Debitis ab placeat sit minima explicabo vitae ut ipsum,
                        reprehenderit aperiam nulla officia facere! Error accusantium
                        magnam repellat. Incidunt eum perspiciatis ab?
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

<jsp:include page="Prueba-Reu/my-footer.html" />
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