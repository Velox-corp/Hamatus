<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="sec">
                <article id="izquierda_3">
                    <div class="container_4">
                        <h1 class="titulo">Misión</h1>
                        <br>
                        <p>
                            Desarrollar servicios web para la persona u organización que lo requiera,
                            mediante la aplicación de insumos de alta calidad con la finalidad de
                            satisfacer diferentes funcionalidades tanto establecidas como nuevas que
                            se van presentando a través del internet.
                        </p>
                    </div>
                </article>

                <aside id="derecha_3">
                    <div class="container_4">
                        <h1 class="titulo">Visión</h1>
                        <br>
                        <p>
                            Ser una empresa capaz de satisfacer las necesidades y peticiones de
                            nuestros clientes, siendo innovadores y responsables a la hora y termino
                            del desarrollo de nuestros proyectos para convertirnos en una empresa
                            reconocida por su potencial y competitividad dentro del mercado, pero sin
                            perder la calidad de nuestros proyectos.
                        </p>
                    </div>
                </aside>
            </div> 
            <div class="sec">
                <article id="izquierda_3">
                    <div class="container_4">
                        <h1 class="titulo">Razón Social</h1>
                        <br>
                        <p style="text-align: center">
                            Velox S. en C. por A.
                        </p>
                    </div><br>
                    <div class="container_4">
                        <h1 class="titulo">Eslogan</h1>
                        <br>
                        <p style="text-align: center">
                            “Adaptados para cualquier carrera”
                        </p>
                    </div><br>
                    <div class="container_4">
                        <h1 class="titulo">Filosofía</h1>
                        <br>
                        <p>
                            “No hay problema que no podamos solucionar a pesar de entrar en crisis,
                            pues siempre concentramos nuestras ideas para aprovechar y tomar las
                            riendas de la situación”
                        </p>
                    </div>
                </article>

                <aside id="derecha_3">
                    <div class="container_4">
                        <h1 class="titulo">Logotipo</h1>
                        <br>
                        <img src="img/Logotipo.png">
                        <p>
                            Nuestro logotipo está representado por la especie endémica de México Geococcyx
                            velox, el cual representa que somos una empresa mexicana competitiva, con una
                            gran velocidad en los servicios y con una gran facilidad en que podemos realizar
                            una tarea.
                            Los números binarios que se encuentran en la cola del Geococcyx velox y en las
                            iniciales del nombre de la empresa representan el sistema que usan las
                            computadoras, el cual va a estar relacionado con la programación.
                            El nombre de la empresa es “Velox” debido a la especie, por lo tanto, se encuentra
                            debajo de la imagen de esta misma. El color del logotipo es azul debido a que
                            psicológicamente su vinculación más conocida es con la idea de serenidad y
                            calma, que es con lo que exactamente queremos transmitir a los clientes.
                        </p>
                    </div>
                </aside>
            </div>
            <script>
                function mostrarOcultar(id){
                var elemento = document.getElementById(id);
                if(!elemento) {
                return true;
                }
                if (elemento.style.display == "none") {
                elemento.style.display = "block"
                } else {
                elemento.style.display = "none"
                };
                return true;
                };
            </script>
            <div class="container_3">
		<article class="col">
                    <img src="img/Alicia.jpg" width="70" height="70">
                    <h1>Cortés Gamboa Alicia</h1>
                    <br><button onclick="return mostrarOcultar('ocultable')" type="button" class="btn btn-dark">Mostrar</button>
                    <div id="ocultable" style="display: none">
                        <p>
                            Soy actualmente una estudiante en la carrera de programación en CECyT 9 "Juan De Dios Bátiz",teniendo la edad de 16 años 
                            me considero aplicada a en mis estudios y responsable, además de ser alguien bastante sociable, teniendo un interés en area de tecnología y todo lo relacionado a esta,
                            siendo en el futuro dedicarme a alguna carrera de esta.<br>
                            Me gusta ver series, jugar videojuegos, hacer ejercicio y escuchar música.<br>
                            Siempre estoy dispuesta a aprender cosas nuevas y cumplir todos los retos que me proponga.
                        </p> 
                    </div>
		</article>
                
		<article class="col">
                    <img src="img/Damian.jpg" width="70" height="70">
                    <h1>Jarillo Hernández Armando Damián</h1>
                    <br><button onclick="return mostrarOcultar('ocultable_1')" type="button" class="btn btn-dark">Mostrar</button>
                    <div id="ocultable_1" style="display: none">
                        <p>
                            Soy un estudiante del CECyT 9 JDB, me considero alguien que debido a circunstancias de mi niñez me hice muy dedicado a los
                            estudios y con gran afición a la tecnología y videojuegos, aunque gracias a eso se me dificultan las situaciones sociales, 
                            pero hago todo lo que puedo para mejorar en todos los aspectos.
                        </p>
                    </div>
		</article>
                
		<article class="col">
                    <img src="img/Uzias.jpg" width="70" height="70">
                    <h1>García Lucero Uzias</h1>
                    <br><button onclick="return mostrarOcultar('ocultable_2')" type="button" class="btn btn-dark">Mostrar</button>
                    <div id="ocultable_2" style="display: none">
                        <p>
                            Actualmente estudio programación en el nivel medio superior, tengo 16 años y planeo dedicarme a algo
                            relacionado con la computación en un futuro, ya sea como ingeniero en sistemas computacionales o en algo relacionado al
                            software. En estos momentos tengo conocimientos en java, css3, html5, js, python y algunas nociones en c++, hablo español
                            y un poco de inglés. En mis tiempos libres me gusta leer o ver la televisión.<br>
                            He desarrollado proyectos relacionados con la computación desde que tenia 12 años y siempre me ha gustado, por eso, una de
                            las cosas que más disfruto hacer es usar una computadora o un celular, creo que se pueden usar para muchas cosas, tanto 
                            buenas, como malas, desafortunadamente.
                        </p>
                    </div>
		</article>
                
		<article class="col">
                    <img src="img/Roberto.jpg" width="70" height="70">
                    <h1>Quintana Romero Roberto</h1>
                    <br><button onclick="return mostrarOcultar('ocultable_3')" type="button" class="btn btn-dark">Mostrar</button>
                    <div id="ocultable_3" style="display: none">
                        <p>
                            Nací el 12 de mayo de 2003 en la Ciudad de México, hijo de Jesús Roberto Quintana y Graciela
                            Romero. <br>En 2006 ingrese al Colegio Simón Bolívar donde llevaría a cabo mis estudios básicos de primaria y secundaria 
                            donde realice deportes como natación y basquetbol participando así en partidos y competencias, pero mi gusto por las 
                            ciencias exactas como matemáticas me llevaría a ingresar en 2018 al Instituto Politécnico Nacional donde estudio 
                            actualmente la carrera Técnica en Programación. <br>Planeo ingresar a la universidad y estudiar alguna especialidad 
                            relacionada con matemáticas o alguna rama de la programación.
                        </p>
                    </div>
		</article>
		
                <article class="col">
                    <img src="img/Ivan.jpg" width="70" height="70">
                    <h1>Sánchez Gonzáles Daniel Ivan</h1>
                    <br><button onclick="return mostrarOcultar('ocultable_4')" type="button" class="btn btn-dark">Mostrar</button>
                    <div id="ocultable_4" style="display: none">
                        <p>
                            Me apasiona programar, creo que es una gran forma de expresarse tanto de forma intelectual como artistica, mi objetivo
                            es lograr llevar a cabo los proyectos que mi mente propone, y cuando algo realmente util o divertido emerja llevarlo 
                            al siguiente nivel -Navy.
                        </p>
                    </div>
		</article>
                
		<article class="col">
                    <img src="img/Luis.jpg" width="70" height="70">
                    <h1>Tenorio Aspiros Luis Fernando</h1>
                    <br><button onclick="return mostrarOcultar('ocultable_5')" type="button" class="btn btn-dark">Mostrar</button>
                    <div id="ocultable_5" style="display: none">
                        <p>
                           Soy un apasionado a la programación y a los videojuegos, mis pasatiempos favoritos
                           son jugar videojuegos, ver anime y leer cuentos de ciencia ficción. <br>
                           Tengo la intención de estudiar ciencia de los datos 
                           cuando vaya a la universidad. 
                        </p>
                    </div>
		</article>
            </div>
