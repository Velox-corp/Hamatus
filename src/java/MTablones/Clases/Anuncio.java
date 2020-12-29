
package MTablones.Clases;

import ClasesSoporte.Conexion;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
public class Anuncio {
    
    private int id;
    private String titulo;
    private String descripcion;
    private String fecha;
    private int idDivision;
    static Connection con;
    static PreparedStatement ps;
    static ResultSet rs;
    static String q = "";
    
    public Anuncio() {
    }

    public Anuncio(int id, String titulo, String descripcion, String fecha, int idDivision) {
        this.id = id;
        this.titulo = titulo;
        this.descripcion = descripcion;
        this.fecha = fecha;
        this.idDivision = idDivision;
    }

    public Anuncio(String titulo, String descripcion, String fecha, int idDivision){
        this.titulo = titulo;
        this.descripcion = descripcion;
        this.fecha = fecha;
        this.idDivision = idDivision;
    }
    
    public static boolean ingresarAnuncio(Anuncio anuncio){
        boolean procesoCorrecto = true;
        try{
            con = Conexion.obtenerConexion();
            q = "INSERT INTO anuncio (Titulo_Anuncio, Contenido, Id_division, fecha_publicacion) VALUES (?,?,?,current_timestamp())";
            ps = con.prepareStatement(q);
            ps.setString(1, anuncio.getTitulo());
            ps.setString(2, anuncio.getDescripcion());
            ps.setInt(3, anuncio.getIdDivision());
            procesoCorrecto = (ps.executeUpdate() == 1);
        } catch (Exception ex) {
            Logger.getLogger(Anuncio.class.getName()).log(Level.SEVERE, null, ex);
            procesoCorrecto = false;
        }finally{
            try {
                con.close();
                ps.close();
                q = "";
            } catch (SQLException ex) {
                Logger.getLogger(Anuncio.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return procesoCorrecto;
    }
    
    public static boolean modAnuncio(Anuncio newAnuncio){
        boolean procesoCorrecto = true;
        try{
            con = Conexion.obtenerConexion();
            q = "UPDATE Anuncio SET titulo_anuncio = ?, contenido = ? WHERE id_Anuncio =?";
            ps = con.prepareStatement(q);
            ps.setString(1, newAnuncio.getTitulo());
            ps.setString(2, newAnuncio.getDescripcion());
            ps.setInt(3, newAnuncio.getId());
            procesoCorrecto = (ps.executeUpdate() == 1);
        } catch (Exception ex) {
            Logger.getLogger(Anuncio.class.getName()).log(Level.SEVERE, null, ex);
            procesoCorrecto = false;
        }finally{
            try {
                con.close();
                ps.close();
                q = "";
            } catch (SQLException ex) {
                Logger.getLogger(Anuncio.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return procesoCorrecto;
    }
    
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public int getIdDivision() {
        return idDivision;
    }

    public void setIdDivision(int idDivision) {
        this.idDivision = idDivision;
    }
    
    
}
