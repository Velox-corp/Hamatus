/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MDocumentos.Clases;

import ClasesSoporte.Conexion;
import java.io.Serializable;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
public class d_Documento implements Serializable {
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

    private static Connection con = null;
    private String query = "";
    private static PreparedStatement ps = null;
    private static ResultSet rs = null;
    private static final long serialVersionUID = 1L;
    
    public d_Documento(){
        
    }
    
    public d_Documento(int ID){
        this.ID_Documento = ID;
    }
    
    public d_Documento(String nombre, String ruta, String pass, 
            Integer id_tipo_acceso, String folio, Integer Equipo_ID_Equipo, 
            Integer id_MDocumento){
        this.Equipo_ID_Equipo = Equipo_ID_Equipo;
        this.folio = folio;
        this.ruta = ruta;
        this.nombre = nombre;
        this.pass = pass;
        this.id_tipo_acceso = id_tipo_acceso;
        this.id_MDocumento = id_MDocumento; 
    }
    
    /**
     * Aqui va a ir un metodo para registrar una clase del doc
     * @return 
     */
    public boolean registrarDoc(){
        boolean correcto = false;
        //CallableStatement cs = null;
        try {
            this.con = Conexion.obtenerConexion();
            this.query = ("INSERT INTO d_Documento (Ruta, Nombre, Password, Folio, id_tipo_acceso) " + 
                    "VALUES (?, ?, ?, ?, ?)");
            ps = con.prepareCall(query);
            ps.setString(1, this.ruta);
            ps.setString(2, this.nombre);
            ps.setString(3, this.pass);
            ps.setString(4, this.folio);
            ps.setInt(5, this.id_tipo_acceso);
            if(ps.executeUpdate()==1) correcto = true;
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
        return correcto;
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
        if (!(object instanceof d_Documento)) {
            return false;
        }
        d_Documento other = (d_Documento) object;
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
    
}
