/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MDistribucion.Servlets;

import MDistribucion.Clases.Equipo;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author maste
 */
public class eliminarEquipo extends HttpServlet {

    
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
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            boolean proceso_nice = true;
            int id_e_qepd;
            String redirect;
            try{
                id_e_qepd = Integer.parseInt(request.getParameter("id"));
                proceso_nice = Equipo.eliminarEquipo(id_e_qepd);
            }catch(Exception e){
                e.printStackTrace();
                proceso_nice = false;
            }
            if(proceso_nice){
                redirect = "verEquipos.jsp";
            }else{
                redirect = "error.jsp";
            }
            
            response.sendRedirect(redirect);
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet eliminarEquipo</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet eliminarEquipo at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}