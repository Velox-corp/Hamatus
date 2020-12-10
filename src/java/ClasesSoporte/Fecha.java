
package ClasesSoporte;

import java.util.Calendar;
import java.text.SimpleDateFormat;

public class Fecha {
    
    public static Calendar calendar = Calendar.getInstance();
    private static String fecha;

    public Fecha() {
    }
    
public static String Fecha(){
    SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
    fecha=sdf.format(calendar.getTime());
    return fecha;
}
    

public static String FechaBD(){
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    fecha=sdf.format(calendar.getTime());
    return fecha;
}

}