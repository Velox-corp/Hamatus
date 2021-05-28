/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MChat.Servlets;

import MChat.Clases.Sala;
import MChat.Clases.UsuarioSala;
import MUsuarios.clases.UsuarioEmpleado;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author roberto
 */
@WebServlet(name = "agregarSala", urlPatterns = {"/agregarSala"})
public class agregarSala extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");

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
        response.setContentType("text/html;charset=UTF-8");
        response.setContentType("application/json");
        PrintWriter out = response.getWriter(); 

        HttpSession sesion = request.getSession();
        int idsla = 0;
        boolean proceso_nice = true;
        String redirect = "";
        

        try {
            // processRequest(request, response);
            

            //int id_user=((UsuarioEmpleado)sesion.getAttribute("usuario")).getIDUsuarioE();
            UsuarioSala newRelacion = new UsuarioSala();

            try {

                int id_user =  Integer.parseInt(request.getParameter("id_usuario"));
       
        int id_contacto = Integer.parseInt(request.getParameter("id_contacto"));
        int id_sala_tipo = Integer.parseInt(request.getParameter("id_sala_tipo"));
                Sala sala = new Sala();
                idsla = newRelacion.existe(id_user, id_contacto, id_sala_tipo);
                System.out.println(idsla);
               
                MessageModel mm = new MessageModel();
                
                String jsonObject = new Gson().toJson(mm.get(idsla, id_user));
                
                response.getWriter().write(jsonObject);
                
               // response.sendRedirect("Last_Messages?json="+jsonObject);
                
                /*RequestDispatcher view = request.getRequestDispatcher("Last_Messages?json="+jsonObject+"");
                request.setAttribute("idsla", idsla);
                view.forward(request, response);*/
            } catch (NullPointerException e) {
                System.out.println(e);
            }

        } catch (Exception e) {
            e.getMessage();
            e.printStackTrace();
            proceso_nice = false;
            System.out.println(e);
        }

        if (proceso_nice) {
            System.out.println("Sala ingresada correctamente");
            response.sendRedirect("Mensajes.jsp");

        } else {
            redirect = "error.jsp";
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(agregarSala.class.getName()).log(Level.SEVERE, null, ex);
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
