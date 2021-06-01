package ServletsEstadisticas;

import MDistribucion.Clases.Equipo;
import MDivisiones.clases.Division;
import MDocumentos.Clases.D_Documento;
import com.google.gson.JsonObject;
import MFlujos.Clases.FlujoDeTrabajo;
import MUsuarios.clases.Empresa;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Uzías
 * DE LOS FLUJOS DE TRABAJO OBTENER TODO SIN IMPORTAR LA FECHA
 * DE LOS DOCUMENTOS ENTREGADOS SÍ ES TOMANDO EN CUENTA LAS FECHAS
 */
@WebServlet(name = "afterFormulario", urlPatterns = {"/afterFormulario"})
public class afterFormulario extends HttpServlet {

        
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            //en cuanto llega del formulario hay que obtener las fechas, la division o equipo, id_empresa, supongo
            boolean esDivision = true;
            String division = "";
            String id_esDiv = "DI3";
            String id_own_division = "";
            
            //aqui tengo que revisar si es admin o nel xd
            String id_usuario = request.getParameter("usuario_id");
            String id_priv = request.getParameter("privilegio_id");
            int privilegioXD = Integer.parseInt(id_priv);
            System.out.println("EL id del usuario es " + id_usuario);
            System.out.println("EL id del privilegio es " + id_priv);
            
            //primero wa comparar las fechas que me dieron para ver que no me hayan puesto la de inicio mayor 
            String fechaxd = request.getParameter("fecha_in");
            String fechax = request.getParameter("fecha_fin");
            String seleccion = request.getParameter("seleccion");
            
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date fecha1 = sdf.parse(fechaxd);
            Date fecha2 = sdf.parse(fechax);
            System.out.println("La fecha 1 es "+fecha1);
            System.out.println("La fecha 2 es "+fecha2);
            
            int esMenor = fecha1.compareTo(fecha2); // si fecha 1 es menor que fecha2 será un numero menor a 0
            System.out.println("ATENCION AQUI El numero es " + esMenor);
            if (esMenor > 0){ 
                //entonces aqui hay un problema B)
                switch(privilegioXD){
                    case 1:
                        response.sendRedirect("Stats_Admin.jsp?fecha=bad");
                        return;
                    case 2:
                        response.sendRedirect("Stats_Lider.jsp?fecha=bad");
                        return;
                    case 3:
                        
                        return;
                    default:
                        System.out.println("Este usuario no tiene autoridad");
                        response.sendRedirect("error.jsp");
                        return;
                }
            }
            //primer problema abatido
            
            //para ver si dejo la seleccion en "blanco"
            if (seleccion.equals("defaultxd")){
                switch(privilegioXD){
                    case 1:
                        response.sendRedirect("Stats_Admin.jsp?opcion=bad");
                        return;
                    case 2:
                        response.sendRedirect("Stats_Lider.jsp?opcion=bad");
                        return;
                    case 3:
                        
                        return;
                    default:
                        System.out.println("Este usuario no tiene autoridad");
                        response.sendRedirect("error.jsp");
                        return;
                }
            }
            //segundo error abatido
            
            //para identificar a la division a la que pertenece el usuario
            id_own_division = request.getParameter("division_id");;
            
            //despues de que esos dos errores del formulario hayan pasado, vendrá aqui
            //primero tengo que saber de que division o equipo se verán las gráficas
            System.out.println("La seleccion es "+seleccion);
            if (seleccion.contains(id_esDiv)){
                //esto significa que es una division
                division = seleccion.substring(3);
                esDivision = true;
            } else {
                //esto significa que no es una division
                division = seleccion;
                esDivision = false;
            }
            
