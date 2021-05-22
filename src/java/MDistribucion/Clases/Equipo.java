/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MDistribucion.Clases;

import ClasesSoporte.Conexion;
import MSeguridad.Clases.AES;
import java.io.Serializable;
import java.util.Collection;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.sql.*;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
/**
 * Clase/entidad de equipo, util para crear un equipo en bruto (aquí no se ingresan los usuarios) y se desapareció
 * @author el Damián
 */
@Entity
@Table(name = "equipo", catalog = "hamatus", schema = "")
@NamedQueries({
    @NamedQuery(name = "Equipo.findAll", query = "SELECT e FROM Equipo e")})
public class Equipo implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "ID_Equipo")
    private Integer iDEquipo;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 45)
    @Column(name = "Nombre")
    private String nombre;
    @Basic(optional = false)
    @NotNull
    @Column(name = "ID_Division")
    private int iDDivision;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "iDEquipo")
    private Collection<EUsuarioEquipo> eUsuarioEquipoCollection;

    private static Connection con;
    private static  String q;
    private static PreparedStatement ps;
    private static ResultSet rs;
    private static CallableStatement cs;
    
    public Equipo() {
    }

    public Equipo(Integer iDEquipo) {
        this.iDEquipo = iDEquipo;
    }

    /**
     * Metodo de construcción de equipo, se usara para crear objetos de equipos a partir de querys
     * @param iDEquipo: El ide del equipo
     * @param nombre: El nombre del equipo
     * @param iDDivision: EL ide de la división a la que pertenece
     */
    public Equipo(Integer iDEquipo, String nombre, int iDDivision) {
        this.iDEquipo = iDEquipo;
        this.nombre = nombre;
        this.iDDivision = iDDivision;
    }
    /**
     * Método de instancía de Equipo, con el cual se van a crear los equipos, ya que el ide es auto_increment
     * @param nombre: El nombre del equipo a crear
     * @param idDivision: La división a la que pertenece el equipo 
     */
    public Equipo(String nombre, int idDivision){
        this.nombre = nombre;
        this.iDDivision = idDivision;
    }
    
    /**
     * Método para guardar un equipo en la base de datos
     * @param equipoInsert: EL equipo a ser insertado
     * @return true si se ingreso correctamente el equipo
     */
    public static boolean crearEquipo(Equipo equipoInsert){
        boolean proceso_correcto = true;
        try{
            con = Conexion.obtenerConexion();
            q = "{call crearEquipo(?,?)}";
            cs = con.prepareCall(q);
            cs.setBytes(1,AES.cifrar(equipoInsert.getNombre(),3));
            cs.setInt(2, equipoInsert.getIDDivision());
            if(cs.executeUpdate() == 1){
                proceso_correcto = true;
            }else{
                proceso_correcto = false;
                System.out.println("No jalo");
            }
        } catch (SQLException ex) {
            Logger.getLogger(Equipo.class.getName()).log(Level.SEVERE, null, ex);
            proceso_correcto = false;
        }finally{
            try {
                con.close();
                q = "";
                cs.close();
            } catch (SQLException ex) {
                Logger.getLogger(Equipo.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return proceso_correcto;
    }
    
     /**
     * Método para obtener el ide del ultimo equipo registrado, ya que este es auto_increment.
     * Y como parte del modulo del chat, incluye el ultimo id de la sala registrada para poder hacer registros de los usuarios a la sala
     * Si ocurre algún error va retornar -1.
     * @return id 
     */
    public static int[] obtenerIDNuevoEquipo() {
        int ides[] = new int[2];
        try{
            con = Conexion.obtenerConexion();
            q = "SELECT MAX(id_equipo) as idE, MAX(idSala_chat) as idSC  from sala_chat, equipo";
            ps = con.prepareStatement(q);
            rs = ps.executeQuery();
            if(rs.next()){
                ides[0] = rs.getInt("idE");
                ides[1] = rs.getInt("idSC");
            }
        } catch (SQLException ex) {
            Logger.getLogger(Equipo.class.getName()).log(Level.SEVERE, null, ex);
            return new int[] {-1,-1};
        }finally{
            try {
                con.close();
                ps.close();
                q="";
                rs.close();
            } catch (SQLException ex) {
                Logger.getLogger(Equipo.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return ides;
    }
    
    /**
     * Método para obtener los equipos pertenecientes a una división
     * @param id_div: ide de la división del equipo
     * @return: ArrayList de todos los equipos
     */
    public static ArrayList<Equipo> obtenerEquipos(int id_div){
        ArrayList<Equipo> equipos = new ArrayList<Equipo>();
        try{
            con = Conexion.obtenerConexion();
            q = "SELECT * FROM Equipo WHERE ID_DIvision = ?";
            ps = con.prepareStatement(q);
            ps.setInt(1, id_div);
            rs = ps.executeQuery();
            while(rs.next()){
                Equipo equipo = new Equipo(rs.getInt("ID_Equipo"),
                        AES.descifrar(rs.getBytes("Nombre"),3), 
                rs.getInt("ID_DIvision"));
                equipos.add(equipo);
            }
        } catch (SQLException ex) {
            Logger.getLogger(Equipo.class.getName()).log(Level.SEVERE, null, ex);
            equipos = null;
        }finally{
            try {
                con.close();
                q= "";
                ps.close();
                rs.close();
            } catch (SQLException ex) {
                Logger.getLogger(Equipo.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return equipos;     
    }
    
    
    public static ArrayList<Equipo> obtenerAllEquipos(int idemp){
        ArrayList<Equipo> equipos = new ArrayList<Equipo>();
        try{
            con = Conexion.obtenerConexion();
            q = "SELECT Equipo.* FROM Equipo JOIN Division ON equipo.ID_Division = division.ID_Division WHERE division.ID_Empresa = ?";
            ps = con.prepareStatement(q);
            ps.setInt(1, idemp);
            rs = ps.executeQuery();
            while(rs.next()){
                Equipo equipo = new Equipo(rs.getInt("ID_Equipo"),
                        AES.descifrar(rs.getBytes("Nombre"),3), 
                rs.getInt("ID_Division"));
                equipos.add(equipo);
            }
        } catch (SQLException ex) {
            Logger.getLogger(Equipo.class.getName()).log(Level.SEVERE, null, ex);
            equipos = null;
        }finally{
            try {
                con.close();
                q= "";
                ps.close();
                rs.close();
            } catch (SQLException ex) {
                Logger.getLogger(Equipo.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return equipos;     
    }
    
    
    /**
     * Obtener un equipo dado su ide.
     * @param id_equipo el ide del equipo.
     * @return El equipo buscado.
     */
    public static Equipo obtenerEquipo(int id_equipo){
        Equipo equipoBuscado = null;
        try{
            con = Conexion.obtenerConexion();
            q = "SELECT * FROM equipo where ID_Equipo = ?";
            ps = con.prepareStatement(q);
            ps.setInt(1, id_equipo);
            rs = ps.executeQuery();
            if(rs.next()){
                    equipoBuscado = new Equipo(rs.getInt("ID_Equipo"),
                            AES.descifrar(rs.getBytes("Nombre"),3),  
                    rs.getInt("ID_Division"));
                }
        } catch (SQLException ex) {
            Logger.getLogger(Equipo.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }finally{
            try {
                con.close();
                q= "";
                ps.close();
                rs.close();
            } catch (SQLException ex) {
                Logger.getLogger(Equipo.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return equipoBuscado;
    }
    
    public static boolean eliminarEquipo(int id_equipo, int idSala){
        boolean proceso_adecuado = true;
        try{
            con = Conexion.obtenerConexion();
            q = "{call deleteEquipo(?,?)}";
            cs = con.prepareCall(q);
            cs.setInt(1,id_equipo);
            cs.setInt(2,idSala);
            if(cs.executeUpdate() == 1){
                proceso_adecuado = true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(Equipo.class.getName()).log(Level.SEVERE, null, ex);
            proceso_adecuado = false;
        }finally{
            try {
                con.close();
                q= "";
                cs.close();
            } catch (SQLException ex) {
                Logger.getLogger(Equipo.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return proceso_adecuado;
    }
    
    public static int getIdSala(int idEquipo){
        int ids = -1;
        try{
            con = Conexion.obtenerConexion();
            q = "select sala_chat.idSala_chat from sala_chat join e_usuario_sala on idSala_chat = id_sala " +
                "where id_usuario in (select ID_Usuario_Empleado from e_usuario_equipo where ID_Equipo = ?);";
            ps = con.prepareStatement(q);
            ps.setInt(1, idEquipo);
            rs = ps.executeQuery();
            if(rs.next()){
                ids = rs.getInt("idSala_chat");
            }
        } catch (SQLException ex) {
            Logger.getLogger(Equipo.class.getName()).log(Level.SEVERE, null, ex);
            return -1;
        }finally{
            try {
                con.close();
                ps.close();
                q="";
                rs.close();
            } catch (SQLException ex) {
                Logger.getLogger(Equipo.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return ids;
    }
    
    /**
     * Metodo para cambiar el nombre de un equipo
     * @param newName el nuevo nombre del equipo
     * @return true si se ejecuta el cambio con exito
     */
    public static boolean editName(String newName, int idE) {
        boolean proceso_adecuado = true;
        try{
            con = Conexion.obtenerConexion();
            q = "UPDATE equipo SET Nombre = ? WHERE ID_Equipo = ?";
            ps = con.prepareStatement(q);
            ps.setBytes(1,AES.cifrar(newName, 3));
            ps.setInt(2, idE);
            if(ps.executeUpdate() == 1){
                proceso_adecuado = true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(Equipo.class.getName()).log(Level.SEVERE, null, ex);
            proceso_adecuado = false;
        }finally{
            try {
                con.close();
                q= "";
                ps.close();
            } catch (SQLException ex) {
                Logger.getLogger(Equipo.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return proceso_adecuado;
    }
    
    public Integer getIDEquipo() {
        return iDEquipo;
    }

    public void setIDEquipo(Integer iDEquipo) {
        this.iDEquipo = iDEquipo;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public int getIDDivision() {
        return iDDivision;
    }

    public void setIDDivision(int iDDivision) {
        this.iDDivision = iDDivision;
    }

    public Collection<EUsuarioEquipo> getEUsuarioEquipoCollection() {
        return eUsuarioEquipoCollection;
    }

    public void setEUsuarioEquipoCollection(Collection<EUsuarioEquipo> eUsuarioEquipoCollection) {
        this.eUsuarioEquipoCollection = eUsuarioEquipoCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (iDEquipo != null ? iDEquipo.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Equipo)) {
            return false;
        }
        Equipo other = (Equipo) object;
        if ((this.iDEquipo == null && other.iDEquipo != null) || (this.iDEquipo != null && !this.iDEquipo.equals(other.iDEquipo))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "MDistribucion.Clases.Equipo[ iDEquipo=" + iDEquipo + " ]";
    }
    
}
