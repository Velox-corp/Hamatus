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
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import javax.activation.MimetypesFileTypeMap;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author taspi
 * 
 * OK vamos a hacer esto, cuando quieran descargar un documento lo que vamos a
 * hacer es utilizar el metodo get en un link, en teoria esto deberia de abrir 
 * otra ventana para descargar el archivo.
 * El link debera de aparecer de la siguiente forma:
 * <a href="/downloadFile?ruta=<%=file.getAbsolutePath()%>&fileName=<%=file.getName()%>" target="_top"><%=list[i]%></a>
 * 
 * los demas atributos seran tomados bajo un script en la pagina JSP de la
 * siguiente manera:
 * <%
        String ruta = "la ruta sera consultada de la bd";
        java.io.File file;
        java.io.File dir = new java.io.File(ruta);

        String[] list = dir.list();

        if (list.length > 0) {

            for (int i = 0; i < list.length; i++) {
                file = new java.io.File(root + list[i]);

        if (file.isFile()) {
    %>
    * <a href="/downloadFile?ruta=<%=file.getAbsolutePath()%>&fileName=<%=file.getName()%>" target="_top"><%=list[i]%></a>
            <%
            }
        }
    }
    %>
 */
public class downloadFile extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
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
        HttpSession sesionUser = request.getSession();
        boolean obtencionAdecuada = false;
        UsuarioEmpleado usuario = null;
        Empresa emp = null;
        try{
            usuario = (UsuarioEmpleado) sesionUser.getAttribute("usuario");
            emp = (Empresa) sesionUser.getAttribute("empresa");
        }catch(NullPointerException ex){
            System.out.println("Algun error raro de null");
            System.out.println(ex.getMessage());
            ex.printStackTrace();
            obtencionAdecuada = false;
            response.sendRedirect("error.jsp");
        }catch(Exception e){
            System.out.println("Algun error raro");
            System.out.println(e.getMessage());
            e.printStackTrace();
            obtencionAdecuada = false;
            response.sendRedirect("error.jsp");
        }
        
        M_Documento mdoc = new M_Documento();
        D_Documento ddoc = new D_Documento();
        
        
        int ID_equipo = Integer.parseInt(request.getParameter("e"));
        String q = request.getParameter("q");
        
        String filePath = request.getServletContext().getRealPath("/archivos/"
                + ID_equipo + "/" + q);
        String fileName = request.getParameter("fileName");
        filePath += ("/"+fileName);
        
        ddoc.ConsultarD_Doc(ID_equipo, fileName);
        mdoc.Consultar_mDoc(ddoc.getID_Documento(), usuario.getIDUsuarioE());
        if (true/*mdoc.registrarRegistro(usuario.getIDUsuarioE())*/) {
            MimetypesFileTypeMap mimeTypesMap = new MimetypesFileTypeMap();
            String mimeType = mimeTypesMap.getContentType(fileName);

            response.setContentType(mimeType);
            response.setHeader("Content-disposition", "attachment; filename=" + fileName);

            OutputStream out = response.getOutputStream();
            FileInputStream in = new FileInputStream(filePath);
            byte[] buffer = new byte[4096];
            int length;
            while ((length = in.read(buffer)) > 0) {
                out.write(buffer, 0, length);
            }
            in.close();
            out.flush();
        }else{
            System.out.println("Ara ara asi que no te has registrado UwU");
            System.out.println("ni siquiera deberias de estar aqui");
            response.sendRedirect("error.jsp");
        }

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
