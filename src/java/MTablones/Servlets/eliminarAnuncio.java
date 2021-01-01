/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MTablones.Servlets;

import MTablones.Clases.Anuncio;
import MTablones.Clases.AnuncioDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author maste
 */
public class eliminarAnuncio extends HttpServlet {

    AnuncioDAO adao = new AnuncioDAO();
    List<Anuncio> anuncios = new ArrayList<>();
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String menu = request.getParameter("menu");
        String accion = request.getParameter("accion");
        
        anuncios = adao.listar();
        
        switch(accion){
            case "Eliminar" :
                
                break;
            case "EditarA" :
                
                break;
            default:
                request.setAttribute("anuncios", anuncios);
                request.getRequestDispatcher("tablon.jsp").forward(request, response);   
        }
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }


    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
