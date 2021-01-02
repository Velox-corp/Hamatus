
package MDivisiones.clases;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletResponse;
import ClasesSoporte.Conexion;

public class diviDAO {
    Connection con;
    Conexion cn=new Conexion();
    PreparedStatement ps;
    ResultSet rs;
    
    public List listar() {
        List<divi>divisiones=new ArrayList();
        String sql="SELECT * FROM yl10l8ymbc.division";
        try {
            con = cn.obtenerConexion();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                divi d =new divi();
                d.setId(rs.getInt(1));
                d.setNombre(rs.getString(2));
                d.setIdj(rs.getInt(3));
                d.setIde(rs.getInt(4));
                divisiones.add(d);
                System.out.println("Corrio");
            }
        } catch (Exception e) {
            System.out.println("Ocurrio un error diviDAO");
            System.out.println(e.getMessage());
            System.out.println(e.getStackTrace());
        }
        return divisiones;
    }
}
