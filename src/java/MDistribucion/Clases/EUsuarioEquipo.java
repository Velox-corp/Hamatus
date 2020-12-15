/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MDistribucion.Clases;

import ClasesSoporte.Conexion;
import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
/**
 *  Clase/Encabezado de usuario equipo, usada para poder asignar empleados a los diferentes equipos
 * @author maste
 */
@Entity
@Table(name = "e_usuario_equipo", catalog = "hamatus", schema = "")
@NamedQueries({
    @NamedQuery(name = "EUsuarioEquipo.findAll", query = "SELECT e FROM EUsuarioEquipo e")})
public class EUsuarioEquipo implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "ID_Usuario_Equipo")
    private Integer iDUsuarioEquipo;
    @Basic(optional = false)
    @NotNull
    @Column(name = "ID_Usuario_Empleado")
    private int iDUsuarioEmpleado;
    @JoinColumn(name = "ID_Equipo", referencedColumnName = "ID_Equipo")
    @ManyToOne(optional = false)
    private int idEquipo;
    
    private static Connection con;
    private static String q = "";
    private static PreparedStatement ps;
    private static ResultSet rs;

    public EUsuarioEquipo() {
    }

    public EUsuarioEquipo(Integer iDUsuarioEquipo) {
        this.iDUsuarioEquipo = iDUsuarioEquipo;
    }
    /**
     * Constructor full, para consultas
     * @param iDUsuarioEquipo: id del encabezado.
     * @param iDUsuarioEmpleado: ide del usuario.
     * @param idEquipo: Id del equipo
     */
    public EUsuarioEquipo(Integer iDUsuarioEquipo, int iDUsuarioEmpleado, int idEquipo) {
        this.iDUsuarioEquipo = iDUsuarioEquipo;
        this.iDUsuarioEmpleado = iDUsuarioEmpleado;
        this.idEquipo = idEquipo;
    }

    /**
     * Método para crear instancias de asignaciones de usuario y equipo
     * @param idUE: el ide del suario
     * @param idE: el ide del equipo
     */
    public EUsuarioEquipo(int idUE, int idE){
        this.iDUsuarioEmpleado = idUE;
        this.idEquipo = idE;
    }
   
    /**
     * Método para ingresar a la bd la relación entre los empleados y el equipo, este método solo ingresa a una persona, por lo que debe de implementarse dentro de un for
     * @param relUserEquip El objeto EUsuarioEquipo con la relación entre tablas;
     * @return 
     */
    public static boolean ingresarEmpleadoEquipo(EUsuarioEquipo relUserEquip){
        boolean proceso_correcto = true;
        System.out.println("Un saludo");
        try{
           con = Conexion.obtenerConexion();
           q = "INSERT INTO e_usuario_equipo (ID_Usuario_Empleado, ID_Equipo) values (?,?)";
           ps = con.prepareStatement(q);
           ps.setInt(1, relUserEquip.getIDUsuarioEmpleado());
           ps.setInt(2, relUserEquip.getIdEquipo());
           if(1 == ps.executeUpdate()){
               proceso_correcto = true;
           }else{
               System.out.println("No jaló");
           }
        } catch (SQLException ex) {
            Logger.getLogger(EUsuarioEquipo.class.getName()).log(Level.SEVERE, null, ex);
            proceso_correcto = false;
        }finally{
            try {
                con.close();
                ps.close();
                q= "";
            } catch (SQLException ex) {
                Logger.getLogger(EUsuarioEquipo.class.getName()).log(Level.SEVERE, null, ex);
                proceso_correcto = false;
            }
        }
        return proceso_correcto;
    }
    
    /**
     * Método para obtener el total de empleados dentor de un registro, util para la vista general de equipos, reporta .1 si no encuentra el equipo
     * @param ID_equipo
     * @return 
     */
    public static int getTotalEmpleadosEquipo(int ID_equipo){
        int total = -1;
        try{
            con = Conexion.obtenerConexion();
            q = "SELECT COUNT(ID_Equipo) AS total FROM e_usuario_equipo WHERE ID_Equipo = ?";
            ps = con.prepareStatement(q);
            ps.setInt(1, ID_equipo);
            rs = ps.executeQuery();
            if(rs.next()){
                total = rs.getInt("total");
            }
        } catch (SQLException ex) {
            Logger.getLogger(EUsuarioEquipo.class.getName()).log(Level.SEVERE, null, ex);
        }finally{
            try {
                con.close();
                ps.close();
                rs.close();
                q = "";
            } catch (SQLException ex) {
                Logger.getLogger(EUsuarioEquipo.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return total;
    }
    
   
    public static boolean removerUsuario(int id_empleado){
        boolean proceso_adecuado = true;
        try{
            con = Conexion.obtenerConexion();
            q = "DELETE FROM e_usuario_equipo WHERE ID_Usuario_Empleado = ?";
            ps = con.prepareStatement(q);
            ps.setInt(1, id_empleado);
            if(ps.executeUpdate() == 1){
                proceso_adecuado = true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(Equipo.class.getName()).log(Level.SEVERE, null, ex);
            proceso_adecuado = false;
        }finally{
            try {
                con.close();
                q = "";
                ps.close();
            } catch (SQLException ex) {
                Logger.getLogger(Equipo.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return proceso_adecuado;
    }
    
    public Integer getIDUsuarioEquipo() {
        return iDUsuarioEquipo;
    }

    public void setIDUsuarioEquipo(Integer iDUsuarioEquipo) {
        this.iDUsuarioEquipo = iDUsuarioEquipo;
    }

    public int getIDUsuarioEmpleado() {
        return iDUsuarioEmpleado;
    }

    public void setIDUsuarioEmpleado(int iDUsuarioEmpleado) {
        this.iDUsuarioEmpleado = iDUsuarioEmpleado;
    }

    public int getIdEquipo() {
        return idEquipo;
    }

    public void setIdEquipo(int idEquipo) {
        this.idEquipo = idEquipo;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (iDUsuarioEquipo != null ? iDUsuarioEquipo.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof EUsuarioEquipo)) {
            return false;
        }
        EUsuarioEquipo other = (EUsuarioEquipo) object;
        if ((this.iDUsuarioEquipo == null && other.iDUsuarioEquipo != null) || (this.iDUsuarioEquipo != null && !this.iDUsuarioEquipo.equals(other.iDUsuarioEquipo))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "MDistribucion.Clases.EUsuarioEquipo[ iDUsuarioEquipo=" + iDUsuarioEquipo + " ]";
    }
        
}
