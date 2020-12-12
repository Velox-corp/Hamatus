/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MDistribucion.Clases;

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

/**
 *
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
    private Equipo iDEquipo;

    public EUsuarioEquipo() {
    }

    public EUsuarioEquipo(Integer iDUsuarioEquipo) {
        this.iDUsuarioEquipo = iDUsuarioEquipo;
    }

    public EUsuarioEquipo(Integer iDUsuarioEquipo, int iDUsuarioEmpleado) {
        this.iDUsuarioEquipo = iDUsuarioEquipo;
        this.iDUsuarioEmpleado = iDUsuarioEmpleado;
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

    public Equipo getIDEquipo() {
        return iDEquipo;
    }

    public void setIDEquipo(Equipo iDEquipo) {
        this.iDEquipo = iDEquipo;
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
