/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package MFlujos.Servlets;

import MDocumentos.Clases.D_Documento;
import MDocumentos.Clases.M_Documento;
import MFlujos.Clases.FlujoDeTrabajo;
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
 * Sevlet para ejecutar función de: descargar evidencia
 * el hijo bastardo de downloadFile.java
 * @author Armando Jarillo
 */
public class descargaEvidencia extends HttpServlet {
   
    
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
        
        /*
        A meterle fe, aunque con el solo ide del flujo puedo obtener practicamente todo
        */
        HttpSession sesionUser = request.getSession();
        boolean obtencionAdecuada = false;
        UsuarioEmpleado usuario = null;
        try{
            usuario = (UsuarioEmpleado) sesionUser.getAttribute("usuario");
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
        
        FlujoDeTrabajo flujoD = FlujoDeTrabajo.consultaFlujo(Integer.parseInt(request.getParameter("idF")));
        
        int idE = flujoD.getIdEquipo();
        
        String nombreEvidencia = FlujoDeTrabajo.obtenerNameEvidencia(flujoD.getIdFlujodetrabajo());
        String filePath = request.getServletContext().getRealPath("/evidencias/" + idE);
        
        M_Documento mdoc = new M_Documento();
        D_Documento ddoc = new D_Documento();
        
        ddoc.ConsultarD_Doc(idE, nombreEvidencia);
        mdoc.Consultar_mDoc(ddoc.getID_Documento(), usuario.getIDUsuarioE());
        
        MimetypesFileTypeMap mimeTypesMap = new MimetypesFileTypeMap();
        String mimeType = mimeTypesMap.getContentType(nombreEvidencia);

        response.setContentType(mimeType);
        response.setHeader("Content-disposition", "attachment; filename=" + nombreEvidencia);

        OutputStream out = response.getOutputStream();
        FileInputStream in = new FileInputStream(filePath+"/"+nombreEvidencia);
        byte[] buffer = new byte[4096];
        int length;
        while ((length = in.read(buffer)) > 0) {
            out.write(buffer, 0, length);
        }
        in.close();
        out.flush();
    } 

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
