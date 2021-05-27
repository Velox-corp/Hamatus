package ServletsEstadisticas;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Uzías
 */
@WebServlet(name = "afterFormulario", urlPatterns = {"/afterFormulario"})
public class afterFormulario extends HttpServlet {

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            //en cuanto llega del formulario hay que obtener las fechas, la division o equipo, id_empresa, supongo
            boolean esAdmin = true;
            String division;
            
            //aqui tengo que revisar si es admin o nel xd
            
            
            //primero wa comparar las fechas que me dieron para ver que no me hayan puesto la de inicio mayor 
            String fechaxd = request.getParameter("fecha_in");
            String fechax = request.getParameter("fecha_fin");
            String seleccion = request.getParameter("seleccionxd");
            
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date fecha1 = sdf.parse(fechaxd);
            Date fecha2 = sdf.parse(fechax);
            
            int esMenor = fecha1.compareTo(fecha2); // si fecha 1 es menor que fecha2 será un numero menor a 0
            if (esMenor < 0){
                //entonces aqui hay un problema B)
                if (esAdmin){
                    response.sendRedirect("Stats_Admin.jsp?fecha=bad");
                } else {
                    response.sendRedirect("Stats_Lider.jsp?fecha=bad");
                }
            }
            //primer problema abatido
            
            //para ver si dejo la seleccion en "blanco"
            if (seleccion.equals("Seleccione una")){
                if (esAdmin){
                    response.sendRedirect("Stats_Admin.jsp?opcion=bad");
                } else {
                    response.sendRedirect("Stats_Lider.jsp?opcion=bad");
                }
            }
            //segundo error abatido
            
            
        } catch(Exception e){
            e.printStackTrace();
            response.sendRedirect("error.jsp");
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
