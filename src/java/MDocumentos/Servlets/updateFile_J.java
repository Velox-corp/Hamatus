/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MDocumentos.Servlets;

import MDocumentos.Clases.D_Documento;
import MUsuarios.clases.Empresa;
import MUsuarios.clases.UsuarioEmpleado;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.nio.file.Paths;
import java.util.Hashtable;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author taspi
 * 
 * Importante: Es probable que para el metodo se utilice GET pero de 
 * preferencia utlizar POST, hay una pequeña trampa con este metodo ya que es 
 * probable que sea como sobre escribir el archivo
 */
@MultipartConfig(maxFileSize = 16177215)
public class updateFile_J extends HttpServlet {

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
        try {
            try {
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
                System.out.println("credenciales correctas");
                String value = request.getParameter("dictionary");
                value = value.substring(1, value.length()-1);
                String[] keyValuePairs = value.split(",");
                Hashtable<Integer, String> list = new Hashtable<Integer, String>();
                for (String pair : keyValuePairs) {
                    String[] entry = pair.split("=");
                    list.put(1, value);
                }
                String pass   = request.getParameter("pass");
                String nombre = request.getParameter("nombre");
                Integer es_evidencia_flujo = Integer.getInteger(
                        request.getParameter("es_evidencia_flujo"));
                Integer id_cat_clasif_doc = Integer.getInteger(
                        request.getParameter("id_cat_clasif_doc"));

                int id_tipo_acceso   = Integer.parseInt(String.valueOf(request
                        .getParameter("id_tipo_acceso").charAt(0)));  
                Part filePart = null;
                try {
                    filePart      = request.getPart("file");
                } catch (Exception e) {
                    System.out.println("Bueno no encontro el archivo pero eso no significa nada malo");
                }
                if (filePart.getSize() != 0) {
                    //Listado de datos preparados para entrar en la BD
                    int ID_equipo = Integer.parseInt(request.getParameter("id_e"));
                    D_Documento ddoc = new D_Documento();
                    ddoc.ConsultarD_Doc(ID_equipo, nombre);
                    if(ddoc.UpdateDoc(nombre, pass, id_tipo_acceso,
                            ddoc.getID_Documento(), es_evidencia_flujo, 
                            id_cat_clasif_doc)){
                        System.out.println("Ok ahora la parte del archivo");
                        OutputStream outs = null;
                        InputStream filecontent = null;
                        //final PrintWriter writer = response.getWriter();
                        File file = new File(request.getServletContext().getRealPath("/archivos/"
                                +ID_equipo+"/" + nombre));
                        outs = new FileOutputStream(file);//A donde se diregen los bytes
                        filecontent = filePart.getInputStream();
                        int read = 0;
                        final byte[] bytes = new byte[1024];

                        while ((read = filecontent.read(bytes)) != -1) {
                            outs.write(bytes, 0, read);
                        }
                        response.sendRedirect("docs.jsp?flag=true");
                    }else{
                        System.out.println("Ni modo ya valio en esta otra parte");
                        response.sendRedirect("docs.jsp?flag=false");
                    }
                }else{
                    //Listado de datos preparados para entrar en la BD
                    int ID_equipo = Integer.parseInt(request.getParameter("id_e"));
                    D_Documento ddoc = D_Documento.ConsultarD_Doc_sget(ID_equipo, nombre);
                    if(ddoc.UpdateDoc(nombre, pass, id_tipo_acceso, 
                            ddoc.getID_Documento(), es_evidencia_flujo, 
                            id_cat_clasif_doc)){
                        response.sendRedirect("docs.jsp?flag=true");
                    }else{
                        response.sendRedirect("docs.jsp?flag=false");
                    }
                }
                
            }else{
                response.sendRedirect("error.jsp");
            }
            } catch (Exception e) {
                System.out.println("Error al hacer update de un doc");
                System.out.println(e.getMessage());
                e.printStackTrace();
                response.sendRedirect("error.jsp");
            }
        }catch(Exception e){
            System.out.println(e.getMessage());
            e.printStackTrace();
            System.out.println(e.getLocalizedMessage());
            response.sendRedirect("error.jsp");
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
