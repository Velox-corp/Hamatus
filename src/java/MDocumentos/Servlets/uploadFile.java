/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MDocumentos.Servlets;

import MDocumentos.Clases.D_Documento;
import MDocumentos.Clases.M_Documento;
import MUsuarios.clases.Empresa;
import MUsuarios.clases.UsuarioEmpleado;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
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
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
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

@MultipartConfig(maxFileSize = 16177215)
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
        
        String redirect = request.getContextPath() + "/error.jsp";
        try {
            response.setContentType("text/html;charset=UTF-8");
            //Bueno creo que seria bueno traer una parte de la sesion
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
            
            String pass          = request.getParameter("pass");
            int id_tipo_acceso   = Integer.parseInt(request
                    .getParameter("id_tipo_acceso"));
            String folio         = request.getParameter("folio");
            int Equipo_ID_Equipo = Integer.parseInt(request
                    .getParameter("Equipo_ID_Equipo"));
            int id_D_DOcumento   = Integer.parseInt(request
                    .getParameter("id_D_DOcumento"));
            int id_usuario_p     = usuario.getIDUsuarioE();
            String ruta          = usuario.getIDUsuarioE().toString();
            Part filePart        = request.getPart("file"); // Es el archivo y es la unica menra de traerlo
            String nombre        = Paths.get(filePart.getSubmittedFileName())
                    .getFileName().toString(); //Basicamente nos trae el nombre del archivo
            
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
            
            OutputStream outs = null;
            InputStream filecontent = null;
            final PrintWriter writer = response.getWriter();
            try {
                crearFolder(usuario.getIDUsuarioE().toString(), request);
                outs = new FileOutputStream(new File(request.getRealPath("/archivos/"
                        +usuario.getIDUsuarioE().toString()+"/")+ File.separator
                        + nombre));
                filecontent = filePart.getInputStream();

                int read = 0;
                final byte[] bytes = new byte[1024];

                while ((read = filecontent.read(bytes)) != -1) {
                    outs.write(bytes, 0, read);
                }
                
                outs.close();
                filecontent.close();
                writer.close();
                
                response.flushBuffer();
            } catch (FileNotFoundException fne) {
                System.out.println("Algo de que no encontro el archivo"
                        + " o el folder");
                System.out.println(fne.getMessage());
                //response.sendRedirect(request.getContextPath() + "http://localhost:8080/Hamatus/error.jsp");
            } finally {
                System.out.println("Aver aver aver que demonios esta pasando");
                outs.close();
                filecontent.close();
                writer.close();
            }
            //redirect = "/docs.jsp";
            //response.setContentType("text/html/jsp");
            System.out.println("La URL es:" + request.getParameter("url"));
            if (response.isCommitted()) {
                
            }else{
                System.out.println("Algo anda mal y muy mal unu");
            }
        }catch(Exception e){
            System.out.println("El bug es dibido a:" + e.getMessage());
            System.out.println(e.getCause());
            System.out.println(e.getLocalizedMessage());
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
     * Crea nuestro archivo y lo guarda en el directorio
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
    
    /**
     * Es un metodo un poco mas robusto y para un folder en especifico
     */
    private void crearFolder(String dirc, HttpServletRequest request){
        //Creacion del directorio y del achivo
        try {
            String sCarpAct = request.getRealPath("/archivos/");
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
        String redirect = request.getContextPath() + "/error.jsp";
        try {
            response.setContentType("text/html;charset=UTF-8");
            //Bueno creo que seria bueno traer una parte de la sesion
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
            
            String pass          = request.getParameter("pass");
            int id_tipo_acceso   = Integer.parseInt(request
                    .getParameter("id_tipo_acceso"));
            String folio         = request.getParameter("folio");
            int Equipo_ID_Equipo = Integer.parseInt(request
                    .getParameter("Equipo_ID_Equipo"));
            int id_D_DOcumento   = Integer.parseInt(request
                    .getParameter("id_D_DOcumento"));
            int id_usuario_p     = usuario.getIDUsuarioE();
            String ruta          = usuario.getIDUsuarioE().toString();
            Part filePart        = request.getPart("file"); // Es el archivo y es la unica menra de traerlo
            String nombre        = Paths.get(filePart.getSubmittedFileName())
                    .getFileName().toString(); //Basicamente nos trae el nombre del archivo
            
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
            
            OutputStream outs = null;
            InputStream filecontent = null;
            final PrintWriter writer = response.getWriter();
            try {
                crearFolder(usuario.getIDUsuarioE().toString(), request);
                outs = new FileOutputStream(new File(request.getRealPath("/archivos/"
                        +usuario.getIDUsuarioE().toString()+"/")+ File.separator
                        + nombre));
                filecontent = filePart.getInputStream();

                int read = 0;
                final byte[] bytes = new byte[1024];

                while ((read = filecontent.read(bytes)) != -1) {
                    outs.write(bytes, 0, read);
                }
                
                request.setAttribute("flag_file_ok", true);
                request.getRequestDispatcher("docs.jsp").forward(request, response);
                //response.sendRedirect("docs.jsp");
                
            } catch (FileNotFoundException fne) {
                System.out.println("Algo de que no encontro el archivo"
                        + " o el folder");
                System.out.println(fne.getMessage());
                //response.sendRedirect(request.getContextPath() + "http://localhost:8080/Hamatus/error.jsp");
            } finally {
                System.out.println("Aver aver aver que demonios esta pasando");
                outs.close();
                filecontent.close();
                writer.close();
            }
        }catch(Exception e){
            System.out.println("El bug es dibido a:" + e.getMessage());
            System.out.println(e.getLocalizedMessage());
            e.printStackTrace();
        }
    }
    
    
}
