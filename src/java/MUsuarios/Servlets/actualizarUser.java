/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MUsuarios.Servlets;

import ClasesSoporte.Validaciones;
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
public class actualizarUser extends HttpServlet {

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
            boolean proceso_correcto = true;
            String redirect;
            HttpSession sesion = request.getSession();
            UsuarioEmpleado oldUser = (UsuarioEmpleado)sesion.getAttribute("usuario");
            //elementos user admin empresa
            String nombreUser = request.getParameter("nombre");
            String correo = request.getParameter("Email");
            String appat = request.getParameter("appat");
            String apmat = request.getParameter("apmat");
            String f_n = request.getParameter("f_n");
            String oldPass = request.getParameter("pwd");
            String newPass = request.getParameter("Npwd");
            String newPass2 = request.getParameter("Npwd2");
            boolean[] bufferValidaciones = new boolean[7];
            bufferValidaciones[0] = Validaciones.esString(nombreUser, true, false);
            bufferValidaciones[1] = Validaciones.esString(appat, false, false);
            bufferValidaciones[2] = Validaciones.esString(apmat, false, false);
            bufferValidaciones[3] = Validaciones.esPassword(oldPass);
            bufferValidaciones[4] = Validaciones.esEmail(correo);
            if(newPass != null){
                bufferValidaciones[5] = Validaciones.esPassword(newPass);
                bufferValidaciones[6] = Validaciones.esPassword(newPass2);
            }
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
                UsuarioEmpleado updateEmpleado;
                try{
                    if(newPass == null) {
                        updateEmpleado = new UsuarioEmpleado(oldUser.getIDUsuarioE(), correo, appat, apmat, f_n, correo, oldPass, 0, 0, null);
                    }else{
                        updateEmpleado = new UsuarioEmpleado(oldUser.getIDUsuarioE(), correo, appat, apmat, f_n, correo, newPass, 0, 0, null);
                    }
                    if(UsuarioEmpleado.modEmpleado(updateEmpleado)){
                        sesion.setAttribute("usuario", updateEmpleado);
                    }else{
                        redirect = "error.jsp";
                    }
                    
                    redirect = "CRUD_TU.jsp";
                }catch(Exception e){
                    redirect = "error.jsp";
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
