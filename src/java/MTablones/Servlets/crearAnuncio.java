/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MTablones.Servlets;

import MTablones.Clases.Anuncio;
import MUsuarios.clases.UsuarioEmpleado;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class crearAnuncio extends HttpServlet {


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            HttpSession sesion = request.getSession();
            boolean procesoCorrecto;
            String redirect;
            
            try{
                int ideDivEmp = ((UsuarioEmpleado)sesion.getAttribute("usuario")).getiD_Division();
                String titulo = request.getParameter("titulo");
                String contenido = request.getParameter("contenido");
                Anuncio anuncio = new Anuncio(titulo, contenido,ideDivEmp);
                procesoCorrecto = Anuncio.ingresarAnuncio(anuncio);
            }catch(Exception e){
                procesoCorrecto = false;
                e.getMessage();
                e.printStackTrace();
            }
            if(!procesoCorrecto){
                redirect = "error.jsp";
            }else{
                redirect = "anuncios.jsp";
            }
            response.sendRedirect(redirect);
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet crearAnuncio</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet crearAnuncio at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }


    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
