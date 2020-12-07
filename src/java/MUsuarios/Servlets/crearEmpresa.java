/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MUsuarios.Servlets;

import ClasesSoporte.Validaciones;
import MUsuarios.clases.Empresa;
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
            String redirect = "";
            boolean proceso_correcto = true;
            //elementos user admin empresa
            String nombreUser = request.getParameter("name");
            String correo = request.getParameter("email");
            String appat = request.getParameter("appat");
            String apmat = request.getParameter("apmat");
            String pass = request.getParameter("pwd");
            String pass2 = request.getParameter("pwd2");
            //elementos empesa
            String nombreEmp = request.getParameter("nameEmpresa");
            String descripcion = request.getParameter("description");
            String razon_social = request.getParameter("razonSocial");
            Part logo = request.getPart("logo");
            
            boolean[] bufferValidaciones = new boolean[9];
            bufferValidaciones[0] = Validaciones.esString(nombreUser, true, false);
            bufferValidaciones[1] = Validaciones.esString(appat, true, false);
            bufferValidaciones[2] = Validaciones.esString(apmat, true, false);
            bufferValidaciones[3] = Validaciones.esString(pass, true, false);
            bufferValidaciones[4] = Validaciones.esEmail(correo);
            bufferValidaciones[5] = pass.equals(pass2);
            bufferValidaciones[6] = Validaciones.esString(nombreEmp, true, true);
            bufferValidaciones[7] = Validaciones.esString(descripcion, true, true);
            bufferValidaciones[8] = Validaciones.esString(razon_social, true, true);
            for (int i = 0; i < bufferValidaciones.length; i++) {
                if(!bufferValidaciones[i]){
                    proceso_correcto = false;
                    redirect = "index.jsp"; //sujeto a cambios
                    System.out.println("Mal validado");
                    break;
                }
            }
            if(proceso_correcto){
                Empresa emp = null;
                try{
                emp = new Empresa(nombreEmp, descripcion, logo, razon_social);
                }catch(IOException e){
                    e.getMessage();
                    e.getCause();
                }
                proceso_correcto = Empresa.crearEmpresa(emp);

                if(proceso_correcto){
                    redirect="empresa.jsp";
                }else{
                    System.out.println("No se guardo en la bd");
                    redirect = "index.jsp";
                }
                HttpSession sesionEmpresa = request.getSession(true);
                sesionEmpresa.setAttribute("empresa", emp);

            }
            
            response.sendRedirect(redirect);
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet crearEmpresa</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet crearEmpresa at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
