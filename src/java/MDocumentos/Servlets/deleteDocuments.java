/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MDocumentos.Servlets;

import MDocumentos.Clases.D_Documento;
import MDocumentos.Clases.M_Documento;
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
public class deleteDocuments extends HttpServlet {

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
        try{
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
                response.sendRedirect("error.jsp");
            }
            if (obtencionAdecuada) {
                String list = request.getParameter("li");//Esta lista tiene la id del ddoc
                String query = request.getParameter("q");
                int ID_equipo = UsuarioEmpleado.consultarID_Equipo(usuario.getIDUsuarioE());
                String[] li = list.split(",");
                boolean c = false;
                try {
                    for (String i : li) {
                        int value = Integer.parseInt(i);
                        M_Documento mdoc = new M_Documento();
                        D_Documento ddoc = new D_Documento();
                        ddoc.ConsultarD_Doc(value);
                        String filename = ddoc.getNombre();
                        String ruta = request.getServletContext().getRealPath("/archivos/"
                                +String.valueOf(ID_equipo)+"/"+(query != null ? query : ""));
                        if (ruta!=null) {
                            File file = new File(ruta+"/"+filename);
                            if (file.delete()) {
                                System.out.println("Perfecto archivo borrado UwU");
                                c = true;
                            }else{
                                System.out.println("Oh no..");
                                c = false;
                            }
                        }
                        mdoc.BorrarM_Documentos(ddoc.getId_MDocumento());
                    }
                    if (c) {
                        response.sendRedirect("docs2.jsp?flag_del=true&q="+query);
                    }else{
                        response.sendRedirect("error.jsp");
                    }
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                    e.printStackTrace();
                    response.sendRedirect("error.jsp");
                }      
            }
        }catch(Exception e){
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
