/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package MUsuarios.Servlets;

import MUsuarios.clases.Empresa;
import MUsuarios.clases.UsuarioEmpleado;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Sevlet para ejecutar función de: 
 * @author Armando Jarillo
 */
public class deleteEmpresa extends HttpServlet {
   
    
    /*
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        boolean proccesoCorrecto = false;
        String redirect;
        HttpSession sesion = request.getSession();
        UsuarioEmpleado admin = (UsuarioEmpleado) sesion.getAttribute("usuario");
        if ( admin.getiD_cat_priv() == 1){
            Empresa emp = (Empresa) sesion.getAttribute("empresa");
            proccesoCorrecto = Empresa.deleteEmpresa(emp.getIDEmpresa());
            if(proccesoCorrecto){
                sesion.setAttribute("usario", null);
                sesion.setAttribute("empresa", null);
                sesion.invalidate();
            }
        }else{
            proccesoCorrecto = false;
        }
        
        if(proccesoCorrecto){
           redirect = "index.jsp"; 
        }else{
            redirect = "error.jsp";
        }
        
        response.sendRedirect(redirect);
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
