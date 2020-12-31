/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MDivisiones.clases;

import ClasesSoporte.Conexion;
import MUsuarios.clases.UsuarioEmpleado;
import java.io.IOException;
import java.io.InputStream;
import java.io.Serializable;
import java.sql.CallableStatement;
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
 *
 * @author alis0
 */
@Entity
@Table(name = "division")
@NamedQueries({
    @NamedQuery(name = "division.findAll", query = "SELECT d FROM Division d")})
public class Divisiones implements Serializable{

    static Connection con = null;
    static String query = "";
    static PreparedStatement ps = null;
    static ResultSet rs = null;
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "ID-Division")
    private int IDDivision;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "Nombre")
    private String nombre;
    @Basic(optional = false)
    @NotNull
    @Lob
    @Size(min = 1, max = 16777215)
    @Column(name = "ID-Jerarquia")
    private Integer IDJerarquia;
    @Column(name = "ID-Empresa")
    private Integer IDEmpresa;

    public Divisiones() {
    }

    public Divisiones(Integer IDDivision) {
        this.IDDivision = IDDivision;
    }

    public Divisiones(int IDDivision, String nombre, int IDJerarquia, int IDEmpresa) throws IOException{
        this.IDDivision = IDDivision;
        this.nombre = nombre;
        this.IDJerarquia = IDJerarquia;
        this.IDEmpresa = IDEmpresa;
    }
    
    public Divisiones(String nombre, int IDJerarquia, int IDEmpresa) throws IOException{
        this.nombre = nombre;
        this.IDJerarquia = IDJerarquia;
        this.IDEmpresa = IDEmpresa;
    }

    public static boolean crearDivisiones(Divisiones div, int id_emp){
        int idj = 2;
        try{
            con = Conexion.obtenerConexion();
            String q = "INSERT INTO division (Nombre_A, ID_Jerarquia, ID_Empresa) values(?,?,?)";
            ps = con.prepareCall(q);
            ps.setString(1, div.getNombre());
            ps.setInt(2, idj);
            ps.setInt(3, id_emp);
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(Divisiones.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println("No jalo el query");
            System.out.println("Error: "+ex.getCause());
            return false;
        }finally{
            try {
                con. close();
                ps.close();
                String q = "";
            } catch (SQLException | NullPointerException ex) {
                Logger.getLogger(Divisiones.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    public static Connection getCon() {
        return con;
    }

    public static void setCon(Connection con) {
        Divisiones.con = con;
    }

    public static String getQuery() {
        return query;
    }

    public static void setQuery(String query) {
        Divisiones.query = query;
    }

    public static PreparedStatement getPs() {
        return ps;
    }

    public static void setPs(PreparedStatement ps) {
        Divisiones.ps = ps;
    }

    public static ResultSet getRs() {
        return rs;
    }

    public static void setRs(ResultSet rs) {
        Divisiones.rs = rs;
    }

    public Integer getIDDivision() {
        return IDDivision;
    }

    public void setIDDivision(Integer IDDivision) {
        this.IDDivision = IDDivision;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public Integer getIDJerarquia() {
        return IDJerarquia;
    }

    public void setIDJerarquia(Integer IDJerarquia) {
        this.IDJerarquia = IDJerarquia;
    }

    public Integer getIDEmpresa() {
        return IDEmpresa;
    }

    public void setIDEmpresa(Integer IDEmpresa) {
        this.IDEmpresa = IDEmpresa;
    }
    
    
}
