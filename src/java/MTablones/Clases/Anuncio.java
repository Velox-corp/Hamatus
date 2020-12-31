
package MTablones.Clases;

import ClasesSoporte.Conexion;
import java.sql.*;
import java.util.ArrayList;
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

    public Anuncio(String titulo, String descripcion, int idDivision){
        this.titulo = titulo;
        this.descripcion = descripcion;
        this.idDivision = idDivision;
    }
    
    public static boolean ingresarAnuncio(Anuncio anuncio){
        boolean procesoCorrecto = true;
        try{
            con = Conexion.obtenerConexion();
            q = "INSERT INTO tablon (Titulo_Anuncio, Contenido, Id_division, fecha_publicacion) VALUES (?,?,?,current_timestamp())";
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
            q = "UPDATE tablon SET titulo_anuncio = ?, contenido = ? WHERE id_Anuncio =?";
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
    
    public static boolean borrarAnuncio(int ideAnuncio){
        boolean procesoCorrecto = true;
        try{
            con = Conexion.obtenerConexion();
            q = "DELETE FROM tablon WHERE ID_tablon = ?";
            ps = con.prepareStatement(q);
            ps.setInt(1, ideAnuncio);
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
    
    public static ArrayList<Anuncio> obtenerAnuncios(int idEmpresa, int idDiv){
        ArrayList<Anuncio> anuncios = new ArrayList<Anuncio>();
        CallableStatement cs = null;
        try{
            con = Conexion.obtenerConexion();
            q = "{call obtenerAnuncios(?,?)}";
            cs = con.prepareCall(q);
            cs.setInt(1, idEmpresa);
            cs.setInt(2, idDiv);
            rs = cs.executeQuery();
            while(rs.next()){
                Anuncio anuncio = new Anuncio(rs.getInt("ID_Tablon"),
                        rs.getString("Titulo_Anuncio"), 
                        rs.getString("Contenido"), 
                        rs.getString("fecha_publicacion"), 
                        rs.getInt("Id_division"));
                anuncios.add(anuncio);
            }
        } catch (Exception ex) {
            Logger.getLogger(Anuncio.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }finally{
            try {
                con.close();
                ps.close();
                rs.close();
                q = "";
            } catch (SQLException ex) {
                Logger.getLogger(Anuncio.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return anuncios;
    }
    
    public static Anuncio buscar(int id) {
        Anuncio p = new Anuncio();
        String sql = "select * from tablon where ID_Tablon=" + id;
        try {
            con = Conexion.obtenerConexion();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                p.setId(rs.getInt("ID_Tablon"));
                p.setTitulo(rs.getString("Titulo_Anuncio"));
                p.setDescripcion(rs.getString("Contenido"));
                p.setFecha(rs.getString("fecha_publicacion"));
                p.setIdDivision(rs.getInt("Id_division"));
            }
        } catch (Exception e) {
        }
        return p;
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
