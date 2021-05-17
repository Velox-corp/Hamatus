/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MUsuarios.Servlets;

import ClasesSoporte.Validaciones;
import MUsuarios.clases.Empresa;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author alis0
 */
public class actualizarEmpresa extends HttpServlet {

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
            boolean proceso_correcto = true;
            String redirect;
            HttpSession sesion = request.getSession();
            Empresa oldE = (Empresa)sesion.getAttribute("empresa");
            //elementos user admin empresa
            String nombreE = request.getParameter("nombre");
            String razon = request.getParameter("razon");
            String descripcion = request.getParameter("descripcion");
            
            proceso_correcto = true;
            if(proceso_correcto){
                Empresa updateEmpresa;
                try{
                    updateEmpresa = new Empresa(nombreE, descripcion, razon, null);
                    
                    if(Empresa.editEmpresa(updateEmpresa)){
                        sesion.setAttribute("empresa", updateEmpresa);
                        redirect = "actualizarEmpresa.jsp";
                    }else{
                        redirect = "error.jsp";
                    }
                    
                }catch(Exception e){
                    redirect = "error.jsp";
                    e.getMessage();
                    e.printStackTrace();
                }
                
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
