/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MUsuarios.Servlets;

import MUsuarios.clases.Empresa;
import MUsuarios.clases.UsuarioEmpleado;
import static MUsuarios.clases.UsuarioEmpleado.ConsultarEmpleado;
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
public class iniciarSesion extends HttpServlet {

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
            String redirect = "error.jsp";
            boolean proceso_correcto = true;
            try{
                String correo = request.getParameter("email");
                String pass = request.getParameter("pwd");
                UsuarioEmpleado usu = null;
                //Ejecutar busqueda
                usu = ConsultarEmpleado(correo, pass);
                //Iniciamos sesion
                HttpSession sesionEmpresa = request.getSession(true);

                System.out.println(usu.getNombre());
                sesionEmpresa.setAttribute("usuario", usu);
                Empresa emp = Empresa.buscarEmpresa(usu.getIDUsuarioE());
                sesionEmpresa.setAttribute("empresa", emp);
                redirect = "empresa.jsp";
            }catch(Exception e){
                redirect = "error.jsp";

                System.out.println(e.getMessage());
                e.printStackTrace();
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
