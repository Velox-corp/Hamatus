
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
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class diviDAO {
    private static Connection con;
    private static  String q;
    private static PreparedStatement ps;
    private static ResultSet rs;
    
    public List listar() {
        List<divi>divisiones=new ArrayList();
        try {
            con = Conexion.obtenerConexion();
            q = "SELECT * FROM yl10l8ymbc.division";
            ps = con.prepareStatement(q);
            rs = ps.executeQuery();
            while (rs.next()) {
                divi d =new divi();
                d.setId(rs.getInt(1));
                d.setNombre(rs.getString(2));
                d.setIdj(rs.getInt(3));
                d.setIde(rs.getInt(4));
                divisiones.add(d);
            }
        } catch (SQLException ex) {
            Logger.getLogger(diviDAO.class.getName()).log(Level.SEVERE, null, ex);
            divisiones = null;
        }finally{
            try {
                con.close();
                q= "";
                ps.close();
                rs.close();
            } catch (SQLException ex) {
                Logger.getLogger(diviDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return divisiones;     
    }
}