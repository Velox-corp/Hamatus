/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MDivisiones.clases;

import ClasesSoporte.Conexion;
import MSeguridad.Clases.AES;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
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
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

/**
 *
 * @author alis0
 */

@Entity
@Table(name = "division")
@NamedQueries({
    @NamedQuery(name = "Division.findAll", query = "SELECT d FROM Division d")})
public class Division implements Serializable{
    
    private static Connection con;
    private static String q = "";
    static String query = "";
    private static PreparedStatement ps = null;
    private static ResultSet rs = null;
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "ID_Division")
    private Integer id_Division;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "Nombre_A")
    private String nombre;
    @Basic(optional = false)
    @NotNull
    @Lob
    @Size(min = 1, max = 16777215)
    @Column(name = "ID_Jerarquia")
    private Integer id_Jerarquia;
    @Column(name = "ID_Empresa")
    private Integer id_Empresa;
    
    public Division() {
    }

    public Division(Integer id_Division) {
        this.id_Division = id_Division;
    }
    
    //Constructores de Division
    /**
     * Constructor de Cuenta de administración
     * @param nombre Nombre de division
     */
    public Division(String nombre) {
        this.nombre = nombre;
    }
    
    /**
     * Metodo de creación de division
     * @param id_division: Ide de la division
     * @param nombre: nombre de la division
     * @param id_j: El ide de la jerarquia a la que pertenece
     * @param id_emp: El id de la empresa correspondiente
     */
    public Division(int id_division, int id_emp) {
        this.id_Division = id_division;
        this.nombre = nombre;
    }
    
    public Division(int id_division, String nombre, int id_j, int id_emp) {
        this.id_Division = id_division;
        this.nombre = nombre;
        this.id_Jerarquia = id_j;
        this.id_Empresa = id_emp;
    }
    
    public static boolean crearDivision(Division div, int id_emp){
        boolean procesoCorrecto = true;
        int idj = 2;
        try{
            Division.con = Conexion.obtenerConexion();
            Division.query = ("INSERT INTO division (Nombre_A, ID_Jerarquia, ID_Empresa) values(?,?,?)");
            System.out.println("------------------------");
            System.out.println(div.getNombre() + "" + idj + "" + id_emp);
            ps = con.prepareStatement(Division.query);
            ps.setString(1, div.getNombre());
            ps.setInt(2, idj);
            ps.setInt(3, id_emp);
            
           if(ps.executeUpdate()==1) procesoCorrecto = true;
           else procesoCorrecto = false;
        }catch(Exception e){
            procesoCorrecto = false;
            System.out.println("Error: "+e.getCause());
            e.printStackTrace();
        }
        finally{
            try {
                Division.ps.close();
                Division.con.close();
                
            } catch (SQLException ex) {
                Logger.getLogger(Division.class.getName()).log(Level.SEVERE, null, ex);
                procesoCorrecto = false;
            }
        }
        return procesoCorrecto;
    }
    
    public static ArrayList<Division> obtenerDivisiones(int id_emp){
        ArrayList<Division> divisiones = new ArrayList<Division>();
        try{
            con = Conexion.obtenerConexion();
            q = "SELECT * FROM division WHERE ID_Empresa = ?";
            ps = con.prepareStatement(q);
            ps.setInt(1, id_emp);
            rs = ps.executeQuery();
            while(rs.next()){
                Division div = new Division(rs.getInt("ID_Division"),rs.getString("Nombre_A"),rs.getInt("ID_Jerarquia"),rs.getInt("ID_Empresa"));
                divisiones.add(div);
            }
        } catch (SQLException ex) {
            Logger.getLogger(Division.class.getName()).log(Level.SEVERE, null, ex);
            divisiones = null;
        }finally{
            try {
                con.close();
                q= "";
                ps.close();
                rs.close();
            } catch (SQLException ex) {
                Logger.getLogger(Division.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return divisiones;     
    }
    
    public static boolean eliminarDivision(Division div, int id_emp){
        boolean procesoCorrecto = true;
        try{
            Division.con = Conexion.obtenerConexion();
            Division.query = ("DELETE FROM division WHERE ID_Division=? AND ID_Empresa=?");
            ps = con.prepareStatement(Division.query);
            ps.setInt(1, div.getId_Division());
            ps.setInt(2, id_emp);
            
           if(ps.executeUpdate()==1) procesoCorrecto = true;
           else procesoCorrecto = false;
        }catch(Exception e){
            procesoCorrecto = false;
            System.out.println("Error: "+e.getCause());
            e.printStackTrace();
        }
        finally{
            try {
                Division.ps.close();
                Division.con.close();
                
            } catch (SQLException ex) {
                Logger.getLogger(Division.class.getName()).log(Level.SEVERE, null, ex);
                procesoCorrecto = false;
            }
        }
        return procesoCorrecto;
    }
    
    public static int IDDivision(Division div, int id_emp){
        int idDiv = -1;
        try{
            Division.con = Conexion.obtenerConexion();
            Division.query = ("SELECT ID_Division FROM division WHERE Nombre_A = ? AND ID_Empresa = ?");
            ps = con.prepareStatement(Division.query);
            ps.setString(1, div.getNombre());
            ps.setInt(2, id_emp);
            rs = ps.executeQuery();
            if(rs.next()){
                idDiv = rs.getInt("ID_Division");
            }else{
                idDiv = -1;
            }
        }catch(Exception e){
            idDiv = -1;
            System.out.println("Error: "+e.getCause());
            e.printStackTrace();
        }
        finally{
            try {
                Division.ps.close();
                Division.con.close();
                
            } catch (SQLException ex) {
                Logger.getLogger(Division.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return idDiv;
    }
    
    public static String traducirID(int id_emp){
        String nombreD = "";
        try{
            Division.con = Conexion.obtenerConexion();
            Division.query = ("SELECT Nombre_A FROM division WHERE ID_Empresa = ?");
            ps = con.prepareStatement(Division.query);
            ps.setInt(1, id_emp);
            
            if(rs.next()){
                nombreD = rs.getString("Nombre_A");
                
            }else{
                nombreD="";
            }
        }catch(Exception e){
            System.out.println("Error: "+e.getCause());
            e.printStackTrace();
        }
        finally{
            try {
                Division.ps.close();
                Division.con.close();
                
            } catch (SQLException ex) {
                Logger.getLogger(Division.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return nombreD;
    }
    
    public List lista(int id_emp) {
        List<divi> divisiones = new ArrayList();
        int idj = 2;
        try {
            con = Conexion.obtenerConexion();
            Division.query = ("SELECT * FROM division WHERE ID_Jerarquia = ? AND ID_Empresa = ?");
            ps = con.prepareStatement(Division.query);
            ps.setInt(1, idj);
            ps.setInt(2, id_emp);          
            rs = ps.executeQuery();
            while (rs.next()) {
                divi p =new divi();
                p.setId(rs.getInt(1));
                p.setNombre(rs.getString(2));
                p.setIdj(rs.getInt(3));
                p.setIde(rs.getInt(4));
                divisiones.add(p);
            }
        } catch (SQLException ex) {
            System.out.println("Ocurrio un error Division");
            Logger.getLogger(Division.class.getName()).log(Level.SEVERE, null, ex);
            divisiones = null;
        }
        return divisiones;
    }
    
    public static Connection getCon() {
        return con;
    }

    public static void setCon(Connection con) {
        Division.con = con;
    }

    public static String getQ() {
        return q;
    }

    public static void setQ(String q) {
        Division.q = q;
    }

    public static String getQuery() {
        return query;
    }

    public static void setQuery(String query) {
        Division.query = query;
    }

    public static PreparedStatement getPs() {
        return ps;
    }

    public static void setPs(PreparedStatement ps) {
        Division.ps = ps;
    }

    public static ResultSet getRs() {
        return rs;
    }

    public static void setRs(ResultSet rs) {
        Division.rs = rs;
    }

    public Integer getId_Division() {
        return id_Division;
    }

    public void setId_Division(Integer id_Division) {
        this.id_Division = id_Division;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public Integer getId_Jerarquia() {
        return id_Jerarquia;
    }

    public void setId_Jerarquia(Integer id_Jerarquia) {
        this.id_Jerarquia = id_Jerarquia;
    }

    public Integer getId_Empresa() {
        return id_Empresa;
    }

    public void setId_Empresa(Integer id_Empresa) {
        this.id_Empresa = id_Empresa;
    }
    
    
}