                System.out.println("El final sería "+division);
            //hasta ahora ya tengo las fechas, la seleccion y el tipo de usuario, me falta hacer la grafica y probablemente obtener el id de la division
            //se cancela, cambie el nombre por el ID de la division o equipo
            
            
            //como ya tengo el id del privilegio, hay que parsear
            int cantFlujos = 0;
            int cantFlujos2 = 0;
            int flujosHechos = 0;
            int flujosHechos2 = 0;
            HttpSession sesionUser = request.getSession();
            Empresa emp = (Empresa) sesionUser.getAttribute("empresa");
            switch (privilegioXD){
                //1 = admin, 2 = directivo, 3 = jefe de area
                case 1:
                    //primero haré las donas que son las fáciles xd
                    //para flujos hechos               Para estadisticas del equipo xd
                    //dona1xd
                    //aqui no importa la fecha
                    if (esDivision){
                        //para la primera dona
                        int id_empDx = 0;
                        HttpSession sesionUserx = request.getSession();
                        Empresa empx = (Empresa) sesionUserx.getAttribute("empresa");
                        id_empDx = empx.getIDEmpresa();
                        ArrayList<Equipo> equiposx = new ArrayList<Equipo>();
                        equiposx = Equipo.obtenerAllEquipos( id_empDx );
                        
                        
                        FlujoDeTrabajo flu = new FlujoDeTrabajo();
                        
                        if (equiposx.isEmpty()){
                            response.sendRedirect("Stats_Admin.jsp?noteam=bad");
                            return;
                        } 
                        for (int i = 0; i < equiposx.size(); i++) {
                            ArrayList<FlujoDeTrabajo> fluj = flu.consultarFlujosEmpleado(equiposx.get(i).getIDEquipo());
                            if(fluj.isEmpty()){
                                response.sendRedirect("Stats_Admin.jsp?noteam=bad");
                            return;
                            }
                            for (int j = 0; j < fluj.size(); j++) {
                                cantFlujos2 += 1;
                                if (fluj.get(j).isEntregado()){
                                    flujosHechos +=1;
                                }
                            }
                        }
                        int ff = cantFlujos2 - flujosHechos2;
                        
                        String finish2 = String.valueOf(flujosHechos2);
                        String finishnt2 = String.valueOf(ff);
                        
                        JsonObject jsonAEm = new JsonObject();
                        jsonAEm.addProperty("hechos", finish2);
                        jsonAEm.addProperty("noHechos", finishnt2);
                        request.setAttribute("JSONAEm", jsonAEm);
                        //esto significa que hay que revisar todos los equipos
                        int id_divi = Integer.parseInt(division);
                        FlujoDeTrabajo fl = new FlujoDeTrabajo();
                        ArrayList<FlujoDeTrabajo> fluj = fl.consultarFlujosLiderDiv(id_divi);
                        
                        if (fluj.isEmpty()){ //con esto evitamos que si es nulo haga algo, maybe tendria que hacer otra pestaña de error
                            response.sendRedirect("Stats_Admin.jsp?noteam=bad");
                            return;
                        }
                        
                        for (int i = 0; i < fluj.size(); i++) {
                            cantFlujos += 1;
                            if (fluj.get(i).isEntregado()){
                                flujosHechos += 1;
                            }
                        }
                        int faltantes = cantFlujos - flujosHechos;
                        
                        String faltante = String.valueOf(faltantes);
                        String realizados = String.valueOf(flujosHechos);
                        
                        JsonObject jsonD = new JsonObject();
                        jsonD.addProperty("hechos", realizados);
                        jsonD.addProperty("noHechos", faltante);
                        request.setAttribute("esemiJSON", jsonD);
                        
                        //a hacer la segunda grafica pero para una division
                        int id_empD = 0;
                        int docsTotales = 0;
                        int docsDivision = 0;
                        D_Documento doc = new D_Documento();
                        
                        
                        id_empD = emp.getIDEmpresa();
                        if(id_empD != 0){
                            ArrayList<Equipo> equipos = new ArrayList<Equipo>();
                            ArrayList<D_Documento> documentos = new ArrayList<D_Documento>();
                            equipos = Equipo.obtenerAllEquipos( id_empD );
                            
                            if (equipos.isEmpty()){
                                response.sendRedirect("Stats_Admin.jsp?noteam=bad");
                            return;
                            } else {
                                for (int i = 0; i < equipos.size(); i++) {
                                    documentos = doc.consultarDocByEquipo(equipos.get(i).getIDEquipo());
                                    
                                    for (int j = 0; j < documentos.size(); j++) {
                                        docsTotales += 1;
                                        String fechaaux = documentos.get(j).getFecha();
                                        Date fecha_aux = sdf.parse(fechaaux);
                                        
                                        //esta fecha debe ser mayor o igual a la fecha1 y menor o igual a fecha2
                                        int aux_ini = fecha_aux.compareTo(fecha1);
                                        int aux_fin = fecha_aux.compareTo(fecha2);
                                        if (aux_ini >= 0 && aux_fin <=0){
                                            //aparte ahora hay que revisar si el documento es de la division que queremos consultar

                                            int tempIdE = equipos.get(i).getIDDivision();
                                            if (tempIdE == id_divi){
                                                docsDivision += 1;
                                            }
                                            
                                        }
                                    }
                                }
                            }
                        }
                        System.out.println("Los documentos hechos por la division son "+docsDivision);
                        JsonObject jsonDoc = new JsonObject();
                        jsonDoc.addProperty("empresa", docsTotales);
                        jsonDoc.addProperty("equipo", docsDivision);
                        request.setAttribute("JSONDocumentos", jsonDoc);
                        
                        //
                        //PARA LA ULTIMA GRAFICA (LA ULTIMA QUE HICE, NO LA ULTIMA EN VISTA XD)
                        int id_empresaX = 0;
                        int cuantosDocumentosEX = 0;
                        int docsParaEquipoX = 0;
                        doc = new D_Documento();
                        ArrayList<Equipo> equipos = new ArrayList<Equipo>();
                        equipos = Equipo.obtenerAllEquipos( id_empD );
                        
                        // HttpSession sesionUser = request.getSession();
                        // Empresa emp = (Empresa) sesionUser.getAttribute("empresa");
                         id_empresaX = emp.getIDEmpresa(); //aqui me regresa el valor del ID empresa
                         System.out.println("El id de la empresa es "+id_empresaX);
                         if (id_empresaX != 0){
                             //continua
                             //ahora necesito obtener todos los id de los equipos de la empresa
                          //   ArrayList<Equipo> equipos = new ArrayList<Equipo>();
                             ArrayList<D_Documento> documentos = new ArrayList<D_Documento>();
                             equipos = Equipo.obtenerAllEquipos( id_empresaX );
                             int cuantosEquipos = 0;
                             if (equipos.isEmpty()){
                                 //hay que cambiar esto para mandar un ALERT para que diga no hay tims xd
                                 response.sendRedirect("Stats_Admin.jsp?noteam=bad");
                             return;
                             } else {
                                 cuantosEquipos = equipos.size();
                                 //ya tengo los equipos, ahora tengo que consultar los documentos de cada equipo
                                 for (int i = 0; i < cuantosEquipos; i++) {
                                     documentos = doc.consultarDocByEquipo(equipos.get(i).getIDEquipo());
                                     //ya que obtuve los documentos de un equipo, tengo que sumar cada vez que haya un doc
                                     for (int j = 0; j < documentos.size(); j++) {
                                         cuantosDocumentosEX += 1; // al final de esta secuencia debería tener el total de docs
                                         //primero hay que revisar que el documento se haya subido entre las fechas elegidas
                                         String fechaaux = documentos.get(j).getFecha();
                                         Date fecha_aux = sdf.parse(fechaaux);

                                         //esta fecha debe ser mayor o igual a la fecha1 y menor o igual a fecha2
                                         int aux_ini = fecha_aux.compareTo(fecha1);
                                         int aux_fin = fecha_aux.compareTo(fecha2);
                                         if (aux_ini >= 0 && aux_fin <=0){
                                                 docsParaEquipoX += 1;
                                         }
                                     }

                                 }
                                 JsonObject jsonDocE = new JsonObject();
                                 jsonDocE.addProperty("empresa", cuantosDocumentosEX);
                                 jsonDocE.addProperty("equipo", docsParaEquipoX);
                                 request.setAttribute("JSONDocumentosE", jsonDocE);
                             }
                         } else  {
                             response.sendRedirect("error.jsp");
                             System.out.println("NO HAY ID EMPRESA WEEEEE");
                             return;
                         } 
                         
                        JsonObject jsonFechas = new JsonObject();
                                 jsonFechas.addProperty("inicio", fechaxd);
                                 jsonFechas.addProperty("fin", fechax);
                                 request.setAttribute("JSONFechas", jsonFechas); 
                        RequestDispatcher rd;
                        rd = request.getRequestDispatcher("/Estadisticas_Administrador.jsp");
                        rd.forward(request, response); 
                    } else {
                        //para la que ahora será la primera dona 
                        //estamos en el caso de que es un team, pero eso en realidad no importa
                        //debo consultar todos los flujos para los equipos de la empresa
                        int id_empD = 0;
                        id_empD = emp.getIDEmpresa();
                        ArrayList<Equipo> equipos = new ArrayList<Equipo>();
                        equipos = Equipo.obtenerAllEquipos( id_empD );
                        
                        
                        FlujoDeTrabajo fl = new FlujoDeTrabajo();
                        
                        if (equipos.isEmpty()){
                            response.sendRedirect("Stats_Admin.jsp?noteam=bad");
                            return;
                        } 
                        for (int i = 0; i < equipos.size(); i++) {
                            ArrayList<FlujoDeTrabajo> fluj = fl.consultarFlujosEmpleado(equipos.get(i).getIDEquipo());
                            if(fluj.isEmpty()){
                                response.sendRedirect("Stats_Admin.jsp?noteam=bad");
                            return;
                            }
                            for (int j = 0; j < fluj.size(); j++) {
                                cantFlujos2 += 1;
                                if (fluj.get(j).isEntregado()){
                                    flujosHechos +=1;
                                }
                            }
                        }
                        int ff = cantFlujos2 - flujosHechos2;
                        
                        String finish2 = String.valueOf(flujosHechos2);
                        String finishnt2 = String.valueOf(ff);
                        
                        JsonObject jsonAEm = new JsonObject();
                        jsonAEm.addProperty("hechos", finish2);
                        jsonAEm.addProperty("noHechos", finishnt2);
                        request.setAttribute("JSONAEm", jsonAEm);
                        //esto fue para la dona xd
                        //sencillo, esto significa que es un equipo, por lo que la consulta se hace más simple
                        int id_equipo = Integer.parseInt(division);
                        
                        FlujoDeTrabajo f = new FlujoDeTrabajo();
                        ArrayList<FlujoDeTrabajo> flujos = f.consultarFlujosEmpleado(id_equipo);
                        
                        if (flujos.isEmpty()){ //con esto evitamos que si es nulo haga algo, maybe tendria que hacer otra pestaña de error
                            response.sendRedirect("Stats_Admin.jsp?noteam=bad");
                            return;
                        }
                        
                        for (int i = 0; i < flujos.size(); i++) {
                            cantFlujos += 1; //con esto obtendré el numero total de flujos realizados
                            if (flujos.get(i).isEntregado() == true){
                                flujosHechos += 1;
                            }
                        }
                        //para comprobar
                        System.out.println("Los flujos totales son " + cantFlujos);
                        System.out.println("Los flujos hechos del equipo son " + flujosHechos);
                        //en teoria it works 
                        //ahora viene lo hardcore, tengo que hacer que estos datos se pasen a la grafica, dona1xd
                        //request.setAttribute("totales", cantFlujos);
                        //request.setAttribute("noHechos", cantFlujos-flujosHechos);
                        //request.setAttribute("hechos", flujosHechos);
                        int no = cantFlujos - flujosHechos;
                        
                        String finish = String.valueOf(flujosHechos);
                        String finishnt = String.valueOf(no);
                        
                        JsonObject json = new JsonObject();
                        json.addProperty("hechos", finish);
                        json.addProperty("noHechos", finishnt);
                        request.setAttribute("esemiJSON", json);
                        
                        //AQUI VA PARA ARCHIVOS SUBIDOS EN LA SECCION DE EQUIPO
                        int id_empresa = 0;
                        int cuantosDocumentosE = 0;
                        int docsParaEquipo = 0;
                        D_Documento doc = new D_Documento();
                        
                       // HttpSession sesionUser = request.getSession();
                       // Empresa emp = (Empresa) sesionUser.getAttribute("empresa");
                        id_empresa = emp.getIDEmpresa(); //aqui me regresa el valor del ID empresa
                        System.out.println("El id de la empresa es "+id_empresa);
                        if (id_empresa != 0){
                            //continua
                            //ahora necesito obtener todos los id de los equipos de la empresa
                         //   ArrayList<Equipo> equipos = new ArrayList<Equipo>();
                            ArrayList<D_Documento> documentos = new ArrayList<D_Documento>();
                            equipos = Equipo.obtenerAllEquipos( id_empresa );
                            int cuantosEquipos = 0;
                            if (equipos.isEmpty()){
                                //hay que cambiar esto para mandar un ALERT para que diga no hay tims xd
                                response.sendRedirect("Stats_Admin.jsp?noteam=bad");
                            return;
                            } else {
                                cuantosEquipos = equipos.size();
                                //ya tengo los equipos, ahora tengo que consultar los documentos de cada equipo
                                for (int i = 0; i < cuantosEquipos; i++) {
                                    documentos = doc.consultarDocByEquipo(equipos.get(i).getIDEquipo());
                                    //ya que obtuve los documentos de un equipo, tengo que sumar cada vez que haya un doc
                                    for (int j = 0; j < documentos.size(); j++) {
                                        cuantosDocumentosE += 1; // al final de esta secuencia debería tener el total de docs
                                        //primero hay que revisar que el documento se haya subido entre las fechas elegidas
                                        String fechaaux = documentos.get(j).getFecha();
                                        Date fecha_aux = sdf.parse(fechaaux);
                                        
                                        //esta fecha debe ser mayor o igual a la fecha1 y menor o igual a fecha2
                                        int aux_ini = fecha_aux.compareTo(fecha1);
                                        int aux_fin = fecha_aux.compareTo(fecha2);
                                        if (aux_ini >= 0 && aux_fin <=0){
                                            //aparte ahora hay que revisar si el documento es del equipo que queremos consultar
                                            if (documentos.get(j).getEquipo_ID_Equipo() == id_equipo){
                                                docsParaEquipo += 1;
                                            }
                                        }
                                    }
                                    
                                }
                                System.out.println("Los documentos para la empresa son "+cuantosDocumentosE);
                                System.out.println("Los documentos para el equipo son " + docsParaEquipo);
                                JsonObject jsonDoc = new JsonObject();
                                jsonDoc.addProperty("empresa", cuantosDocumentosE);
                                jsonDoc.addProperty("equipo", docsParaEquipo);
                                request.setAttribute("JSONDocumentos", jsonDoc);
                            }
                        } else  {
                            response.sendRedirect("error.jsp");
                            System.out.println("NO HAY ID EMPRESA WEEEEE");
                            return;
                        }
                        
                        //PARA LA ULTIMA GRAFICA (LA ULTIMA QUE HICE, NO LA ULTIMA EN VISTA XD)
                        id_empresa = 0;
                        cuantosDocumentosE = 0;
                        docsParaEquipo = 0;
                        doc = new D_Documento();
                        
                       // HttpSession sesionUser = request.getSession();
                       // Empresa emp = (Empresa) sesionUser.getAttribute("empresa");
                        id_empresa = emp.getIDEmpresa(); //aqui me regresa el valor del ID empresa
                        System.out.println("El id de la empresa es "+id_empresa);
                        if (id_empresa != 0){
                            //continua
                            //ahora necesito obtener todos los id de los equipos de la empresa
                         //   ArrayList<Equipo> equipos = new ArrayList<Equipo>();
                            ArrayList<D_Documento> documentos = new ArrayList<D_Documento>();
                            equipos = Equipo.obtenerAllEquipos( id_empresa );
                            int cuantosEquipos = 0;
                            if (equipos.isEmpty()){
                                //hay que cambiar esto para mandar un ALERT para que diga no hay tims xd
                                response.sendRedirect("Stats_Admin.jsp?noteam=bad");
                            return;
                            } else {
                                cuantosEquipos = equipos.size();
                                //ya tengo los equipos, ahora tengo que consultar los documentos de cada equipo
                                for (int i = 0; i < cuantosEquipos; i++) {
                                    documentos = doc.consultarDocByEquipo(equipos.get(i).getIDEquipo());
                                    //ya que obtuve los documentos de un equipo, tengo que sumar cada vez que haya un doc
                                    for (int j = 0; j < documentos.size(); j++) {
                                        cuantosDocumentosE += 1; // al final de esta secuencia debería tener el total de docs
                                        //primero hay que revisar que el documento se haya subido entre las fechas elegidas
                                        String fechaaux = documentos.get(j).getFecha();
                                        Date fecha_aux = sdf.parse(fechaaux);
                                        
                                        //esta fecha debe ser mayor o igual a la fecha1 y menor o igual a fecha2
                                        int aux_ini = fecha_aux.compareTo(fecha1);
                                        int aux_fin = fecha_aux.compareTo(fecha2);
                                        if (aux_ini >= 0 && aux_fin <=0){
                                                docsParaEquipo += 1;
                                        }
                                    }
                                    
                                }
                                JsonObject jsonDocE = new JsonObject();
                                jsonDocE.addProperty("empresa", cuantosDocumentosE);
                                jsonDocE.addProperty("equipo", docsParaEquipo);
                                request.setAttribute("JSONDocumentosE", jsonDocE);
                            }
                        } else  {
                            response.sendRedirect("error.jsp");
                            System.out.println("NO HAY ID EMPRESA WEEEEE");
                            return;
                        }
                        
                        JsonObject jsonFechas = new JsonObject();
                                 jsonFechas.addProperty("inicio", fechaxd);
                                 jsonFechas.addProperty("fin", fechax);
                                 request.setAttribute("JSONFechas", jsonFechas); 
                        
                        RequestDispatcher rd;
                        rd = request.getRequestDispatcher("/Estadisticas_Administrador.jsp");
                        rd.forward(request, response);
                    }
                    break;
                case 2:
                    
                    break;
                case 3:
                    
                    break;
                default:
                    System.out.println("Que haces aqui xd");
                    response.sendRedirect("error.jsp");
            }
        } catch(Exception e){
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        } 
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
