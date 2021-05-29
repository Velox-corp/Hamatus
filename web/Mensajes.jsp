<%@page import="MChat.Clases.UsuarioSala"%>
<%@page import="MUsuarios.clases.Empresa"%>
<%@page import="MUsuarios.clases.UsuarioEmpleado"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession sesionUser = request.getSession();
    String username = "";
    int id_user=0;
    
    UsuarioEmpleado usuario = (UsuarioEmpleado) sesionUser.getAttribute("usuario");
    username = usuario.getNombre();
    id_user=usuario.getIDUsuarioE();
    //System.out.println(request.getAttribute("idsla").toString());/*
    //int sla =Integer.parseInt(request.getAttribute("idsla").toString());*/
    
%>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Mensajes</title>
        
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
        <link rel="stylesheet" href="CSS/style.css">
        
        <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
        
    </head>
    <body>
        <div class="row ">
            <div class="col-md-4 chat-box ">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        
                        <span class="glyphicon glyphicon-comment"></span> Chat
                        <div class="btn-group pull-right">
                            <button type="button" class="btn btn-default btn-xs dropdown toggle" data-toggle="dropdown">
                                <span class="glyphicon glyphicon-chevron-down"></span>
                            </button>
                            <ul class="dropdown-menu slidedown">
                                <li><a href=""><span class="glyphicon glyphicon-off"></span>Salir</a></li>
                                
                            </ul>
                        </div>
                        
                    </div>
                    
                    <div class="panel-body chat-widget">
                        <ul class="chat chat-messages">                
                            <li>
                                <span class="chat-img pull-left">
                                    <img src=""/>
                                </span>
                                <div class="chat-body clear-fix">
                                    <div class="header">
                                        <strong class="primary-font">Mensage Predeterminado</strong>
                                        <small class="pull-right text-muted">
                                            <span class="glyphicon glyphicon-time"></span>
                                            A las 12:30
                                        </small>
                                        <p>
                                            Aqui se visualizaran los mensajes :)
                                        </p>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>
                    
                    <div class="panel-footer">
                        <div class="form-group">
                            <input type="text" class="form-control input-sm chat-name" value="<%=username%>" readonly>
                            <input type="hidden"  class="user-id" value="<%=id_user%>">
                            <input type="hidden"  class="sala-id" value="${idsla}">
                        </div>
                        <div class="form-group">
                            <input type="text" class="form-control input-sm chat-entry" placeholder="Escriba un mensaje y presione enter para enviar">
                        </div>
                    </div>
                    
                </div>
            </div>
        </div>
    <script src="https://js.pusher.com/7.0/pusher.min.js"></script>
    <script src="JS/chat.js"></script>
    <script>

    // Enable pusher logging - don't include this in production
    //Pusher.logToConsole = true;

    var pusher = new Pusher('78f597b507c09cc4229c', {
      cluster: 'us2'
      //encrypted: true//sirve cuando se usa https
    });
    
    var chat= new ChatWidget(pusher);
/*canal del usuario*/
    /*var channel = pusher.subscribe('my-channel');
    channel.bind('my-event', function(data) {
      console.log(data); 
    });*/
  </script>
    </body>
</html>
