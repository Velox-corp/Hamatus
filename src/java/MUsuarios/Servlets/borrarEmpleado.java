/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MUsuarios.Servlets;

import MUsuarios.clases.UsuarioEmpleado;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author maste
 */
public class borrarEmpleado extends HttpServlet {

   

    /**
     * Handles the HTTP <code>POST</code> method.
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
            String redirect = "verUsuarios.jsp";
            boolean allgood = true;
            try{
                int id_user = Integer.parseInt(request.getParameter("id"));
                allgood = UsuarioEmpleado.DespedirEmpleado(id_user);
            }catch(Exception e){
                e.getMessage();
                e.printStackTrace();
                allgood = false;
            }
            if(allgood){
                redirect = "verUsuarios.jsp";
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
