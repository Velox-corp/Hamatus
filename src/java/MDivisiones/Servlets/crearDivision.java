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
@WebServlet(name = "crearDivision", urlPatterns = {"/crearDivision"})
public class crearDivision extends HttpServlet {

    /**
     * Handles the HTTP <code>POST</code> method.
     *
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
            
            String redirect = "error.jsp";
            boolean proceso_correcto = true;
            //elementos user admin empresa
            String nombreD = request.getParameter("nombreD");
            //Validaciones  registro de la division
            
            //validar campos de datos por parte del controlador
            boolean[] bufferValidaciones = new boolean[1];
            bufferValidaciones[0] = Validaciones.esString(nombreD, true, false);
            
            for (int i = 0; i < bufferValidaciones.length; i++) {
                if(!bufferValidaciones[i]){
                    proceso_correcto = false;
                    redirect = "error.jsp";
                    System.out.println("Mal validado");
                    break;
                }
            }
            if(proceso_correcto){
                Empresa emp = null;
                Division div = null;
                try{
                    
                    div = new Division(nombreD);
                    
                    if(emp.getIDEmpresa() != -1){
                        proceso_correcto = Division.crearDivision(div, emp.getIDEmpresa());
                        System.out.println(div);
                        System.out.println(emp.getIDEmpresa());
                        
                    }else{
                        proceso_correcto = false;
                    }
                    
                }catch(NullPointerException e){
                    e.getMessage();
                    e.printStackTrace();
                }
                

                if(proceso_correcto){
                    redirect="empresa.jsp";
                }else{
                    System.out.println("No se guardo en la bd");
                    redirect = "error.jsp";
                }                
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
