/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MUsuarios.Servlets;

import MDivisiones.clases.Division;
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
 *
 * @author maste
 */
public class cambioDePuesto extends HttpServlet {

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
            HttpSession sesion;
            String redirect;
            int ideNewPuesto;
            int ideOldPuesto;
            int ideOldPrivilegio;
            int ideNewPrivilegio;
            try{
                sesion = request.getSession();
                if(((UsuarioEmpleado)sesion.getAttribute("usuario")).getiD_cat_priv() > 2){
                    redirect = "error.jsp";
                }else{
                    //aquí meter algo que traduzca las string de div y privilegios a ides
                    Empresa emp = (Empresa)sesion.getAttribute("empresa");
                    ideOldPuesto = Integer.parseInt(request.getParameter("idDivOld"));
                    ideOldPrivilegio = Integer.parseInt(request.getParameter("idCatOld"));
                    try{
                        ideNewPrivilegio = Integer.parseInt(request.getParameter("newPriv"));
                    }catch(NullPointerException | NumberFormatException npe){
                        ideNewPrivilegio = ideOldPrivilegio;
                    }
                    try{
                        ideNewPuesto = Division.IDDivision(new Division(request.getParameter("newDiv")), emp.getIDEmpresa());
                        if(ideNewPuesto == -1){
                            ideNewPuesto = ideOldPuesto;
                        }
                    }catch(NullPointerException | NumberFormatException npe){
                        System.out.println("No jalo la div");
                        ideNewPuesto = ideOldPuesto;
                    }
                    if(UsuarioEmpleado.modPuestoEmpleado(Integer.parseInt(request.getParameter("ideUserCambio")), ideNewPuesto, ideNewPrivilegio, ideOldPuesto, ideOldPrivilegio)){
                        redirect = "verUsuarios.jsp";
                    }else{
                        redirect = "error.jsp";
                    }
                }
                
            }catch(Exception e){
                e.getMessage();
                e.printStackTrace();
                redirect = "error.jsp";
            }
            response.sendRedirect(redirect);
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet cambioDePuesto</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet cambioDePuesto at " + request.getContextPath() + "</h1>");
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
