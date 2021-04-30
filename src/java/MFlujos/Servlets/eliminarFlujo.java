/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package MFlujos.Servlets;

import MDivisiones.clases.Division;
import MFlujos.Clases.FlujoDeTrabajo;
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
 * Sevlet para ejecutar función de: eliminar un flujo
 * @author Armando Jarillo
 */
public class eliminarFlujo extends HttpServlet {
   
    
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
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
            int id;
            try{
                id = Integer.parseInt(request.getParameter("idf"));
                HttpSession sesion = request.getSession();
                    emp = (Empresa) sesion.getAttribute("empresa");
                    UsuarioEmpleado user  = (UsuarioEmpleado) sesion.getAttribute("usuario");
                    if(emp.getIDEmpresa() != -1 && user.getiD_cat_priv() == 3){
                        proceso_correcto = FlujoDeTrabajo.eliminarFlujo(id);
                    }else{
                        proceso_correcto = false;
                    }
            }catch(Exception e){
                e.getMessage();
                e.printStackTrace();
                proceso_correcto = false;
            } 

            if(proceso_correcto){
                    redirect="verFlujosTrabajo.jsp";
                }else{
                    System.out.println("No se guardo en la bd");
                    redirect = "error.jsp";
                }                
            
            
            response.sendRedirect(redirect);
            
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
