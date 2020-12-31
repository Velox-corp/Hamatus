/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MDivisiones.Servlets;

import ClasesSoporte.Validaciones;
import MDivisiones.clases.Divisiones;
import MDivisiones.clases.Divisiones;
import MUsuarios.clases.Empresa;
import MUsuarios.clases.UsuarioEmpleado;
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
@WebServlet(name = "crearDivisiones", urlPatterns = {"/crearDivisiones"})
public class crearDivisiones extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String redirect = "error.jsp";
            boolean proceso_correcto = true;
            //elementos de división
            String nombreD = request.getParameter("nombreD");
            
            //validar campos de datos por parte del controlador
            boolean[] bufferValidaciones = new boolean[1];
            bufferValidaciones[0] = Validaciones.esString(nombreD, true, false);
            
            if(proceso_correcto){
                Divisiones div = null;
                try{
                    HttpSession sesion = request.getSession();
                    Empresa emp = (Empresa) sesion.getAttribute("empresa"); 
                    int idem = emp.getIDEmpresa();
                    div = new Divisiones(nombreD, idem);
                    if(Divisiones.crearDivisiones(div, emp.getIDEmpresa())){
                        redirect = "verUsuarios.jsp";
                    }
                }catch(Exception e){
                    e.getMessage();
                    e.printStackTrace();
                    redirect = "error.jsp";
                }
            }else{
                redirect = "error.jsp";
            }
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
