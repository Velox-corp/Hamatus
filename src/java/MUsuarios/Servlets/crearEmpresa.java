/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MUsuarios.Servlets;

import ClasesSoporte.Validaciones;
import MDivisiones.clases.Division;
import MUsuarios.clases.Empresa;
import MUsuarios.clases.UsuarioEmpleado;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Paths;
import java.sql.Blob;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.servlet.ServletException;
import javax.servlet.ServletInputStream;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;


/**
 *
 * @author maste
 */
@MultipartConfig(maxFileSize = 16177215)    // para que jalen las imagenes, y representan 16MegaBytes de máximo
public class crearEmpresa extends HttpServlet {

    
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
        response.setContentType("text/html;charset=UTF-8");
        
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String redirect = "error.jsp";
            boolean proceso_correcto = true;
            //elementos user admin empresa
            String nombreUser = request.getParameter("nameUser");
            String correo = request.getParameter("email");
            String appat = request.getParameter("appat");
            String apmat = request.getParameter("apmat");
            String f_n = request.getParameter("f_n");
            String pass = request.getParameter("pwd");
            String pass2 = request.getParameter("pwd2");
            
            //Validaciones  registro del empleado
            //elementos empesa
            String nombreEmp = request.getParameter("nameEmpresa");
            String descripcion = request.getParameter("description");
            String razon_social = request.getParameter("razonSocial");
            Part logo = request.getPart("logo");
            String logo_name = Paths.get(logo.getSubmittedFileName())
                    .getFileName().toString(); //Basicamente nos trae el nombre del logo
            //validar campos de datos por parte del controlador
            boolean[] bufferValidaciones = new boolean[10];
            bufferValidaciones[0] = Validaciones.esString(nombreUser, true, false);
            bufferValidaciones[1] = Validaciones.esString(appat, false, false);
            bufferValidaciones[2] = Validaciones.esString(apmat, false, false);
            bufferValidaciones[3] = Validaciones.esPassword(pass);
            bufferValidaciones[4] = Validaciones.esEmail(correo);
            bufferValidaciones[5] = pass.equals(pass2);
            bufferValidaciones[6] = Validaciones.esString(nombreEmp, true, true);
            bufferValidaciones[7] = Validaciones.esStringLong(descripcion);
            bufferValidaciones[8] = Validaciones.esString(razon_social, true, true);
            String tyc = request.getParameter("tYc");
            if (tyc != null) {
                bufferValidaciones[9] = tyc.equals("true");
            }else{
                bufferValidaciones[9] = false;
            }
            for (int i = 0; i < bufferValidaciones.length; i++) {
                if(!bufferValidaciones[i]){
                    proceso_correcto = false;
                    redirect = "registro.jsp";
                    if(i != 9){
                        System.out.println("Mal validado");
                    }else{
                        System.out.println("No acepto los terminos y condiciones");
                    }
                    break;
                }
            }
            
            if (logo.getSize() != 0) {
                Pattern pattern = Pattern.compile("([a-zA-Z0-9])"
                            + "+(.png|.jpg|.gif)$", Pattern.CASE_INSENSITIVE);
                Matcher matcher = pattern.matcher(logo_name);
                boolean matchFound = matcher.find();
                if (!matchFound) {
                    proceso_correcto = false;
                }
            }
            
            if(proceso_correcto){
                Empresa emp = null;
                UsuarioEmpleado admin = null;
                try{
                    emp = new Empresa(nombreEmp, descripcion, logo, razon_social);
                    admin = new UsuarioEmpleado(nombreUser, appat, apmat, f_n, correo, pass);
                    admin.setiD_cat_priv(1);
                    if (Empresa.crearEmpresa(emp)){
                        emp.setIDEmpresa(Empresa.getIDEmpresaRegistrada());
                        if(emp.getIDEmpresa() != -1){
                            proceso_correcto = UsuarioEmpleado.ingresarAdmin(admin, emp.getIDEmpresa());
                            admin.setiD_Division(Division.getDivGen(emp.getIDEmpresa()));
                            HttpSession sesionEmpresa = request.getSession(true);
                            sesionEmpresa.setAttribute("empresa", emp);
                            sesionEmpresa.setAttribute("usuario", admin);
                            sesionEmpresa.setMaxInactiveInterval(1000 * 3600);
                        }else{
                            proceso_correcto = false;
                        }
                        
                    }else{
                        proceso_correcto = false;
                    }
                    
                }catch(IOException | NullPointerException e){
                    e.getMessage();
                    e.printStackTrace();
                  }
                

                if(proceso_correcto){
                    redirect="empresa.jsp";
                }else{
                    System.out.println("No se guardo en la bd");
                    redirect = "error.jsp";
                }
                
            }
            
            response.sendRedirect(redirect);
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
