/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MUsuarios.clases;

import ClasesSoporte.Conexion;
import MSeguridad.Clases.AES;
import java.io.IOException;
import java.io.InputStream;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.servlet.http.Part;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

/**
 *  Clase correspondiente a la entidad de Empresa.
 * @author maste
 */
@Entity
@Table(name = "empresa")
@NamedQueries({
    @NamedQuery(name = "Empresa.findAll", query = "SELECT e FROM Empresa e")})
public class Empresa implements Serializable{

    static Connection con = null;
    static String query = "";
    static PreparedStatement ps = null;
    static ResultSet rs = null;
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "ID-Empresa")
    private Integer iDEmpresa;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "Nombre")
    private String nombre;
    @Basic(optional = false)
    @NotNull
    @Lob
    @Size(min = 1, max = 16777215)
    @Column(name = "Descripcion")
    private String descripcion;
    @Basic(optional = false)
    @NotNull
    @Lob
    @Column(name = "Logo")
    private InputStream logo;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "Raz\u00f3n social")
    private String razónsocial;

    public Empresa() {
    }

    public Empresa(Integer iDEmpresa) {
        this.iDEmpresa = iDEmpresa;
    }

    public Empresa(Integer iDEmpresa, String nombre, String descripcion, Part logo, String razónsocial) throws IOException{
        this.iDEmpresa = iDEmpresa;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.logo = logo.getInputStream();
        this.razónsocial = razónsocial;
    }
    
    public Empresa( String nombre, String descripcion, Part logo, String razónsocial) throws IOException{
        
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.logo = logo.getInputStream();
        this.razónsocial = razónsocial;
    }

    /**
     * Método para instanc´piar una empresa dnetor del programa, fundamental para el funcionamiento de hamatus ya que es el paso 1
     * @param emp El objeto empresa el cual posee toda la información de la empresa;
     * @return true si se ejecuto el ingreso a la bd de manera correcta
     */
    public static boolean crearEmpresa(Empresa emp){
        boolean procesoCorrecto = true;
        try{
            Empresa.con = Conexion.obtenerConexion();
            Empresa.query = ("INSERT INTO empresa (Nombre, Descripcion, Logo, Razon_social) VALUES (?, ?, ?, ?)");
            ps = con.prepareStatement(query);
            ps.setBytes(1, AES.cifrar(emp.getNombre(),0));
            ps.setBytes(2, AES.cifrar(emp.getDescripcion(),0));
            ps.setBlob(3, emp.getLogo());
            ps.setBytes(4, AES.cifrar(emp.getRazónsocial(),0));
            
           if(ps.executeUpdate()==1) procesoCorrecto = true;
           else procesoCorrecto = false;
        }catch(Exception e){
            procesoCorrecto = false;
            System.out.println("Error: "+e.getCause());
            e.printStackTrace();
        }
        finally{
            try {
                Empresa.ps.close();
                Empresa.con.close();
                query = "";
            } catch (SQLException ex) {
                Logger.getLogger(Empresa.class.getName()).log(Level.SEVERE, null, ex);
                procesoCorrecto = false;
            }
        }
        return procesoCorrecto;
    }
    
    public static Empresa buscarEmpresa(int iD_Division){
        Empresa emp = null;
        try{
            con = Conexion.obtenerConexion();
            query = ("SELECT * FROM empresa WHERE ID_Empresa="
                    + "(SELECT ID_Empresa FROM division WHERE ID_Division= ?)");
            ps = con.prepareStatement(query);
            ps.setInt(1, iD_Division);
            rs = ps.executeQuery();
            if (rs.next()) {
                emp = new Empresa();
                emp.setDescripcion(AES.descifrar(rs.getBytes("Descripcion"),0));
                emp.setIDEmpresa(rs.getInt("ID_Empresa"));
                //emp.setLogo() este no se va a añadir
                emp.setNombre(AES.descifrar(rs.getBytes("Nombre"),0));
                emp.setRazónsocial(AES.descifrar(rs.getBytes("Razon_social"),0));
            }else{
                System.out.println("Chanfle, no encontro nada");
            }
        }catch(Exception e){
            System.out.println("Error: "+e.getCause());
            e.printStackTrace();
        }
        finally{
            try {
                System.out.println("Termino busqueda");
                Empresa.ps.close();
                Empresa.con.close();
                query = "";
            } catch (SQLException ex) {
                Logger.getLogger(Empresa.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return emp;
    }
    
    /**
     * Metodó para obtener al logo de una emrpesa
     * @param id_emp: El ide de la empresa
     * @return Un inputStream que posee la informacón del logo para ser leida
     */
    public static InputStream sacarLogo(int id_emp){
        try{
            con = Conexion.obtenerConexion();
            query = "Select Logo from Empresa where ID_Empresa = ?";
            ps = con.prepareStatement(query);
            ps.setInt(1, id_emp);
            rs = ps.executeQuery();
            if(rs.next()){
                return rs.getBinaryStream("Logo");
            }else{
                return null;
            }
        } catch (SQLException ex) {
            Logger.getLogger(Empresa.class.getName()).log(Level.SEVERE, null, ex);
        }finally{
            try {
                rs.close();
                ps.close();
                con.close();
            } catch (SQLException ex) {
                Logger.getLogger(Empresa.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return null;
    }
    
    /**
     * Método para eidtar la información de una empresa a excepción del logo
     * @param emp: el objeto empresa con los datos nuevos a meter
     * @return true si se realizó el opdate correctamente
     */
    public static boolean editEmpresa(Empresa emp){
        boolean procesoCorrecto = false;
        try{
            con = Conexion.obtenerConexion();
            query = "UPDATE empresa SET Nombre = ?, Descripcion = ?, Razon_social = ? where id_empresa = ?";
            ps = con.prepareStatement(query);
            ps.setBytes(1, AES.cifrar(emp.getNombre(),0));
            ps.setBytes(2, AES.cifrar(emp.getDescripcion(),0));
            ps.setBytes(3, AES.cifrar(emp.getRazónsocial(),0));
            ps.setInt(4, emp.getIDEmpresa());
            procesoCorrecto = ( ps.executeUpdate() == 1 );
        } catch (Exception ex) {
            Logger.getLogger(Empresa.class.getName()).log(Level.SEVERE, null, ex);
            procesoCorrecto = false;
        }finally{
            try {
                con.close();
                query = "";
                ps.close();
            } catch (SQLException ex) {
                Logger.getLogger(Empresa.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return procesoCorrecto;
    }
    
    public static boolean editLogo(Part newLogo, int idEmp){
        boolean procesoCorrecto = false;
        try{
            con = Conexion.obtenerConexion();
            query = "UPDATE empresa SET logo = ? where ID_Empresa = ?";
            ps = con.prepareStatement(query);
            ps.setBlob(1, newLogo.getInputStream());
            ps.setInt(2, idEmp);
            procesoCorrecto = ( ps.executeUpdate() == 1 );
        } catch (Exception ex) {
            Logger.getLogger(Empresa.class.getName()).log(Level.SEVERE, null, ex);
            procesoCorrecto = false;
        }finally{
            try {
                con.close();
                query = "";
                ps.close();
            } catch (SQLException ex) {
                Logger.getLogger(Empresa.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return procesoCorrecto;
    }
    
    /**
     * Método para borrar una empresa
     * @param idEmp: el ide de la empresa a borrar
     * @return true si se realizó el delete con éxito
     */
    public static boolean deleteEmpresa(int idEmp){
        boolean procesoCorrecto = false;
        try{
         con = Conexion.obtenerConexion();
         query = "DELETE FROM empresa where ID_Empresa = ?";
         ps = con.prepareStatement(query);
         ps.setInt(1, idEmp);
         procesoCorrecto = ( ps.executeUpdate() == 1 );
        } catch (Exception ex) {
            Logger.getLogger(Empresa.class.getName()).log(Level.SEVERE, null, ex);
            procesoCorrecto = false;
        }finally{
            try {
                con.close();
                query = "";
                ps.close();
            } catch (SQLException ex) {
                Logger.getLogger(Empresa.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return procesoCorrecto;
    }

    public Empresa(Integer idEmpresa, String nombreE, String des, String raz, Object object) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    public Empresa(String nombreE, String descripcion, String razon, Object object) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
    public Integer getIDEmpresa() {
        return iDEmpresa;
    }

    public void setIDEmpresa(Integer iDEmpresa) {
        this.iDEmpresa = iDEmpresa;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public InputStream getLogo() {
        return logo;
    }

    public void setLogo(InputStream logo) {
        this.logo = logo;
    }

    public String getRazónsocial() {
        return razónsocial;
    }

    public void setRazónsocial(String razónsocial) {
        this.razónsocial = razónsocial;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (iDEmpresa != null ? iDEmpresa.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Empresa)) {
            return false;
        }
        Empresa other = (Empresa) object;
        if ((this.iDEmpresa == null && other.iDEmpresa != null) || (this.iDEmpresa != null && !this.iDEmpresa.equals(other.iDEmpresa))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "MUsuarios.clases.Empresa[ iDEmpresa=" + iDEmpresa + " ]";
    }

    /**
     * Metódo para obtener el id de la emresa que se acaba de registrar, ya que este, pese a que es auto_increment, lo necesitamos para el encabezado de empresa empleado
     * @return el id de la empresa que acaba de ser registrada, lanza -1 si no se pudo ejecutar la query o no se encontro la empresa
     */
    public static int getIDEmpresaRegistrada() {
        try{
           con = Conexion.obtenerConexion();
           query = "select MAX(ID_empresa) as id_emp from empresa";
           ps = con.prepareStatement(query);
           rs = ps.executeQuery();
           if(rs.next()){
               return rs.getInt("id_emp");
           }else{
               return -1;
           }
       } catch (SQLException ex) {
            Logger.getLogger(Empresa.class.getName()).log(Level.SEVERE, null, ex);
            return -1;
        }finally{
           try {
               con.close();
               ps.close();
               rs.close();
               query = "";
           } catch (SQLException ex) {
               Logger.getLogger(Empresa.class.getName()).log(Level.SEVERE, null, ex);
           }
       }
    }
    
}
