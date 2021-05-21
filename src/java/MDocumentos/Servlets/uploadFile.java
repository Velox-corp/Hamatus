/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MDocumentos.Servlets;

import ClasesSoporte.Folio;
import MDocumentos.Clases.D_Documento;
import MDocumentos.Clases.M_Documento;
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
import java.util.Hashtable;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
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
 * Basicamente esta cosa se activa con un formulario, y requiere los siguientes 
 * parametros para la subida: pass, direccion y file, este ultimo en funcion
 * de la clase Part
 */

@MultipartConfig(maxFileSize = 16177215)
public class uploadFile extends HttpServlet {
    
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
    
    /**Un metodo de emergencia por si todo llega a salir mal*/
    private void crearFolderA(HttpServletRequest request) {
        //Creacion del directorio y del achivo
        try {
            String sCarpAct = request.getServletContext().getRealPath("/");
            //String sCarpAct = ServletContext.getRealPath("/");
            System.out.println(sCarpAct);
            File dir = new File(sCarpAct +"/archivos");//Primero creamos el directorio
            if (!dir.exists()) {
                dir.mkdirs();
            }            
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
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
        String redirect = request.getContextPath() + "error.jsp";
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
                String pass = null;

                int id_tipo_acceso   = Integer.parseInt(String.valueOf(request
                        .getParameter("id_tipo_acceso").charAt(0)));  

                char tipo_archivo    = request.getParameter("tipo_archivo").charAt(0);
                Calendar c1 = Calendar.getInstance();
                String folio         = Folio.generarFolio(
                        tipo_archivo,Character.forDigit(id_tipo_acceso, 10),
                        c1.get(Calendar.YEAR),c1.get(Calendar.MONTH),
                        c1.get(Calendar.DATE),c1.get(Calendar.HOUR),
                        c1.get(Calendar.MINUTE));
                try {
                    pass = request.getParameter("pass");
                } catch (Exception e) {
                    System.out.println("No hay contraseña procedemos a darle una");
                }
                
                if ("".equals(pass)) {
                    pass = folio;
                }
                
                String q = request.getParameter("q");
                int Equipo_ID_Equipo = UsuarioEmpleado.consultarID_Equipo(usuario.getIDUsuarioE());
                int id_D_DOcumento   = 1;//no entiendo bien esto
                int id_usuario_p     = usuario.getIDUsuarioE();
                String ruta          = "/archivos/"+Equipo_ID_Equipo+"/";
                Part filePart        = request.getPart("file"); // Es el archivo y es la unica menra de traerlo
                String nombre        = Paths.get(filePart.getSubmittedFileName())
                        .getFileName().toString(); //Basicamente nos trae el nombre del archivo
                Integer es_evidencia_flujo = 1;
                Integer id_cat_clasif_doc = (request.getParameter("id_cat_clasif_doc").equals("Normal"))?1:2;;
                //Listado de datos preparados para entrar en la BD
                M_Documento mdoc = new M_Documento(id_D_DOcumento, id_usuario_p);
                
                
                Pattern pattern = Pattern.compile("([a-zA-Z0-9])"
                        + "+(.doc|.docx|.pdf|.pptx|.png|.jpg|.gif|.csv|"
                        + ".xlsx|.pptm|.ppt|.xps|.potx|.potm|.pot|.thmx|.ppsx|"
                        + ".ppsm|.pps|.ppam|.xml|.mp4|.wmv|.tif|.bmp|.rtf|.htm|"
                        + ".html|.css|.tiff|.psd|.svg|.eps|.mp3|.txt)$", Pattern.CASE_INSENSITIVE);
                Matcher matcher = pattern.matcher(nombre);
                boolean matchFound = matcher.find();
                if(matchFound) {
                    if (mdoc.registrarM_Documentos()) {
                        System.out.println("Todo correcto hasta el moemnto..");
                        System.out.println("Entrando en fase 2");
                        D_Documento ddoc = new D_Documento(nombre, ruta, pass,
                                id_tipo_acceso,folio, Equipo_ID_Equipo, 
                                mdoc.getIdM_Documento(), es_evidencia_flujo, id_cat_clasif_doc);
                        if (!D_Documento.ConsultarD_Doc_B(Equipo_ID_Equipo , nombre)) {
                            if (ddoc.registrarDoc()) {
                                System.out.println("Todo Correcto uwu");
                                OutputStream outs = null;
                                InputStream filecontent = null;
                                final PrintWriter writer = response.getWriter();
                                try {
                                    crearFolderA(request);
                                    crearFolder(String.valueOf(Equipo_ID_Equipo), request);
                                    outs = new FileOutputStream(new File(request.getRealPath("/archivos/"
                                            +Equipo_ID_Equipo+"/") + (q!=null?q:"") + "/" + nombre));
                                    filecontent = filePart.getInputStream();

                                    int read = 0;
                                    final byte[] bytes = new byte[1024];

                                    while ((read = filecontent.read(bytes)) != -1) {
                                        outs.write(bytes, 0, read);
                                    }

                                    if (pass.equals(folio)) {
                                        response.sendRedirect("docs2.jsp?flag=true_pass&pass="+pass);
                                    }else{
                                        response.sendRedirect("docs2.jsp?flag=true");
                                    }

                                } catch (FileNotFoundException fne) {
                                    System.out.println("Algo de que no encontro el archivo"
                                            + " o el folder");
                                    System.out.println(fne.getMessage());
                                } finally {
                                    System.out.println("Aver aver aver que demonios esta pasando");
                                    outs.close();
                                    filecontent.close();
                                    writer.close();
                                }
                            }else{
                                System.out.println("Todo mal en ddoc unu");
                                response.sendRedirect("docs2.jsp?flag=false");
                            }
                        }else{
                            System.out.println("Hijole ya existe este doc uwu");
                            response.sendRedirect("docs2.jsp?flag=exist");
                        }
                    }else{
                        System.out.println("Ya valio esto unu, posible error al "
                                + "registrar la master del doc");
                        response.sendRedirect("docs2.jsp?flag=false");
                    }
                } else {
                    System.out.println("Un archivo con nomenclatura incorrecta");
                    response.sendRedirect("docs2.jsp?flag=file_sec");
                }
            }
        }catch(Exception e){
            System.out.println("El bug es dibido a:" + e.getMessage());
            System.out.println(e.getLocalizedMessage());
            e.printStackTrace();
            response.sendRedirect("docs2.jsp?flag=too_w");
        }
            
    }   

}