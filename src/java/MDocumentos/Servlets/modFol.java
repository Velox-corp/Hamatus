/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MDocumentos.Servlets;

import MUsuarios.clases.Empresa;
import MUsuarios.clases.UsuarioEmpleado;
import java.io.File;
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
public class modFol extends HttpServlet {

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
            boolean obtencionAdecuada = false;
            UsuarioEmpleado usuario = null;
            Empresa emp = null;
            try{
                usuario = (UsuarioEmpleado) sesionUser.getAttribute("usuario");
                emp = (Empresa) sesionUser.getAttribute("empresa");
                obtencionAdecuada = true; 
            }catch(NullPointerException ex){
                System.out.println(ex.getMessage());
                ex.printStackTrace();
                obtencionAdecuada = false;
            }
            if (obtencionAdecuada) {
                int IDequipo = UsuarioEmpleado.consultarID_Equipo(usuario.getIDUsuarioE());
                CRUD_Folders crud = new CRUD_Folders();
                try {
                    String q = request.getParameter("q");
                    String nombre = request.getParameter("name");
                    String newNombre = request.getParameter("newname");
                    String ruta = request.getServletContext().getRealPath("/archivos/" 
                            +String.valueOf(IDequipo)+"/"+(q != null ? q : ""));
                    File oldfile = new File(ruta+"/"+nombre);
                    File newFile = new File(ruta+"/"+newNombre);
                    if(!nombre.equals(newNombre)){
                        if (oldfile.renameTo(newFile)) {
                            System.out.println("archivo renombrado");
                            response.sendRedirect("docs2.jsp?q="+q+"&flag=true_dir");
                        } else {
                            System.out.println("error");
                            response.sendRedirect("docs2.jsp?flag=false");
                        }
                    }else{
                        System.out.println("error");
                        response.sendRedirect("docs2.jsp?flag=sm_dir");
                    }
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                    e.printStackTrace();
                    response.sendRedirect("eror.jsp");
                }
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
