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
import javax.servlet.ServletContext;
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
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     * Este servlet tiene la funcion de ejecutar la parte del inicio de sesion 
     * de la pagina, creo que debemos de poner esta pagina despues de que el 
     * usuario ya se registro pero bueno ya veremos como estara esta onda, 
     * me voy a basar de la clase de crear empresa
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String redirect = "error.jsp";
        try (PrintWriter out = response.getWriter()) {
            boolean proceso_correcto = true;
            String correo = request.getParameter("email");
            String pass = request.getParameter("pwd");
            UsuarioEmpleado usu = new UsuarioEmpleado();
            int reintento;
            //Ejecutar busqueda
            usu = ConsultarEmpleado(correo, pass);
            //Iniciamos sesion
            if (usu != null) {
                HttpSession sesionEmpresa = request.getSession(true);
                sesionEmpresa.setAttribute("usuario", usu);
                Empresa emp = Empresa.buscarEmpresa(usu.getiD_Division());
                sesionEmpresa.setAttribute("empresa", emp);
                sesionEmpresa.setMaxInactiveInterval(1000 * 3600);
                reintento = 0;
                switch(usu.getiD_cat_priv()){
                    case 1:
                        redirect = "controlA?accion=home"; //posiblemente cambia a estádisticas. auque lo cambio a anuncios para evitar la sobrecarga de querys
                        break;
                    case 2:
                        redirect = "controlA?accion=home";
                        break;
                    case 3:
                        redirect = "controlA?accion=home";
                        break;
                    case 4:
                        redirect = "controlA?accion=home";
                        break;
                    default:
                        redirect = "error.jsp";
                }
            }else{
                reintento = 1;
                redirect = "inicio_sesion.jsp";
            }
            ServletContext contexto = getServletContext();
            contexto.setAttribute("reintento", reintento);
            
            response.sendRedirect(redirect);
        }catch(Exception e){
            System.out.println(e.getMessage());
            e.printStackTrace();
        }finally{
            
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
