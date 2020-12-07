/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MUsuarios.clases;

import ClasesSoporte.Conexion;
import java.io.Serializable;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 * Clase corraspondiente a la entidad UsuarioEmpleado
 * @author maste
 */
@Entity
@Table(name = "usuario-empleado")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "UsuarioEmpleado.findAll", query = "SELECT u FROM UsuarioEmpleado u")})
public class UsuarioEmpleado implements Serializable {

    private static Connection con;
    private static String q = "";
    private static PreparedStatement ps = null;
    private static ResultSet rs = null;
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "ID-Usuario-E")
    private Integer iDUsuarioE;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "Nombre")
    private String nombre;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "appat")
    private String appat;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "apmat")
    private String apmat;
    @Basic(optional = false)
    @NotNull
    @Column(name = "Fecha-Nacimiento")
    @Temporal(TemporalType.DATE)
    private String fechaNacimiento;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "Correo")
    private String correo;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "Password")
    private String password;
    @Lob
    @Column(name = "Foto")
    private byte[] foto;
    @Column(name = "ID-Nivel-P")
    private Integer iDNivelP;
    @Column(name = "ID-Jerarquia-P")
    private Integer iDJerarquiaP;

    public UsuarioEmpleado() {
    }

    public UsuarioEmpleado(Integer iDUsuarioE) {
        this.iDUsuarioE = iDUsuarioE;
    }
    //Constructores de Empleado
    /**
     * Constructor de Cuenta de administración
     * @param nombre Nombre admin
     * @param appat Appat admin
     * @param apmat Apmat admin
     * @param fechaNacimiento Fecha nac admin
     * @param correo Correo de la empresa preferentemente
     * @param password Contraseña solicitada
     */
    public UsuarioEmpleado(String nombre, String appat, String apmat, String fechaNacimiento, String correo, String password) {
        this.nombre = nombre;
        this.appat = appat;
        this.apmat = apmat;
        this.fechaNacimiento = fechaNacimiento;
        this.correo = correo;
        this.password = password;
    }
    
    /**
     * Metodo de creación de empleado, este se usará principalmente para obtener los usuarios de una query en un if o un for
     * El cual se tendría que llenar usarlo los rs.getParameter('nombre_col');
     * @param id_usuario_e: Ide del usuario solicitado
     * @param nombre: nombre del usuario solicitado
     * @param appat:  appat del usuario solicitado
     * @param apmat: apmat  del usuario solicitado
     * @param fechaNacimiento: fecha de nacimiento del usuario solicitado
     * @param correo: correo del usuario solicitado
     * @param password: Contraseña del usuario solicitado
     * @param idjerarquiap: id_jer del usuario solicitado
     * @param idjerarquiaNivelD: id_nivel  del usuario solicitado
     * @param foto: foto  del usuario solicitado
     */
    public UsuarioEmpleado(int id_usuario_e, String nombre, String appat, String apmat, String fechaNacimiento, String correo, String password, int idjerarquiap, int idjerarquiaNivelD, byte[]foto) {
        this.iDUsuarioE = id_usuario_e;
        this.nombre = nombre;
        this.appat = appat;
        this.apmat = apmat;
        this.fechaNacimiento = fechaNacimiento;
        this.correo = correo;
        this.password = password;
        this.iDJerarquiaP =idjerarquiap;
        this.iDNivelP = idjerarquiaNivelD;
        this.foto = foto;
    }
    
    /**
     * Metodo de creación de empleado, este se usará para registrar a los empleados por parte del administrador.
     * @param nombre: nombre del usuario a ingresar
     * @param appat:  appat del usuario a ingresar
     * @param apmat: apmat  del usuario a ingresar
     * @param fechaNacimiento: fecha de nacimiento del usuario a ingresar
     * @param correo: correo del usuario a ingresar
     * @param password: Contraseña del usuario a ingresar
     * @param idjerarquiap: id_jer del usuario a ingresar
     * @param idjerarquiaNivelD: id_nivel del usuario a ingresar
     * @param foto: foto  del usuario a ingresar
     */
    public UsuarioEmpleado(String nombre, String appat, String apmat, String fechaNacimiento, String correo, String password, int idjerarquiap, int idjerarquiaNivelD, byte[]foto) {
        this.nombre = nombre;
        this.appat = appat;
        this.apmat = apmat;
        this.fechaNacimiento = fechaNacimiento;
        this.correo = correo;
        this.password = password;
        this.iDJerarquiaP =idjerarquiap;
        this.iDNivelP = idjerarquiaNivelD;
        this.foto = foto;
    }

    //CRUD empleados
    
    /**
     * Método para ingresar un empleado a la bd
     * Si es la cuenta de administrador recordar que se van a enviar nulos, de lo contrario todos los campos a excepción de la foto deben de estar
     * @param admin: la cuenta de administrador a insertar
     * @param id_emp: El id de la empresa al que pertenece el usuario.
     * @return 
     */
    public static boolean ingresarAdmin(UsuarioEmpleado admin, int id_emp){
        CallableStatement cs = null;
        try{
            con = Conexion.obtenerConexion();
            q = "{call ingresarAdmin(?,?,?,?,?,?,?,?)}";
            cs = con.prepareCall(q);
            cs.setString(1, admin.getNombre());
            cs.setString(2, admin.getAppat());
            cs.setString(3, admin.getApmat());
            cs.setString(4, admin.getFechaNacimiento());
            cs.setString(5, admin.getCorreo());
            cs.setString(6, admin.getPassword());
            cs.setBytes(7, null); //chance luego hacemos que pueda meter foto tambien
            cs.setInt(8, id_emp);
            return cs.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(UsuarioEmpleado.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println("No jalo el call");
            return false;
        }finally{
            try {
                con. close();
                cs.close();
                q = "";
            } catch (SQLException | NullPointerException ex) {
                Logger.getLogger(UsuarioEmpleado.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
    
    /**
     * Método para ingresar un empleado a la bd
     * Si es la cuenta de administrador recordar que se van a enviar nulos, de lo contrario todos los campos a excepción de la foto deben de estar
     * @param empleado: El empleado a ingresar a la bd
     * @param id_emp: El id de la empresa al que pertenece el usuario.
     * @return 
     */
    public static boolean ingresarEmpleado(UsuarioEmpleado empleado, int id_emp){
        CallableStatement cs = null;
        try{
            con = Conexion.obtenerConexion();
            q = "{call ingresarUsuario(?,?,?,?,?,?,?,?,?,?)}";
            cs = con.prepareCall(q);
            cs.setString(1, empleado.getNombre());
            cs.setString(2, empleado.getAppat());
            cs.setString(3, empleado.getApmat());
            cs.setString(4, empleado.getFechaNacimiento());
            cs.setString(5, empleado.getCorreo());
            cs.setString(8, empleado.getPassword());
            cs.setInt(6, empleado.getIDJerarquiaP());
            cs.setInt(7, empleado.getIDNivelP());
            cs.setBytes(9, empleado.getFoto());
            cs.setInt(10, id_emp);
            return cs.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(UsuarioEmpleado.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println("No jalo el call");
            return false;
        }finally{
            try {
                con. close();
                cs.close();
                q = "";
            } catch (SQLException | NullPointerException ex) {
                Logger.getLogger(UsuarioEmpleado.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
            
    public Integer getIDUsuarioE() {
        return iDUsuarioE;
    }

    public void setIDUsuarioE(Integer iDUsuarioE) {
        this.iDUsuarioE = iDUsuarioE;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getAppat() {
        return appat;
    }

    public void setAppat(String appat) {
        this.appat = appat;
    }

    public String getApmat() {
        return apmat;
    }

    public void setApmat(String apmat) {
        this.apmat = apmat;
    }

    public String getFechaNacimiento() {
        return fechaNacimiento;
    }

    public void setFechaNacimiento(String fechaNacimiento) {
        this.fechaNacimiento = fechaNacimiento;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public byte[] getFoto() {
        return foto;
    }

    public void setFoto(byte[] foto) {
        this.foto = foto;
    }

    public Integer getIDNivelP() {
        return iDNivelP;
    }

    public void setIDNivelP(Integer iDNivelP) {
        this.iDNivelP = iDNivelP;
    }

    public Integer getIDJerarquiaP() {
        return iDJerarquiaP;
    }

    public void setIDJerarquiaP(Integer iDJerarquiaP) {
        this.iDJerarquiaP = iDJerarquiaP;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (iDUsuarioE != null ? iDUsuarioE.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof UsuarioEmpleado)) {
            return false;
        }
        UsuarioEmpleado other = (UsuarioEmpleado) object;
        if ((this.iDUsuarioE == null && other.iDUsuarioE != null) || (this.iDUsuarioE != null && !this.iDUsuarioE.equals(other.iDUsuarioE))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "MUsuarios.clases.UsuarioEmpleado[ iDUsuarioE=" + iDUsuarioE + " ]";
    }
    
}
