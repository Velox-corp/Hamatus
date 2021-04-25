/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package MFlujos.Clases;

import ClasesSoporte.Conexion;
import MSeguridad.Clases.AES;
import MTablones.Clases.Anuncio;
import java.io.Serializable;
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
    
    static Connection con;
    static ResultSet rs;
    static PreparedStatement ps;
    static String q;
    
    public FlujoDeTrabajo(){

    }

    public FlujoDeTrabajo(Integer idFlujodetrabajo) {
        this.idFlujodetrabajo = idFlujodetrabajo;
    }

    /**
     * Constructor de un flujo de trabajo que se usa para obtenciones de querys
     * @param idFlujodetrabajo ide dle flujo
     * @param tituloFlujo titulo del flujo
     * @param descripcionFlujo descripción del flujo
     * @param idEquipo el ide equipo del flujo
     * @param fechaLimite fecha limite dle flujo
     * @param horaLimite hora limite del flujo
     */
    public FlujoDeTrabajo(Integer idFlujodetrabajo, String tituloFlujo, String descripcionFlujo, int idEquipo,String fechaLimite, String horaLimite) {
        this.idFlujodetrabajo = idFlujodetrabajo;
        this.tituloFlujo = tituloFlujo;
        this.idEquipo = idEquipo;
        this.descripcionFlujo = descripcionFlujo;
        this.fechaLimite = fechaLimite;
        this.horaLimite = horaLimite;
    }

    /**
     * Constructor del flujo de trabajo que se usará para genera el objeto del usuario
     * @param tituloFlujo el titulo del flujo ingresado por el usuario
     * @param descripcionFlujo la descripción del flujo ingresado por el usuario
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
    public boolean ingresarFlujo (FlujoDeTrabajo fdt){
        boolean procesoCorrecto;
        try{
            con = Conexion.obtenerConexion();
            q = "INSRET INTO flujodetrabajo (titulo_flujo, descripcion_flujo, id_equipo, fecha_limite, hora_limite) values (?, ?, ?, ?, ?) ";
            ps = con.prepareStatement(q);
            ps.setBytes(1, AES.cifrar(fdt.getTituloFlujo()));
            ps.setBytes(2, AES.cifrar(fdt.getDescripcionFlujo()));
            ps.setInt(3, fdt.getIdEquipo());
            ps.setBytes(4, AES.cifrar(fdt.getFechaLimite()));
            ps.setBytes(5, AES.cifrar(fdt.getHoraLimite()));
            procesoCorrecto = (ps.executeUpdate() == 1);
        } catch (Exception ex) {
            Logger.getLogger(Anuncio.class.getName()).log(Level.SEVERE, null, ex);
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
    
    public boolean consultaFlujo(int idflujo){
        return false;
        
    }
    
    public boolean consultarFlujos(int idEquipo){
        return false;
        
    }

    public boolean editarFlujo(int idFlujo, FlujoDeTrabajo fdt){
        return false;
        
    }
    
    public boolean eliminarFlujo(int idFlujo){
        return false;
        
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
