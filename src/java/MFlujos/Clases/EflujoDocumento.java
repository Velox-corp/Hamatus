/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package MFlujos.Clases;

import ClasesSoporte.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Armando Jarillo
 */
public class EflujoDocumento {

    private int idfd;
    private int idd;
    private int idf;
    
    static Connection con;
    static String q;
    static ResultSet rs;
    static PreparedStatement ps;
    /**
     * constructor vacio
     */
    public EflujoDocumento(){

    }

    /**
     * constructor para obtencion a partir de query
     * @param idfd
     * @param idd
     * @param idf 
     */
    public EflujoDocumento(int idfd, int idd, int idf) {
        this.idfd = idfd;
        this.idd = idd;
        this.idf = idf;
    }
    
    /**
     * Insertar la relación en la bd
     * @param efd: la relación flujo.documento a usar
     * @return true si el procedimiento fue correcto
     */
    public static boolean insertarEFD(EflujoDocumento efd){
        boolean procesoCorrecto;
        try{
            con = Conexion.obtenerConexion();
            q = "INSERT INTO E_flujo_documento (id_flujo, id_doc) values(?,?)";
            ps = con.prepareStatement(q);
            ps.setInt(1, efd.getIdf());
            ps.setInt(2, efd.getIdfd());
            procesoCorrecto = ps.executeUpdate() == 1;
            if(procesoCorrecto){
                ps.close();
                q = "UPDATE flujo_de_trabajo SET entregado = 1 WHERE idFlujo_de_trabajo = "
                        + "(SELECT idE_flujo_documento FROM E_flujo_documento WHERE id_flujo = ? AND id_doc = ?)";
                ps = con.prepareStatement(q);
                ps.setInt(1, efd.getIdf());
                ps.setInt(2, efd.getIdfd());
                procesoCorrecto = ps.executeUpdate() == 1;
            }
        }catch (SQLException ex) {
            Logger.getLogger(EflujoDocumento.class.getName()).log(Level.SEVERE, null, ex);
            procesoCorrecto = false;
        }finally{
            try {
                con.close();
                ps.close();
                q = "";
            } catch (SQLException ex) {
                Logger.getLogger(EflujoDocumento.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return procesoCorrecto;
    }
    
    
    /**
     * Obtiene la relación a partir del id del flujo
     * @param flujo el id del flujo
     * @return 
     */
    public static EflujoDocumento obtenerEFD_por_flujo(int flujo){
        EflujoDocumento efd = null;
        
        try{
            con = Conexion.obtenerConexion();
            q = "";
            ps = con.prepareStatement(q);
            
        }catch (Exception ex) {
            Logger.getLogger(EflujoDocumento.class.getName()).log(Level.SEVERE, null, ex);
        }finally{
            try {
                con.close();
                ps.close();
                q = "";
            } catch (SQLException ex) {
                Logger.getLogger(EflujoDocumento.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return efd;
    }
    
    
    public int getIdfd() {
        return idfd;
    }

    public void setIdfd(int idfd) {
        this.idfd = idfd;
    }

    public int getIdd() {
        return idd;
    }

    public void setIdd(int idd) {
        this.idd = idd;
    }

    public int getIdf() {
        return idf;
    }

    public void setIdf(int idf) {
        this.idf = idf;
    }
    
    
    
}
