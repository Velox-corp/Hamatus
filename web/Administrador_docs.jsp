<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
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

    <jsp:include page="Prueba-Reu/my-head.jsp" />
    
    <main>
    <div class="row margin-top-1rem">
    <div class="col-md-4 folio">
            <ul>
                    <li class="list-item">
                        <h4>Clientes</h4>
                            <ul>
                                <li class="list-item">
                                        Consectetur adipiscing elit
                                </li>
                                <li class="list-item">
                                        Integer molestie lorem at massa
                                </li>
                                <li class="list-item">
                                        Facilisis in pretium nisl aliquet
                                </li>
                                <li class="list-item">
                                        Nulla volutpat aliquam velit
                                </li>
                                <li class="list-item">
                                        Faucibus porta lacus fringilla vel
                                </li>
                            </ul>
                    </li>
                    <li class="list-item">
                            Aenean sit amet erat nunc
                    </li>
                    <li class="list-item">
                        <h4>Empresa</h4>
                            <ul>
                                <li class="list-item">
                                        Consectetur adipiscing elit
                                </li>
                                <li class="list-item">
                                        Integer molestie lorem at massa
                                </li>
                                <li class="list-item">
                                        Facilisis in pretium nisl aliquet
                                </li>
                                <li class="list-item">
                                        Nulla volutpat aliquam velit
                                </li>
                                <li class="list-item">
                                        Faucibus porta lacus fringilla vel
                                </li>
                            </ul>
                    </li>
            </ul>
        
        </div>
        <div class="col-md-7">
			<nav>
				<ul class="pagination">
					<li class="page-item">
						<a class="page-link" href="#">Previous</a>
					</li>
					<li class="page-item">
						<a class="page-link" href="#">1</a>
					</li>
					<li class="page-item">
						<a class="page-link" href="#">2</a>
					</li>
					<li class="page-item">
						<a class="page-link" href="#">3</a>
					</li>
					<li class="page-item">
						<a class="page-link" href="#">4</a>
					</li>
					<li class="page-item">
						<a class="page-link" href="#">5</a>
					</li>
					<li class="page-item">
						<a class="page-link" href="#">Next</a>
					</li>
				</ul>
			</nav>
			<div class="card">
				<h5 class="card-header">
					Card title
				</h5>
				<div class="card-body">
					<p class="card-text">
						Card content
					</p>
				</div>
				<div class="card-footer">
					Card footer
				</div>
			</div> 
                    <br>
                    <div class="justify-content-center">
			<button type="button" class="btn btn-success btn-lg">
                            Save Changes
			</button>
                        <button type="button" class="btn btn-success btn-lg">
                            Cancel
			</button>
                    </div>
		</div>
		<div class="col-md-1">
		</div>
        <br>
        <div class="container-fluid ">
                <h3>Nuevo Folio</h3>
                <hr>
                <!--ok no se que diablos esta pasando aqui-->
                <form class="form-group">
                    <div>
                        <h4>Documento</h4>
                        <input name="documento" type="text" placeholder="Text Input" class="form-control">
                        <input name="documento" type="file" placeholder="File Upload" class="form-control-file border">
                    </div>

                    <h4>Jerarquias</h4>
                    <div class="custom-control custom-checkbox">
                        <input type="checkbox" class="custom-control-input" id="defaultChecked1" checked>
                        <label class="custom-control-label" for="defaultChecked1">Default checked</label>
                    </div>
                    <div class="custom-control custom-checkbox">
                        <input type="checkbox" class="custom-control-input" id="defaultChecked2" checked>
                        <label class="custom-control-label" for="defaultChecked2">Default checked</label>
                    </div>
                    <div class="custom-control custom-checkbox">
                        <input type="checkbox" class="custom-control-input" id="defaultChecked3" checked>
                        <label class="custom-control-label" for="defaultChecked3">Default checked</label>
                    </div>
                    
                    <button class="form-control btn btn-success">Done</button>
                </form>       
            </div>
        </div>
        
    </main>
        

  <jsp:include page="Prueba-Reu/my-footer.html" />
  </body>
</html>