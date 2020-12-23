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
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author maste
 */
public class agregarEmpleado extends HttpServlet {


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
            HttpSession sesion;
            String redirect = "";
            boolean proceso_correcto = false;
            //elementos user admin empresa
            String nombreUser = request.getParameter("nameUser");
            String correo = request.getParameter("email");
            String appat = request.getParameter("appat");
            String apmat = request.getParameter("apmat");
            String f_n = request.getParameter("f_n");
            String pass = request.getParameter("pwd");
            String pass2 = request.getParameter("pwd2");
            
            boolean[] bufferValidaciones = new boolean[6];
            bufferValidaciones[0] = Validaciones.esString(nombreUser, true, false);
            bufferValidaciones[1] = Validaciones.esString(appat, false, false);
            bufferValidaciones[2] = Validaciones.esString(apmat, false, false);
            bufferValidaciones[3] = Validaciones.esPassword(pass);
            bufferValidaciones[4] = Validaciones.esEmail(correo);
            bufferValidaciones[5] = pass.equals(pass2);
            
            for (int i = 0; i < bufferValidaciones.length; i++) {
                if(!bufferValidaciones[i]){
                    proceso_correcto = false;
                    redirect = "error.jsp";
                    System.out.println("Mal validado");
                    break;
                }
            }
            proceso_correcto = true;
            if(proceso_correcto){
                try{
                    sesion = request.getSession();
                    Empresa emp = (Empresa) sesion.getAttribute("empresa");
                    UsuarioEmpleado newEmpleado = new UsuarioEmpleado(nombreUser, appat, apmat, redirect, correo, pass, 0, 0, null);
                    if(UsuarioEmpleado.ingresarEmpleado(newEmpleado, 0)){
                        redirect = "verUsuarios.jsp";
                    }
                }catch(Exception e){
                    e.getMessage();
                    e.printStackTrace();
                    proceso_correcto = false;
                }
            }else{
                redirect = "error.jsp";
            }
            response.sendRedirect(redirect);
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet agregarEmpleado</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet agregarEmpleado at " + request.getContextPath() + "</h1>");
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
