<%-- 
    Document   : vistaOrganigrama
    Created on : 1/12/2020, 01:11:02 AM
    Author     : maste
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Vista Del Organigrama</title>
        <jsp:include page="Prueba-Reu/my-links-boostrap.html" />
    </head>
    <body>
        <jsp:include page="Prueba-Reu/my-head2.jsp" />
        <main>
            <div class="row">
                <div class="col-md-12"><br>
                        <center><h1>Organigrama de la empresa</h1></center>
			<div class="row">
				<div class="col-md-12" id='organigrama'>
				</div>
			</div>
			<dl>
				<dt>
					Puesto actual:
				</dt>
				<dd>
					{Puesto_usuario}
				</dd>
				
			</dl>
		</div>
            </div>
            
        </main>
    </body>
    <jsp:include page="Prueba-Reu/my-footer.jsp" />
</html>
