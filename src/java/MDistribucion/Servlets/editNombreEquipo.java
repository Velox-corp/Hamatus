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
 * Sevlet para ejecutar función de: 
 * @author Armando Jarillo
 */
public class editNombreEquipo extends HttpServlet {
   
    

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
            boolean proceso_nice = false;
            String redirect = "";
            int id_equipo;
            String newName = "";
            try{
                id_equipo = Integer.parseInt(request.getParameter("idEquipo"));
                newName = request.getParameter("nombregEquipo");
                System.out.println("A editar name equipo");
                proceso_nice = Equipo.editName(newName, id_equipo);
                
                ServletContext contexto = getServletContext();
                contexto.setAttribute("id", id_equipo);
            }catch(Exception e){
                e.getMessage();
                e.printStackTrace();
                proceso_nice = false;
            }finally{
                if(proceso_nice){
                redirect = "verEquipos.jsp";
                }else{
                    redirect = "error.jsp";
                }
                response.sendRedirect(redirect); 
            }
            
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
