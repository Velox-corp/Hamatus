/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package MFlujos.Clases;

import ClasesSoporte.Conexion;
import MSeguridad.Clases.AES;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
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

/**
 *
 * @author Armando Jarillo
 */
@Entity
@Table(name = "flujo de trabajo")
@NamedQueries({
    @NamedQuery(name = "FlujoDeTrabajo.findAll", query = "SELECT f FROM FlujoDeTrabajo f")})
public class FlujoDeTrabajo implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "idFlujo de trabajo")
    private Integer idFlujodetrabajo;
    @Basic(optional = false)
    @NotNull
    @Lob
    @Column(name = "titulo_flujo")
    private String tituloFlujo;
    @Basic(optional = false)
    @NotNull
    @Lob
    @Column(name = "descripcion_flujo")
    private String descripcionFlujo;
    @Basic(optional = false)
    @NotNull
    @Column(name = "fecha_limite")
    @Temporal(TemporalType.DATE)
    private String fechaLimite;
    @Basic(optional = false)
    @NotNull
    @Column(name = "hora_limite")
    @Temporal(TemporalType.TIME)
    private String horaLimite;

    private int idEquipo;
    private boolean entregado;
    
    static Connection con;
    static ResultSet rs;
    static PreparedStatement ps;
    static String q;
    
    /**
     * Contructor vacio
     */
    public FlujoDeTrabajo(){

    }


    /**
     * Constructor de un flujo de trabajo que se usa para obtenciones de querys
     * @param idFlujodetrabajo ide dle flujo
     * @param tituloFlujo titulo del flujo
     * @param descripcionFlujo descripción del flujo
     * @param idEquipo el ide equipo del flujo
     * @param fechaLimite fecha limite dle flujo
     * @param horaLimite hora limite del flujo
     * @param entregado indica si el flujo ya recibio respuesta
     */
    public FlujoDeTrabajo(Integer idFlujodetrabajo, String tituloFlujo, String descripcionFlujo, int idEquipo,String fechaLimite, String horaLimite, boolean entregado) {
        this.idFlujodetrabajo = idFlujodetrabajo;
        this.tituloFlujo = tituloFlujo;
        this.idEquipo = idEquipo;
        this.descripcionFlujo = descripcionFlujo;
        this.fechaLimite = fechaLimite;
        this.horaLimite = horaLimite;
        this.entregado = entregado;
    }

    /**
     * Constructor del flujo de trabajo que se usará para genera el objeto del usuario
     * @param tituloFlujo el titulo del flujo ingresado por el usuario
     * @param descripcionFlujo la descripción del flujo ingresado por el usuario
     * @param idEquipo el ide al equipoa l que se le será asignado
     * @param fechaLimite la fecha limite del flujo ingresado por el usuario
     * @param horaLimite la hora limite del flujo ingresado por el usuario
     */
    public FlujoDeTrabajo(String tituloFlujo, String descripcionFlujo, int idEquipo, String fechaLimite, String horaLimite) {
        this.tituloFlujo = tituloFlujo;
        this.descripcionFlujo = descripcionFlujo;
        this.idEquipo = idEquipo;
        this.fechaLimite = fechaLimite;
        this.horaLimite = horaLimite;
    }
    
    /**
     * Método para insertar un flujo de trabajo
     * @param fdt el flujo de trabajo a insertar
     * @return true si el proceso fue adecuado
     */
    public static boolean ingresarFlujo (FlujoDeTrabajo fdt){
        boolean procesoCorrecto;
        try{
            con = Conexion.obtenerConexion();
            q = "INSERT INTO flujo_de_trabajo (titulo_flujo, descripcion_flujo, id_equipo, fecha_limite, hora_limite, entregado) values (?, ?, ?, ?, ?, 0) ";
            ps = con.prepareStatement(q);
            ps.setBytes(1, AES.cifrar(fdt.getTituloFlujo()));
            ps.setBytes(2, AES.cifrar(fdt.getDescripcionFlujo()));
            ps.setInt(3, fdt.getIdEquipo());
            ps.setBytes(4, AES.cifrar(fdt.getFechaLimite()));
            ps.setBytes(5, AES.cifrar(fdt.getHoraLimite()));
            procesoCorrecto = (ps.executeUpdate() == 1);
        } catch (Exception ex) {
            Logger.getLogger(FlujoDeTrabajo.class.getName()).log(Level.SEVERE, null, ex);
            procesoCorrecto = false;
        }finally{
            try {
                con.close();
                ps.close();
                q = "";
            } catch (SQLException ex) {
                Logger.getLogger(FlujoDeTrabajo.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return procesoCorrecto;
    }
    
    /**
     * Método para obtener 1 flujo de trabajo, este se utilizará principalmente para visualizar flujos individuales
     * @param idflujo el ide del flujo a ver
     * @return 
     */
    public static FlujoDeTrabajo consultaFlujo(int idflujo){
        FlujoDeTrabajo fdtc = null;
        try{
            con = Conexion.obtenerConexion();
            q = "SELECT * FROM Flujo_de_trabajo where idFlujo_de_trabajo = ?";
            ps = con.prepareStatement(q);
            ps.setInt(1, idflujo);
            rs =ps.executeQuery();
            if(rs.next()){
                fdtc = new FlujoDeTrabajo(rs.getInt("idFlujo_de_trabajo"), 
                        AES.descifrar(rs.getBytes("titulo_flujo")), 
                        AES.descifrar(rs.getBytes("descripcion_flujo")), 
                        rs.getInt("id_equipo"), 
                        AES.descifrar(rs.getBytes("fecha_limite")), 
                        AES.descifrar(rs.getBytes("hora_limite")), 
                        rs.getInt("entregado")==1);
            }
        }catch (Exception ex) {
            Logger.getLogger(FlujoDeTrabajo.class.getName()).log(Level.SEVERE, null, ex);
        }finally{
            try {
                con.close();
                ps.close();
                q = "";
                rs.close();
            } catch (SQLException ex) {
                Logger.getLogger(FlujoDeTrabajo.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return fdtc;
        
    }
    
    /**
     * Obetener los flujos de trabajo asignados a un equipo en concreto
     * @param idEquipo el ide del equipo en concreto
     * @return una lista de todos los flujos de trabajo asignados a el equipo
     */
    public static ArrayList<FlujoDeTrabajo> consultarFlujosEmpleado(int idEquipo){
        ArrayList<FlujoDeTrabajo> flujos = new ArrayList<FlujoDeTrabajo>();
        try{
            con = Conexion.obtenerConexion();
            q = "SELECT * FROM Flujo_de_trabajo where id_Equipo = ?";
            ps = con.prepareStatement(q);
            ps.setInt(1, idEquipo);
            rs =ps.executeQuery();
            if(rs.next()){
                FlujoDeTrabajo fdte = new FlujoDeTrabajo(rs.getInt("idFlujo_de_trabajo"), 
                        AES.descifrar(rs.getBytes("titulo_flujo")), 
                        AES.descifrar(rs.getBytes("descripcion_flujo")), 
                        rs.getInt("id_equipo"), 
                        AES.descifrar(rs.getBytes("fecha_limite")), 
                        AES.descifrar(rs.getBytes("hora_limite")), 
                        rs.getInt("entregado")==1);
                flujos.add(fdte);
            }
            
        }catch (Exception ex) {
            Logger.getLogger(FlujoDeTrabajo.class.getName()).log(Level.SEVERE, null, ex);
        }finally{
            try {
                con.close();
                ps.close();
                q = "";
            } catch (SQLException ex) {
                Logger.getLogger(FlujoDeTrabajo.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return flujos;
    }
    
    /**
     * Obetener los flujos de trabajo asignados a todos los equipos de un lider de división
     * @param idDiv el ide de la división
     * @return una lista de todos los flujos de trabajo asignados a el equipo
     */
    public static ArrayList<FlujoDeTrabajo> consultarFlujosLiderDiv(int idDiv){
        ArrayList<FlujoDeTrabajo> flujos = new ArrayList<FlujoDeTrabajo>();
        try{
            con = Conexion.obtenerConexion();
            q = "SELECT Flujo_de_trabajo.* FROM Flujo_de_trabajo \n" +
                "WHERE Flujo_de_trabajo.id_equipo \n" +
                "IN (SELECT equipo.ID_equipo FROM equipo WHERE id_division = ?)";
            ps = con.prepareStatement(q);
            ps.setInt(1, idDiv);
            rs = ps.executeQuery();
            if(rs.next()){
                FlujoDeTrabajo fdte = new FlujoDeTrabajo(rs.getInt("idFlujo_de_trabajo"), 
                        AES.descifrar(rs.getBytes("titulo_flujo")), 
                        AES.descifrar(rs.getBytes("descripcion_flujo")), 
                        rs.getInt("id_equipo"), 
                        AES.descifrar(rs.getBytes("fecha_limite")), 
                        AES.descifrar(rs.getBytes("hora_limite")), 
                        rs.getInt("entregado")==1);
                flujos.add(fdte);
            }
            
        }catch (Exception ex) {
            Logger.getLogger(FlujoDeTrabajo.class.getName()).log(Level.SEVERE, null, ex);
        }finally{
            try {
                con.close();
                ps.close();
                q = "";
            } catch (SQLException ex) {
                Logger.getLogger(FlujoDeTrabajo.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return flujos;
    }
    
    
    /**
     * Método para editar los dátos de un flujo
     * @param idFlujo el ide del flujo a editar
     * @param fdt el pbjeto flujo con los nuevos datos
     * @return true si se realizó la actualziación con exito
     */
    public static boolean editarFlujo(int idFlujo, FlujoDeTrabajo fdt){
        boolean procesoCorrecto;
        try{
            con = Conexion.obtenerConexion();
            q = "UPDATE Flujo_de_trabajo SET titulo_flujo = ?, descripcion_flujo = ?, fecha_limite = ?, hora_limite = ? WHERE idFlujo_de_trabajo = ?";
            ps = con.prepareStatement(q);
            ps.setBytes(1, AES.cifrar(fdt.getTituloFlujo()));
            ps.setBytes(2, AES.cifrar(fdt.getDescripcionFlujo()));
            ps.setBytes(3, AES.cifrar(fdt.getFechaLimite()));
            ps.setBytes(4, AES.cifrar(fdt.getHoraLimite()));
            ps.setInt(5, idFlujo);
            procesoCorrecto = (ps.executeUpdate() == 1);
        }catch (Exception ex) {
            Logger.getLogger(FlujoDeTrabajo.class.getName()).log(Level.SEVERE, null, ex);
            procesoCorrecto = false;
        }finally{
            try {
                con.close();
                ps.close();
                q = "";
            } catch (SQLException ex) {
                Logger.getLogger(FlujoDeTrabajo.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return procesoCorrecto;
        
    }
    
    /**
     * Metodo para eliminar un flujo
     * @param idFlujo: el ide del flujo a eliminar
     * @return true si se realizó la eliminación con exito
     */
    public static boolean eliminarFlujo(int idFlujo){
        boolean procesoCorrecto;
        try{
            con = Conexion.obtenerConexion();
            q = "DELETE FROM flujo_de_trabajo WHERE idFlujo_de_trabajo = ?";
            ps = con.prepareStatement(q);
            ps.setInt(1, idFlujo);
            procesoCorrecto = (ps.executeUpdate() == 1);
        }catch (Exception ex) {
            Logger.getLogger(FlujoDeTrabajo.class.getName()).log(Level.SEVERE, null, ex);
            procesoCorrecto = false;
        }finally{
            try {
                con.close();
                ps.close();
                q = "";
            } catch (SQLException ex) {
                Logger.getLogger(FlujoDeTrabajo.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return procesoCorrecto;
        
    }
    
    public Integer getIdFlujodetrabajo() {
        return idFlujodetrabajo;
    }

    public void setIdFlujodetrabajo(Integer idFlujodetrabajo) {
        this.idFlujodetrabajo = idFlujodetrabajo;
    }

    public String getTituloFlujo() {
        return tituloFlujo;
    }

    public void setTituloFlujo(String tituloFlujo) {
        this.tituloFlujo = tituloFlujo;
    }

    public String getDescripcionFlujo() {
        return descripcionFlujo;
    }

    public void setDescripcionFlujo(String descripcionFlujo) {
        this.descripcionFlujo = descripcionFlujo;
    }

    public String getFechaLimite() {
        return fechaLimite;
    }

    public void setFechaLimite(String fechaLimite) {
        this.fechaLimite = fechaLimite;
    }

    public String getHoraLimite() {
        return horaLimite;
    }

    public void setHoraLimite(String horaLimite) {
        this.horaLimite = horaLimite;
    }

    public int getIdEquipo() {
        return idEquipo;
    }

    public void setIdEquipo(int idEquipo) {
        this.idEquipo = idEquipo;
    }

    public boolean isEntregado() {
        return entregado;
    }

    public void setEntregado(boolean entregado) {
        this.entregado = entregado;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idFlujodetrabajo != null ? idFlujodetrabajo.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof FlujoDeTrabajo)) {
            return false;
        }
        FlujoDeTrabajo other = (FlujoDeTrabajo) object;
        return !((this.idFlujodetrabajo == null && other.idFlujodetrabajo != null) || (this.idFlujodetrabajo != null && !this.idFlujodetrabajo.equals(other.idFlujodetrabajo)));
    }

    @Override
    public String toString() {
        return "MFlujos.Clases.FlujoDeTrabajo[ idFlujodetrabajo=" + idFlujodetrabajo + " ]";
    }
}
