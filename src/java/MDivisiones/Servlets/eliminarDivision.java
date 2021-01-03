/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MDivisiones.Servlets;

import ClasesSoporte.Validaciones;
import MDivisiones.clases.Division;
import MUsuarios.clases.Empresa;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author alis0
 */
@WebServlet(name = "eliminarDivision", urlPatterns = {"/eliminarDivision"})
public class eliminarDivision extends HttpServlet {

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
            
            String redirect = "error.jsp";
            boolean proceso_correcto = true;
            Empresa emp = null;
                Division div = null;
            int id;
            try{
                id = Integer.parseInt(request.getParameter("id"));
                HttpSession sesion = request.getSession();
                    emp = (Empresa) sesion.getAttribute("empresa");
                    div = new Division(id);
                    
                    if(emp.getIDEmpresa() != -1){
                        proceso_correcto = Division.eliminarDivision(div, emp.getIDEmpresa());
                        
                    }else{
                        proceso_correcto = false;
                    }
            }catch(Exception e){
                e.getMessage();
                e.printStackTrace();
                proceso_correcto = false;
            } 

            if(proceso_correcto){
                    redirect="divisiones.jsp";
                }else{
                    System.out.println("No se guardo en la bd");
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
    }// </editor-fold>

}
