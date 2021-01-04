/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MUsuarios.Servlets;

import ClasesSoporte.Validaciones;
import MUsuarios.clases.Empresa;
import MUsuarios.clases.UsuarioEmpleado;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Blob;
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
            //validar campos de datos por parte del controlador
            boolean[] bufferValidaciones = new boolean[9];
            bufferValidaciones[0] = Validaciones.esString(nombreUser, true, false);
            bufferValidaciones[1] = Validaciones.esString(appat, false, false);
            bufferValidaciones[2] = Validaciones.esString(apmat, false, false);
            bufferValidaciones[3] = Validaciones.esPassword(pass);
            bufferValidaciones[4] = Validaciones.esEmail(correo);
            bufferValidaciones[5] = pass.equals(pass2);
            bufferValidaciones[6] = Validaciones.esString(nombreEmp, true, true);
            bufferValidaciones[7] = Validaciones.esString(descripcion, true, true);
            bufferValidaciones[8] = Validaciones.esString(razon_social, true, true);
            for (int i = 0; i < bufferValidaciones.length; i++) {
                if(!bufferValidaciones[i]){
                    proceso_correcto = false;
                    redirect = "error.jsp";
                    System.out.println("Mal validado");
                    break;
                }
            }
            if(proceso_correcto){
                Empresa emp = null;
                UsuarioEmpleado admin = null;
                try{
                    emp = new Empresa(nombreEmp, descripcion, logo, razon_social);
                    admin = new UsuarioEmpleado(nombreUser, appat, apmat, f_n, correo, pass);
                    if (Empresa.crearEmpresa(emp)){
                        emp.setIDEmpresa(Empresa.getIDEmpresaRegistrada());
                        if(emp.getIDEmpresa() != -1){
                            proceso_correcto = UsuarioEmpleado.ingresarAdmin(admin, emp.getIDEmpresa());
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
                HttpSession sesionEmpresa = request.getSession(true);
                sesionEmpresa.setAttribute("empresa", emp);
                System.out.println(sesionEmpresa.getAttribute("empresa"));
                sesionEmpresa.setAttribute("usuario", admin);
                
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
