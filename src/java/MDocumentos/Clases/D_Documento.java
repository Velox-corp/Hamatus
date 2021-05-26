/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MDocumentos.Clases;

import ClasesSoporte.Conexion;
import ClasesSoporte.Fecha;
import MSeguridad.Clases.AES;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.Hashtable;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

/**
 *
 * @author taspi
 */
@Entity
@Table(name = "d_Documento")
@NamedQueries({
    @NamedQuery(name = "d_Documento.findAll", query = "SELECT e FROM d_Documento e")})
public class D_Documento implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "ID_Documento")
    private Integer ID_Documento;

    private String nombre;
    private String ruta;
    private String pass;
    private Integer id_tipo_acceso;
    private String folio;
    private String fecha;
    private String hora;
    private Integer Equipo_ID_Equipo;
    private Integer id_MDocumento;
    private Integer es_evidencia_flujo;
    private Integer id_cat_clasif_doc;

    private static Connection con = null;
    private String query = "";
    private static PreparedStatement ps = null;
    private static ResultSet rs = null;
    private static final long serialVersionUID = 1L;
    
    public D_Documento(){
        
    }
    
    public D_Documento(int ID){
        this.ID_Documento = ID;
    }
    
    /**
     * Este metodo se dedicara a buscar ese doc que necesitamos, el objeto que 
     * utilice este metodo se converira en ese objeto
     * @param ID
     */
    public void ConsultarD_Doc(int ID){
        boolean correcto = false;
        //CallableStatement cs = null;
        try {
            this.con = Conexion.obtenerConexion();
            this.query = ("SELECT * FROM d_Documento WHERE id_MDocumento=?");
            ps = con.prepareCall(query);
            ps.setInt(1, ID);
            ResultSet res = ps.executeQuery();
            while(res.next()){
                this.setEquipo_ID_Equipo(res.getInt("Equipo_ID_Equipo"));
                this.setFecha(AES.descifrar(res.getBytes("fecha_subida"), 4));
                this.setFolio(AES.descifrar(res.getBytes("Folio"), 4));
                this.setHora(AES.descifrar(res.getBytes("hora_subida"), 4));
                this.setID_Documento(res.getInt("ID_Documento"));
                this.setId_MDocumento(res.getInt("Id_MDocumento"));
                this.setId_tipo_acceso(res.getInt("Id_tipo_acceso"));
                this.setNombre(AES.descifrar(res.getBytes("Nombre"), 4));
                this.setPass(AES.descifrar(res.getBytes("Password"), 4));
                this.setRuta(AES.descifrar(res.getBytes("Ruta"), 4));
                this.setEs_evidencia_flujo(res.getInt("es_evidencia_flujo"));
                this.setId_cat_clasif_doc(res.getInt("id_cat_clasif_doc"));
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        } finally{
            try {
                this.con.close();
                this.ps.close();
            } catch (SQLException ex) {
                Logger.getLogger(D_Documento.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
    
    /**
     * Otra manera de hacer lo mismo pero diferente
     * @param ID_e del equipo
     * @param fileName
     */
    public void ConsultarD_Doc(int ID_e, String fileName){
        boolean correcto = false;
        //CallableStatement cs = null;
        try {
            D_Documento.con = Conexion.obtenerConexion();
            this.query = ("SELECT * FROM d_Documento WHERE equipo_id_equipo=? AND nombre=?");
            ps = con.prepareCall(query);
            ps.setInt(1, ID_e);
            ps.setBytes(2, AES.cifrar(fileName, 4));
            ResultSet res = ps.executeQuery();
            while(res.next()){
                System.out.println("Documento encontrado");
                this.setEquipo_ID_Equipo(res.getInt("Equipo_ID_Equipo"));
                this.setFecha(AES.descifrar(res.getBytes("fecha_subida"), 4));
                this.setFolio(AES.descifrar(res.getBytes("Folio"), 4));
                this.setHora(AES.descifrar(res.getBytes("hora_subida"), 4));
                this.setID_Documento(res.getInt("ID_Documento"));
                this.setId_MDocumento(res.getInt("Id_MDocumento"));
                this.setId_tipo_acceso(res.getInt("Id_tipo_acceso"));
                this.setNombre(AES.descifrar(res.getBytes("Nombre"), 4));
                this.setPass(AES.descifrar(res.getBytes("Password"), 4));
                this.setRuta(AES.descifrar(res.getBytes("Ruta"), 4));
                this.setEs_evidencia_flujo(res.getInt("es_evidencia_flujo"));
                this.setId_cat_clasif_doc(res.getInt("id_cat_clasif_doc"));
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }finally{
            try{
                con.close();
                ps.close();
            }catch(SQLException exe){
                exe.getMessage();
                exe.getStackTrace();
            }
        }
    }
    
    /**
     * Sirve para confirmar que existe cierto doc
     * @param ID_equipo
     * @param fileName
     * @return 
     */
    public static boolean ConsultarD_Doc_B(int ID_equipo, String fileName){
        boolean correcto = false;
        //CallableStatement cs = null;
        try {
            con = Conexion.obtenerConexion();
            String query = ("SELECT * FROM d_Documento WHERE equipo_id_equipo=? AND nombre=?");
            ps = con.prepareCall(query);
            ps.setInt(1, ID_equipo);
            ps.setBytes(2, AES.cifrar(fileName, 4));
            ResultSet res = ps.executeQuery();
            if (res.next()) {
                correcto=true;
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }finally{
            try{
                con.close();
                ps.close();
            }catch(SQLException exe){
                exe.getMessage();
                exe.getStackTrace();
            }
        }
        
        return correcto;
    }
    
    public static D_Documento ConsultarD_Doc_sget(int ID_equipo, String fileName){
        D_Documento ddoc = new D_Documento();
        //CallableStatement cs = null;
        try {
            Connection con = Conexion.obtenerConexion();
            String query = ("SELECT * FROM d_Documento WHERE equipo_id_equipo=? AND nombre=?");
            ps = con.prepareCall(query);
            ps.setInt(1, ID_equipo);
            ps.setBytes(2, AES.cifrar(fileName, 4));
            ResultSet res = ps.executeQuery();
            if (res.next()) {
                ddoc.setFecha(AES.descifrar(res.getBytes("fecha_subida"), 4));
                ddoc.setEquipo_ID_Equipo(res.getInt("Equipo_ID_Equipo"));
                ddoc.setFolio(AES.descifrar(res.getBytes("Folio"), 4));
                ddoc.setHora(AES.descifrar(res.getBytes("hora_subida"), 4));
                ddoc.setID_Documento(res.getInt("ID_Documento"));
                ddoc.setId_MDocumento(res.getInt("Id_MDocumento"));
                ddoc.setId_tipo_acceso(res.getInt("Id_tipo_acceso"));
                ddoc.setNombre(AES.descifrar(res.getBytes("Nombre"), 4));
                ddoc.setPass(AES.descifrar(res.getBytes("Password"), 4));
                ddoc.setRuta(AES.descifrar(res.getBytes("Ruta"), 4));
                ddoc.setEs_evidencia_flujo(res.getInt("es_evidencia_flujo"));
                ddoc.setId_cat_clasif_doc(res.getInt("id_cat_clasif_doc"));
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }finally{
            try{
                con.close();
                ps.close();
            }catch(SQLException exe){
                exe.getMessage();
                exe.getStackTrace();
            }
        }
        
        return ddoc;
    }
    
    /**
     * Como contruir un objeto ddoc atraves de estos parametros
     * @param nombre
     * @param ruta
     * @param pass
     * @param id_tipo_acceso
     * @param folio
     * @param Equipo_ID_Equipo
     * @param id_MDocumento
     * @param es_evidencia_flujo
     * @param id_cat_clasif_doc
     */
    public D_Documento(String nombre, String ruta, String pass, 
            Integer id_tipo_acceso, String folio, Integer Equipo_ID_Equipo, 
            Integer id_MDocumento, Integer es_evidencia_flujo, Integer id_cat_clasif_doc){
        this.Equipo_ID_Equipo = Equipo_ID_Equipo;
        this.folio = folio;
        this.ruta = ruta;
        this.nombre = nombre;
        this.pass = pass;
        this.id_tipo_acceso = id_tipo_acceso;
        this.id_MDocumento = id_MDocumento;
        this.es_evidencia_flujo = es_evidencia_flujo;
        this.id_cat_clasif_doc = id_cat_clasif_doc;
    }
    
    /**
     * Aqui va a ir un metodo para registrar una clase del doc
     * @return boolean false es que no lo registro, true si lo logro registrar
     */
    public boolean registrarDoc(){
        boolean correcto = false;
        Calendar c = new GregorianCalendar();
        try {
            this.con = Conexion.obtenerConexion();
            this.query = ("INSERT INTO d_Documento (Ruta, Nombre, Password,"
                    + " Folio, id_tipo_acceso, fecha_subida, hora_subida, "
                    + "id_MDocumento, Equipo_ID_Equipo, es_evidencia_flujo,"
                    + " id_cat_clasif_doc) " 
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
            ps = con.prepareCall(query);
            ps.setBytes(1, AES.cifrar(this.ruta, 4));
            ps.setBytes(2, AES.cifrar(this.nombre, 4));
            ps.setBytes(3, AES.cifrar(this.pass, 4));
            ps.setBytes(4, AES.cifrar(this.folio, 4));
            ps.setInt(5, this.id_tipo_acceso);
            String fechaS = Fecha.FechaBD();
            ps.setBytes(6, AES.cifrar(fechaS, 4));
            String hora = c.get(Calendar.HOUR) + ":" + c.get(Calendar.MINUTE) + 
                    ":" + c.get(Calendar.SECOND);
            ps.setBytes(7, AES.cifrar(hora, 4));
            ps.setInt(8, this.id_MDocumento); 
            ps.setInt(9, this.Equipo_ID_Equipo);
            ps.setInt(10, this.es_evidencia_flujo);
            ps.setInt(11, this.id_cat_clasif_doc);
            if(ps.executeUpdate()==1) correcto = true;
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        } finally{
            try {
                this.con.close();
                this.ps.close();
            } catch (SQLException ex) {
                Logger.getLogger(D_Documento.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return correcto;
    }
    
    /**
     * Bueno bueno aqui ira una parte para borrar cierto documento
     * *Nota*:Este metodo solo borrara su registro de la BD solo para 
     * que el archivo sea inaccesible unciamente 
     * @param id_MDocumento
     * @return 
     */
    public boolean BorrarDoc( int id_MDocumento ){
        boolean correcto = false;
        //CallableStatement cs = null;
        try {
            this.con = Conexion.obtenerConexion();
            this.query = ("DELETE FROM d_documento WHERE id_MDocumento=?");
            ps = con.prepareCall(query);
            ps.setInt(1, id_MDocumento);
            if(ps.executeUpdate()==1) correcto = true;
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        } finally{
            try {
                this.con.close();
                this.ps.close();
            } catch (SQLException ex) {
                Logger.getLogger(D_Documento.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return correcto;
    }
    
    /**
     * Bueno bueno aqui ira una parte para borrar cierto documento
     * *Nota*:Este metodo solo borrara su registro de la BD solo para 
     * que el archivo sea inaccesible unciamente 
     * @return 
     */
    public boolean BorrarDoc(){
        boolean correcto = false;
        //CallableStatement cs = null;
        try {
            this.con = Conexion.obtenerConexion();
            this.query = ("DELETE FROM d_documento WHERE ID_Documento=?");
            ps = con.prepareCall(query);
            ps.setInt(1, this.ID_Documento);
            if(ps.executeUpdate()==1) correcto = true;
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        } finally{
            try {
                this.con.close();
                this.ps.close();
            } catch (SQLException ex) {
                Logger.getLogger(D_Documento.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return correcto;
    }
    
    /**
     * Actualizar parte del doc
     * @param nombre
     * @param ruta: hay que tener cuidado con este primero hay que mover el archivo
     * y despues actualizarlo con este metodo si se hace eso
     * @param pass
     * @param id_tipo_acceso
     * @param es_evidencia_flujo
     * @param id_cat_clasif_doc
     * @param folio
     * @param ID_Documento el unico que realmente importa es este
     * @return 
     */
    public boolean UpdateDoc(String nombre, String pass, 
            Integer id_tipo_acceso, Integer ID_Documento, 
            Integer es_evidencia_flujo, Integer id_cat_clasif_doc){
        boolean correcto = false;
        //CallableStatement cs = null;
        try {
            this.con = Conexion.obtenerConexion();
            this.query = ("UPDATE d_Documento SET Nombre=?, Password=?,"
                    + " id_tipo_acceso=?, es_evidencia_flujo=?, id_cat_clasif_doc=? WHERE ID_Documento=?");
            ps = con.prepareCall(query);
            ps.setBytes(1, AES.cifrar(nombre, 4));
            ps.setBytes(2, AES.cifrar(pass, 4));
            ps.setInt(3, id_tipo_acceso);
            ps.setInt(4, es_evidencia_flujo);
            ps.setInt(5, id_cat_clasif_doc);
            ps.setInt(6, ID_Documento);
            ps.execute();
            correcto = true;
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        } finally{
            try {
                this.con.close();
                ps.close();
            } catch (SQLException ex) {
                Logger.getLogger(D_Documento.class.getName()).log(Level.SEVERE, null, ex);
            } catch(Exception e){
                System.out.println(e.getMessage());
                e.printStackTrace();
            }   
        }
        return correcto;
    }
    
    /**
     * Este es un metodo de consula a la BD rapida para ver todos 
     * los permisos con sus categorias
     * @return una lista con el id y la descrición de su acceso
     */
    public static Hashtable<Integer, String> consultarCat_Tipo_Acceso(){
        Hashtable<Integer, String> list = new Hashtable<Integer, String>();
        String q;
        try{
            con = Conexion.obtenerConexion();
            q = "SELECT * FROM cat_tipo_acceso"; //por aquí debe de haber un WHERE tal = ?
            ps = con.prepareStatement(q);
            rs = ps.executeQuery();
            while(rs.next()){
                list.put(rs.getInt("idC_tipo_acceso"),
                rs.getString("nombre_tipo_acceso"));
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
        return list;
    }
    
    public static Connection getCon() {
        return con;
    }

    public static void setCon(Connection aCon) {
        con = aCon;
    }

    public String getQuery() {
        return query;
    }

    public void setQuery(String aQuery) {
        query = aQuery;
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
    
    

    public Integer getId() {
        return ID_Documento;
    }

    public void setId(Integer id) {
        this.ID_Documento = id;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (ID_Documento != null ? ID_Documento.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof D_Documento)) {
            return false;
        }
        D_Documento other = (D_Documento) object;
        if ((this.ID_Documento == null && other.ID_Documento != null) || (this.ID_Documento != null && !this.ID_Documento.equals(other.ID_Documento))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "MDocumentos.Clases.d_Documento[ id=" + ID_Documento + " ]";
    }

    public Integer getID_Documento() {
        return ID_Documento;
    }

    public void setID_Documento(Integer ID_Documento) {
        this.ID_Documento = ID_Documento;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getRuta() {
        return ruta;
    }

    public void setRuta(String ruta) {
        this.ruta = ruta;
    }

    public String getPass() {
        return pass;
    }

    public void setPass(String pass) {
        this.pass = pass;
    }

    public Integer getId_tipo_acceso() {
        return id_tipo_acceso;
    }

    public void setId_tipo_acceso(Integer id_tipo_acceso) {
        this.id_tipo_acceso = id_tipo_acceso;
    }

    public String getFolio() {
        return folio;
    }

    public void setFolio(String folio) {
        this.folio = folio;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public String getHora() {
        return hora;
    }

    public void setHora(String hora) {
        this.hora = hora;
    }

    public Integer getEquipo_ID_Equipo() {
        return Equipo_ID_Equipo;
    }

    public void setEquipo_ID_Equipo(Integer Equipo_ID_Equipo) {
        this.Equipo_ID_Equipo = Equipo_ID_Equipo;
    }

    public Integer getId_MDocumento() {
        return id_MDocumento;
    }

    public void setId_MDocumento(Integer id_MDocumento) {
        this.id_MDocumento = id_MDocumento;
    }

    public Integer getEs_evidencia_flujo() {
        return es_evidencia_flujo;
    }

    public void setEs_evidencia_flujo(Integer es_evidencia_flujo) {
        this.es_evidencia_flujo = es_evidencia_flujo;
    }

    public Integer getId_cat_clasif_doc() {
        return id_cat_clasif_doc;
    }

    public void setId_cat_clasif_doc(Integer id_cat_clasif_doc) {
        this.id_cat_clasif_doc = id_cat_clasif_doc;
    }
    
}
