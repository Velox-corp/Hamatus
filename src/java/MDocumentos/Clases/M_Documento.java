/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MDocumentos.Clases;

import ClasesSoporte.Conexion;
import MSeguridad.Clases.AES;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Calendar;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

/**
 *
 * @author taspi
 * 
 * No hay mucho que decir de esta clase, primero se tiene la table de usuario,
 * despues la table de documento y al final se crea esta fabulosa clase
 */
@Entity
public class M_Documento implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int idM_Documento;
    private int id_D_DOcumento;
    private int id_usuario_p;
    
    private static Connection con = null;
    private String query = "";
    private static PreparedStatement ps = null;
    private static ResultSet rs = null;
    private static final long serialVersionUID = 1L;
    
    public M_Documento(){
        
    }
    
    /**
     * @param id_D_DOcumento
     * @param id_usuario_p
     */
    public M_Documento(int id_D_DOcumento, int id_usuario_p){
        this.id_D_DOcumento = id_D_DOcumento;
        this.id_usuario_p   = id_usuario_p;
    }
    
    /**
     * Este metodo registra esta entidad basicamente
     * @return 
     */
    public boolean registrarM_Documentos(){
        boolean correcto = false;
        //CallableStatement cs = null;
        try {
            this.con = Conexion.obtenerConexion();
            this.query = ("INSERT INTO m_documento (id_D_DOcumento, id_usuario_p)"
                    + "VALUES (?, ?)");
            ps = con.prepareCall(query);
            ps.setInt(1, this.id_D_DOcumento);
            ps.setInt(2, this.id_usuario_p);
            int lastInsertedID = ps.executeUpdate();
            ResultSet rs= ps.getGeneratedKeys();
            if (rs.next()) 
            {
              System.out.println("Last Inserted ID = "+rs.getLong(1));
              this.idM_Documento = rs.getInt(1);
            }
            correcto = true;
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
            System.out.println(e.getLocalizedMessage());
        } finally{
            try {
                this.con.close();
                this.ps.close();
            } catch (SQLException ex) {
                Logger.getLogger(M_Documento.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return correcto;
    }
    
    /**
     * BOrrar la maestra del documento no es la gran cosa
     * @param idM_Documento para hacer lo anteriror necesita la id del doc
     * @return 
     */
    public boolean BorrarM_Documentos(int idM_Documento){
        boolean correcto = false;
        //CallableStatement cs = null;
        try {
            this.con = Conexion.obtenerConexion();
            this.query = ("DELETE FROM m_documento WHERE idM_Documento=?");
            ps = con.prepareCall(query);
            ps.setInt(1, idM_Documento);  
            if(ps.executeUpdate()==1) correcto = true;
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }finally{
            try {
                this.con.close();
                this.ps.close();
            } catch (SQLException ex) {
                Logger.getLogger(M_Documento.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return correcto;
    }
    
    /**
     * Borrar la maestra del documento no es la gran cosa
     * @return 
     */
    public boolean BorrarM_Documentos(){
        boolean correcto = false;
        //CallableStatement cs = null;
        try {
            this.con = Conexion.obtenerConexion();
            this.query = ("DELETE FROM m_documentos WHERE idM_Documento=?");
            ps = con.prepareCall(query);
            ps.setInt(1, this.idM_Documento);  
            if(ps.executeUpdate()==1) correcto = true;
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        } finally{
            try {
                this.con.close();
                this.ps.close();
            } catch (SQLException ex) {
                Logger.getLogger(M_Documento.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return correcto;
    }
    
    /**
     * Borrar la maestra del documento no es la gran cosa
     * @param idM_Documento
     * @return 
     */
    public boolean Consultar_mDoc(int idM_Documento, int id_usuario_p){
        boolean correcto = false;
        //CallableStatement cs = null;
        try {
            this.con = Conexion.obtenerConexion();
            this.query = ("SELECT * FROM m_Documento WHERE idM_Documento=?");
            ps = con.prepareCall(query);
            ps.setInt(1, idM_Documento);
            ResultSet res = ps.executeQuery();
            while(res.next()){
                System.out.println("Documento encontrado");
                this.setIdM_Documento(res.getInt("idM_Documento"));
                this.setId_D_DOcumento(res.getInt("id_D_DOcumento"));
                this.setId_usuario_p(res.getInt("id_usuario_p"));
            }
            correcto = true;
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        } finally{
            try {
                this.con.close();
                this.ps.close();
            } catch (SQLException ex) {
                Logger.getLogger(M_Documento.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return correcto;
    }
    
    /**
     * Subir para arriba XD, este metodo tiene el proposito de hacer los registros
     * de las entradas de los uaurios
     * @param id_persona
     * @return 
     */
    public boolean registrarRegistro(int id_persona){
        boolean right = false;
        try {
            this.con = Conexion.obtenerConexion();
            this.query = ("INSERT INTO registro_entrada (Fecha_entrada,"
                    + " hora_entrada, ID_Usuario_Consulta, id_M_documento)"
                    + "VALUES (?, ?, ?, ?)");
            Calendar c1 = Calendar.getInstance();
            String fecha = c1.get(Calendar.DATE) + "-" + c1.get(Calendar.MONTH) 
                    + "-" + c1.get(Calendar.YEAR);
            String hora = c1.get(Calendar.HOUR) + ":" + c1.get(Calendar.MINUTE) 
                    + ":" + c1.get(Calendar.SECOND);
            ps = con.prepareCall(query);
            ps.setBytes(1, AES.cifrar(fecha,8));
            ps.setBytes(2, AES.cifrar(hora,8));
            ps.setInt(4, this.getIdM_Documento());
            ps.setInt(3, id_persona);
            if(ps.executeUpdate()==1) right = true;
        } catch (Exception e) {
            System.out.println(e.getMessage());
            System.out.println(e.getLocalizedMessage());
            e.printStackTrace();
        } finally{
            try {
                this.con.close();
                ps.close();
            } catch (Exception e) {
            }
        }
        return right;
    }

    @Override
    public String toString() {
        return "m_documento{" + "idM_Documento=" + idM_Documento + ", id_D_DOcumento=" + id_D_DOcumento + ", id_usuario_p=" + id_usuario_p + '}';
    }

    public int getIdM_Documento() {
        return idM_Documento;
    }

    public void setIdM_Documento(int idM_Documento) {
        this.idM_Documento = idM_Documento;
    }

    public int getId_D_DOcumento() {
        return id_D_DOcumento;
    }

    public void setId_D_DOcumento(int id_D_DOcumento) {
        this.id_D_DOcumento = id_D_DOcumento;
    }

    public int getId_usuario_p() {
        return id_usuario_p;
    }

    public void setId_usuario_p(int id_usuario_p) {
        this.id_usuario_p = id_usuario_p;
    }

    public String getQuery() {
        return query;
    }

    public void setQuery(String query) {
        this.query = query;
    }
    
    public static Connection getCon() {
        return con;
    }

    public static void setCon(Connection aCon) {
        con = aCon;
    }

    public static PreparedStatement getPs() {
        return ps;
    }

    public static void setPs(PreparedStatement aPs) {
        ps = aPs;
    }

    public static ResultSet getRs() {
        return rs;
    }

    public static void setRs(ResultSet aRs) {
        rs = aRs;
    }
}
