<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>CRUD</title>

    <meta name="description" content="Source code generated using layoutit.com">
    <meta name="author" content="LayoutIt!">

    <jsp:include page="Prueba-Reu/my-links-boostrap.html" />
  </head>
  <body>

    <jsp:include page="Prueba-Reu/my-head.jsp" />
    <div class="container-fluid">
	<div class="row margin-top-1rem">
		<div class="col-md-2">
		</div>
		<div class="col-md-8">
                    <div class="container-fluid row justify-content-center">
			<img alt="Bootstrap Image Preview" src="https://www.layoutit.com/img/sports-q-c-140-140-3.jpg" class="rounded-circle">
                    </div>
			<form role="form">
                                <div class="row form-group justify-content-center">
                                    <label for="InputFile">
						Imagen
                                    </label>
                                    <input type="file" class="form-control-file" id="InputFile">
                                    <p class="help-block">
                                            Inserte imagen del empleado
                                    </p>
				</div>
                                <div class="form-group">		 
                                    <label for="nombre">
                                            Nombre
                                    </label>
                                    <input type="text" class="form-control" id="nombre">
				</div>
				<div class="form-group">
                                    <label for="Email">
                                            Email
                                    </label>
                                    <input type="email" class="form-control" id="Email">
				</div>
				<div class="form-group">
                                    <label for="Puesto">
                                            Puesto
                                    </label>
                                    <input type="text" class="form-control" id="Puesto">
				</div>
                                <div class="form-group">
                                    <label for="equipos">
                                            Equipos
                                    </label>
                                    <input type="text" class="form-control" id="equipos">
				</div>
				<button type="submit" class="btn btn-primary">
					Submit
				</button>
			</form>
		</div>
		<div class="col-md-2">
		</div>
	</div>
	<div class="row">
		<div class="col-md-12">
		</div>
	</div>
</div>
  </body>
  <jsp:include page="Prueba-Reu/my-footer.html" />
</html>