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
 * Cabe recordar que este metodo solo es para borrar la info de donde se 
 * guarda el archivo solo es para que se vuelva inaccesible como tal el archivo 
 * no se borra aunque esta en consideracion eso mismo
 */
public class deleteFile_J extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
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
            }
            if (obtencionAdecuada) {
                /*Suponinedo que se presiono un boton o algo asi, 
                porcedemos a hacer lo siguiente*/
                //String pass = request.getParameter("pass");//Pide pass para borrar el doc
                int id_MDocumento = Integer.parseInt(request.
                        getParameter("id_M"));
                M_Documento mdoc = new M_Documento();
                String rec = "error.jsp";
                boolean correcto = false;
                int ID_equipo = Integer.parseInt(request.getParameter("id_e"));
                try {
                    //Hasta aqui no hay problema
                    mdoc.BorrarM_Documentos(id_MDocumento);
                    String filename = request.getParameter("fileName");
                    File fichero = new File(request.getRealPath("/archivos/"+ID_equipo+"/"+ filename));
                    if (fichero.delete()) {
                        System.out.println("Borrado uwu");
                        correcto=true;
                    }else{
                        System.out.println("No borrado unu");
                        correcto=false;
                    }
                } catch (Exception e) {//EN caso de que algo extraño sucediera
                    System.out.println(e.getMessage());
                    e.printStackTrace();
                }
                if (correcto) {
                    System.out.println("Bien lo borro perfectamente");
                    rec="docs.jsp?flag_del=true";
                }else{
                    System.out.println("No se borro el doc unu");
                    rec="docs.jsp?flag_del=false";
                }
                response.sendRedirect(rec);
            }
            
        }catch(Exception e){
            System.out.println(e.getMessage());
            e.printStackTrace();
            System.out.println(e.getLocalizedMessage());
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
