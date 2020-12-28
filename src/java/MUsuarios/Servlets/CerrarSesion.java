/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MUsuarios.Servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author taspi
 */
public class CerrarSesion extends HttpServlet {

   
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
            /* TODO output your page here. You may use following sample code. */
            String redirect;
            boolean allgood;
            try{
                HttpSession sesionADesconectar = request.getSession();
                sesionADesconectar.setAttribute("usuario", null);
                sesionADesconectar.setAttribute("empresa", null);
                sesionADesconectar.invalidate();
                System.out.println("Ya se cerro la sesion");
                
                allgood = true;
            }catch(Exception e){
                                allgood = false;
            }
            if(allgood){
                redirect = "index.jsp";
            }else{
                redirect = "error.jsp";

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
    }

}
