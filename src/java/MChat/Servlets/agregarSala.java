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
        //PrintWriter out = response.getWriter();

        HttpSession sesion = request.getSession();
        int idsla = 0;
        int id_contacto=0;
        boolean proceso_nice = true;
        String redirect = "";

        int id_user = ((UsuarioEmpleado) sesion.getAttribute("usuario")).getIDUsuarioE();
        //int privilegio=Integer.parseInt(request.getParameter("priv"));
        id_contacto=Integer.parseInt(request.getParameter("id_contacto"));
       // int id_contacto= ((int) request.getServletContext().getAttribute("id_contacto"))-1;
        System.out.println("Contacto:"+id_contacto);
        //int id_contacto = Integer.parseInt(request.getParameter("id_contacto"));
        System.out.println("user:" + id_user);
        int id_sala_tipo = Integer.parseInt(request.getParameter("id_sala_tipo"));
        String jsonObject = "";

        try {
            // processRequest(request, response);

            UsuarioSala newRelacion = new UsuarioSala();

            try {

                Sala sala = new Sala();

                if (id_sala_tipo == 1) {
                    idsla = newRelacion.existe(
                            ((UsuarioEmpleado) sesion.getAttribute("usuario")).getIDUsuarioE(),
                            (id_contacto ));

                    if (idsla == 0) {

                        sala.crearSala(1);
                        newRelacion.insertSalaUser(id_user);
                        newRelacion.insertSalaContacto(id_contacto );
                        idsla = newRelacion.num_salas().get(newRelacion.num_salas().size()-1);

                    } else if (idsla != 0) {
                        newRelacion.existe(
                            ((UsuarioEmpleado) sesion.getAttribute("usuario")).getIDUsuarioE(),
                            (id_contacto ));
                    }
                }else if(id_sala_tipo == 2){
                    /*if(privilegio==3){
                        
                    }else if(privilegio==4){
                        
                    }*/
                    //System.out.println("ID EQUIPO: "+request.getServletContext().getAttribute("id_contacto"));
                    idsla=newRelacion.salaEquipoLider(2, 
                            ((UsuarioEmpleado) sesion.getAttribute("usuario")).getIDUsuarioE(),
                            (id_contacto));
                    System.out.println("La Sala grupal es: "+idsla);
                }

                //mostrarmensajes(request,response);
                //MessageModel mm = new MessageModel();
                //String jsonObject = new Gson().toJson(mm.get(idsla, id_user));
                //out.println(jsonObject);
                //getServletContext().setAttribute("id_contacto", id_contacto);
                System.out.println(idsla);
                request.getSession().setAttribute("idsla", idsla);
                RequestDispatcher view = request.getRequestDispatcher("Mensajes.jsp");
                view.forward(request, response);

                //jsonObject = new Gson().toJson(mm.get(idsla));
                //response.getWriter().print(jsonObject);
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
            //response.sendRedirect("Mensajes.jsp");

        } else {
            System.out.println("algo ha pasado");
            //redirect = "error.jsp";
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

    /*  private void mostrarmensajes(HttpServletRequest request, HttpServletResponse response) {
        try {
            response.setContentType("application/json");
            MessageModel mm = new MessageModel();
            String jsonObject = new Gson().toJson(mm.get());
            response.getWriter().println(jsonObject);
        } catch (IOException ex) {
            Logger.getLogger(agregarSala.class.getName()).log(Level.SEVERE, null, ex);
        }
    }*/
}
