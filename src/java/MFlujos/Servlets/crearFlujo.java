/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package MFlujos.Servlets;

import MFlujos.Clases.FlujoDeTrabajo;
import MUsuarios.clases.UsuarioEmpleado;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Sevlet para ejecutar función de: crear un nuevo flujo de trabajo
 * @author Armando Jarillo
 */
public class crearFlujo extends HttpServlet {
   
    
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
            
            HttpSession sesion = request.getSession();
            boolean procesoCorrecto = false;
            String redirect;
            try{
                String titulo = request.getParameter("titulo");
                String contenido = request.getParameter("contenido");
                String fecha = request.getParameter("fecha_l");
                String hora = request.getParameter("hora_l");
                int idEquipo = Integer.parseInt(request.getParameter("equipo"));
                if(idEquipo != 0){
                    FlujoDeTrabajo flujo = new FlujoDeTrabajo(titulo, contenido, idEquipo, fecha, hora);
                procesoCorrecto = flujo.ingresarFlujo(flujo);
                }
            }catch(Exception e){
                e.getMessage();
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
