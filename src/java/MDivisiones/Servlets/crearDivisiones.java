/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MDivisiones.Servlets;

import ClasesSoporte.Validaciones;
import MDivisiones.Servlets.crearDivisiones;
import MDivisiones.clases.Divisiones;
import MUsuarios.clases.UsuarioEmpleado;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
            String nombreUser = request.getParameter("nameUser");
            
            //validar campos de datos por parte del controlador
            boolean[] bufferValidaciones = new boolean[1];
            bufferValidaciones[0] = Validaciones.esString(nombreUser, true, false);
            
            if(proceso_correcto){
                Divisiones div = null;
                UsuarioEmpleado admin = null;
                try{
                    div = new Divisiones(nombreUser);
                    if (Divisiones.crearDivisiones(div, id_emp)){
                        div.setIDEmpresa(Empresa.getIDEmpresaRegistrada());
                        if(emp.getIDEmpresa() != -1){
                            proceso_correcto = UsuarioEmpleado.ingresarAdmin(admin, emp.getIDEmpresa());
                        }else{
                            proceso_correcto = false;
                        }
                        
                    }else{
                        proceso_correcto = false;
                    }
                    
                }catch(IOException | NullPointerException e){
                    e.getMessage();
                    e.printStackTrace();
                }
                

                if(proceso_correcto){
                    redirect="empresa.jsp";
                }else{
                    System.out.println("No se guardo en la bd");
                    redirect = "error.jsp";
                }
                HttpSession sesionEmpresa = request.getSession(true);
                sesionEmpresa.setAttribute("empresa", emp);
                System.out.println(sesionEmpresa.getAttribute("empresa"));
                sesionEmpresa.setAttribute("usuario", admin);
                
            }
            
            response.sendRedirect(redirect);
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
