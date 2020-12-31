/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MDistribucion.Servlets;

import ClasesSoporte.Validaciones;
import MDistribucion.Clases.EUsuarioEquipo;
import MDistribucion.Clases.Equipo;
import MUsuarios.clases.UsuarioEmpleado;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author maste
 */
public class crearEquipoTrabajo extends HttpServlet {

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String redirect;
            boolean procesoAdecuado;
            HttpSession sesion;
             try{
                sesion = request.getSession();
                String nombre_Equipo = request.getParameter("nombreEquipo");
                UsuarioEmpleado liderDiv = (UsuarioEmpleado) sesion.getAttribute("usuario");
                //la división del usuario obtenida desde la sesión para camuflar info
                int id_div = liderDiv.getiD_Division();
                int maxUsers = Integer.parseInt(request.getParameter("maxEmpleados"));
                if(!Validaciones.esString(nombre_Equipo, true, false) || !Validaciones.esNumeroEntero(maxUsers) || !Validaciones.esNumeroEntero(id_div)){
                    System.out.println("La validación no te la paso");
                    procesoAdecuado = false;
                }else{
                    Equipo new_equipo = new Equipo(nombre_Equipo, id_div);
                    procesoAdecuado = Equipo.crearEquipo(new_equipo);
                    if(procesoAdecuado){
                        new_equipo.setIDEquipo(Equipo.obtenerIDNuevoEquipo());
                        System.out.println(new_equipo.getIDEquipo());
                        //obtener los checkbox
                        for (int i = 0; i < maxUsers; i++) {
                            try{
                                if(request.getParameter("empleado_"+(i+1)).equals("true")){
                                    int idE = Integer.parseInt(request.getParameter("idE_"+(i+1)));
                                    EUsuarioEquipo newRelacion = new EUsuarioEquipo(idE, new_equipo.getIDEquipo());
                                    if(!EUsuarioEquipo.ingresarEmpleadoEquipo(newRelacion)){
                                        System.out.println("No se pudo ingresar la relación");
                                        procesoAdecuado=false;
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
                procesoAdecuado = false;
                e.printStackTrace();
            }catch(Exception e){
                e.getMessage();
                e.printStackTrace();
                procesoAdecuado = false;
            }
            
            if(procesoAdecuado){
                redirect = "verEquipos.jsp";
            }else{
                redirect = "error.jsp";
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
