/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MUsuarios.Servlets;

import MUsuarios.clases.Empresa;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.Blob;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.rowset.serial.SerialBlob;
import sun.misc.IOUtils;

/**
 *
 * @author maste
 */
public class cargaRegistro extends HttpServlet {


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
        try{
            Blob blob = null;
            int id = Integer.parseInt(request.getParameter("id"));
            InputStream input = Empresa.sacarLogo(id);
            byte[] imgData = new byte[input.available()];
            blob = new SerialBlob(IOUtils.readFully(input, -1, true));
            response.setContentType("image/gif");
            OutputStream o = response.getOutputStream();
            o.write(blob.getBytes(1, (int) blob.length()));
            o.flush();
            o.close();
        }catch(Exception e){
            
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
    }

}
