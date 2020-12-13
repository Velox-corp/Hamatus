/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MDistribucion.Clases;

import ClasesSoporte.Conexion;
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
 * Clase/entidad de equipo, util para crear un equipo en bruto (aquí no se ingresan los usuarios)
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
     * @param equipoInsert
     * @return 
     */
    public static boolean crearEquipo(Equipo equipoInsert){
        boolean proceso_correcto = true;
        try{
            con = Conexion.obtenerConexion();
            q = "INSERT INTO EQUIPO (nombre, idDivision) values(?,?)";
            ps = con.prepareStatement(q);
            ps.setString(1,equipoInsert.getNombre());
            ps.setInt(2, equipoInsert.iDDivision);
            proceso_correcto = (1 == ps.executeUpdate());
        } catch (SQLException ex) {
            Logger.getLogger(Equipo.class.getName()).log(Level.SEVERE, null, ex);
            proceso_correcto = false;
        }finally{
            try {
                con.close();
                q = "";
                ps.close();
            } catch (SQLException ex) {
                Logger.getLogger(Equipo.class.getName()).log(Level.SEVERE, null, ex);
                proceso_correcto = false;
            }
        }
        return proceso_correcto;
    }
    
    /**
     * Método para obtener los equipos pertenecientes a una división
     * @param id_div: ide de la división del equipo
     * @return: ArrayList de todos los equipos
     */
    public static ArrayList<Equipo> obtenerEquipos(int id_div){
        ArrayList<Equipo> equipos = new ArrayList<Equipo>();
        
        return equipos;     
    }
    
    public static Equipo obtenerEquipo(int id_equipo){
        Equipo equipoBuscado = null;
        return equipoBuscado;
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
