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
            String division = "";
            String id_esDiv = "DI3";
            
            //aqui tengo que revisar si es admin o nel xd
            String id_usuario = request.getParameter("usuario_id");
            String id_priv = request.getParameter("privilegio_id");
            System.out.println("EL id del usuario es " + id_usuario);
            System.out.println("EL id del privilegio es " + id_priv);
            
            //primero wa comparar las fechas que me dieron para ver que no me hayan puesto la de inicio mayor 
            String fechaxd = request.getParameter("fecha_in");
            String fechax = request.getParameter("fecha_fin");
            String seleccion = request.getParameter("seleccion");
            
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date fecha1 = sdf.parse(fechaxd);
            Date fecha2 = sdf.parse(fechax);
            System.out.println("La fecha 1 es "+fecha1);
            System.out.println("La fecha 2 es "+fecha2);
            
            int esMenor = fecha1.compareTo(fecha2); // si fecha 1 es menor que fecha2 será un numero menor a 0
            System.out.println("El numero es " + esMenor);
            if (esMenor > 0){
                //entonces aqui hay un problema B)
                if (esAdmin){
                    response.sendRedirect("Stats_Admin.jsp?fecha=bad");
                } else {
                    response.sendRedirect("Stats_Lider.jsp?fecha=bad");
                }
            }
            //primer problema abatido
            
            //para ver si dejo la seleccion en "blanco"
            if (seleccion.equals("defaultxd")){
                if (esAdmin){
                    response.sendRedirect("Stats_Admin.jsp?opcion=bad");
                } else {
                    response.sendRedirect("Stats_Lider.jsp?opcion=bad");
                }
            }
            //segundo error abatido
            
            //despues de que esos dos errores del formulario hayan pasado, vendrá aqui
            //primero tengo que saber de que division o equipo se verán las gráficas
            System.out.println("La seleccion es "+seleccion);
            if (seleccion.contains(id_esDiv)){
                //esto significa que es una division
                division = seleccion.substring(3);
            } else {
                //esto significa que no es una division
                division = seleccion;
            }
            
                System.out.println("El final sería "+division);
            //hasta ahora ya tengo las fechas, la seleccion y el tipo de usuario, me falta hacer la grafica y probablemente obtener el id de la division
            //se cancela, cambie el nombre por el ID de la division o equipo
            
            
            //como ya tengo el id del privilegio, hay que parsear
            int privilegioXD = Integer.parseInt(id_priv);
            switch (privilegioXD){
                //1 = admin, 2 = directivo, 3 = jefe de area
                case 1:
                    
                    break;
                case 2:
                    
                    break;
                case 3:
                    
                    break;
                default:
                    System.out.println("Que haces aqui xd");
                    response.sendRedirect("error.jsp");
            }
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
