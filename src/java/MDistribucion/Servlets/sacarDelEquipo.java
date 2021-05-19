/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MDistribucion.Servlets;

import MDistribucion.Clases.EUsuarioEquipo;
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
public class sacarDelEquipo extends HttpServlet {
    
    
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
            String redirect = "";
            int id_usuario;
            int id_equipo;
            try{
                id_usuario = Integer.parseInt(request.getParameter("id"));
                id_equipo = Integer.parseInt(request.getParameter("idE"));
                ServletContext contexto = getServletContext();
                contexto.setAttribute("id", id_equipo);
                
                proceso_nice = EUsuarioEquipo.removerUsuario(id_usuario);
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

    
    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }

}