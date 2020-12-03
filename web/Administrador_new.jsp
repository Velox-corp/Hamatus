<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Administrador</title>

    <meta name="description" content="Source code generated using layoutit.com">
    <meta name="author" content="LayoutIt!">

    <jsp:include page="Prueba-Reu/my-links-boostrap.html" />

  </head>
  <body>

        <jsp:include page="Prueba-Reu/my-head2.jsp" />
	<div class="row margin-top-1rem">
		<div class="col-md-2">
		</div>
		<div class="col-md-8">
			<h3 class="text-center">
				Nuevo empleado
			</h3>
			<form role="form">
                            <div class="form-group">
                                <label for="Nombre">
                                        Nombre
                                </label>
                                <input type="text" class="form-control" 
                                       id="Nombre" placeholder="Inserte nombre del empleado">
                            </div>
                            <div class="form-group">
                                    <label for="Email1">
                                            Correo
                                    </label>
                                    <input type="email" class="form-control" 
                                           placeholder="Inserte correo del empleado" id="Email1">
                            </div>
                            <div class="form-group">
                                    <label for="Password">
                                            Contraseña
                                    </label>
                                    <input type="password" class="form-control" id="Password" placeholder="Inserte contrseña del empleado">
                            </div>
                            <div class="form-group">
                                    <label for="Img">
                                            Imagen
                                    </label>
                                    <input type="file" class="form-control-file" id="Img">
                                    <!--<p class="help-block">
                                            Example block-level help text here.
                                    </p>-->
                            </div>
                            <div class="row">
                                <div class="col-md-2">
                                    <div class="dropdown">
                                        <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
                                            Opciones
                                        </button>
                                        <div class="dropdown-menu">
                                          <a class="dropdown-item" href="#">Link 1</a>
                                          <a class="dropdown-item" href="#">Link 2</a>
                                          <a class="dropdown-item" href="#">Link 3</a>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-7"></div>
                                <div class="col-md-3">
                                    <div class="row">
                                        <button type="submit" class="btn btn-primary">
                                                Save changes
                                        </button>
                                        <button type="submit" class="btn btn-danger">
                                                Cancel
                                        </button>
                                    </div>
                                </div>
                            </div>
			</form>
		</div>
		<div class="col-md-2">
		</div>
	</div>
  </body>
  <jsp:include page="Prueba-Reu/my-footer.html" />
</html>