/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MTablones.Servlets;

import ClasesSoporte.Fecha;
import MTablones.Clases.Anuncio;
import MTablones.Clases.AnuncioDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author roberto
 */
public class controlA extends HttpServlet {
    
    Anuncio a = new Anuncio();
    AnuncioDAO adao = new AnuncioDAO();
    List<Anuncio> anuncios = new ArrayList<>();
    List<Anuncio> anunciosID = new ArrayList<>();
    
    int ida;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String menu = request.getParameter("menu");
        String accion = request.getParameter("accion");

        anuncios = adao.listar();  
        

        switch (accion) {
            case "Delete":
                int idanuncio = Integer.parseInt(request.getParameter("ida"));
                adao.delete(idanuncio);
                request.getRequestDispatcher("controlA?accion=home").forward(request, response);
                break;
            case "Update":
                int idmod = Integer.parseInt(request.getParameter("idmod"));
                String mod_titulo = request.getParameter("mod_titulo");
                String mod_descripcion = request.getParameter("mod_descripcion");
                
                Anuncio modanuncio= new Anuncio(mod_titulo,mod_descripcion,Fecha.FechaBD(),1);
                adao.actualizar(idmod,modanuncio);
                
                request.getRequestDispatcher("controlA?accion=home").forward(request, response);
                break;
            case "ListarID":
                int idanuncioupdate = Integer.parseInt(request.getParameter("ida"));
                anunciosID=adao.listarId(idanuncioupdate);
                request.setAttribute("anuncios", anunciosID);
                request.getRequestDispatcher("editanuncio.jsp").forward(request, response);
                break;
            case "Agregar":
                String tituloa = request.getParameter("tituloa");
                String descripciona = request.getParameter("descripciona");
                //String fechaa = request.getParameter("fechaa");
                
                Anuncio anuncio= new Anuncio(tituloa,descripciona,Fecha.FechaBD(),1);
                adao.agregar(anuncio);
                
                //request.setAttribute("contador", listaCarrito.size());
                request.getRequestDispatcher("controlA?accion=home").forward(request, response);
                break;
            default:
                request.setAttribute("anuncios", anuncios);
                request.getRequestDispatcher("anuncios.jsp").forward(request, response);
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
