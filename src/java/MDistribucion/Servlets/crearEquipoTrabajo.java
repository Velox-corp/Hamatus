/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MDistribucion.Servlets;

import ClasesSoporte.Validaciones;
import MDistribucion.Clases.EUsuarioEquipo;
import MDistribucion.Clases.Equipo;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet para crear el equipo de trabajo
 * @author maste
 */
public class crearEquipoTrabajo extends HttpServlet {

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String redirect = "";
            boolean procesoAdecuado = true;
            HttpSession sesion;
            System.out.println("Hola");
            try{
                sesion = request.getSession();
                String nombre_Equipo = request.getParameter("nombreEquipo");
                int id_div = Integer.parseInt(request.getParameter("id_div"));
                int maxUsers = Integer.parseInt(request.getParameter("maxEmpleados"));
                if(!Validaciones.esString(nombre_Equipo, true, false) || !Validaciones.esNumeroEntero(maxUsers) || !Validaciones.esNumeroEntero(id_div)){
                    System.out.println("La validación no te la paso");
                    procesoAdecuado = false;
                    redirect = "error.jsp";
                }else{
                    Equipo new_equipo = new Equipo(nombre_Equipo, id_div);
                    procesoAdecuado = Equipo.crearEquipo(new_equipo);
                    if(procesoAdecuado){
                        new_equipo.setIDEquipo(Equipo.obtenerIDNuevoEquipo());
                        System.out.println(new_equipo.getIDEquipo());
                        //obtener los checkbox
                        for (int i = 0; i < maxUsers; i++) {
                            try{
                                if(request.getParameter("empleado_"+i).equals("true")){
                                    EUsuarioEquipo newRelacion = new EUsuarioEquipo((i+1), new_equipo.getIDEquipo());
                                    if(!EUsuarioEquipo.ingresarEmpleadoEquipo(newRelacion)){
                                        System.out.println("No se pudo ingresar la relación");
                                        procesoAdecuado=false;
                                        redirect = "error.jsp";
                                        break;
                                    }else{
                                    }
                                }
                            }catch(NullPointerException e){
                            }
                        }
                    }else{
                        System.out.println("No se pudo crear el equipo");
                    }
                }
                
            }catch(NumberFormatException e){
                System.out.println("Excepcion");
                e.printStackTrace();
            }
            
            if(procesoAdecuado){
                redirect = "verEquipos.jsp";
                
            }
            response.sendRedirect(redirect);
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet crearEquipoTrabajo</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet crearEquipoTrabajo at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
