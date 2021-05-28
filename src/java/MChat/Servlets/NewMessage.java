/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MChat.Servlets;

import MChat.Clases.Message;
import com.pusher.rest.Pusher;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author roberto
 */
@WebServlet(name = "NewMessage", urlPatterns = {"/create"})
public class NewMessage extends HttpServlet {


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        int id_user = Integer.parseInt(request.getParameter("id_user"));
        String name = request.getParameter("name");
        int sala = Integer.parseInt(request.getParameter("sala-id"));
        String message = request.getParameter("message");
        
        MessageModel mm = new MessageModel();
        
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        
        Date date = new Date(); 
        
        Message msg = new Message(message, id_user, sala, dateFormat.format(date));
        
        mm.create(msg);
        
        DateFormat dateFormat2 = new SimpleDateFormat("dd-MM-yy 'a las' hh:mm:ss a");
        msg.setCreated_at(dateFormat2.format(date));
        
        Pusher pusher = new Pusher("1201370", "78f597b507c09cc4229c", "52fece1045d7512aa1fc");
        pusher.setCluster("us2");
        pusher.setEncrypted(true);

        pusher.trigger("my-channel", "my-event",msg.getJsonObject());
        
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
