/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MDocumentos.Servlets;

import MDocumentos.Clases.D_Documento;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.nio.file.Paths;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author taspi
 * 
 * Importante: Es probable que para el metodo se utilice GET pero de 
 * preferencia utlizar POST, hay una pequeña trampa con este metodo ya que es 
 * probable que sea como sobre escribir el archivo
 */
public class updateFile extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String rec = "error.jsp";
            try {
                /*Todo ese contenido aqui
                Lo que se cambia en la BD es nombe, ruta, pass, id_tipo_acceso y folio*/
                /*ahora si esto es lo que se cambia del file*/
                Part filePart = request
                        .getPart("file"); // Es el archivo y es la unica menra de traerlo
                String nombre = Paths.get(filePart.getSubmittedFileName())
                        .getFileName().toString(); //Basicamente nos trae el nombre del archivo
                InputStream fileContent = filePart
                        .getInputStream();//El contenido en bytes del archivo
                String pass = request.getParameter("pass");
                int id_tipo_acceso   = Integer.parseInt(request.getParameter("id_tipo_acceso"));
                String folio         = request.getParameter("folio");
                String ruta = request
                        .getParameter("ruta"); //Se refiere al titulo de la carpeta
                int id_D_DOcumento   = Integer.parseInt(request.getParameter("id_D_DOcumento"));

                D_Documento ddoc = new D_Documento();
                ddoc.UpdateDoc(nombre, ruta, pass, id_tipo_acceso,
                        folio, id_D_DOcumento);//Y pues ya esto seria todo en BD

                //Ahora falta en el archivo como tal
                File archivo = new File(ruta);
                if(archivo.exists()) {
                    // El fichero ya existe
                    OutputStream out2 = new FileOutputStream(archivo);//Todo el inputStream va hacia nuestro archivo

                    byte[] buf = new byte[1024];
                    int len;

                    while ((len = fileContent.read(buf)) > 0) {//Metemos contenido desde fileContent
                        out2.write(buf, 0, len);//Metemos byte por byte al archivo de destino
                    }

                    //Cerramos todos los flujos para evitar brechas de seguridad
                    fileContent.close();
                    out2.close();
                    rec = "docs.jsp";
                } else {
                      // El fichero no existe y porlo tanto XD
                      System.out.println("No se encontro el archivo");
                }
            } catch (Exception e) {
                System.out.println("Error al hacer update de un doc");
                System.out.println(e.getMessage());
                e.printStackTrace();
            }
            response.sendRedirect(rec);
        }
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

}
