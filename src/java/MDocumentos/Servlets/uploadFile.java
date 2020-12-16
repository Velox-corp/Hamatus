/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MDocumentos.Servlets;

import MDocumentos.Clases.D_Documento;
import MDocumentos.Clases.M_Documento;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.nio.file.Paths;
import java.util.Calendar;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import org.apache.commons.fileupload.*;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author taspi
 * 
 * Basicamente esta cosa se activa con un formulario, y requiere los siguientes 
 * parametros para la subida: pass, direccion y file, este ultimo en funcion
 * de la clase Part
 */
public class uploadFile extends HttpServlet {
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try (PrintWriter out = response.getWriter()) {
            String pass = request.getParameter("pass");
            int id_tipo_acceso   = Integer.parseInt(request.getParameter("id_tipo_acceso"));
            String folio         = request.getParameter("folio");
            int Equipo_ID_Equipo = Integer.parseInt(request.getParameter("Equipo_ID_Equipo"));
            int id_D_DOcumento   = Integer.parseInt(request.getParameter("id_D_DOcumento"));
            int id_usuario_p     = Integer.parseInt(request.getParameter("id_usuario_p"));
            String ruta = request
                    .getParameter("ruta"); //Se refiere al titulo
            Part filePart = request
                    .getPart("file"); // Es el archivo y es la unica menra de traerlo
            String nombre = Paths.get(filePart.getSubmittedFileName())
                    .getFileName().toString(); //Basicamente nos trae el nombre del archivo
            InputStream fileContent = filePart
                    .getInputStream();//El contenido en bytes del archivo
            
            //Listado de datos preparados para entrar en la BD
            M_Documento mdoc = new M_Documento(id_D_DOcumento, id_usuario_p);
            if (mdoc.registrarM_Documentos()) {
                System.out.println("Todo correcto hasta el moemnto..");
                System.out.println("Entrando en fase 2");
                D_Documento ddoc = new D_Documento(nombre, ruta, pass,
                        id_tipo_acceso,folio, Equipo_ID_Equipo, 
                        mdoc.getIdM_Documento());
                if (ddoc.registrarDoc()) {
                    System.out.println("Todo Correcto uwu");
                }else{
                    System.out.println("Todo mal en ddoc unu");
                }
            }else{
                System.out.println("Ya valio esto unu, posible error al "
                        + "registrar la master del doc");
            }
            
            //Despues de todo ese merequetenge de la BD ya empieza lo del doc
            //Creacion del directorio y del achivo
            crearDirectorio(ruta);
            
            //despues metemos en ese direcorio nuestro archivo
            File f = crearArchivo(ruta, nombre);
            
            OutputStream out2 = new FileOutputStream(f);//Todo el inputStream va hacia nuestro archivo
            
            byte[] buf = new byte[1024];
            int len;

            while ((len = fileContent.read(buf)) > 0) {//Metemos contenido desde fileContent
              out2.write(buf, 0, len);//Metemos byte por byte al archivo de destino
            }

            //Cerramos todos los flujos para evitar brechas de seguridad
            fileContent.close();
            out2.close();
            //fw.close();
        }catch(Exception e){
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
    }
    
    /**
     * Crea el directorio o verifica que exita el mismo
     */
    private static void crearDirectorio(String dirc){
        //Creacion del directorio y del achivo
        File dir = new File(dirc);//Primero creamos el directorio
        if (!dir.exists()) {
            dir.mkdirs();
        }
    }
    
    /**
     * Crea nuestro archivo
     */
    private static File crearArchivo(String dirc, String fileName){
        File f = new File(dirc + "/" + fileName);//Este es nuestro archivo que queremos guardar
        if (!f.exists()) {
            try {
                f.createNewFile();
                return f;
            } catch (IOException ex) {
                Logger.getLogger(uploadFile.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return f;
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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