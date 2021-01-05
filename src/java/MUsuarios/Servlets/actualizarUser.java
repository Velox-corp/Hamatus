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
            boolean cambioPass = false;
            String redirect;
            HttpSession sesion = request.getSession();
            UsuarioEmpleado oldUser = (UsuarioEmpleado)sesion.getAttribute("usuario");
            //elementos user admin empresa
            String nombreUser = request.getParameter("nombre");
            String correo = request.getParameter("Email");
            String appat = request.getParameter("appat");
            String apmat = request.getParameter("apmat");
            String f_n = request.getParameter("fecha_nacimiento");
            String oldPass = "";
            try{
                oldPass = request.getParameter("pwd");
                cambioPass = !(oldPass == null || oldPass.equals(""));
            }catch(NullPointerException e){
                System.out.println("No nueva pass");
                cambioPass = false;
            }
            String newPass = request.getParameter("Npwd");
            String newPass2 = request.getParameter("Npwd2");
            boolean[] bufferValidaciones = new boolean[9];
            bufferValidaciones[0] = Validaciones.esString(nombreUser, true, false);
            bufferValidaciones[1] = Validaciones.esString(appat, false, false);
            bufferValidaciones[2] = Validaciones.esString(apmat, false, false);
            bufferValidaciones[3] = Validaciones.esEmail(correo);
           int contadorValidaciones;
            if(cambioPass){
                bufferValidaciones[4] = Validaciones.esPassword(oldPass);
                bufferValidaciones[5] = Validaciones.esPassword(newPass);
                bufferValidaciones[6] = Validaciones.esPassword(newPass2);
                bufferValidaciones[7] = oldUser.getPassword().equals(oldPass);
                bufferValidaciones[8] = newPass.equals(newPass2);
                contadorValidaciones = 8;
            }else{
                contadorValidaciones = 3;
            }
            for (int i = 0; i <= contadorValidaciones; i++) {
                if(!bufferValidaciones[i]){
                    proceso_correcto = false;
                    redirect = "error.jsp";
                    System.out.println("Mal validado en el buffer:"+(i));
                    break;
                }
            }
            proceso_correcto = true;
            if(proceso_correcto){
                UsuarioEmpleado updateEmpleado;
                try{
                    if(!cambioPass) {
                        System.out.println("Contraseña igual");
                        updateEmpleado = new UsuarioEmpleado(oldUser.getIDUsuarioE(), nombreUser, appat, apmat, f_n, correo, oldPass, oldUser.getiD_Division(), oldUser.getiD_cat_priv(), null);
                    }else{
                        System.out.println("new Contraseña");
                        updateEmpleado = new UsuarioEmpleado(oldUser.getIDUsuarioE(), nombreUser, appat, apmat, f_n, correo, newPass, oldUser.getiD_Division(), oldUser.getiD_cat_priv(), null);
                    }
                    if(UsuarioEmpleado.modEmpleado(updateEmpleado)){
                        sesion.setAttribute("usuario", updateEmpleado);
                        redirect = "CRUD_TU.jsp";
                    }else{
                        redirect = "error.jsp";
                    }
                    
                }catch(Exception e){
                    redirect = "error.jsp";
                    e.getMessage();
                    e.printStackTrace();
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
