
package ClasesSoporte;

import java.util.Calendar;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.GregorianCalendar;

public class Fecha {
    
    public static Calendar calendar = Calendar.getInstance();
    private static String fecha, hora, minutos, segundos;

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

public static String hora(){
    Calendar calendar = new GregorianCalendar();
    Date horaactual=new Date();
    hora=calendar.get(Calendar.HOUR_OF_DAY)>9?""+calendar.get(Calendar.HOUR_OF_DAY):"0"+calendar.get(Calendar.HOUR_OF_DAY);
    minutos=calendar.get(Calendar.MINUTE)>9?""+calendar.get(Calendar.MINUTE):"0"+calendar.get(Calendar.MINUTE);
    segundos=calendar.get(Calendar.SECOND)>9?""+calendar.get(Calendar.SECOND):"0"+calendar.get(Calendar.SECOND);
    Fecha fecha = new Fecha();
    String day=fecha.FechaBD();
    String tiempo=day+" "+hora+":"+minutos+":"+segundos;
    //System.out.println(tiempo);
    return tiempo;
}

}