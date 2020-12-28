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
import java.util.ArrayList;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityManager;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.sql.DataSource;
import javax.transaction.UserTransaction;
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
    @Column(name = "ID_Division")
    private Integer iD_Division;
    @Column(name = "ID_cat_privilegios")
    private Integer iD_cat_priv;

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
     * @param id_division: El ide de la división a la pertenecerá
     * @param id_cat_priv: id_nivel de la jerarquía del empleado
     * @param foto: foto  del usuario solicitado
     */
    public UsuarioEmpleado(int id_usuario_e, String nombre, String appat, String apmat, String fechaNacimiento, String correo, String password, int id_division, int id_cat_priv, byte[]foto) {
        this.iDUsuarioE = id_usuario_e;
        this.nombre = nombre;
        this.appat = appat;
        this.apmat = apmat;
        this.fechaNacimiento = fechaNacimiento;
        this.correo = correo;
        this.password = password;
        this.iD_Division = id_division;
        this.iD_cat_priv = id_cat_priv;
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
     * @param id_division: El ide de la división a la pertenecerá
     * @param id_cat_priv: id_nivel de la jerarquía del empleado
     * @param foto: foto  del usuario a ingresar
     */
    public UsuarioEmpleado(String nombre, String appat, String apmat, String fechaNacimiento, String correo, String password, int id_division, int id_cat_priv, byte[]foto) {
        this.nombre = nombre;
        this.appat = appat;
        this.apmat = apmat;
        this.fechaNacimiento = fechaNacimiento;
        this.correo = correo;
        this.password = password;
        this.iD_Division = id_division;
        this.iD_cat_priv = id_cat_priv;
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
     * Método para ingresar un empleado a la bd, basicamente el método a llamar para que el administrador vaya generando los usuarios
     * *¡NOTA! Este método usa ul procedimiento almacenado desactualizado, así que se tend´ria que reajustar este método o ejecutar el insert directamente por aquí*
     * @param empleado: El empleado a ingresar a la bd
     * @param id_emp: El id de la empresa al que pertenece el usuario.
     * @return 
     */
    public static boolean ingresarEmpleado(UsuarioEmpleado empleado, int id_emp){
        try{
            con = Conexion.obtenerConexion();
            q = "INSERT INTO usuario_empleado (Nombre, appat, apmat, Fecha_Nacimiento, Correo, pass, ID_Division, id_cat_privilegios, foro) values(?,?,?,?,?,?,?,?,?)";
            ps = con.prepareCall(q);
            ps.setString(1, empleado.getNombre());
            ps.setString(2, empleado.getAppat());
            ps.setString(3, empleado.getApmat());
            ps.setString(4, empleado.getFechaNacimiento());
            ps.setString(5, empleado.getCorreo());
            ps.setString(8, empleado.getPassword());
            ps.setInt(6, empleado.getiD_Division());
            ps.setInt(7, empleado.getiD_cat_priv());
            ps.setBytes(9, empleado.getFoto());
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(UsuarioEmpleado.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println("No jalo el query");
            return false;
        }finally{
            try {
                con. close();
                ps.close();
                q = "";
            } catch (SQLException | NullPointerException ex) {
                Logger.getLogger(UsuarioEmpleado.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
    
    /**
     * Metodo para modificar los datos de un empleado
     * @param empleado El objeto UsuarioEmpleado que posee los nuevos valores del empleado.
     * @return true si el update se eejcutó adecuadamente
     */
    public static boolean modEmpleado(UsuarioEmpleado empleado){
        try{
            con = Conexion.obtenerConexion();
            q = "UDATE usuario_empleado SET Nombre = ?, appat = ?, apmat = ?, Fecha_Nacimiento, Correo = ?, pass = ?, ID_Division = ? , id_cat_privilegios = ?, foro= ? WHERE ID_Usuario_E = ?";
            ps = con.prepareCall(q);
            ps.setString(1, empleado.getNombre());
            ps.setString(2, empleado.getAppat());
            ps.setString(3, empleado.getApmat());
            ps.setString(4, empleado.getFechaNacimiento());
            ps.setString(5, empleado.getCorreo());
            ps.setString(8, empleado.getPassword());
            ps.setInt(6, empleado.getiD_Division());
            ps.setInt(7, empleado.getiD_cat_priv());
            ps.setBytes(9, empleado.getFoto());
            ps.setInt(10, empleado.getIDUsuarioE());
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(UsuarioEmpleado.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println("No jalo el update");
            return false;
        }finally{
            try {
                con. close();
                ps.close();
                q = "";
            } catch (SQLException | NullPointerException ex) {
                Logger.getLogger(UsuarioEmpleado.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
    
    
    /**
     * Metodo para despedir a un empleado
     * @param id_empleado: el ide del empleado a eliminar
     * @return true si el cambio se ejecutó correctamente
     */
    public static boolean DespedirEmpleado(int id_empleado){
        try{
            con = Conexion.obtenerConexion();
            q = "DELETE FROM usuario_empleado WHERE ID_Usuario_E = ?";
            ps = con.prepareCall(q);
            ps.setInt(1, id_empleado);
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(UsuarioEmpleado.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println("No jalo el query");
            return false;
        }finally{
            try {
                con. close();
                ps.close();
                q = "";
            } catch (SQLException | NullPointerException ex) {
                Logger.getLogger(UsuarioEmpleado.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
    
    
    /**
     * Ok so basicamente esta funcion lo que hace es buscar el usuario solicitado
     * es un void por que basicamente tomara atributos del usuario buscado
     * Nota: Si vas a utilizar esta funcion hazlo encima de una clase vacia para 
     * que no reemplace otros datos
     * @param correo pues el correo
     * @param pass pues la pass
     * @return EL objeto UsuarioEmpleado con los datos del usuario que se logeo
     */
    public static UsuarioEmpleado ConsultarEmpleado(String correo, String pass){
        UsuarioEmpleado userLog = null;
        try{
            con = Conexion.obtenerConexion();
            q = "SELECT * FROM usuario_empleado WHERE Correo = ? AND pass = ? limit 1";
            ps= con.prepareStatement(q);
            ps.setString(1, correo);
            ps.setString(2, pass);
            rs = ps.executeQuery();
            if(rs.next()){
                userLog = new UsuarioEmpleado();
                userLog.setNombre(rs.getString("Nombre"));
                userLog.setAppat(rs.getString("appat"));
                userLog.setApmat(rs.getString("apmat"));
                userLog.setCorreo(rs.getString("correo"));
                userLog.setFechaNacimiento(rs.getString("Fecha_Nacimiento"));
                userLog.setPassword(rs.getString("pass"));
                userLog.setiD_Division(rs.getInt("ID_Division"));
                userLog.setiD_cat_priv(rs.getInt("ID_cat_privilegios"));
                userLog.setIDUsuarioE(rs.getInt("ID_Usuario_E"));
            }
        }catch(SQLException | NullPointerException e){
            System.out.println(e.getMessage());
            e.printStackTrace();
        }finally{
            try {
                con. close();
                q = "";
                rs.close();
            } catch (SQLException | NullPointerException ex) {
                Logger.getLogger(UsuarioEmpleado.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return userLog;
    }
    
    
    /**
     * Metodo para obtener todos los usuarios de la base de datos
     * @return  Un ArrayLisy vectorizado que contiene a TODOS los usuarios de la base de datos
     */
    public static ArrayList<UsuarioEmpleado> obtenerUsuarios(){
        ArrayList<UsuarioEmpleado> empleados = null;
        try{
            con = Conexion.obtenerConexion();
            q = "SELECT * FROM Usuario_empleado";
            ps = con.prepareStatement(q);
            rs = ps.executeQuery();
            while(rs.next()){
                UsuarioEmpleado empleado = 
                        new UsuarioEmpleado(
                                rs.getInt("ID_usuario_e"), 
                                rs.getString("nombre"), 
                                rs.getString("appat"), 
                                rs.getString("apmat"), 
                                rs.getString("correo"), 
                                rs.getString("fecha_nacimiento"), 
                                rs.getString("pass"), 
                                rs.getInt("ID_Division"), 
                                rs.getInt("ID_cat_privilegios"), 
                                rs.getBytes("foto"));
                
                empleados.add(empleado);
            }
        }catch(Exception e){
            e.getMessage();
            e.getStackTrace();
            return null;
        }finally{
            try{
                con.close();
                ps.close();
                rs.close();
                q = "";
            }catch(SQLException ex){
                ex.getMessage();
                ex.getStackTrace();
            }
        }
        return empleados;
    }
    
    /**
     * Metodo para obtener los usuarios pertenecientes a una división en la base de datos a partir del id del lider de división
     * ¡¡NOTA!! Este metodo aún no está implementado para funcionar como debería a partir de un usuario, de momento funciona igual a la obtención de usuarios general
     * @param idLider El id del lider de sección.
     * @return  Un ArrayLisy vectorizado que contiene a todos los usuarios de la base de datos
     */
    public static ArrayList<UsuarioEmpleado> obtenerUsuarios(int idLider){
        ArrayList<UsuarioEmpleado> empleados = new ArrayList<UsuarioEmpleado>();
        try{
            con = Conexion.obtenerConexion();
            q = "SELECT * FROM Usuario_empleado"; //por aquí debe de haber un WHERE tal = ?
            ps = con.prepareStatement(q);
            //ps.setInt(1,idLider);
            rs = ps.executeQuery();
            while(rs.next()){
                UsuarioEmpleado empleado = 
                        new UsuarioEmpleado(
                                rs.getInt("ID_usuario_e"), 
                                rs.getString("nombre"), 
                                rs.getString("appat"), 
                                rs.getString("apmat"), 
                                rs.getString("correo"), 
                                rs.getString("fecha_nacimiento"), 
                                rs.getString("pass"), 
                                rs.getInt("ID_Division"), 
                                rs.getInt("ID_cat_privilegios"), 
                                rs.getBytes("foto"));
                empleados.add(empleado);
            }
        }catch(Exception e){
            e.getMessage();
            e.getStackTrace();
            return null;
        }finally{
            try{
                con.close();
                ps.close();
                rs.close();
                q = "";
            }catch(SQLException ex){
                ex.getMessage();
                ex.getStackTrace();
            }
        }
        return empleados;
    }
    
    /**
     * Metodo para obtener todos los usuarios pertenecientes a un equipo. 
     * Ingresar '0' si se desea recuperar los que NO tienen equipo.
     * @param id_equipo El ide del equipo donde se buscaran todos los empleados
     * @return la lista de empleados pertenecientes a un equipo de trabajo.
     */
    public static ArrayList<UsuarioEmpleado> obtenerUsuariosEquipo(int id_equipo){
        ArrayList<UsuarioEmpleado> empleados =  new ArrayList<UsuarioEmpleado>();
        try{
            con = Conexion.obtenerConexion();
            if(id_equipo == 0){
                q = "SELECT * from usuario_empleado where ID_usuario_e \n" +
                    " not in (select ID_Usuario_Empleado from e_usuario_equipo)";
                ps = con.prepareStatement(q);
            }else{
                q = "SELECT usuario_empleado.* FROM usuario_empleado join e_usuario_equipo on ID_Usuario_E = ID_Usuario_Empleado \n" +
                    "where e_usuario_equipo.ID_Equipo = ?;";
                ps = con.prepareStatement(q);
                ps.setInt(1, id_equipo);
            }
            rs = ps.executeQuery();
            while(rs.next()){
                UsuarioEmpleado empleado = 
                        new UsuarioEmpleado(
                                rs.getInt("ID_usuario_e"), 
                                rs.getString("nombre"), 
                                rs.getString("appat"), 
                                rs.getString("apmat"), 
                                rs.getString("correo"), 
                                rs.getString("fecha_nacimiento"), 
                                rs.getString("pass"), 
                                rs.getInt("ID_Division"), 
                                rs.getInt("ID_cat_privilegios"), 
                                rs.getBytes("foto"));
                empleados.add(empleado);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UsuarioEmpleado.class.getName()).log(Level.SEVERE, null, ex);
        }finally{
            try {
                con.close();
                q = "";
                ps.close();
                rs.close();
            } catch (SQLException ex) {
                Logger.getLogger(UsuarioEmpleado.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return empleados;
    }
    
    /**
     * Bueno dios aqui estoy de nuevo, un metodo magico para obtener el 
     * equipo del usuario solo es para hacer las cosas mas sencillas
     * a este paso debo reconocer que la clase usuario va a terminar siendo
     * la clase mas extensa y compleja
     * @param ID_Usuario el id del usuario
     * @return el id del equipo del empleado
     */
    public static int consultarID_Equipo(int ID_Usuario){
        int numero = 0;
                try{
            con = Conexion.obtenerConexion();
            q = "SELECT ID_Equipo FROM e_usuario_equipo WHERE ID_Usuario_Empleado=? limit 1";
            ps= con.prepareStatement(q);
            ps.setInt(1, ID_Usuario);
            rs = ps.executeQuery();
            if(rs.next()){
                numero = rs.getInt("ID_Equipo");
            }
        }catch(SQLException | NullPointerException e){
            System.out.println(e.getMessage());
            e.printStackTrace();
        }finally{
            try {
                con. close();
                q = "";
                rs.close();
            } catch (SQLException | NullPointerException ex) {
                Logger.getLogger(UsuarioEmpleado.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return numero;
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


    public Integer getiDUsuarioE() {
        return iDUsuarioE;
    }

    public void setiDUsuarioE(Integer iDUsuarioE) {
        this.iDUsuarioE = iDUsuarioE;
    }

    public Integer getiD_Division() {
        return iD_Division;
    }

    public void setiD_Division(Integer iD_Division) {
        this.iD_Division = iD_Division;
    }

    public Integer getiD_cat_priv() {
        return iD_cat_priv;
    }

    public void setiD_cat_priv(Integer iD_cat_priv) {
        this.iD_cat_priv = iD_cat_priv;
    }

    
    
    public static Connection getCon() {
        return con;
    }

    public static void setCon(Connection aCon) {
        con = aCon;
    }

    public static String getQ() {
        return q;
    }

    public static void setQ(String aQ) {
        q = aQ;
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
