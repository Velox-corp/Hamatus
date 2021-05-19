/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MDocumentos.Servlets;

import MDocumentos.Clases.D_Documento;
import MDocumentos.Clases.M_Documento;
import MDocumentos.Clases.cat_clasif_doc;
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
 * @author taspi
 */
public class fav extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession sesionUser = request.getSession();
        boolean corect = false;
        UsuarioEmpleado usuario = null;
        Empresa emp = null;
        try{
            usuario = (UsuarioEmpleado) sesionUser.getAttribute("usuario");
            emp = (Empresa) sesionUser.getAttribute("empresa");
        }catch(NullPointerException ex){
            System.out.println("Algun error raro de null");
            System.out.println(ex.getMessage());
            ex.printStackTrace();
            corect = false;
            response.sendRedirect("error.jsp");
        }catch(Exception e){
            System.out.println("Algun error raro");
            System.out.println(e.getMessage());
            e.printStackTrace();
            corect = false;
            response.sendRedirect("error.jsp");
        }
        try {
            cat_clasif_doc cat = new cat_clasif_doc();
            int id = Integer.parseInt(request.getParameter("fav"));
            int action = cat.query_doc_state(id);
            corect = cat.classify_docs(id, action==2?1:2);
            if (corect) {
                System.out.println("Todo exelete todo correcto UwU");
                response.sendRedirect("docs2.jsp");
            }else{
                System.out.println("Mmmm tendre que ver ese dichoso error");
                response.sendRedirect("error.jsp");
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
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
        processRequest(request, response);
    }

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
        processRequest(request, response);
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
