/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package MFlujos.Servlets;

import MFlujos.Clases.FlujoDeTrabajo;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Sevlet para ejecutar función de: 
 * @author Armando Jarillo
 */
public class editarFlujo extends HttpServlet {
   
   

    /** 
     * Handles the HTTP <code>POST</code> method.
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
            boolean procesoCorrecto = false;
            String redirect;
            try{
                String titulo = request.getParameter("mod_titulo");
                String des = request.getParameter("mod_des");
                String hora = request.getParameter("mod_hora");
                String fecha = request.getParameter("mod_fecha");
                int id = Integer.parseInt(request.getParameter("idF"));

                FlujoDeTrabajo flujo = new FlujoDeTrabajo(titulo, des, 0, fecha, hora);
                procesoCorrecto = FlujoDeTrabajo.editarFlujo(id, flujo);
            }catch(Exception e){
                e.printStackTrace();
                procesoCorrecto = false;
            }
            if(!procesoCorrecto){
                redirect = "error.jsp";
            }else{
                redirect = "verFlujosTrabajo.jsp";
            }
            response.sendRedirect(redirect);
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet crearFlujo</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet crearFlujo at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
