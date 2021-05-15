/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package MFlujos.Servlets;

import ClasesSoporte.Folio;
import MDistribucion.Clases.EUsuarioEquipo;
import MDocumentos.Clases.D_Documento;
import MDocumentos.Clases.M_Documento;
import MFlujos.Clases.FlujoDeTrabajo;
import MUsuarios.clases.Empresa;
import MUsuarios.clases.UsuarioEmpleado;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.nio.file.Paths;
import java.util.Calendar;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 * Sevlet para ejecutar función de: subir una evidencia
 * Se puede decir que este sevlet es el la copia barata de upladFile_J.java
 * Implementando tambien los folders de equipo
 * 
 * @author Armando Jarillo
 */
@MultipartConfig(maxFileSize = 16177215)
public class subirEvidencia extends HttpServlet {
   
    
    /**
     * Es un metodo un poco mas robusto y para un folder en especifico
     * Y está aquí para no jugarle al vergas y mejor tambien dividir las evidencias por equipos a nivel almacenamiento
     */
    private void crearFolder(String dirc, HttpServletRequest request){
        //Creacion del directorio y del achivo
        try {
            String sCarpAct = request.getRealPath("/evidencias/");
            //String sCarpAct = ServletContext.getRealPath("/");
            System.out.println(sCarpAct +"/"+ dirc);
            File dir = new File(sCarpAct +"/"+ dirc);//Primero creamos el directorio
            if (!dir.exists()) {
                dir.mkdirs();
            }            
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
    }
    
    
    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String redirect = "error.jsp";
        try {
            //bueno, tomare lo que hizo Tenorio y lo ajustare a las necesidades de aquí, lo tengo que hacer con mucha fe
            response.setContentType("text/html;charset=UTF-8");
            //Validación sesión
            HttpSession sesionUser = request.getSession();
            boolean obtencionAdecuada = false;
            UsuarioEmpleado usuario = null;
            Empresa emp = null;
            try{
                usuario = (UsuarioEmpleado) sesionUser.getAttribute("usuario");
                emp = (Empresa) sesionUser.getAttribute("empresa");
                obtencionAdecuada = true; 
            }catch(NullPointerException ex){
                System.out.println(ex.getMessage());
                ex.printStackTrace();
                obtencionAdecuada = false;
            }
            if (obtencionAdecuada) {
                //a obtener los datos, que son pocos, y otros se generan automaticamente al ser "evidencias"
                
                int idf = Integer.parseInt(request.getParameter("idf"));
                
                int id_tipo_acceso = 1 ;//tecnicamente el lider de división es el único que tiene acceso

                char tipo_archivo = request.getParameter("tipo_archivo").charAt(0); 
                
                Calendar c1 = Calendar.getInstance();
                String folio         = Folio.generarFolio(
                        tipo_archivo,Character.forDigit(id_tipo_acceso, 10),
                        c1.get(Calendar.YEAR),c1.get(Calendar.MONTH),
                        c1.get(Calendar.DATE),c1.get(Calendar.HOUR),
                        c1.get(Calendar.MINUTE));
                
                String pass = folio;
                
                int Equipo_ID_Equipo = EUsuarioEquipo.buscarEquipo(usuario.getIDUsuarioE());
                
                int id_D_DOcumento   = 1;//no entiendo bien esto, mi explicación es que metimos estre atributo, pero no tiene la relación correcta, así que debría ser depreciado
                
                int id_usuario_p     = usuario.getIDUsuarioE();
                
                String ruta          = "/evidencias/"+Equipo_ID_Equipo+"/";
                
                Part filePart        = request.getPart("file"); // Es el archivo (ahora evidencía) y es la unica menra de traerlo
                
                String nombre        = Paths.get(filePart.getSubmittedFileName())
                        .getFileName().toString(); //Basicamente nos trae el nombre del archivo
                
                Integer es_evidencia_flujo = 1; //SOLO AQUÍ este valor va a tener el valor de 1
                
                Integer id_cat_clasif_doc = 2; //cuenta como un archivo normal, ya que el que se aevidencia de trabajo lo determina el booleano
                
                //Listado de datos preparados para entrar en la BD
                
                M_Documento mdoc = new M_Documento(id_D_DOcumento, id_usuario_p);
                
                if (mdoc.registrarM_Documentos()) {
                    System.out.println("Fase 2");
                    D_Documento ddoc = new D_Documento(nombre, ruta, pass,
                            id_tipo_acceso,folio, Equipo_ID_Equipo, 
                            mdoc.getIdM_Documento(), es_evidencia_flujo, 
                            id_cat_clasif_doc);
                    
                    if (!D_Documento.ConsultarD_Doc_B(Equipo_ID_Equipo , nombre)) { //diría que gasta mucho recurso, pero mejor no jugarle al verga con nombre y terminación repetida
                        if (ddoc.registrarDoc()) {
                            
                            //si ya está el doc, significa que ya puedo actualizar la evidencía,así que ahí va otro if
                            
                            if (FlujoDeTrabajo.insertarEFD(mdoc.getIdM_Documento(), idf)){
                                //subida de documento al servidor
                                OutputStream outs = null;
                                InputStream filecontent = null;
                                final PrintWriter writer = response.getWriter();
                                try {
                                    crearFolder(String.valueOf(Equipo_ID_Equipo), request);

                                    outs = new FileOutputStream(new File(request.getRealPath("/evidencias/"
                                            +Equipo_ID_Equipo+"/")+ File.separator + nombre));
                                    filecontent = filePart.getInputStream();

                                    int read = 0;
                                    final byte[] bytes = new byte[1024];

                                    while ((read = filecontent.read(bytes)) != -1) {
                                        outs.write(bytes, 0, read);
                                    }

                                    redirect = "verFlujosTrabajo.jsp";
                                    
                                } catch (FileNotFoundException fne) {
                                    System.out.println("Algo de que no encontro el archivo"
                                            + " o el folder");
                                    System.out.println(fne.getMessage());
                                } catch(IOException e){
                                    System.out.println("E fallado por otra razón");
                                }finally {
                                    System.out.println("Aver aver aver que demonios esta pasando");
                                    outs.close();
                                    filecontent.close();
                                    //writer.close();
                                }
                                
                            }else{//Aun no se a donde mandarlos si hay errores, así que usaré la vieja confiable
                                System.out.println("No se guardo la relación");
                                redirect = "error.jsp";
                            }
                        }else{ 
                            System.out.println("Todo mal en ddoc unu");
                            redirect = "error.jsp";
                        }
                    }else{
                        System.out.println("Hijole ya existe este doc uwu");
                        redirect = "error.jsp";
                    }
                }else{
                    System.out.println("Ya valio esto unu, posible error al "
                            + "registrar la master del doc");
                    redirect = "error.jsp";
                }
            }
        }catch(Exception e){
            System.out.println("El bug es dibido a:" + e.getMessage());
            System.out.println(e.getLocalizedMessage());
            e.printStackTrace();
            redirect = "error.jsp";
        }finally{
            response.sendRedirect(redirect);
        }
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
